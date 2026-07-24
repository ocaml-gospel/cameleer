open Ml_lang

module E = Expression_coma

module Sid = Set.Make(struct
  type t = Ml_lang.id
  let compare a b = String.compare a.id_name b.id_name
end)

module Mid = Map.Make(struct
  type t = Ml_lang.id
  let compare a b = String.compare a.id_name b.id_name
end)

(* binds type name to type constructors *)
let htypes
  (* (string, (string * (Ppxlib.Parsetree.core_type * int)) list) Hashtbl.t = *)
  = Hashtbl.create 16

let get_constructors t =
  match Hashtbl.find_opt htypes t with
  | Some cs -> List.map fst cs
  | None -> []

let () = ignore get_constructors

(* let get_arity t s =
  match Hashtbl.find_opt htypes t with
  | Some cs -> snd @@ List.assoc s cs
  | None -> 0 *)

let get_type_informations t s =
  try
    match Hashtbl.find_opt htypes t with
    | Some cs ->
        List.assoc s cs
    | None -> [], 0
  with e -> Format.printf "ERROR : %s %s@." t s; raise e

exception NonExhaustive

(** get the type of an atom *)
let t_type a = match a.atom_desc with
  | ACast (_,t) -> t
  | AId id ->
      failwith (Format.sprintf "missing type for `%s'" id.id_name)
  | ABinop (_, _, _) -> assert false
  | AUnop (_, _) -> assert false
  | ACst _ -> assert false
  | AFun (_, _, _) -> assert false
  | ATuple _ -> assert false
  | ACons (_, _) -> assert false

let type_name t =
  match Parsetree.(t.ptyp_desc) with
  | Parsetree.Ptyp_constr ({ txt; loc = _ }, _) -> E.string_of_longident txt
  | Parsetree.Ptyp_tuple _tl -> failwith "todo"
  | Parsetree.Ptyp_var s -> s
  | Parsetree.Ptyp_any -> assert false
  | Parsetree.Ptyp_arrow (_, _, _) -> assert false
  | Parsetree.Ptyp_object (_, _) -> assert false
  | Parsetree.Ptyp_class (_, _) -> assert false
  | Parsetree.Ptyp_alias (_, _) -> assert false
  | Parsetree.Ptyp_variant (_, _, _) -> assert false
  | Parsetree.Ptyp_poly (_, _) -> assert false
  | Parsetree.Ptyp_package _ -> assert false
  | Parsetree.Ptyp_extension _ -> assert false

let compile
  ~(mk_case: atom -> (pattern * 'a) list -> 'a)
  ~(mk_let:  binder -> atom -> 'a -> 'a)
  (a: atom) (rl: (pattern list * 'a) list) : 'a =
  let rec compile tl rl = match tl,rl with
    | _, [] -> (* no actions *)
        raise NonExhaustive
    | [], (_,a) :: _ -> (* no terms, at least one action *)
        a
    | ({atom_desc=ATuple at; _} :: tl, _)  ->
        let tl = at @ tl in
        let rl = List.map (function
          | {ppat_desc=PTuple pl; _}::tl,a -> (pl @ tl), a
          | p::pl, a ->
              let rec loop p =
                match p.ppat_desc with
                | PWild ->
                    let r = ref 0 in
                    let () = try List.iter2 (fun _ _ -> incr r) tl pl
                             with Invalid_argument _ -> () in
                    let loc = p.ppat_loc in
                    let ws = List.init !r (fun _ ->
                      E.(mk_pattern ~loc @@ PWild)) in
                    ws @ pl, a
                | PCast (p,_) -> loop p
                | PVar _ | PCst _ | PCons (_, _) | PTuple _ -> assert false in
              loop p
          | _, _ -> assert false) rl in
        compile tl rl
    | t :: tl, _ -> (* process the leftmost column *)
        let ty = t_type t in
        let name_ty = type_name ty in
        let rl_tail, fc = (* [fc] = first column of the matrix *)
          List.fold_right (fun (pl,a) (rl, fc) ->
            match pl with [] -> assert false
            | p::pls -> (pls, a)::rl, p::fc)
          rl ([],[]) in
        let rec simple p = match p.ppat_desc with
          | PWild | PVar _ -> true
          | PCast (p, _) -> simple p
          | _ -> false in
        let rec get_constr p = match p.ppat_desc with
          | PCst _ | PWild | PVar _ | PTuple _ -> None
          | PCons (c, _) -> Some c
          | PCast (p, _) -> get_constr p in
        if List.for_all simple fc then begin (* [fc] made of vars / wildcard only! *)
          let rl_tail = List.map2 (fun (pl, a) p ->
            let rec loop ty p =
              match p.ppat_desc with
              | PWild -> a
              | PVar id -> mk_let (id, (Some ty)) t a
              | PCast (p, t) -> loop t p
              | _ -> assert false in
            pl, loop ty p) rl_tail fc in
          compile tl rl_tail
        end else (* not simple *)
          (* the constructors present on the first column *)
          let (_, col_cons) = List.fold_right (fun p (s,acc) ->
            match get_constr p with
            | None -> (s, acc)
            | Some c -> if Sid.mem c s then s, acc
                        else Sid.add c s, ((p,c) :: acc)) fc (Sid.empty,[]) in
          let mat_c (c: id) at types = (* matrix for constructor [c] *)
            let nwilds = List.map (E.mk_wild_typed ~loc:c.id_loc) types in
            let filtered =
              (* filtered [fc] for [c], filtered [rl] for [c] *)
              List.fold_right2 (fun p (pl,a) acc ->
                let rec take p =
                  match p.ppat_desc with
                  | PWild -> (nwilds @ pl, a) :: acc
                  | PVar id ->
                      let a = mk_let (id, Some ty) t a in
                      (nwilds @ pl, a) :: acc
                  | PCons (cc, l2) when c.id_name = cc.id_name -> (l2 @ pl, a) :: acc
                  | PCons _ -> acc
                  | PCst _ | PTuple _ -> failwith "unreachable"
                  | PCast (p, _) -> take p in
                take p)
              fc rl_tail [] in
            compile (at @ tl) filtered in
          let default_mat =
            let rec collect_lets_opt ?ty a p =
              match p.ppat_desc with
              | PWild        -> Some a
              | PVar id      -> Some (mk_let (id, ty) t a)
              | PCast (p, t) -> collect_lets_opt ~ty:t a p
              | _            -> None in
            let rl_tail = List.fold_right2 (fun (pl, a) p acc ->
              match collect_lets_opt ~ty a p with
              | None -> acc
              | Some a -> (pl, a) :: acc) rl_tail fc [] in
            if rl_tail = [] then []
            else [E.(mk_tpattern PWild ty), compile tl rl_tail] in
          let rec get_args p = match p.ppat_desc with
            | PCons (_, pl) -> pl
            | PCast (p, _) -> get_args p
            | _ -> failwith "unreachable2" in
          let rec change_args p na = match p.ppat_desc with
            | PCons (c, _) -> { p with ppat_desc = PCons (c, na) }
            | PCast (p, t) -> { p with ppat_desc = PCast (change_args p na, t) }
            | _ -> failwith "unreachable4" in
          let () = ignore change_args in
          let rec p2a { ppat_loc=loc; ppat_desc } i =
            match ppat_desc with
            | PVar id -> E.mk_atom ~loc @@ AId id
            | PCast (p, t) -> E.mk_atom ~loc @@ ACast (p2a p i, t)
            | PWild
            | PCons (_, _) -> i
            | PTuple _ | PCst _ -> failwith "unreachable6" in
          ignore p2a ;
          let get_type p = match p.ppat_desc with
            | PVar _ -> assert false
                (* default *)
            | PCast (_, t) -> t
            | PCons (_, _) -> assert false
            | _ -> failwith "unreachable3" in
          let pl = List.fold_right (fun (p,cons) acc ->
            let args = get_args p in
            let ts, _arity = get_type_informations name_ty cons.id_name in
            (*Format.printf "%d %d %s %s@." (List.length args) (List.length ts) cons.id_name name_ty; *)
            let (t_args, p_args) = List.fold_right (fun arg (acct, accp) ->
              let i = E.gen_id () in
              let ty = get_type arg in
              let a = E.mk_atom (ACast (E.mk_atom (AId i), ty)) in
              let p = E.mk_pattern (PVar i) in
              let p = E.mk_pattern (PCast (p, ty)) in
              a::acct, p::accp) args ([],[]) in

            let c = change_args p p_args in
            let mc = c, mat_c cons t_args ts in
            mc::acc) col_cons default_mat in

          mk_case t pl in
  compile [a] rl

let rec expr e = match e.expr_desc with
  | EFail -> e
  | EAssert (phi,e) ->
      let expr_desc = EAssert (phi, expr e) in
      { e with expr_desc }
  | EHide e ->
      let expr_desc = EHide (expr e) in
      { e with expr_desc }
  | ELet (k, a, e2) ->
      let expr_desc = ELet (k, atom a, expr e2) in
      { e with expr_desc }
  | ELetRef (k, a, e2) ->
      let expr_desc = ELetRef (k, atom a, expr e2) in
      { e with expr_desc }
  | EAssignRef (r, a, e2) ->
      let expr_desc = EAssignRef (r, atom a, expr e2) in
      { e with expr_desc }
  | ELetK (k, id, o, e1, e2) ->
      let expr_desc = ELetK (k, id, o, expr e1, expr e2) in
      { e with expr_desc }
  | EApp (c, al, cl) ->
      let c = callable c in
      let cl = List.map callable cl in
      let al = List.map atom al in
      let expr_desc = EApp (c, al, cl) in
      { e with expr_desc }
  | EIf (a, e1, e2) ->
      let a = atom a in
      let e1 = expr e1 in
      let e2 = expr e2 in
      let expr_desc = EIf (a, e1, e2) in
      { e with expr_desc }
  | EMatch (a, pl) ->
      let mk_case a pl = E.mk_expr @@ EMatch (a, pl) in
      let mk_let (_,bt as b) e1 e2 =
        assert (bt <> None);
        E.mk_expr (ELet (b, e1, e2)) in
      let pl = List.map (fun (p,e) -> [p], expr e) pl in
      compile ~mk_case ~mk_let a pl

and atom a = match a.atom_desc with
  | ACst _ | AId _ -> a
  | ABinop (a1, o, a2) ->
      let atom_desc = ABinop (atom a1, o, atom a2) in
      { a with atom_desc }
  | AUnop (o, a) ->
      let atom_desc = AUnop (o, atom a) in
      { a with atom_desc }
  | AFun (r, b, e) ->
      let atom_desc = AFun (r, b, expr e) in
      { a with atom_desc }
  | ATuple al ->
      let al = List.map atom al in
      let atom_desc = ATuple al in
      { a with atom_desc }
  | ACons (id, al) ->
      let al = List.map atom al in
      let atom_desc = ACons (id, al) in
      { a with atom_desc }
  | ACast (a, t) ->
      let atom_desc = ACast (atom a, t) in
      { a with atom_desc }

and callable c = match c.callable_desc with
  | CId _ -> c
  | CFun (x, k, e) ->
      let e = expr e in
      let callable_desc = CFun (x, k, e) in
      { c with callable_desc }

let add_type tname (c: Parsetree.type_kind) =
  match c with
  | Ptype_open -> failwith "not implemented 0"
  | Ptype_record _ -> failwith "not implemented 1"
  | Ptype_abstract -> ()
  | Ptype_variant cl ->
      let cs = List.map (fun Parsetree.{pcd_name={txt;_}; pcd_args; _} ->
        let n = match pcd_args with
                | Pcstr_tuple l -> l, List.length l
                | _ -> failwith "not implemented 3" in
        txt, n) cl in
      Hashtbl.add htypes tname cs

let compile_pattern (d: declaration) =
  match d.decl_desc with
  | DFun (r,id,bl,pre,olds,kl,e) ->
      let decl_desc = DFun (r,id,bl,pre,olds,kl, expr e) in
      { d with decl_desc }
  | DType (_, dl) ->
      let () = List.iter (fun Gospel.Uast.{ tname; tkind; _ } ->
        add_type tname.txt tkind) dl in
      d
  | DFunction _
  | DProp _ -> d

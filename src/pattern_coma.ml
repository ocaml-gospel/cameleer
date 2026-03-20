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

let rev2 (l1,l2) = List.(rev l1, rev l2)

(* binds type name to type constructors *)
let htypes
  (* (string, (string * (Ppxlib.Parsetree.core_type * int)) list) Hashtbl.t = *)
  = Hashtbl.create 16

let get_constructors t =
  match Hashtbl.find_opt htypes t with
  | Some cs -> List.map fst cs
  | None -> []

(* let get_arity t s =
  match Hashtbl.find_opt htypes t with
  | Some cs -> snd @@ List.assoc s cs
  | None -> 0 *)

let get_type_informations t s =
  match Hashtbl.find_opt htypes t with
  | Some cs -> List.assoc s cs
  | None -> [], 0

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

let t2s t =
  match Parsetree.(t.ptyp_desc) with
  | Parsetree.Ptyp_constr ({ txt; loc = _ }, _) ->
      E.string_of_longident txt
  | Parsetree.Ptyp_any -> assert false
  | Parsetree.Ptyp_var s -> s
  | Parsetree.Ptyp_arrow (_, _, _) -> assert false
  | Parsetree.Ptyp_tuple _ -> assert false
  | Parsetree.Ptyp_object (_, _) -> assert false
  | Parsetree.Ptyp_class (_, _) -> assert false
  | Parsetree.Ptyp_alias (_, _) -> assert false
  | Parsetree.Ptyp_variant (_, _, _) -> assert false
  | Parsetree.Ptyp_poly (_, _) -> assert false
  | Parsetree.Ptyp_package _ -> assert false
  | Parsetree.Ptyp_extension _ -> assert false

let compile
  ~(get_constructors: string -> string list)
  ~(mk_case: atom -> (pattern * 'a) list -> 'a)
  ~(mk_let:  binder -> expr -> 'a -> 'a)
  (a: atom) (rl: (pattern list * 'a) list) : 'a =

  let rec compile tl rl = match tl,rl with
    | _, [] -> (* no actions *)
        Format.printf "---%a]@."
          (Format.pp_print_list
            ~pp_sep:Format.pp_print_space Pp_ml_lang.pp_atom)
          tl;
        raise NonExhaustive
    | [], (_,a) :: _ -> (* no terms, at least one action *)
        a
    | {atom_desc=ATuple t; _} :: tl, _ ->
        let tl = t @ tl in
        let rl = List.map (function[@warning "-8"] ({ppat_desc=PTuple pl;_}::tl,a) ->
          (pl @ tl), a
        ) rl in
        compile tl rl
    | t :: tl, _ -> (* process the leftmost column *)

        let expr_t = E.mk_expr_atom t.atom_desc in
        let ty = t_type t in

        (* fc: first column
           idea: rl = @ (fc_i ++ rl_tail i) *)
        let rl_tail, fc = rev2 @@
          List.fold_left (fun (rls, fcs) (pl,a) ->
            match pl with [] -> assert false
            | p::pls -> (pls, a)::rls, p::fcs)
          ([],[]) rl in

        let simple p = match p.ppat_desc with
          | PWild | PVar _ -> true
          | _ -> false in

        let rec get_constr p = match p.ppat_desc with
          | PWild | PVar _ | PTuple _ -> None
          | PCons (c, _) -> Some c
          | PCast (p, _) -> get_constr p in

        let rec is_compat c p = match p.ppat_desc with
          | PWild | PVar _ -> true
          | PCons (c2, _) -> String.equal c.id_name c2.id_name
          | PCast (p, _) -> is_compat c p
          | PTuple _ -> failwith "unreachable" in

        let simple = List.for_all simple fc in

        if simple then begin
          let rl_tail = List.map2 (fun (pl, a) p ->
            match p.ppat_desc with
            | PWild -> pl, a
            | PVar id ->
                let a = mk_let (id, (Some ty)) expr_t a in
                pl, a
            | _ -> assert false
            ) rl_tail fc in
          (* assert (List.length tl < List.length rl_tail); *)
          compile tl rl_tail
        end else (* not simple *)

          (* the constructors present on the leftmost column *)
          let col_cons = List.fold_left (fun acc x ->
            match get_constr x with
            | None -> acc
            | Some e -> Sid.add e acc) Sid.empty fc in

          (* extract the list of constructors *)
          let ty_str = t2s ty in
          (* let css = get_constructors ty_str in *)
          ignore get_constructors;

          let type_info id = get_type_informations ty_str id in
          (* let arity id = snd @@ type_inf id in *)

          (* let _css = List.fold_left (fun acc a ->
            let l = List.init (arity a) (fun _ -> E.gen_id ()) in
            (* récupérer les types dans la liste que je viens de rajouter *)
            let k = assert false in
            (* let k:binder = None in *)
            Mid.add k l acc) Mid.empty css in *)

          (* matrix for constructor [c] *)
          let mat_c (c: id) arity proj =
            let nwilds = List.init arity (fun _ -> E.mk_pattern PWild) in
            (* filtered fc, filtered rl *)
            Format.printf "compat with %s for (%a)@." c.id_name (Pp_ml_lang.pp_atom ~paren:false) t;
            let (ffc, rl_tail) = rev2 @@
              List.fold_left2 (fun (pats,acc) p line ->
                Format.printf "::: %a@." (Pp_ml_lang.pp_pattern ~paren:false) p;
                if is_compat c p then (Format.printf"\ttrue@.";p :: pats, line :: acc) else (pats, acc)
              ) ([],[]) fc rl_tail in
            let rl_tail = List.rev @@ List.fold_left2 (
              fun acc p (pl,a) ->
                let rec loop p =
                  match p.ppat_desc with
                  | PWild ->
                      let l = nwilds @ pl, a in
                      l :: acc
                  | PVar id ->
                      let a = mk_let (id, Some ty) expr_t a in
                      let l = nwilds @ pl, a in
                      l :: acc
                  | PCons (_, l2) ->
                      let l = l2 @ pl, a in
                      l :: acc
                  | PTuple t ->
                      (* is this good? *)
                      let l = t @ pl, a in
                      l :: acc
                  | PCast (p, _) -> loop p
                in loop p
            ) [] ffc rl_tail in
            compile (proj @ tl) rl_tail
          in

          let rec collect_lets_opt ?(ty=None) a p =
            match p.ppat_desc with
            | PWild -> Some a
            | PVar id ->
                Some (mk_let (id, ty) expr_t a)
            | PCast (p, t) ->
                collect_lets_opt ~ty:(Some t) a p
            | _ -> None in


          (* TODO TO BE REMOVED *)
          let dp = if false then PVar (E.mk_id "coucou") else PWild in

          let default_mat =
            let rl_tail = List.rev @@ List.fold_left2 (fun acc (pl, a) p ->
              match collect_lets_opt ~ty:(Some ty) a p with
              | None -> acc
              | Some a -> (pl, a) :: acc
            ) [] rl_tail fc in
            if rl_tail = [] then (Format.printf "i:%a@." (Pp_ml_lang.pp_atom ~paren:false) t ; [])
            else [E.mk_pattern dp, compile tl rl_tail] in
            (* Format.printf "%d %d : %a@." (List.length tl) (List.length rl_tail)
              (Pp_ml_lang.pp_atom ~paren:false) t
            ;
            try *)

          let pl = Sid.fold (fun c acc ->
            let ts, arity = type_info c.id_name in
            let projs = List.init arity (fun _ -> E.gen_id ()) in
            let t_ats = List.map2 (fun id ty ->
              let a = E.mk_atom @@ AId id in
              E.mk_atom @@ ACast (a, ty)
            ) projs ts in
            let patproj = List.map (fun i -> E.mk_pattern @@ PVar i) projs in
            let pm = E.mk_pattern @@ PCons(c, patproj) in
            let mc = pm, mat_c c arity t_ats in
            mc::acc
          ) col_cons default_mat in

          mk_case t pl

  in
  compile [a] rl


let rec expr e = match e.expr_desc with
  | EAtom a ->
      let expr_desc = EAtom (atom a) in
      { e with expr_desc }
  | EFail -> e
  | EAssert (phi,e) ->
      let expr_desc = EAssert (phi, expr e) in
      { e with expr_desc }
  | EHide e ->
      let expr_desc = EHide (expr e) in
      { e with expr_desc }
  | ELet (k, e1, e2) ->
      let expr_desc = ELet (k, expr e1, expr e2) in
      { e with expr_desc }
  | ELetK (k, id, e1, e2) ->
      let expr_desc = ELetK (k, id, expr e1, expr e2) in
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
      let mk_case a pl =
          E.mk_expr @@ EMatch (a, pl)
        in
      let mk_let b e1 e2 = E.mk_expr (ELet (b, e1, e2)) in
      let pl = List.map (fun (p,e) -> [p],e) pl in
      compile ~get_constructors ~mk_case ~mk_let a pl

and atom a = match a.atom_desc with
  | ACst _ | AId _ -> a
  | ABinop (e1, o, e2) ->
      let atom_desc = ABinop (expr e1, o, expr e2) in
      { a with atom_desc }
  | AUnop (o, e) ->
      let atom_desc = AUnop (o, expr e) in
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
  | DFun (r,id,bl,pre,kl,e) ->
      let decl_desc = DFun (r,id,bl,pre,kl, expr e) in
      { d with decl_desc }
  | DType (_, dl) ->
      let () = List.iter (fun Gospel.Uast.{ tname; tkind; _ } ->
        add_type tname.txt tkind) dl in
      d
  | DFunction _
  | DProp _ -> d

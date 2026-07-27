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

exception NonExhaustive
exception ListCons

(* binds type name to type constructors+params *)
let (htypes : (string, (string * Parsetree.core_type list) list) Hashtbl.t)
  = Hashtbl.create 16

let get_constructors t =
  match Hashtbl.find_opt htypes t with
  | Some cs -> List.map fst cs
  | None -> []

let () = ignore get_constructors

let get_type_informations t s =
  if s = "::" then raise ListCons else
  match Hashtbl.find_opt htypes t with
  | Some cs ->
      List.assoc s cs
  | None -> []

(** get the type of an atom *)
let rec atom_types a = match a.atom_desc with
  | ACast (_,t) -> [t]
  | AId id ->
      failwith (Format.sprintf "missing type for `%s'" id.id_name)
  | ABinop (_, _, _) -> assert false
  | AUnop (_, _) -> assert false
  | ACst _ -> assert false
  | AFun (_, _, _) -> assert false
  | ATuple a ->
      List.map (fun a ->
        match atom_types a with
        | [t] -> t
        | _ -> failwith "broken assumption: tuple of tuple are forbidden")
      a
  | ACons (_, _) -> assert false

let rec is_tuple a = match a.atom_desc with
  | ACast (a, _) -> is_tuple a
  | ATuple _ -> true
  | _ -> false

let rec get_tuple a =
  assert (is_tuple a);
  match a.atom_desc with
  | ACast (a, _) -> get_tuple a
  | ATuple at -> at
  | _ -> assert false

let rec is_simple p = match p.ppat_desc with
  | PWild | PVar _ -> true
  | PCast (p, _) -> is_simple p
  | _ -> false

let rec get_constr p = match p.ppat_desc with
  | PCst _ | PWild | PVar _ | PTuple _ ->
      raise (Invalid_argument "get_constr")
  | PCons (c, _) -> c
  | PCast (p, _) -> get_constr p

let rec get_pargs p = match p.ppat_desc with
  | PCons (_, pl) -> pl
  | PCast (p, _) -> get_pargs p
  | _ -> raise (Invalid_argument "get_pargs")

let rec change_pargs p na = match p.ppat_desc with
  | PCons (c, _) -> { p with ppat_desc = PCons (c, na) }
  | PCast (p, t) -> { p with ppat_desc = PCast (change_pargs p na, t) }
  | _ -> raise (Invalid_argument "change_pargs")

let pattern_type p = match p.ppat_desc with
  | PCast (_, t) -> t
  | _ -> raise (Invalid_argument "pattern_type")

let core_type_to_string t =
  match Parsetree.(t.ptyp_desc) with
  | Parsetree.Ptyp_constr ({ txt; loc = _ }, _) -> E.string_of_longident txt
  | Parsetree.Ptyp_tuple _ -> failwith "todo"
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

type tov = Concrete of string | Abstract of string
let pp_tov fmt =
  let open Format in
  function Concrete s -> fprintf fmt "%s" s
         | Abstract s -> fprintf fmt "'%s" s

let rec get_vars_core_type t =
  match Parsetree.(t.ptyp_desc) with
  | Parsetree.Ptyp_constr ({ txt; _}, []) -> [ Concrete (E.string_of_longident txt) ]
  | Parsetree.Ptyp_constr (_, l) -> List.concat_map get_vars_core_type l
  | Parsetree.Ptyp_var s -> [ Abstract s ]
  | Parsetree.Ptyp_tuple _ -> assert false
  | Parsetree.Ptyp_any -> assert false
  | Parsetree.Ptyp_arrow (_, _, _) -> assert false
  | Parsetree.Ptyp_object (_, _) -> assert false
  | Parsetree.Ptyp_class (_, _) -> assert false
  | Parsetree.Ptyp_alias (_, _) -> assert false
  | Parsetree.Ptyp_variant (_, _, _) -> assert false
  | Parsetree.Ptyp_poly (_, _) -> assert false
  | Parsetree.Ptyp_package _ -> assert false
  | Parsetree.Ptyp_extension _ -> assert false

let instanciate sl t =
  let rec loop t =
    let open Parsetree in
    match t.ptyp_desc with
    | Ptyp_constr (c, l) ->
        let l = List.map loop l in
        let ptyp_desc = Ptyp_constr (c, l) in
        { t with ptyp_desc }
    | Ptyp_var _a ->
        (try List.hd sl with _ -> failwith "broken assumption 1 type argument maximum")
        (* generalize line -1 with: List.assoc a sl *)
    | Ptyp_tuple _ -> assert false
    | Ptyp_any -> assert false
    | Ptyp_arrow (_, _, _) -> assert false
    | Ptyp_object (_, _) -> assert false
    | Ptyp_class (_, _) -> assert false
    | Ptyp_alias (_, _) -> assert false
    | Ptyp_variant (_, _, _) -> assert false
    | Ptyp_poly (_, _) -> assert false
    | Ptyp_package _ -> assert false
    | Ptyp_extension _ -> assert false in
  loop t


let compile
  ~(mk_case: atom -> (pattern * 'a) list -> 'a)
  ~(mk_let:  id -> Parsetree.core_type -> atom -> 'a -> 'a)
  (a: atom) (rl: (pattern list * 'a) list) : 'a =
  let rec compile tl rl = match tl,rl with
    | _, [] -> (* no actions *)
        raise NonExhaustive
    | [], (_,a) :: _ -> (* no terms, at least one action *)
        a
    | t :: tl, _ when is_tuple t ->
        let at = get_tuple t in
        let tl = at @ tl in
        let rl = List.map (function
          | {ppat_desc=PTuple pl; _} :: tl,a -> (pl @ tl), a
          | p :: pl, a ->
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
        let[@warning "-8"] [ty] = atom_types t in
        let name_ty = core_type_to_string ty in
        let rl_tail, fc = (* [fc] = first column of the matrix *)
          List.fold_right (fun (pl,a) (rl, fc) ->
            match pl with [] -> assert false
            | p :: pls -> (pls, a) :: rl, p :: fc)
          rl ([],[]) in
        if List.for_all is_simple fc then begin
          let rl_tail = List.map2 (fun (pl, a) p ->
            let rec loop _ty p =
              match p.ppat_desc with
              | PWild -> a
              | PVar id ->
                  (* let[@warning "-8"] [ty] = atom_types t in *) (* TODO *)
                  mk_let id ty t a
              | PCast (p, t) -> loop t p
              | _ -> assert false in
            pl, loop ty p) rl_tail fc in
          compile tl rl_tail
        end else
          (* the constructors present on the first column *)
          let (_, col_cons) = List.fold_right (fun p (s,acc) ->
            try let c = get_constr p in
                if Sid.mem c s then s, acc
                else Sid.add c s, ((p,c) :: acc)
            with Invalid_argument _ -> (s, acc)) fc (Sid.empty,[]) in
          let mat_c (c: id) at types = (* matrix for constructor [c] *)
            let nwilds = List.map (E.mk_wild_typed ~loc:c.id_loc) types in
            let filtered =
              (* filtered [fc] for [c], filtered [rl] for [c] *)
              List.fold_right2 (fun p (pl,a) acc ->
                let rec take ty p =
                  match p.ppat_desc with
                  | PWild -> (nwilds @ pl, a) :: acc
                  | PVar id ->
                      let a = mk_let id ty t a in
                      (nwilds @ pl, a) :: acc
                  | PCons (cc, l2) when c.id_name = cc.id_name -> (l2 @ pl, a) :: acc
                  | PCons _ -> acc
                  | PCst _ | PTuple _ -> failwith "unreachable"
                  | PCast (p, t) -> take t p in
                take ty p)
              fc rl_tail [] in
            compile (at @ tl) filtered in
          let default_mat =
            let rec collect_lets_opt ty a p =
              match p.ppat_desc with
              | PWild        -> Some a
              | PVar id      ->
                  Some (mk_let id ty t a)
              | PCast (p, t) -> collect_lets_opt t a p
              | _            -> None in
            let rl_tail = List.fold_right2 (fun (pl, a) p acc ->
              match collect_lets_opt ty a p with
              | None -> acc
              | Some a -> (pl, a) :: acc) rl_tail fc [] in
            if rl_tail = [] then []
            else [E.mk_tpattern PWild ty, compile tl rl_tail] in
          let pl = List.fold_right (fun (p,cons) acc ->
            let pargs = get_pargs p in let ts =
              try get_type_informations name_ty cons.id_name
              with ListCons -> List.map pattern_type pargs
            in
            Format.printf "%d %d %s %s@." (List.length pargs) (List.length ts) cons.id_name name_ty;
            let (t_args, p_args) = List.fold_right2 (fun arg tsi (acct, accp) ->
              let i = E.gen_id () in
              let ty = try pattern_type arg with Invalid_argument _ -> tsi in
              let a = E.mk_atom (ACast (E.mk_atom (AId i), ty)) in
              let p = E.mk_pattern (PVar i) in
              let p = E.mk_pattern (PCast (p, ty)) in
              a :: acct, p :: accp) pargs ts ([],[]) in
            let c = change_pargs p p_args in
            let mc = c, mat_c cons t_args ts in
            mc :: acc) col_cons default_mat in
          mk_case t pl in
  compile [a] rl

let dummy_location =
  let loc_start, loc_end = E.dummy_loc in
  let loc_ghost = false in
  Location.{ loc_start ; loc_end ; loc_ghost }

(* type annotate all subpatterns in [pl] *)
let annot a pl =
  let rec f ty p =
    match p.ppat_desc with
    | PCast (p', t) ->
        let ppat_desc = PCast (f ty p', t) in
        { p with ppat_desc }
    | PWild | PVar _ | PCst _ | PTuple _ ->
        let ppat_desc = PCast (p, ty) in
        { p with ppat_desc }
    | PCons (c, pl2) ->
        let name_ty = core_type_to_string ty in
        let tys =
          try get_type_informations name_ty c.id_name
          with ListCons -> List.map pattern_type pl2 in
        let sl = get_vars_core_type ty in
        let tys' = (* instanciate sl in tys *)
          (* let sl = assert false in (* faire la liste d'assoc *) *)
          let mk_core_type ptyp_desc =
            let ptyp_loc = dummy_location in
            Parsetree.
            { ptyp_desc; ptyp_loc; ptyp_loc_stack=[]; ptyp_attributes=[] } in
          let sl = List.map (function Abstract s
            | Concrete s ->
                let loc = dummy_location in
                let txt = Longident.Lident s in
                mk_core_type @@ Parsetree.Ptyp_constr ({loc;txt}, [])
            ) sl in
          List.map (instanciate sl) tys in
        let () = if false then
          let open Format in
          Format.printf "ty = %a | name_ty = %s | sl = %a | tys = @[%a@] | tys' @[%a@]@."
            Pp_ml_lang.pp_pty ty
            name_ty
            (pp_print_list ~pp_sep:pp_print_space pp_tov) sl
            (pp_print_list ~pp_sep:pp_print_space Pp_ml_lang.pp_pty) tys
            (pp_print_list ~pp_sep:pp_print_space Pp_ml_lang.pp_pty) tys' in
        let pl2 = try List.map2 f tys' pl2 with e ->
          Format.printf "ICI %s %d %d@." c.id_name (List.length tys') (List.length pl2);
          raise e in
        let pc = E.mk_pattern (PCons (c, pl2)) in
        let ppat_desc = PCast (pc, ty) in
        { p with ppat_desc } in
  let rec split_ptuple p =
    match p.ppat_desc with
    | PCast (p', t) ->
        List.map (fun p -> { p with ppat_desc = PCast (p, t) })
                 (split_ptuple p')
    | PTuple l -> l
    | _ -> assert false in
  match atom_types a with
  | [    ] -> assert false (* unreachable *)
  | [ ty ] -> List.map (fun (p,action) -> f ty p, action) pl
  | ts ->
      List.map (fun (p,a) ->
        let sp = split_ptuple p in
        let sp = List.map2 f ts sp in
        let pt = { p with ppat_desc = PTuple sp } in
        pt, a) pl

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
      let mk_let x bt e1 e2 =
        let b = x, Some bt in
        E.mk_expr (ELet (b, e1, e2)) in
      let pl = annot a pl in
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
                | Pcstr_tuple l -> l
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

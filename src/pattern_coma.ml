open Ml_lang

module E = Expression_coma

(* binds type name to type constructors *)
let htypes: (string, string list) Hashtbl.t = Hashtbl.create 16

let get_constructors t =
  match Hashtbl.find_opt htypes t with
  | Some cs -> cs
  | None -> []

exception NonExhaustive

(** get the type of an atom *)
let t_type a = match a.atom_desc with
  | ACast (_,t) -> t
  | AId _ -> assert false
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
  | _-> assert false

let compile
  ~(get_constructors: string -> string list)
  ~(mk_case: atom -> (pattern * 'a) list -> 'a)
  ~(mk_let:  binder -> expr -> 'a -> 'a)
  (a: atom) (rl: (pattern list * 'a) list) : 'a =

  let rec compile tl rl = match tl,rl with
    | _, [] -> (* no actions *)
        raise NonExhaustive
    | [], (_,a) :: _ -> (* no terms, at least one action *)
        a
    | t :: tl, _ -> (* process the leftmost column *)

        ignore mk_case;

        let expr_t = E.mk_expr_atom t.atom_desc in
        let ty = t_type t in

        (* extract the set of constructors *)
        let css = get_constructors (t2s ty) in
        Format.printf "%s ::: %d@." (t2s ty) (List.length css);

        (* fc: first column *)
        let rl_tail, fc = List.fold_left_map
          (fun acc (pl,a) -> match pl with [] -> assert false
                             | p::pls -> (pls, a)::acc, p) [] rl in

        let rl_tail, fc = List.(rev rl_tail, rev fc) in

        let simple p = match p.ppat_desc with
          | PWild | PVar _ -> true
          | _ -> false in

        let rec get_constr p = match p.ppat_desc with
          | PWild | PVar _ | PTuple _ -> None
          | PCons (c, _) -> Some c
          | PCast (p, _) -> get_constr p in

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
          compile tl rl_tail
        end else (* not simple *)

          (* then one matrix for each elem of [cs] *)
          let _cs = List.filter_map get_constr fc in

          compile tl rl_tail

  in
  compile [a] rl


let rec expr e = match e.expr_desc with
  | EAtom a ->
      let expr_desc = EAtom (atom a) in
      { e with expr_desc }
  | EAssert -> e
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
      let mk_case _ = assert false in
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


let get_constructor c =
  match Parsetree.(c.ptyp_desc) with
  | Parsetree.Ptyp_constr ({ txt; loc = _ }, _) ->
      Some (E.string_of_longident txt)

  | Parsetree.Ptyp_any
  | Parsetree.Ptyp_var _
  | Parsetree.Ptyp_arrow (_, _, _)
  | Parsetree.Ptyp_tuple _ -> assert false

  (* untreated *)
  | Parsetree.Ptyp_alias (_, _)
  | Parsetree.Ptyp_object (_, _)
  | Parsetree.Ptyp_class (_, _)
  | Parsetree.Ptyp_variant (_, _, _)
  | Parsetree.Ptyp_poly (_, _)
  | Parsetree.Ptyp_package _
  | Parsetree.Ptyp_extension _ -> assert false

let compile_pattern (d: declaration) =
  match d.decl_desc with
  | DFun (r,id,bl,pre,kl,e) ->
      let decl_desc = DFun (r,id,bl,pre,kl, expr e) in
      { d with decl_desc }
  | DType (_, dl) ->
      List.iter (fun Gospel.Uast.{ tname; tparams; _ } ->
        let tp = List.filter_map (fun (c, _) -> get_constructor c) tparams in
        Format.printf "%s +++ %d@." (tname.txt) (List.length tparams);
        (* TODO question: where are the constructor of the types? *)
        Hashtbl.add htypes tname.txt tp)
        dl;
      d
  | DFunction _
  | DProp _ -> d


(*
~/.opam/cameleer/lib/gospel/uast.mli
~/.opam/cameleer/lib/ocaml/compiler-libs/parsetree.mli
*)

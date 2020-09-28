open Why3
open Ptree
open Gospel
module E = Expression
module T = Uterm

type mod_constraint =
  | MCtype_sharing         of type_decl
  | MCtype_destructive     of type_decl
  | MCfunction_sharing     of qualid
  | MCfunction_destructive of qualid

(* TODO: change to Set instead of Hashtbl *)
type subst = (string, mod_constraint) Hashtbl.t

let rec str_of_qualid = function
  | Qident {id_str; _} -> id_str
  | Qdot (q, {id_str; _}) -> (str_of_qualid q) ^ "." ^ id_str

let rec subst_term subst {term_desc; term_loc} =
  let mk_term term_desc = T.mk_term ~term_loc term_desc in
  let term_desc = match term_desc with
    | (Ttrue | Tfalse) as t -> t
    | (Tconst _) as t -> t
    | Tident q -> let id_str = str_of_qualid q in
        let q = try match Hashtbl.find subst id_str with
          | MCfunction_destructive new_q -> new_q
          | _ -> q
          with Not_found -> q in
        Tident q
    | Tasref _ -> assert false (* TODO *)
    | Tidapp _ -> assert false (* TODO *)
    | Tapply (tf, targ) ->
        let tf = subst_term subst tf and targ = subst_term subst targ in
        Tapply (tf, targ)
    | Tinfix (t1, op, t2) ->
        let t1 = subst_term subst t1 and t2 = subst_term subst t2 in
        (* FIXME: take `op` into account *)
        Tinfix (t1, op, t2)
    | Tinnfix _ -> assert false (* TODO *)
    | Tbinop _ -> assert false (* TODO *)
    | Tbinnop _ -> assert false (* TODO *)
    | Tnot _ -> assert false (* TODO *)
    | Tif _ -> assert false (* TODO *)
    | Tquant (q, vars, triggers, t) ->
        let t = subst_term subst t in
        (* TODO: make substitution inside quantified vars *)
        Tquant (q, vars, triggers, t)
    | Tattr _ -> assert false (* TODO *)
    | Tlet _ -> assert false (* TODO *)
    | Tcase _ -> assert false (* TODO *)
    | Tcast _ -> assert false (* TODO *)
    | Ttuple _ -> assert false (* TODO *)
    | Trecord _ -> assert false (* TODO *)
    | Tupdate _ -> assert false (* TODO *)
    | Tscope _ -> assert false (* TODO *)
    | Tat _ -> assert false (* TODO *) in
  mk_term term_desc

let subst_type_decl subst ({td_ident; _} as td) =
  try begin match Hashtbl.find subst td_ident.id_str with
    | MCtype_sharing     mod_td -> [mod_td]
    | MCtype_destructive _      -> []
    | _ -> assert false end
  with Not_found -> [td]

let subst_logic_decl subst ld =
  try begin match Hashtbl.find subst ld.ld_ident.id_str with
    | MCfunction_sharing q ->
        let term_desc = Tident q in
        let term_loc = Loc.dummy_position in
        let term = T.mk_term ~term_loc term_desc in
        [{ ld with ld_def = Some term }]
    | MCfunction_destructive _ ->
        []
    | _ -> assert false end
  with Not_found -> let ld_def = Utils.opmap (subst_term subst) ld.ld_def in
    [{ ld with ld_def }]

let subst_decl subst = function
  | Dtype td_list ->
      let mk_subst acc ty_decl = subst_type_decl subst ty_decl :: acc in
      let subst_decl = List.fold_left mk_subst [] td_list in
      if subst_decl = [[]] then []
      else [Dtype (List.rev (List.flatten subst_decl))]
  | Dlogic ld_list ->
      let mk_subst acc l_decl = subst_logic_decl subst l_decl :: acc in
      let subst_decl = List.fold_left mk_subst [] ld_list in
      if subst_decl = [[]] then []
      else [Dlogic (List.rev (List.flatten subst_decl))]
  | Dind _ -> assert false (* TODO *)
  | Dprop (k, id, t) ->
      [Dprop (k, id, subst_term subst t)]
  | Dlet _ -> assert false (* TODO *)
  | Drec _ -> assert false (* TODO *)
  | Dexn _ -> assert false (* TODO *)
  | Dmeta _ -> assert false (* TODO *)
  | Dcloneexport _ -> assert false (* TODO *)
  | Duseexport _ -> assert false (* TODO *)
  | Dcloneimport _ -> assert false (* TODO *)
  | Duseimport _ -> assert false (* TODO *)
  | Dscope _ -> assert false (* TODO *)
  | Dimport _ -> assert false (* TODO *)

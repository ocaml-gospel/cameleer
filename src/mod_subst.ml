open Why3
open Ptree
open Wstdlib

type mod_constraint =
  | MCtype_sharing of type_decl
  | MCtype_destructive of type_decl
  | MCfunction_sharing of qualid
  | MCfunction_destructive of qualid
  | MCprop of Decl.prop_kind

module Mqual = Map.Make (struct
  type t = Ptree.qualid

  let compare = Stdlib.compare
end)

type subst = {
  subst_ts : Ptree.type_decl Mstr.t;
  subst_td : Ptree.type_decl Mstr.t;
  subst_fs : Ptree.qualid Mstr.t;
  subst_fd : Ptree.qualid Mqual.t;
  subst_ps : Ptree.qualid Mstr.t;
  subst_pd : Ptree.qualid Mqual.t;
  subst_pr : Decl.prop_kind Mqual.t;
}

let empty_subst =
  {
    subst_ts = Mstr.empty;
    subst_td = Mstr.empty;
    subst_fs = Mstr.empty;
    subst_fd = Mqual.empty;
    subst_ps = Mstr.empty;
    subst_pd = Mqual.empty;
    subst_pr = Mqual.empty;
  }

let add_ts_subst k subst td =
  { subst with subst_ts = Mstr.add k td subst.subst_ts }

let add_td_subst k subst td =
  { subst with subst_td = Mstr.add k td subst.subst_td }

let add_fs_subst k subst q =
  { subst with subst_fs = Mstr.add k q subst.subst_fs }

let add_fd_subst k subst q =
  { subst with subst_fd = Mqual.add k q subst.subst_fd }

let add_ps_subst k subst q =
  { subst with subst_ps = Mstr.add k q subst.subst_ps }

let add_pd_subst k subst q =
  { subst with subst_pd = Mqual.add k q subst.subst_pd }

let add_pr_subst k subst pr =
  { subst with subst_pr = Mqual.add k pr subst.subst_pr }

(* FIXME: this is so ugly... *)
(* let rec str_of_qualid = function
 *   | Qident {id_str; _} -> id_str
 *   | Qdot (q, {id_str; _}) -> (str_of_qualid q) ^ "." ^ id_str
 *
 * let rec subst_term subst {term_desc; term_loc} =
 *   let mk_term term_desc = T.mk_term ~term_loc term_desc in
 *   let term_desc = match term_desc with
 *     | (Ttrue | Tfalse) as t -> t
 *     | (Tconst _) as t -> t
 *     | Tident q -> let id_str = str_of_qualid q in
 *         let q = Hstr.find_def subst.subst_fd q id_str in
 *         Tident q
 *     | Tasref _ -> assert false (\* TODO *\)
 *     | Tidapp (q, t_list) ->
 *         let id_str = str_of_qualid q in
 *         let q = Hstr.find_def subst.subst_fd q id_str in
 *         Tidapp (q, List.map (subst_term subst) t_list)
 *     | Tapply (tf, targ) ->
 *         let tf = subst_term subst tf and targ = subst_term subst targ in
 *         Tapply (tf, targ)
 *     | Tinfix (t1, op, t2) ->
 *         let t1 = subst_term subst t1 and t2 = subst_term subst t2 in
 *         (\* FIXME: take `op` into account *\)
 *         Tinfix (t1, op, t2)
 *     | Tinnfix _ -> assert false (\* TODO *\)
 *     | Tbinop (t1, op, t2) ->
 *         let t1 = subst_term subst t1 and t2 = subst_term subst t2 in
 *         Tbinop (t1, op, t2)
 *     | Tbinnop _ -> assert false (\* TODO *\)
 *     | Tnot _ -> assert false (\* TODO *\)
 *     | Tif _ -> assert false (\* TODO *\)
 *     | Tquant (q, vars, triggers, t) ->
 *         let t = subst_term subst t in
 *         (\* TODO: make substitution inside quantified vars *\)
 *         Tquant (q, vars, triggers, t)
 *     | Tattr _ -> assert false (\* TODO *\)
 *     | Tlet _ -> assert false (\* TODO *\)
 *     | Tcase _ -> assert false (\* TODO *\)
 *     | Tcast _ -> assert false (\* TODO *\)
 *     | Ttuple _ -> assert false (\* TODO *\)
 *     | Trecord _ -> assert false (\* TODO *\)
 *     | Tupdate _ -> assert false (\* TODO *\)
 *     | Tscope _ -> assert false (\* TODO *\)
 *     | Tat _ -> assert false (\* TODO *\) in
 *   mk_term term_desc
 *
 * let subst_type_decl subst ({td_ident; _} as td) =
 *   let id_str = td_ident.id_str in
 *   match Hstr.find_opt subst.subst_ts id_str with
 *   | Some mod_td -> [mod_td]
 *   | None   -> match Hstr.find_opt subst.subst_td id_str with
 *   | Some _ -> (\* creative indentation *\)
 *       []
 *   | None   -> [td]
 *
 * let subst_logic_decl subst ld =
 *   let id_str = ld.ld_ident.id_str in
 *   match Hstr.find_opt subst.subst_fs id_str with
 *   | Some q ->
 *       let term_desc = Tident q in
 *       let term_loc = Loc.dummy_position in
 *       let term = T.mk_term ~term_loc term_desc in
 *       [{ ld with ld_def = Some term }]
 *   | None   -> match Hstr.find_opt subst.subst_fd id_str with
 *   | Some _ -> (\* creative indentation *\)
 *       []
 *   | None -> let ld_def = Utils.opmap (subst_term subst) ld.ld_def in
 *       [{ ld with ld_def }]
 *
 * let subst_decl subst = function
 *   | Dtype td_list ->
 *       let mk_subst acc ty_decl = subst_type_decl subst ty_decl :: acc in
 *       let subst_decl = List.fold_left mk_subst [] td_list in
 *       if subst_decl = [[]] then []
 *       else [Dtype (List.rev (List.flatten subst_decl))]
 *   | Dlogic ld_list ->
 *       let mk_subst acc l_decl = subst_logic_decl subst l_decl :: acc in
 *       let subst_decl = List.fold_left mk_subst [] ld_list in
 *       if subst_decl = [[]] then []
 *       else [Dlogic (List.rev (List.flatten subst_decl))]
 *   | Dind _ -> assert false (\* TODO *\)
 *   | Dprop (Decl.Plemma, id, t) ->
 *       (\* FIXME: I am not sure if I can turn each lemma into an axiom *\)
 *       [Dprop (Decl.Paxiom, id, subst_term subst t)]
 *   | Dprop (Decl.Paxiom, id, t) ->
 *       let k = Hstr.find_def subst.subst_pr Decl.Plemma id.id_str in
 *       [Dprop (k, id, subst_term subst t)]
 *   | Dprop (Decl.Pgoal, id, t) ->
 *       [Dprop (Decl.Pgoal, id, subst_term subst t)]
 *   | Dlet _ -> assert false (\* TODO *\)
 *   | Drec _ -> assert false (\* TODO *\)
 *   | Dexn _ -> assert false (\* TODO *\)
 *   | Dmeta _ -> assert false (\* TODO *\)
 *   | Dcloneexport _ -> assert false (\* TODO *\)
 *   | Duseexport _ -> assert false (\* TODO *\)
 *   | Dcloneimport _ -> assert false (\* TODO *\)
 *   | Duseimport _ -> assert false (\* TODO *\)
 *   | Dscope _ -> assert false (\* TODO *\)
 *   | Dimport _ -> assert false (\* TODO *\) *)

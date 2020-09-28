open Why3
open Ptree
module E = Expression

type mod_constraint =
  | MCtype_sharing         of type_decl
  | MCtype_destructive     of type_decl
  | MCfunction_sharing     of qualid
  | MCfunction_destructive of qualid

type subst = (string, mod_constraint) Hashtbl.t

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
        let term_loc  = Loc.dummy_position in
        let term = { term_desc; term_loc } in
        [{ ld with ld_def = Some term }]
    | _ -> assert false end
  with Not_found -> [ld]

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
  | (Dprop _) as p -> [p] (* TODO *)
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

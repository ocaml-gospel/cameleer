open Why3
open Ptree
module E = Expression

type mod_constraint =
  | MCsharing of type_decl
  | MCdestructive of type_decl

type subst = (string, mod_constraint) Hashtbl.t

let subst_type_decl subst ({td_ident; _} as td) =
  try begin match Hashtbl.find subst td_ident.id_str with
    | MCsharing mod_td ->
        { td with td_def = mod_td.td_def;
                  td_vis = Ptree.Public }
    | _ -> assert false (* TODO *) end
  with Not_found -> td

let subst_decl subst = function
  | Dtype td_list ->
      let mk_subst acc ty_decl = subst_type_decl subst ty_decl :: acc in
      let subst_decl = List.fold_left mk_subst [] td_list in
      Dtype (List.rev subst_decl)
  | Dlogic l -> Dlogic l (* TODO *)
  | Dind _ -> assert false (* TODO *)
  | (Dprop _) as p -> p (* TODO *)
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

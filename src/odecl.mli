open Why3
open Mod_subst

type odecl = private
  | Odecl of Loc.position * Ptree.decl
  | Omodule of Loc.position * Ptree.ident * odecl list

val mk_odecl : Loc.position -> Ptree.decl -> odecl
val mk_omodule : Loc.position -> Ptree.ident -> odecl list -> odecl

type path = string list

type info_refinement = private {
  info_ref_name : Ptree.qualid option;
  (* module type name to be refined *)
  info_ref_decl : odecl list;
  (* list of declarations to be refined *)
  info_subst : subst;
  (* module constraints *)
  info_path : string list;
}

val mk_info_refinement :
  Ptree.qualid option -> odecl list -> subst -> path -> info_refinement

type info = private {
  info_arith_construct : (string, int) Hashtbl.t;
  info_refinement : (string, info_refinement) Hashtbl.t;
}

val empty_info : unit -> info
val add_info : info -> string -> int -> unit
val add_info_refinement : info -> string -> info_refinement -> unit
val mk_dtype : Loc.position -> Ptree.type_decl list -> odecl

val mk_dlogic :
  Loc.position -> Ptree.qualid option -> Ptree.logic_decl list -> odecl list

val mk_dprop :
  Loc.position -> Decl.prop_kind -> Ptree.ident -> Ptree.term -> odecl

val mk_ind :
  Loc.position ->
  Ptree.ident ->
  Ptree.param list ->
  (Loc.position * Ptree.ident * Ptree.term) list ->
  odecl

val mk_dlet :
  Loc.position -> Ptree.ident -> bool -> Expr.rs_kind -> Ptree.expr -> odecl

val mk_drec : Loc.position -> Ptree.fundef list -> odecl
val mk_dexn : Loc.position -> Ptree.ident -> Ptree.pty -> Ity.mask -> odecl

val mk_duseimport :
  Loc.position ->
  ?import:bool ->
  (Ptree.qualid * Ptree.ident option) list ->
  odecl

val mk_functor :
  Loc.position -> Ptree.ident -> odecl list -> odecl list -> odecl list

val mk_cloneexport :
  ?odecl_loc:Loc.position -> Ptree.qualid -> Ptree.clone_subst list -> odecl

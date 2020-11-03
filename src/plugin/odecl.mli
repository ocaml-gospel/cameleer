open Why3

type odecl = private
  | Odecl   of Loc.position * Ptree.decl
  | Omodule of Loc.position * Ptree.ident * odecl list

val mk_odecl : Loc.position -> Ptree.decl -> odecl

val mk_omodule : Loc.position -> Ptree.ident -> odecl list -> odecl

type info_refinement = private {
  info_ref_name : string option;
  info_ref_decl : odecl list;
}

type info = private {
  info_arith_construct : (string, int) Hashtbl.t;
  info_refinement      : (string, info_refinement) Hashtbl.t
}

val empty_info : unit -> info

val add_info : info -> string -> int -> unit

val mk_dtype : Loc.position -> Ptree.type_decl list -> odecl

val mk_dlogic :
  Loc.position -> Ptree.qualid option -> Ptree.logic_decl list -> odecl list

val mk_dprop :
  Loc.position -> Decl.prop_kind -> Ptree.ident -> Ptree.term -> odecl

val mk_dlet :
  Loc.position -> Ptree.ident -> bool -> Expr.rs_kind -> Ptree.expr -> odecl

val mk_drec : Loc.position -> Ptree.fundef list -> odecl

val mk_dexn : Loc.position -> Ptree.ident -> Ptree.pty -> Ity.mask -> odecl

val mk_duseimport : Loc.position -> ?import:bool ->
  (Ptree.qualid * Ptree.ident option) list -> odecl

val mk_functor :
  Loc.position -> Ptree.ident -> odecl list -> odecl list -> odecl list

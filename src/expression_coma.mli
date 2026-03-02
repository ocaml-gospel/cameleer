open Ppxlib
open Gospel
open Ml_lang

val dummy_loc : position * position

val string_of_longident : Longident.t -> string

val mk_expr : ?expr_loc:location -> expr_desc -> expr

val mk_decl :
  rec_flag * id * id list * expr -> declaration

val s_value_binding : Uast.s_value_binding -> id * expr

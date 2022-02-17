open Ppxlib
open Gospel
open Why3
open Odecl
module P = Parsetree

val string_of_longident : Longident.t -> string
val empty_spec : Ptree.spec
val mk_expr : ?expr_loc:Loc.position -> Ptree.expr_desc -> Ptree.expr

val mk_fun_def :
  Ptree.ghost -> Expr.rs_kind -> Ptree.ident * Ptree.expr -> Ptree.fundef

val is_ghost : P.attributes -> Ptree.ghost

val longident :
  ?id_loc:Loc.position -> ?prefix:string -> Longident.t -> Ptree.qualid

val core_type : P.core_type -> Ptree.pty

val exception_constructor :
  P.extension_constructor -> Ptree.ident * Ptree.pty * Ity.mask

val s_value_binding : info -> Uast.s_value_binding -> Ptree.ident * Ptree.expr

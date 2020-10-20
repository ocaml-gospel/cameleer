open Gospel
open Why3

module O = Oparsetree

type info = private {
  info_arith_construct : (string, int) Hashtbl.t;
}

val empty_info : unit -> info

val add_info : info -> string -> int -> unit

val string_of_longident : Longident.t -> string

val empty_spec : Ptree.spec

val mk_expr : ?expr_loc:Loc.position -> Ptree.expr_desc -> Ptree.expr

val mk_fun_def :
  Ptree.ghost -> Expr.rs_kind -> (Ptree.ident * Ptree.expr) -> Ptree.fundef

val is_ghost : O.attributes -> Ptree.ghost

val core_type : O.core_type -> Ptree.pty

val exception_constructor :
  O.extension_constructor -> Ptree.ident * Ptree.pty * Ity.mask

val s_value_binding : info -> Uast.s_value_binding -> Ptree.ident * Ptree.expr

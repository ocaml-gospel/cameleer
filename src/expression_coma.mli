open Ppxlib
open Gospel
open Ml_lang

type raise_set

val dummy_loc : position * position
val location : Location.t -> position * position

val preid : Identifier.Preid.t -> id
val gen_id : ?prefix:label -> ?loc:Ml_lang.location -> unit -> id

val cst_true  : constant
val cst_false : constant
val cst_num   : int -> constant

val atom_true  : atom_desc
val atom_false : atom_desc
val atom_num   : int -> atom_desc

val string_of_longident : Longident.t -> string

val mayraise : Uast.s_expression -> raise_set

val mk_atom : ?loc:location -> atom_desc -> atom
val mk_expr : ?loc:location -> expr_desc -> expr
val mk_expr_atom : ?loc:location -> atom_desc -> expr
val mk_pattern : ?loc:location -> pattern_desc -> pattern
val mk_decl :
  rec_flag * id * binder list * Uast.term list * kont list * expr -> declaration

val s_value_binding : rec_flag -> Uast.s_value_binding -> id -> declaration

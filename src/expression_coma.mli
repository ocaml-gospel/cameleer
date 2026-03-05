open Ppxlib
open Gospel
open Ml_lang

val dummy_loc : position * position
val location : Location.t -> position * position

val preid : Identifier.Preid.t -> id

val cst_true  : constant
val cst_false : constant
val cst_num   : int -> constant

val atom_true  : atom_desc
val atom_false : atom_desc
val atom_num   : int -> atom_desc

val string_of_longident : Longident.t -> string

val term : Uast.term -> expr

val mk_atom : ?loc:location -> atom_desc -> atom
val mk_expr : ?loc:location -> expr_desc -> expr

val mk_decl :
  rec_flag * id * id list * id list * expr * Uast.val_spec option -> declaration

val s_value_binding : rec_flag -> Uast.s_value_binding -> id -> declaration

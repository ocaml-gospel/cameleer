open Gospel
open Why3
open Expression

type odecl = private
  | Odecl   of Loc.position * Ptree.decl
  | Omodule of Loc.position * Ptree.ident * odecl list

val mk_duseimport : Loc.position -> ?import:bool ->
  (Ptree.qualid * Ptree.ident option) list -> odecl

val s_structure : info -> Uast.s_structure -> odecl list
val s_signature : info -> Uast.s_signature -> odecl list

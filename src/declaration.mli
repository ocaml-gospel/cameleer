open Gospel
open Odecl

val s_structure : info -> Uast.s_structure -> odecl list
val s_signature : info -> Uast.s_signature -> odecl list

val gospel_function : Uast.function_ -> Odecl.odecl

open Why3
open Gospel

val loc_of_lb_arg : Uast.labelled_arg -> Loc.position
val ident_of_lb_arg : Uast.labelled_arg -> Ptree.ident
val empty_spec : Ptree.spec
val vspec : Uast.val_spec -> Ptree.spec
val fun_spec : Uast.fun_spec -> Ptree.spec
val spec_union : Ptree.spec -> Ptree.spec -> Ptree.spec

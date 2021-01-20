open Gospel
open Why3

val dummy_loc : Loc.position

val location : Warnings.loc -> Loc.position

val mk_id :
  ?id_ats:Ptree.attr list -> ?id_loc:Loc.position -> string -> Ptree.ident

val mk_term : ?term_loc:Loc.position -> Ptree.term_desc -> Ptree.term

val ident_of_tvsymbol : Ttypes.tvsymbol -> Ptree.ident
val ident_of_lsymbol  : Tterm.lsymbol   -> Ptree.ident

val mk_pattern : ?pat_loc:Loc.position -> Ptree.pat_desc -> Ptree.pattern

val constant : Oasttypes.constant -> Constant.constant

val preid : Identifier.preid -> Ptree.ident

val qualid : Uast.qualid -> Ptree.qualid

val pty : Uast.pty  -> Ptree.pty
val ty  : Ttypes.ty -> Ptree.pty

val pattern : Uast.pattern -> Ptree.pattern

val term : Uast.term -> Ptree.term

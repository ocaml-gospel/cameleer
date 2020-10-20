open Why3
open Wstdlib

type mod_constraint =
  | MCtype_sharing         of Ptree.type_decl
  | MCtype_destructive     of Ptree.type_decl
  | MCfunction_sharing     of Ptree.qualid
  | MCfunction_destructive of Ptree.qualid
  | MCprop                 of Decl.prop_kind

type subst = private {
  subst_ts : Ptree.type_decl Hstr.t;
  subst_td : Ptree.type_decl Hstr.t;
  subst_fs : Ptree.qualid Hstr.t;
  subst_fd : Ptree.qualid Hstr.t;
  subst_pr : Decl.prop_kind Hstr.t
}

val empty_subst : subst

val subst_decl : subst -> Ptree.decl -> Ptree.decl list

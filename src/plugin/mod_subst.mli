open Why3

type mod_constraint =
  | MCtype_sharing         of Ptree.type_decl
  | MCtype_destructive     of Ptree.type_decl
  | MCfunction_sharing     of Ptree.qualid
  | MCfunction_destructive of Ptree.qualid
  | MCprop                 of Decl.prop_kind

module Mqual : Map.S with type key = Ptree.qualid

type subst = private {
  subst_ts : Ptree.type_decl Mqual.t;
  subst_td : Ptree.type_decl Mqual.t;
  subst_fs : Ptree.qualid Mqual.t;
  subst_fd : Ptree.qualid Mqual.t;
  subst_pr : Decl.prop_kind Mqual.t
}

val empty_subst : subst

val add_ts_subst : Mqual.key -> Ptree.type_decl -> subst -> subst
val add_td_subst : Mqual.key -> Ptree.type_decl -> subst -> subst
val add_fs_subst : Mqual.key -> Ptree.qualid    -> subst -> subst
val add_fd_subst : Mqual.key -> Ptree.qualid    -> subst -> subst
val add_pr_subst : Mqual.key -> Decl.prop_kind  -> subst -> subst

(* val subst_decl : subst -> Ptree.decl -> Ptree.decl list *)

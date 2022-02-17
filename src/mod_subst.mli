open Why3
open Wstdlib

type mod_constraint =
  | MCtype_sharing of Ptree.type_decl
  | MCtype_destructive of Ptree.type_decl
  | MCfunction_sharing of Ptree.qualid
  | MCfunction_destructive of Ptree.qualid
  | MCprop of Decl.prop_kind

module Mqual : Map.S with type key = Ptree.qualid

type subst = private {
  subst_ts : Ptree.type_decl Mstr.t;
  subst_td : Ptree.type_decl Mstr.t;
  subst_fs : Ptree.qualid Mstr.t;
  subst_fd : Ptree.qualid Mqual.t;
  subst_ps : Ptree.qualid Mstr.t;
  subst_pd : Ptree.qualid Mqual.t;
  subst_pr : Decl.prop_kind Mqual.t;
}

val empty_subst : subst
val add_ts_subst : Mstr.key -> subst -> Ptree.type_decl -> subst
val add_td_subst : Mstr.key -> subst -> Ptree.type_decl -> subst
val add_fs_subst : Mstr.key -> subst -> Ptree.qualid -> subst
val add_fd_subst : Mqual.key -> subst -> Ptree.qualid -> subst
val add_ps_subst : Mstr.key -> subst -> Ptree.qualid -> subst
val add_pd_subst : Mqual.key -> subst -> Ptree.qualid -> subst
val add_pr_subst : Mqual.key -> subst -> Decl.prop_kind -> subst

(* val subst_decl : subst -> Ptree.decl -> Ptree.decl list *)

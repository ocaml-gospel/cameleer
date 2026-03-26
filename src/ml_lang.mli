(** An AST for a ML-like toy langauge.
    All the terms are written in A-normal form to ease
    CPS-conversion later. *)

open Gospel
module U = Uast

open Ppxlib
module P = Parsetree

type location = Lexing.position * Lexing.position

(* Each identifier has a name and a location *)
type id = { id_name: string; id_loc: location }

type binder = id * P.core_type option

type constant = CNum of int | CBool of bool | CUnit

type op = OPAdd | OPMinus | OPMult | OPDiv | OPMod
        | OPEq | OPLe | OPLt | OPGe | OPGt
        | OPAnd | OPOr | OPNot

type pattern = {
  ppat_loc: location;
  ppat_desc: pattern_desc;
}

and pattern_desc =
  | PWild                                     (* catch all pattern: _        *)
  | PVar of id                                (* catch all+binder:  x        *)
  | PCons of id * pattern list                (* constructor:   Cons(x, xs)  *)
  | PTuple of pattern list                    (* multiple pattern: p1, p2, … *)
  | PCast of pattern * P.core_type            (* [P: T] *)
  | PCst  of constant

type expr = {
  expr_loc: location;
  expr_desc: expr_desc;
}

and expr_desc =
  | EAtom of atom
  | EFail
  | ELet  of binder * expr * expr                 (* let p = e in e          *)
  | ELetK of id * binder * (id * P.core_type) option * expr * expr
                                        (* let_cont h x (o (_: ty) = e in e  *)
  | EApp  of callable * atom list * callable list (* k a…a k…k               *)
  | EIf of atom * expr * expr
  | EHide of expr
  | EAssert of U.term list * expr               (* U.term list = “U.fun_req” *)
  | EMatch of atom * (pattern * expr) list

and atom = {
  atom_loc: location;
  atom_desc: atom_desc;
}

and atom_desc =
  | AId of id
  | ABinop of expr * op * expr
  | AUnop of op * expr
  | ACst of constant
  | AFun of bool * binder * expr
  | ATuple of atom list
  | ACons of id * atom list
  | ACast of atom * P.core_type

and callable = {
  callable_loc: location;
  callable_desc: callable_desc;
}

and callable_desc =
  | CId  of id                           (* handler name                   *)
  | CFun of binder list * id list * expr (* data params, kont params, body *)

type rec_flag = Asttypes.rec_flag

type precondition = U.term list

type kont = {
  kont_id: id;
  kont_arg: binder list;
  kont_kont: kont list;
  kont_pre: precondition;
}

type declaration = {
  decl_loc: location;
  decl_desc: declaration_desc;
}

(** 1st [id list] is for data parameters
    2nd [id list] is for continuation parameters
    and [expr] is the body. *)
and declaration_desc =
  | DFun of rec_flag * id * binder list * precondition * kont list * expr
  | DType of rec_flag * U.s_type_declaration list
  | DFunction of U.function_
  | DProp of U.prop

type program = declaration list


(* ------------------------------------------------------------------------- *)

(** An intermediate AST for a ML-like toy language to COMA.
    All the terms are written in A-normal form to ease
    CPS-conversion later. *)
open Why3

type cprecondition = Ptree.term list
(* a WhyML precondition *)

type cbinder = id * Ptree.pty option

type info_p = cbinder list

type ckont = {
  ckont_id: id;
  ckont_arg: cbinder list;
  ckont_kont: ckont list;
  ckont_pre: cprecondition;
}

(* type cpattern = {
  cppat_loc: location;
  cppat_desc: cpattern_desc;
}

and cpattern_desc =
  | CPWild                                (* catch all pattern: _            *)
  | CPVar of id                           (* catch all+binder:  x            *)
  | CPCons of id * cpattern list          (* constructor:       Cons(x, xs)  *)
  | CPTuple of cpattern list              (* multiple pattern:  p1, p2, …    *)
  | CPCast of cpattern * Ptree.pty        (* [P: T] *) *)

type cexpr = {
  cexpr_loc: location;
  cexpr_desc: cexpr_desc;
}

and cexpr_desc =
  | CEAtom of catom
  | CEFail
  | CEAssert of cprecondition * cexpr
  | CEHide of cexpr
  | CELet of cbinder * cexpr * cexpr
  | CELetK of id * cbinder * (id * Ptree.pty) option * cexpr * cexpr
                                                       (* let_cont h x = e in e *)
  | CEApp of ccallable * catom list * ccallable list   (* k a…a k…k *)
  | CEIf of catom * cexpr * cexpr
  | CEDestruct of id * catom * (info_p * cexpr) list

and catom = {
  catom_loc: location;
  catom_desc: catom_desc;
}

and catom_desc =
  | CAId of id
  | CABinop of cexpr * op * cexpr
  | CAUnop of op * cexpr
  | CACst of constant
  | CAFun of cbinder * cexpr
  | CATuple of catom list
  | CACons of id * catom list
  | CACast of catom * Ptree.pty

and ccallable = {
  ccallable_loc: location;
  ccallable_desc: ccallable_desc;
}

and ccallable_desc =
  | CCId  of id (* handler name *)
  | CCFun of cbinder list * cprecondition * id list * cexpr
  (* data params, precondition, kont params, body *)

type cdeclaration = {
  cdecl_loc: location;
  cdecl_desc: cdeclaration_desc;
}

(** 1st [id list] is for data parameters
    2nd [id list] is for continuation parameters
    and [expr] is the body. *)
and cdeclaration_desc =
  | CDFun of rec_flag * id * cbinder list * (cprecondition * bool) * ckont list * cexpr
  | CDLogic of Ptree.decl (* Purely logical WhyML declarations *)

type cprogram = cdeclaration list

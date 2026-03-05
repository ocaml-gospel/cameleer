(** An AST for a ML-like toy langauge.
    All the terms are written in A-normal form to ease
    CPS-conversion later. *)

open Gospel
module U = Uast

type location = Lexing.position * Lexing.position

(* Each identifier has a name and a location *)
type id = { id_name: string; id_loc: location }

type constant = CNum of int | CBool of bool

type op = OPAdd | OPMinus | OPMult | OPDiv | OPEq | OPLe

type pattern = {
  ppat_loc: location;
  ppat_desc: pattern_desc;
}

and pattern_desc =
  | PWild                                     (* catch all pattern: _        *)
  | PVar of id                                (* catch all+binder:  x        *)
  | PCons of id * pattern list                (* constructor:   Cons(x, xs)  *)
  | PTuple of pattern list                    (* multiple pattern: p1, p2, … *)

type expr = {
  expr_loc: location;
  expr_desc: expr_desc;
}

and expr_desc =
  | EAtom of atom
  | EAssert
  | ELet  of pattern * expr * expr                  (* let p = e in e        *)
  | ELetK of id * id * expr * expr                  (* let_cont h x = e in e *)
  | EApp  of callable * atom list * callable list   (* k a…a k…k *)
  | EIf of atom * expr * expr
  | EMatch of atom list * (pattern * expr) list

and atom = {
  atom_loc: location;
  atom_desc: atom_desc;
}

and atom_desc =
  | AId of id
  | ABinop of expr * op * expr
  | ACst of constant
  | AFun of bool * id * expr
  | ATuple of atom list
  | ACons of id * atom list

and callable = {
  callable_loc: location;
  callable_desc: callable_desc;
}

and callable_desc =
  | CId  of id                             (* handler name                   *)
  | CFun of id list * id list * expr       (* data params, kont params, body *)

type rec_flag = Asttypes.rec_flag

type declaration = {
  decl_loc: location;
  decl_desc: declaration_desc;
}

(* id list are the parameters and expr is the body *)
and declaration_desc =
  | DFun of rec_flag * id * id list * expr * U.val_spec option
  | DType of rec_flag * U.s_type_declaration list

type program = declaration list


(* ------------------------------------------------------------------------- *)

(** An intermediate AST for a ML-like toy language to COMA.
    All the terms are written in A-normal form to ease
    CPS-conversion later. *)

type info_p = id list 

type cpattern = {
  cppat_loc: location;
  cppat_desc: cpattern_desc;
}

and cpattern_desc =
  | CPWild                                (* catch all pattern: _            *)
  | CPVar of id                           (* catch all+binder:  x            *)
  | CPCons of id * cpattern list          (* constructor:       Cons(x, xs)  *)
  | CPTuple of cpattern list              (* multiple pattern:  p1, p2, …    *)

type cexpr = {
  cexpr_loc: location;
  cexpr_desc: cexpr_desc;
}

and cexpr_desc =
  | CEAtom of catom
  | CEAssert
  | CELet of cpattern * cexpr * cexpr
  | CELetK of id * id * cexpr * cexpr                  (* let_cont h x = e in e *)
  | CEApp of ccallable * catom list * ccallable list   (* k a…a k…k *)
  | CEIf of catom * cexpr * cexpr
  | CEDestruct of catom list * (info_p * cexpr) list

and catom = {
  catom_loc: location;
  catom_desc: catom_desc;
}

and catom_desc =
  | CAId of id
  | CABinop of cexpr * op * cexpr
  | CACst of constant
  | CAFun of id * cexpr
  | CATuple of catom list
  | CACons of id * catom list


and ccallable = {
  ccallable_loc: location;
  ccallable_desc: ccallable_desc;
}

and ccallable_desc =
  | CCId  of id                             (* handler name                   *)
  | CCFun of id list * id list * cexpr      (* data params, kont params, body *)

type cdeclaration = {
  cdecl_loc: location;
  cdecl_desc: cdeclaration_desc;
}

(** [id list] are the parameters and [expr] is the body. *)
and cdeclaration_desc =
  | CDFun of rec_flag * id * id list * cexpr
  | CDType of rec_flag * U.s_type_declaration list

type cprogram = cdeclaration list


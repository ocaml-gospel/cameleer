(** An AST for a ML-like toy langauge.
    All the terms are written in A-normal form to ease
    CPS-conversion later. *)

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
  | PWild                       (* _ *)
  | PVar of id                  (* x *)
  | PCons of id * pattern list  (* Cons(x, xs) *)
  | PTuple of pattern list      (* p1, p2, … *)

type expr = {
  expr_loc: location;
  expr_desc: expr_desc;
}

and expr_desc =
  | EAtom of atom
  | EAssert
  | ELet of pattern * expr * expr
  | EApp of expr * atom list   (* function application *)
  | EIf of atom * expr * expr
  | EMatch of atom * (pattern * expr) list

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

type rec_flag = Recursive | NonRecursive

type declaration = {
  decl_loc: location;
  decl_desc: declaration_desc;
}

(* id list are the parameters and expr is the body *)
and declaration_desc =
  | DFun of rec_flag * id * id list * expr

type program = declaration list





(* --------------------- *)

(** An intermediate AST for a ML-like toy language to COMA.
    All the terms are written in A-normal form to ease
    CPS-conversion later. *)

type info_p = id list 

type cpattern = {
  cppat_loc: location;
  cppat_desc: cpattern_desc;
}

and cpattern_desc =
  | CPWild                       (* _ *)
  | CPVar of id                  (* x *)
  | CPCons of id * cpattern list (* Cons(x, xs) *)

type cexpr = {
  cexpr_loc: location;
  cexpr_desc: cexpr_desc;
}

and cexpr_desc =
  | CEAtom of catom
  | CEAssert
  | CELet of cpattern * cexpr * cexpr
  | CEApp of cexpr * catom list   (* function application *)
  | CEIf of catom * cexpr * cexpr
  | CEDestruct of catom * (info_p * cexpr) list

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

type cdeclaration = {
  cdecl_loc: location;
  cdecl_desc: cdeclaration_desc;
}

(* id list are the parameters and expr is the body *)
and cdeclaration_desc =
  | CDFun of rec_flag * id * id list * cexpr

type cprogram = cdeclaration list


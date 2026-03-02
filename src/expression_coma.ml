open Ppxlib
(* open Gospel *)
open Ml_lang

let dummy_loc = Lexing.dummy_pos, Lexing.dummy_pos

let string_of_longident (_l: Longident.t) = "todo"

let mk_expr ?(expr_loc=dummy_loc) expr_desc =
  { expr_loc ; expr_desc }

let mk_decl (rec_flag, id, params, e) =
  { decl_loc  = id.id_loc;
    decl_desc = DFun (rec_flag, id, params, e); }

let s_value_binding _ = assert false
 (* : Uast.s_value_binding -> id * expr *)

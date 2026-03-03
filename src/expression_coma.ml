open Ppxlib
open Gospel
open Ml_lang

let dummy_loc = Lexing.dummy_pos, Lexing.dummy_pos

let location {loc_start; loc_end; _} =
  (loc_start, loc_end)

let cst_true = CBool true
let cst_false = CBool false
let cst_num n = CNum n

let atom_true = ACst cst_true
let atom_false = ACst cst_false
let atom_num n = ACst (cst_num n)

let mk_atom ?(loc=dummy_loc) atom_desc =
  { atom_loc=loc ; atom_desc }

let string_of_longident (_l: Longident.t) = "todo"

let mk_expr ?(loc=dummy_loc) expr_desc =
  { expr_loc=loc ; expr_desc }

let mk_decl (rec_flag, id, params, e) =
  { decl_loc  = id.id_loc;
    decl_desc = DFun (rec_flag, id, params, e); }

let s_value_binding _ = assert false
 (* : Uast.s_value_binding -> id * expr *)

let mk_id ?(loc=dummy_loc) id_name =
  { id_name; id_loc=loc }

let eatom ?(loc=dummy_loc) a = EAtom (mk_atom ~loc a)

let preid Uast.Preid.{ pid_str; pid_loc; _ } =
  mk_id ~loc:(location pid_loc) pid_str

let qualid = function
  | Uast.Qpreid id -> preid id
  | Uast.Qdot _ -> assert false

let mk_expr_atom ?(loc=dummy_loc) ad =
  mk_expr ~loc (eatom ~loc ad)

let constant = function
  | Pconst_integer (s, _) ->
      if s.[0] = '-' then
        let s = String.sub s 1 (String.length s - 1) in
        let n = Why3.Number.int_literal ILitDec ~neg:false s in
        let n = Why3.Number.neg_int n in
        let n = Why3.Number.to_small_integer n in
        atom_num n
      else
        let n = Why3.Number.int_literal ILitDec ~neg:false s in
        let n = Why3.Number.to_small_integer n in
        atom_num n
  | _ -> assert false

let term (t: Uast.term) =
  let loc = location t.term_loc in
  let mk_expr_atom = mk_expr_atom ~loc in
  match t.term_desc with
    | Ttrue             -> mk_expr_atom atom_true
    | Tfalse            -> mk_expr_atom atom_false
    | Tconst c          -> mk_expr_atom (constant c)
    | Tpreid id         -> mk_expr_atom (AId (qualid id))
    | Tidapp (_, _)     -> assert false
    | Tfield (_, _)     -> assert false
    | Tapply (_, _)     -> assert false
    | Tinfix (_, _, _)  -> assert false
    | Tbinop (_, _, _)  -> assert false
    | Tnot _            -> assert false
    | Tif (_, _, _)     -> assert false
    | Tquant (_, _, _)  -> assert false
    | Tattr (_, _)      -> assert false
    | Tlet (id, _t1, _t2) ->
        let _id = preid id in
        (* ELet ( *)
        assert false
    | Tcase (_, _)      -> assert false
    | Tcast (_, _)      -> assert false
    | Ttuple _          -> assert false
    | Trecord _         -> assert false
    | Tupdate (_, _)    -> assert false
    | Tscope (_, _)     -> assert false
    | Told _            -> assert false

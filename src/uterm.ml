open Ppxlib
open Why3
open Ptree
open Gospel
open Identifier
open Why3ocaml_driver
module D = Why3.Dterm
module Ty = Ttypes
module P = Parsetree

let empty_spec =
  {
    sp_pre = [];
    sp_post = [];
    sp_xpost = [];
    sp_reads = [];
    sp_writes = [];
    sp_alias = [];
    sp_variant = [];
    sp_checkrw = false;
    sp_diverge = false;
    sp_partial = false;
  }

let dummy_loc = Loc.dummy_position
let location Location.{ loc_start = b; loc_end = e; _ } = Loc.extract (b, e)

let mk_id ?(id_ats = []) ?(id_loc = dummy_loc) id_str =
  { id_str; id_ats; id_loc }

let mk_term ?(term_loc = dummy_loc) term_desc = { term_desc; term_loc }
let mk_expr ?(expr_loc = dummy_loc) expr_desc = { expr_desc; expr_loc }
let mk_pattern ?(pat_loc = dummy_loc) pat_desc = { pat_desc; pat_loc }

let ident_of_tvsymbol Ty.{ tv_name = name } =
  mk_id name.id_str ~id_loc:(location name.id_loc)

let ident_of_lsymbol Symbols.{ ls_name = name; _ } =
  mk_id name.id_str ~id_loc:(location name.id_loc)

let constant = function
  | P.Pconst_integer (s, _) ->
      if s.[0] = '-' then
        let s = String.sub s 1 (String.length s - 1) in
        let n = Number.int_literal ILitDec ~neg:false s in
        Constant.(ConstInt (Number.neg_int n))
      else
        let n = Number.int_literal ILitDec ~neg:false s in
        Constant.ConstInt n
  | P.Pconst_string (s, _, _) -> Constant.ConstStr s
  | Pconst_float _ -> assert false (* TODO *)
  | _ -> assert false

let preid Preid.{ pid_str; pid_loc; _ } =
  (* FIXME: right place for driver lookup? *)
  let pid_str = match query_syntax pid_str with Some s -> s | _ -> pid_str in
  mk_id ~id_loc:(location pid_loc) pid_str

let rec qualid = function
  | Uast.Qpreid id -> Qident (preid id)
  | Uast.Qdot (q, id) -> Qdot (qualid q, preid id)

let rec pty = function
  | Uast.PTtyvar id -> PTtyvar (preid id)
  | Uast.PTtuple pty_list -> PTtuple (List.map pty pty_list)
  | Uast.PTarrow (_, pty1, pty2) -> PTarrow (pty pty1, pty pty2)
  | Uast.PTtyapp (q, pty_list) -> PTtyapp (qualid q, List.map pty pty_list)

let rec ty Ty.{ ty_node } =
  match ty_node with
  | Ty.Tyvar { tv_name } ->
      PTtyvar (mk_id tv_name.id_str ~id_loc:(location tv_name.id_loc))
  | Ty.Tyapp (ts, tyl) when Ty.is_ts_tuple ts -> PTtuple (List.map ty tyl)
  | Ty.Tyapp (ts, tyl) when Ty.is_ts_arrow ts ->
      let rec arrow_of_pty_list = function
        | [] -> assert false
        | [ pty ] -> pty
        | arg :: ptyl -> PTarrow (arg, arrow_of_pty_list ptyl)
      in
      arrow_of_pty_list (List.map ty tyl)
  | Ty.Tyapp ({ ts_ident; _ }, tyl) ->
      let id_loc = location ts_ident.id_loc in
      let id_str =
        match query_syntax ts_ident.id_str with
        | None -> ts_ident.id_str
        | Some s -> s
      in
      let qualid = mk_id id_str ~id_loc in
      PTtyapp (Qident qualid, List.map ty tyl)

let quant = function
  | Uast.Tforall -> D.DTforall
  | Uast.Texists -> D.DTexists
  | Uast.Tlambda -> D.DTlambda

let rec pattern Uast.{ pat_desc = p_desc; pat_loc } =
  let pat_loc = location pat_loc in
  let mk_pat p = mk_pattern ~pat_loc p in
  let qualid_pattern (q, pat) = (qualid q, pattern pat) in
  let pat_desc = function
    | Uast.Pwild -> Pwild
    | Uast.Pvar id -> Pvar (preid id)
    | Uast.Papp (q, pat_list) -> Papp (qualid q, List.map pattern pat_list)
    | Uast.Prec q_pat_list -> Prec (List.map qualid_pattern q_pat_list)
    | Uast.Ptuple pat_list -> Ptuple (List.map pattern pat_list)
    | Uast.Pas (pat, id) -> Pas (pattern pat, preid id, false)
    | Uast.Por (pat1, pat2) -> Por (pattern pat1, pattern pat2)
    | Uast.Pcast (pat, ty) -> Pcast (pattern pat, pty ty)
  in
  mk_pat (pat_desc p_desc)

let binder (id, ty) =
  (location id.Preid.pid_loc, Some (preid id), false, Option.map pty ty)

let rec term in_post Uast.{ term_desc = t_desc; term_loc } =
  let term_loc = location term_loc in
  let mk_term t = mk_term ~term_loc t in
  let binop = function
    | Uast.Tand -> D.DTand
    | Uast.Tand_asym -> D.DTand_asym
    | Uast.Tor -> D.DTor
    | Uast.Tor_asym -> D.DTor_asym
    | Uast.Timplies -> D.DTimplies
    | Uast.Tiff -> D.DTiff
  in
  let attr a = ATstr (Why3.Ident.create_attribute a) in
  let pat_term (pat, t) = (pattern pat, term in_post t) in
  let qualid_term (q, t) = (qualid q, term in_post t) in
  let term_desc = function
    | Uast.Ttrue -> Ttrue
    | Uast.Tfalse -> Tfalse
    | Uast.Tconst c -> Tconst (constant c)
    | Uast.Tpreid id -> Tident (qualid id)
    | Uast.Tidapp (q, tl) -> Tidapp (qualid q, List.map (term in_post) tl)
    | Uast.Tfield (t, q) -> Tidapp (qualid q, [ term in_post t ])
    | Uast.Tapply (t1, t2) -> Tapply (term in_post t1, term in_post t2)
    | Uast.Tnot t -> Tnot (term in_post t)
    | Uast.Tattr (a, t) -> Tattr (attr a, term in_post t)
    | Uast.Tcast (t, ty) -> Tcast (term in_post t, pty ty)
    | Uast.Ttuple t_list -> Ttuple (List.map (term in_post) t_list)
    | Uast.Trecord q_t_list -> Trecord (List.map qualid_term q_t_list)
    | Uast.Tscope (q, t) -> Tscope (qualid q, term in_post t)
    | Uast.Tcase (t, pt_list) ->
        Tcase (term in_post t, List.map pat_term pt_list)
    | Uast.Tlet (id, t1, t2) -> Tlet (preid id, term in_post t1, term in_post t2)
    | Uast.Tinfix (t1, id, t2) ->
        Tinfix (term in_post t1, preid id, term in_post t2)
    | Uast.Tbinop (t1, op, t2) ->
        Tbinop (term in_post t1, binop op, term in_post t2)
    | Uast.Told t ->
        let lbl = if in_post then Dexpr.old_label else "'Old" in
        Tat (term in_post t, mk_id ~id_loc:term_loc lbl)
    | Uast.Tif (t1, t2, t3) ->
        Tif (term in_post t1, term in_post t2, term in_post t3)
    | Uast.Tupdate (t, q_t_list) ->
        Tupdate (term in_post t, List.map qualid_term q_t_list)
    | Uast.Tquant (q, bl, t) ->
        Tquant (quant q, List.map binder bl, [], term in_post t)
  in
  mk_term (term_desc t_desc)

let rec expr Uast.{ term_desc = t_desc; term_loc } =
  let expr_loc = location term_loc in
  let mk_expr t = mk_expr ~expr_loc t in
  let binop t1 t2 = function
    | Uast.Tand -> assert false (* FIXME: add a better error message *)
    | Uast.Tand_asym -> Eand (expr t1, expr t2)
    | Uast.Tor -> assert false
    | Uast.Tor_asym -> Eor (expr t1, expr t2)
    | Uast.Timplies -> assert false
    | Uast.Tiff -> assert false
  in
  let attr a = ATstr (Why3.Ident.create_attribute a) in
  let pat_expr (pat, t) = (pattern pat, expr t) in
  let qualid_expr (q, t) = (qualid q, expr t) in
  let is_arith = function
    (* TODO: complete this list *)
    | "infix +" | "infix -" | "infix *" -> true
    | "infix <=" -> true
    | "infix >=" -> true (* assert false (\* TODO *\) *)
    | _ -> false
  in
  let expr_desc = function
    | Uast.Ttrue -> Etrue
    | Uast.Tfalse -> Efalse
    | Uast.Tconst c -> Econst (constant c)
    | Uast.Tpreid id -> Eident (qualid id)
    | Uast.Tidapp ((Qpreid q as qq), [ t1; t2 ]) ->
        if is_arith q.pid_str then
          let f = mk_expr (Eidpur (qualid qq)) in
          let f_app = mk_expr (Eapply (f, expr t1)) in
          Eapply (f_app, expr t2)
        else Eidapp (qualid qq, [ expr t1; expr t2 ])
    | Uast.Tidapp (q, tl) -> Eidapp (qualid q, List.map expr tl)
    | Uast.Tfield (t, q) -> Eidapp (qualid q, [ expr t ])
    | Uast.Tapply (t1, t2) -> Eapply (expr t1, expr t2)
    | Uast.Tnot t -> Enot (expr t)
    | Uast.Tattr (a, t) -> Eattr (attr a, expr t)
    | Uast.Tcast (t, ty) -> Ecast (expr t, pty ty)
    | Uast.Ttuple t_list -> Etuple (List.map expr t_list)
    | Uast.Trecord q_t_list -> Erecord (List.map qualid_expr q_t_list)
    | Uast.Tscope (q, t) -> Escope (qualid q, expr t)
    | Uast.Tcase (t, pt_list) -> Ematch (expr t, List.map pat_expr pt_list, [])
    | Uast.Tlet (id, t1, t2) ->
        Elet (preid id, false, Expr.RKnone, expr t1, expr t2)
    | Uast.Tinfix (t1, id, t2) when is_arith id.pid_str ->
        let f = mk_expr (Eidpur (Qident (preid id))) in
        let f_app = mk_expr (Eapply (f, expr t1)) in
        Eapply (f_app, expr t2)
    | Uast.Tinfix (t1, id, t2) -> Einfix (expr t1, preid id, expr t2)
    | Uast.Tbinop (t1, op, t2) -> binop t1 t2 op
    | Uast.Told _ -> assert false (* FIXME: add a better error message *)
    | Uast.Tif (t1, t2, t3) -> Eif (expr t1, expr t2, expr t3)
    | Uast.Tupdate (t, q_t_list) ->
        Eupdate (expr t, List.map qualid_expr q_t_list)
    | Uast.Tquant (Tlambda, binders, t) ->
        Efun
          ( List.map binder binders,
            None,
            mk_pattern Pwild,
            Ity.MaskVisible,
            empty_spec,
            expr t )
    | Uast.Tquant _ -> assert false
    (* FIXME: add a better error message *)
  in
  mk_expr (expr_desc t_desc)

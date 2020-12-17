open Why3
open Ptree
open Gospel
open Oasttypes
open Identifier
open Why3ocaml_driver
module D = Why3.Dterm
module Ty = Ttypes

let dummy_loc = Loc.dummy_position

let location Location.{loc_start = b; loc_end = e; _} =
  Loc.extract (b, e)

let mk_id ?(id_ats=[]) ?(id_loc=dummy_loc) id_str =
  { id_str; id_ats; id_loc }

let mk_term ?(term_loc=dummy_loc) term_desc =
  { term_desc; term_loc }

let mk_pattern ?(pat_loc=dummy_loc) pat_desc =
  { pat_desc; pat_loc }

(* TO BE USED : *)
let ident_of_tvsymbol Ty.{tv_name = name} =
  mk_id name.id_str ~id_loc:(location name.id_loc)

let ident_of_lsymbol Tterm.{ls_name = name; _} =
  mk_id name.id_str ~id_loc:(location name.id_loc)

let constant = function
  | Pconst_integer (s, _) ->
      if s.[0] = '-' then let s = String.sub s 1 (String.length s - 1) in
        let n = Number.int_literal ILitDec ~neg:false s in
        Constant.(ConstInt (Number.neg_int n))
      else let n = Number.int_literal ILitDec ~neg:false s in
        Constant.ConstInt n
  | Pconst_string (s, _) ->
      Constant.ConstStr s
  | Pconst_float _ -> assert false (* TODO *)
  | _ -> assert false

let preid {pid_str; pid_loc; _} =
  (* FIXME: right place for driver lookup? *)
  let pid_str = match query_syntax pid_str with Some s -> s | _ -> pid_str in
  mk_id ~id_loc:(location pid_loc) pid_str

let rec qualid = function
  | Uast.Qpreid id    -> Qident (preid id)
  | Uast.Qdot (q, id) -> Qdot (qualid q, preid id)

let rec pty = function
  | Uast.PTtyvar id              -> PTtyvar (preid id)
  | Uast.PTtuple pty_list        -> PTtuple (List.map pty pty_list)
  | Uast.PTarrow (_, pty1, pty2) -> PTarrow (pty pty1, pty pty2)
  | Uast.PTtyapp (q, pty_list)   -> PTtyapp (qualid q, List.map pty pty_list)

let rec ty Ty.{ty_node} = match ty_node with
  | Ty.Tyvar {tv_name} ->
      PTtyvar (mk_id tv_name.id_str ~id_loc:(location tv_name.id_loc))
  | Ty.Tyapp (ts, tyl) when Ty.is_ts_tuple ts ->
      PTtuple (List.map ty tyl)
  | Ty.Tyapp (ts, tyl) when Ty.is_ts_arrow ts ->
      let rec arrow_of_pty_list = function
        | [] -> assert false
        | [pty] -> pty
        | arg :: ptyl -> PTarrow (arg, arrow_of_pty_list ptyl) in
      arrow_of_pty_list (List.map ty tyl)
  | Ty.Tyapp ({ts_ident; _}, tyl) -> let id_loc = location ts_ident.id_loc in
      let id_str = match query_syntax ts_ident.id_str with
        | None   -> ts_ident.id_str
        | Some s -> s in
      let qualid = mk_id id_str ~id_loc in
      PTtyapp (Qident qualid, List.map ty tyl)

let quant = function
  | Uast.Tforall -> D.DTforall
  | Uast.Texists -> D.DTexists
  | Uast.Tlambda -> D.DTlambda

let rec pattern Uast.{pat_desc = p_desc; pat_loc} =
  let pat_loc = location pat_loc in
  let mk_pat p = mk_pattern ~pat_loc p in
  let qualid_pattern (q, pat) = qualid q, pattern pat in
  let pat_desc = function
    | Uast.Pwild              -> Pwild
    | Uast.Pvar id            -> Pvar (preid id)
    | Uast.Papp (q, pat_list) -> Papp (qualid q, List.map pattern pat_list)
    | Uast.Prec q_pat_list    -> Prec (List.map qualid_pattern q_pat_list)
    | Uast.Ptuple pat_list    -> Ptuple (List.map pattern pat_list)
    | Uast.Pas (pat, id)      -> Pas (pattern pat, preid id, false)
    | Uast.Por (pat1, pat2)   -> Por (pattern pat1, pattern pat2)
    | Uast.Pcast (pat, ty)    -> Pcast (pattern pat, pty ty) in
  mk_pat (pat_desc p_desc)

let binder (id, ty) =
  (location id.pid_loc, Some (preid id), false, Opt.map pty ty)

let rec term Uast.{term_desc = t_desc; term_loc} =
  let term_loc = location term_loc in
  let mk_term t = mk_term ~term_loc t in
  let binop = function
    | Uast.Tand      -> D.DTand
    | Uast.Tand_asym -> D.DTand_asym
    | Uast.Tor       -> D.DTor
    | Uast.Tor_asym  -> D.DTor_asym
    | Uast.Timplies  -> D.DTimplies
    | Uast.Tiff      -> D.DTiff in
  let attr a = ATstr (Ident.create_attribute a) in
  let pat_term (pat, t) = pattern pat, term t in
  let qualid_term (q, t) = qualid q, term t in
  let term_desc = function
    | Uast.Ttrue               -> Ttrue
    | Uast.Tfalse              -> Tfalse
    | Uast.Tconst c            -> Tconst  (constant c)
    | Uast.Tpreid id           -> Tident  (qualid id)
    | Uast.Tidapp (q, tl)      -> Tidapp  (qualid q, List.map term tl)
    | Uast.Tapply (t1, t2)     -> Tapply  (term t1, term t2)
    | Uast.Tinfix (t1, id, t2) -> Tinfix  (term t1, preid id, term t2)
    | Uast.Tbinop (t1, op, t2) -> Tbinop  (term t1, binop op, term t2)
    | Uast.Tnot t              -> Tnot    (term t)
    | Uast.Tif (t1, t2, t3)    -> Tif     (term t1, term t2, term t3)
    | Uast.Tattr (a, t)        -> Tattr   (attr a, term t)
    | Uast.Tlet (id, t1, t2)   -> Tlet    (preid id, term t1, term t2)
    | Uast.Tcase (t, pt_list)  -> Tcase   (term t, List.map pat_term pt_list)
    | Uast.Tcast (t, ty)       -> Tcast   (term t, pty ty)
    | Uast.Ttuple t_list       -> Ttuple  (List.map term t_list)
    | Uast.Trecord q_t_list    -> Trecord (List.map qualid_term q_t_list)
    | Uast.Tscope (q, t)       -> Tscope  (qualid q, term t)
    | Uast.Told t              ->
        Tat (term t, mk_id ~id_loc:term_loc Dexpr.old_label)
    | Uast.Tupdate (t, q_t_list) ->
        Tupdate (term t, List.map qualid_term q_t_list)
    | Uast.Tquant (q, bl, tt_list, t) ->
        let mk_term_list t_list = List.map term t_list in
        let tt_list = List.map mk_term_list tt_list in
        Tquant (quant q, List.map binder bl, tt_list, term t) in
  mk_term (term_desc t_desc)

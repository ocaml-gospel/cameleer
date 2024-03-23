open Ppxlib
open Why3
open Ptree
open Gospel
open Identifier
open Why3ocaml_driver
module D = Why3.Dterm
module Ty = Ttypes
module P = Parsetree

let dummy_loc = Loc.dummy_position
let location Location.{ loc_start = b; loc_end = e; _ } = Loc.extract (b, e)

let mk_id ?(id_ats = []) ?(id_loc = dummy_loc) id_str =
  { id_str; id_ats; id_loc }

(* uterm -> uterm *)
let mk_uterm term_loc term_desc = Uast.{ term_desc; term_loc }

(* uterm -> term *)
let mk_term ?(term_loc = dummy_loc) term_desc = { term_desc; term_loc }
let mk_pattern ?(pat_loc = dummy_loc) pat_desc = { pat_desc; pat_loc }

(*TODO: this is duplicate code from expression.ml *)
let mk_binder loc id ghost pty : Ptree.binder = (loc, id, ghost, pty)

let is_ghost attributes =
  List.exists (fun P.{ attr_name; _ } -> attr_name.txt = "ghost") attributes

let binder_of_pattern ppat_desc ppat_loc ppat_attributes =
  let binder id pat_loc ghost_pat pty =
    mk_binder (location pat_loc) (Some id) (is_ghost ghost_pat) pty
  in
  match ppat_desc with
  | Uast.Pwild ->
      let id = mk_id "us" ~id_loc:(location ppat_loc) in
      binder id ppat_loc ppat_attributes None
  | Pvar x ->
      let id = mk_id x.pid_str ~id_loc:(location x.pid_loc) in
      binder id ppat_loc ppat_attributes None
  | _ -> assert false

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

let quant = function Uast.Tforall -> D.DTforall | Uast.Texists -> D.DTexists

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
    | _ -> assert false
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
  (* TODO: guards *)
  let pat_term (pat, _guards, t) = (pattern pat, term in_post t) in
  let qualid_term (q, t) = (qualid q, term in_post t) in
  let term_desc = function
    | Uast.Ttrue -> Ttrue
    | Uast.Tfalse -> Tfalse
    | Uast.Tconst c -> Tconst (constant c)
    | Uast.Tpreid id -> Tident (qualid id)
    | Uast.Tidapp (q, tl) -> Tidapp (qualid q, List.map (term in_post) tl)
    | Uast.Tfield (t, q) -> Tapply (mk_term (Tident (qualid q)), term in_post t)
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
    | Uast.Tlambda (pt, t, _) ->
        Tquant
          ( D.DTlambda,
            List.map
              (fun p -> binder_of_pattern p.Uast.pat_desc p.Uast.pat_loc [])
              pt,
            [],
            term in_post t )
  in
  mk_term (term_desc t_desc)

let is_prefix_of p (inv_tname : Preid.t) =
  match p with
  | Uast.Qpreid id when id.pid_str = inv_tname.pid_str -> true
  | _ -> false

(* find t.x and substitute by x *)
let rec remove_prefix (inv_tname : Preid.t)
    Uast.{ term_desc = t_desc; term_loc } =
  let mk_term t = mk_uterm term_loc t in

  let term_desc = function
    | Uast.Ttrue -> Uast.Ttrue
    | Uast.Tfalse -> Uast.Tfalse
    | Uast.Tconst c -> Uast.Tconst c
    | Uast.Tpreid id -> Uast.Tpreid id
    | Uast.Tidapp (q, tl) ->
        Uast.Tidapp (q, List.map (remove_prefix inv_tname) tl)
    | Uast.Tfield (p, q) ->
        let r =
          match p.term_desc with
          | Uast.Tpreid x when is_prefix_of x inv_tname -> Uast.Tpreid q
          | _ -> Uast.Tfield (remove_prefix inv_tname p, q)
        in
        r
    | Uast.Tapply (t1, t2) ->
        Uast.Tapply (remove_prefix inv_tname t1, remove_prefix inv_tname t2)
    | Uast.Tnot t -> Uast.Tnot (remove_prefix inv_tname t)
    | Uast.Tattr (a, t) -> Uast.Tattr (a, remove_prefix inv_tname t)
    | Uast.Tcast (t, ty) -> Uast.Tcast (remove_prefix inv_tname t, ty)
    | Uast.Ttuple t_list ->
        Uast.Ttuple (List.map (remove_prefix inv_tname) t_list)
    | Uast.Trecord q_t_list -> Uast.Trecord q_t_list (* TODO *)
    | Uast.Tscope (q, t) -> Uast.Tscope (q, remove_prefix inv_tname t)
    | Uast.Tcase (t, pt_list) -> Uast.Tcase (remove_prefix inv_tname t, pt_list)
    | Uast.Tlet (id, t1, t2) ->
        Uast.Tlet (id, remove_prefix inv_tname t1, remove_prefix inv_tname t2)
    | Uast.Tinfix (t1, id, t2) ->
        Uast.Tinfix (remove_prefix inv_tname t1, id, remove_prefix inv_tname t2)
    | Uast.Tbinop (t1, op, t2) ->
        Uast.Tbinop (remove_prefix inv_tname t1, op, remove_prefix inv_tname t2)
    | Uast.Told t -> Uast.Told (remove_prefix inv_tname t)
    | Uast.Tif (t1, t2, t3) ->
        Uast.Tif
          ( remove_prefix inv_tname t1,
            remove_prefix inv_tname t2,
            remove_prefix inv_tname t3 )
    | Uast.Tupdate (t, q_t_list) ->
        Uast.Tupdate (remove_prefix inv_tname t, q_t_list)
    | Uast.Tquant (q, bl, t) -> Uast.Tquant (q, bl, remove_prefix inv_tname t)
    | Uast.Tlambda (pt, t, x) -> Uast.Tlambda (pt, remove_prefix inv_tname t, x)
  in
  mk_term (term_desc t_desc)

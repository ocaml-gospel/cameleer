open Ppxlib
open Gospel
open Ml_lang

let (^~) a b = fun c -> a c b

let dummy_loc = Lexing.dummy_pos, Lexing.dummy_pos

let location {loc_start; loc_end; _} =
  (loc_start, loc_end)

module Mh = Map.Make(struct type t = id let compare = Stdlib.compare end)
let empty_map = Mh.empty

let cst_true = CBool true
let cst_false = CBool false
let cst_num n = CNum n

let mk_atom ?(loc=dummy_loc) atom_desc =
  { atom_loc=loc ; atom_desc }

let atom_true = ACst cst_true
let atom_false = ACst cst_false
let atom_num n = ACst (cst_num n)
let atom_unit = mk_atom (ACst CUnit)

let is_false = function
  | Uast.Sexp_construct ({ txt = Lident "false"; _ }, None) -> true
  | _ -> false

let is_raise = function
  | Uast.Sexp_ident { txt = Lident "raise"; _ } -> true
  | _ -> false

(** The function [get_ident] is valid iff [is_ident] succeded. *)
let (is_ident, get_ident) =
  (function
  | Uast.Sexp_ident { txt = Lident _; _ } -> true
  | _ -> false),
  (function[@warning "-8"] Uast.Sexp_ident { txt = Lident f; _ } -> f)

let mk_raise_name eid = "raise_" ^ eid

let mk_id ?(loc=dummy_loc) id =
  { id_name = id; id_loc = loc}

let gen_id ?(prefix = "_x") ?(loc=dummy_loc) () =
  mk_id ~loc (gen_symbol ~prefix ())

let gen_kid ?(prefix = "_k") ?(loc=dummy_loc) () =
  mk_id ~loc (gen_symbol ~prefix ())

let mk_callable ?(loc=dummy_loc) callable_desc =
  { callable_loc=loc ; callable_desc }

let rec string_of_longident = function
  | Longident.Lident s -> s
  | Ldot (t, s) -> string_of_longident t ^ s
  | Lapply (t1, t2) -> string_of_longident t1 ^ string_of_longident t2

let mk_expr ?(loc=dummy_loc) expr_desc =
  { expr_loc=loc ; expr_desc }

let mk_pattern ?(loc=dummy_loc) ppat_desc =
  { ppat_loc=loc; ppat_desc }

let mk_decl (rec_flag, id, params, konts, e, spec) =
  { decl_loc  = id.id_loc;
    decl_desc = DFun (rec_flag, id, params, konts, e, spec); }

let eatom ?(loc=dummy_loc) a = EAtom (mk_atom ~loc a)

let rec get_pattern_id (pat: Parsetree.pattern) =
  match pat.ppat_desc with
  | Ppat_var {txt; loc} ->
      let loc = location loc in
      mk_id ~loc txt, None
  | Ppat_constraint (p, pty) ->
      let id, _ = get_pattern_id p in
      id, Some pty
  | _ -> assert false

let preid Uast.Preid.{ pid_str; pid_loc; _ } =
  mk_id ~loc:(location pid_loc) pid_str

let labelled_arg = function
  | Uast.Lunit -> mk_id "()"
  | Lnone p
  | Loptional p
  | Lnamed p
  | Lghost (p, _) -> preid p

(* TODO: to be removed? *)
let _qualid = function
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

(* TO BE REMOVED? debugging only *)
let rec identify e =
  let open Format in
  let pploc fmt l =
    let ({pos_lnum;pos_cnum;_},_) = location l in
    fprintf fmt "l%d, c%d" pos_lnum pos_cnum in
  match e.Uast.spexp_desc with
  | Sexp_ident {txt;_} -> eprintf "ident %s@." (string_of_longident txt)
  | Sexp_constant _ -> eprintf "constant@."
  | Sexp_let (_, _, _) -> eprintf "let@."
  | Sexp_function _ -> eprintf "function@."
  | Sexp_fun (_, _, _, _, _) -> eprintf "fun@."
  | Sexp_apply (e, _) -> eprintf "apply+(%a)..@." pploc e.spexp_loc; identify e
  | Sexp_match (_, _) -> eprintf "match@."
  | Sexp_try (_, _) -> eprintf "try@."
  | Sexp_tuple _ -> eprintf "tuple@."
  | Sexp_construct (_, _) -> eprintf "construct@."
  | Sexp_variant (_, _) -> eprintf "variant@."
  | Sexp_record (_, _) -> eprintf "record@."
  | Sexp_field (_, _) -> eprintf "field@."
  | Sexp_setfield (_, _, _) -> eprintf "setfield@."
  | Sexp_array _ -> eprintf "array@."
  | Sexp_ifthenelse (_, _, _) -> eprintf "ifthenelse@."
  | Sexp_sequence (_, _) -> eprintf "sequence@."
  | Sexp_while (_, _, _) -> eprintf "while@."
  | Sexp_for (_, _, _, _, _, _) -> eprintf "for@."
  | Sexp_constraint (_, _) -> eprintf "constraint@."
  | Sexp_coerce (_, _, _) -> eprintf "coerce@."
  | Sexp_send (_, _) -> eprintf "send@."
  | Sexp_new _ -> eprintf "new@."
  | Sexp_setinstvar (_, _) -> eprintf "setinstvar@."
  | Sexp_override _ -> eprintf "override@."
  | Sexp_letmodule (_, _, _) -> eprintf "letmodule@."
  | Sexp_letexception (_, _) -> eprintf "letexception@."
  | Sexp_assert _ -> eprintf "assert@."
  | Sexp_lazy _ -> eprintf "lazy@."
  | Sexp_poly (_, _) -> eprintf "poly@."
  | Sexp_object _ -> eprintf "object@."
  | Sexp_newtype (_, _) -> eprintf "newtype@."
  | Sexp_pack _ -> eprintf "pack@."
  | Sexp_open (_, _) -> eprintf "open@."
  | Sexp_letop _ -> eprintf "letop@."
  | Sexp_extension _ -> eprintf "extension@."
  | Sexp_unreachable -> eprintf "unreachable@."

let identify_fail e =
  identify e;
  Why3.Loc.errorm
    ~loc:(Uterm.location e.Uast.spexp_loc)
    "ANF assumption broken"

let collect_params e =
  let rec loop acc e =
    match e.Uast.spexp_desc with
    | Sexp_fun (_, None, pat, e, _) ->
        let arg, pty = get_pattern_id pat in
        let binder = arg, pty in
        (* Format.printf "---> %s@." (Marshal.to_string pty []); *)
        loop (binder :: acc) e
    | _ -> List.rev acc, e
  in
  loop [] e

let mk_kont kont_id kont_arg spec =
  let mk_kont kont_pre = { kont_id; kont_arg; kont_pre } in
  let pre = match spec with
    | None -> []
    | Some U.{sp_post; _} -> sp_post in
  mk_kont pre

let pre_of_spec = function
  | None -> []
  | Some U.{sp_pre; _} -> sp_pre

let rec pattern (p: Parsetree.pattern) = match p.ppat_desc with
  | Ppat_any ->
      PWild
  | Ppat_var {txt; loc} ->
      PVar (mk_id ~loc:(location loc) txt)
  | Ppat_construct ({txt; loc}, args) ->
      let args = match args with
        | Some ([], { ppat_desc = Ppat_tuple pl; _} ) ->
            List.map (fun p -> mk_pattern (pattern p)) pl
        | Some ([], p) -> [mk_pattern (pattern p)]
        | None -> []
        | _ -> assert false in
      let id = mk_id ~loc:(location loc) (string_of_longident txt) in
      PCons (id, args)
  | Ppat_tuple pl ->
      let pl = List.map (fun p -> mk_pattern (pattern p)) pl in
      PTuple pl
  | Ppat_constraint (p, c) ->
      PCast (mk_pattern (pattern p), c)
  | Ppat_constant _
  | Ppat_or (_, _)
  | Ppat_interval (_, _)
  | Ppat_alias (_, _)
  | Ppat_variant (_, _)
  | Ppat_record (_, _)
  | Ppat_array _
  | Ppat_type _
  | Ppat_lazy _
  | Ppat_unpack _
  | Ppat_exception _
  | Ppat_extension _
  | Ppat_open (_, _) -> assert false

let is_unop = function
  | "not" | "-" -> true
  | _ -> false

let get_unop = function
  | "not" -> OPNot
  | "-" -> OPMinus
  | _ -> assert false

let is_binop, get_binop =
  let driver = Hashtbl.create 16 in
  List.iter
    (fun (x,y) -> Hashtbl.add driver x y)
    [ ("+", Some OPAdd);
      ("*", Some OPMult);
      ("-", Some OPMinus);
      ("/", Some OPDiv);
      ("infix mod", Some OPMod);
      ("<=", Some OPLe);
      (">=", Some OPGe);
      ("<", Some OPLt);
      (">", Some OPGt);
      ("&&", Some OPAnd);
      ("<>", None);
      ("=", Some OPEq);
      ("infix ::", None);
      ("::", None);
      ("infix @", None);
      ("@", None) ];
  (fun s -> Hashtbl.mem driver s),
  (fun s -> Option.get @@ Hashtbl.find driver s)

  (** Returns [true] iff [e] is a constant/ident/construct/atomic-tuple. *)
let rec is_atomic e =
  match e.Uast.spexp_desc with
  | Sexp_constant _ | Sexp_ident _ | Sexp_construct (_, None) -> true
  | Sexp_constraint (e, _) | Sexp_construct (_, Some e) -> is_atomic e
  | Sexp_tuple el -> List.for_all is_atomic el
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([(_, e1);(_, e2)]))
    when is_binop (string_of_longident txt) ->
      is_atomic e1 && is_atomic e2
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, [(_, e1)])
    when is_unop (string_of_longident txt) ->
      is_atomic e1
  | _ -> false

let rec atom_of_construct ?(loc=dummy_loc) c = match c with
  | ({ txt = Lident "true"; _ },  None) -> mk_atom ~loc atom_true
  | ({ txt = Lident "false"; _ }, None) -> mk_atom ~loc atom_false
  | ({ txt = Lident "()"; _ }, None)    -> atom_unit
  | ({ txt; loc }, None) ->
      let loc = location loc in
      let id = mk_id ~loc (string_of_longident txt) in
      mk_atom ~loc (ACons (id, []))
  | ({ txt; loc }, Some Uast.{ spexp_desc = Sexp_tuple expr_list; _ }) ->
      let loc = location loc in
      let id = mk_id ~loc (string_of_longident txt) in
      let l = List.map atom_of_sexpr expr_list in
      mk_atom ~loc (ACons (id, l))
  | ({ txt; loc }, Some e) ->
      let loc = location loc in
      let id = mk_id ~loc (string_of_longident txt) in
      mk_atom ~loc (ACons (id, [atom_of_sexpr e]))

and atom_of_sexpr e =
  let loc = location e.spexp_loc in
  if not (is_atomic e) then
    ((* Format.printf "ANF assumption broken@.";  *)identify_fail e) else
  match e.Uast.spexp_desc with
  | Sexp_constant  c      -> mk_atom ~loc (constant c)
  | Sexp_construct (l, e) -> atom_of_construct (l,e)
  | Sexp_ident {txt; loc} ->
      let loc = location loc in
      let id = mk_id ~loc (string_of_longident txt) in
      (mk_atom ~loc @@ AId id)
  | Sexp_tuple el ->
      let loc = location e.spexp_loc in
      let a = List.map atom_of_sexpr el in
      mk_atom ~loc (ATuple a)
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([(_, e1);(_, e2)]))
    when is_binop (string_of_longident txt) ->
      let loc = location e1.spexp_loc in
      let op = get_binop (string_of_longident txt) in
      let e1 = mk_expr_atom ~loc @@ (atom_of_sexpr e1).atom_desc in
      let e2 = mk_expr_atom ~loc @@ (atom_of_sexpr e2).atom_desc in
      mk_atom ~loc (ABinop (e1, op, e2))
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, [(_, e1)])
    when is_unop (string_of_longident txt) ->
      let loc = location e1.spexp_loc in
      let op = get_binop (string_of_longident txt) in
      let e1 = mk_expr_atom ~loc @@ (atom_of_sexpr e1).atom_desc in
      mk_atom ~loc (AUnop (op, e1))
  | Sexp_constraint (e, t) ->
      let loc = location e.spexp_loc in
      let a = atom_of_sexpr e in
      mk_atom ~loc (ACast (a, t))
  | _ -> assert false (* unreachable *)


module S = struct
  module Sstr = Set.Make(String)
  include Sstr
  let not_mem l s = not (Sstr.mem l s)
end

type raise_set = S.t
let raisable_hmap: (string, S.t) Hashtbl.t = Hashtbl.create 32

(** Computes the set of exceptions that can escape expression [e]. *)
let mayraise e =
  let rec loop acc e =
    match e.Uast.spexp_desc with
    (* {1 expr} *)
    | Sexp_field (e, _) | Sexp_constraint (e, _) | Sexp_variant (_, Some e)
    | Sexp_send (e, _) | Sexp_setinstvar (_, e) | Sexp_assert e
    | Sexp_lazy e | Sexp_poly (e, _) | Sexp_newtype (_, e)
    | Sexp_coerce (e, _, _) | Sexp_construct (_, Some e) -> loop acc e
    (* {2 expr} *)
    | Sexp_sequence (e1,e2) | Sexp_while (e1, e2, _)
    | Sexp_setfield (e1, _, e2) | Sexp_ifthenelse (e1, e2, None) ->
        let acc = loop acc e1 in
        loop acc e2
    (* {3 expr} *)
    | Sexp_for (_, e1, e2, _, e3, _) | Sexp_ifthenelse (e1, e2, Some e3) ->
        let acc = loop acc e1 in
        let acc = loop acc e2 in
        loop acc e3
    (* {expr list} *)
    | Sexp_tuple el | Sexp_array el ->
        List.fold_left loop acc el
    (* {0 expr} *)
    | Sexp_variant (_, None) | Sexp_construct (_, None) | Sexp_new _
    | Sexp_unreachable | Sexp_ident _ | Sexp_constant _ ->
        acc
    (* {special cases} *)
    | Sexp_let (_, el, e) ->
        let acc2 = List.fold_left
          (fun acc Uast.{spvb_expr=e;_} -> loop acc e) acc el in
        loop acc2 e
    | Sexp_apply (e, [ (_, arg) ]) when is_raise e.spexp_desc ->
        let a = atom_of_sexpr arg in
        let s = match a.atom_desc with
          | AId _id -> assert false (* how? *)
          | ACons (id, _) -> mk_raise_name id.id_name
          | ATuple _ | ACst _ | AFun _ | AUnop _ | ABinop _
          | ACast _ -> assert false in
        loop (S.add s acc) e
    | Sexp_apply (f, el) when is_ident f.spexp_desc ->
        let acc2 = List.fold_left
          (fun acc (_,e) -> loop acc e) acc el in
        let fname = get_ident f.spexp_desc in
        let ef =
          try Hashtbl.find raisable_hmap fname
          with Not_found -> S.empty in
        S.union acc2 ef
    | Sexp_apply (e, el) ->
        let acc2 = List.fold_left
          (fun acc (_,e) -> loop acc e) acc el in
        loop acc2 e
    | Sexp_match (e, cases) ->
        let acc = loop acc e in
        List.fold_left (fun acc Uast.{spc_rhs=e;_} -> loop acc e) acc cases
    | Sexp_try (e, cases) ->
        let se = loop S.empty e in
        let rmv, add = List.fold_left
          (fun (r,a) Uast.{spc_lhs=x;spc_rhs=e;_} ->
            let x = match x.ppat_desc with
              | Ppat_construct ({txt;_},_) ->
                  mk_raise_name (string_of_longident txt)
              | _ -> assert false in
            S.add x r, loop a e)
          (S.empty,S.empty) cases in
        let se = S.filter (S.not_mem ^~ rmv) se in
        S.union (S.union acc se) add
    (* TODO *)
    | Sexp_fun _ | Sexp_function _ -> assert false (* TODO *)
    | Sexp_record (_, _)
    | Sexp_object _
    | Sexp_override _
    | Sexp_letmodule (_, _, _)
    | Sexp_letexception (_, _)
    | Sexp_pack _
    | Sexp_open (_, _)
    | Sexp_letop _
    | Sexp_extension _ -> identify_fail e in
  loop S.empty e

type kont_type = KName of id | KExpr of callable


let tybool = None (* TODO *)
let tyunit = None (* TODO *)

let bind_cast ty a =
  match ty with
  | None -> a
  | Some ty -> mk_atom ~loc:a.atom_loc @@ ACast (a, ty)

(** CPS translation of [e] where [k] is its normal continuation
    and [hm] is the map of exceptional ones (TODO: unused yet, do we need this?).

    The translation is freely inspired by
    “Compiling with continuation, continued” by Andrew Kennedy.
 *)
let rec expr ?(etype: core_type option=None) (e: Uast.s_expression) k hm : expr_desc =
  let expr_opt ?(etype=etype) e kid hm =
    let loc = location e.Uast.spexp_loc in
    let e = expr ~etype e (KName kid) hm in
    mk_expr ~loc e in
  let callk a = match k with
    | KName k -> EApp (mk_callable ~loc:k.id_loc (CId k), a, [])
    | KExpr k -> EApp (k, a, []) in
  let loc = location e.spexp_loc in
  match e.spexp_desc with
  | Sexp_constant c ->
      let a = mk_atom ~loc (constant c) in
      callk [bind_cast etype a]

  | Sexp_ident {txt; _} ->
      let id = mk_id ~loc (string_of_longident txt) in
      callk [mk_atom ~loc (AId id)]

  | Sexp_tuple el ->
      callk @@ List.map atom_of_sexpr el

  | Sexp_ifthenelse (e1, e2, e3) when is_atomic e1 ->
      let a = atom_of_sexpr e1 in
      let e3 kid = match e3 with
        | Some e3 -> expr_opt e3 kid hm
        | None -> mk_expr @@ EApp (mk_callable (CId kid), [atom_unit], []) in
      begin match k with
      | KName k -> EIf (a, expr_opt e2 k hm, e3 k)
      | KExpr k ->
          let z   = gen_id () in
          let kid = gen_kid () in
          let e2  = expr_opt e2 kid hm in
          ELetK (kid, (z,tybool), mk_expr @@ EApp (k, [mk_atom @@ AId z], []),
                         mk_expr @@ EIf (a, e2, e3 kid))
      end
  | Sexp_ifthenelse (e1, e2, e3) ->
      let z = gen_id ~loc:(location e1.spexp_loc) () in
      let f, kid = match k with
      | KName k ->
          let f e2 e3 = mk_callable @@
            CFun ([z, tybool], [], mk_expr @@ EIf (mk_atom (AId z),e2,e3)) in
          f, k
      | KExpr k ->
          let kid = gen_kid () in
          let z2  = gen_id () in
          let az2 = mk_atom (AId z2) in
          let f e2 e3 = mk_callable @@ CFun ([z, tybool], [],
            mk_expr @@ ELetK (kid, (z2, etype), mk_expr @@ EApp (k, [az2], []),
            mk_expr @@ EIf (mk_atom (AId z), e2, e3))) in
          f, kid in
      let e2 = expr_opt e2 kid hm in
      let e3 = match e3 with
       | Some e3 -> expr_opt e3 kid hm
       | None -> mk_expr @@ EApp (mk_callable (CId kid), [atom_unit], []) in
      expr ~etype:tybool e1 (KExpr (f e2 e3)) hm

  | Sexp_construct (l,e) ->
      let a = atom_of_construct (l,e) in
      callk [bind_cast etype a]

  | Sexp_let ((Nonrecursive | Recursive), [svb], e2) ->
      let id, pty = get_pattern_id svb.spvb_pat in
      let e1 = svb.spvb_expr in
      let loc1 = location e1.spexp_loc in
      let loc2 = location e2.spexp_loc in
      let body = mk_expr ~loc:loc2 @@ expr ~etype e2 k hm in
      let kid = gen_kid () in
      ELetK (kid, (id, pty), body,
             mk_expr ~loc:loc1 @@ expr ~etype:pty e1 (KName kid) hm)

  | Sexp_let (Nonrecursive, svb::svbs, e2) ->
      let id, pty = get_pattern_id svb.spvb_pat in
      let e1 = svb.spvb_expr in
      let loc1 = location e1.spexp_loc in
      let loc2 = location e2.spexp_loc in
      let e2 =
        { e with spexp_desc = Sexp_let (Nonrecursive, svbs, e1) } in
      let body = mk_expr ~loc:loc2 @@ expr ~etype e2 k hm in
      let kid = gen_kid () in
      ELetK (kid, (id,pty), body,
             mk_expr ~loc:loc1 @@ expr ~etype:pty e1 (KName kid) hm)

  | Sexp_let (Recursive, _svb::_svbs, _e) -> assert false (* TODO *)

  | Sexp_let ((Nonrecursive|Recursive), [], _) -> assert false (* unreachable *)

  | Sexp_try (e, cases) ->
      (* remark:
           for now we only consider `try-catch` of the form
           `try e with E x -> e` and
           `try e with E _ -> e`
       *)
      let rec get_mlpattern_id pat =
        match pat.ppat_desc with
        | PVar id -> id
        | PCast  (p,_) -> get_mlpattern_id p
        | PWild -> gen_id ~prefix:"_unused" ()
        | PCons (_,[p]) -> get_mlpattern_id p
        | PCons (_,_) -> assert false
        | PTuple _ -> assert false in
      let ctx, kid = match k with
        | KName k -> Fun.id, k
        | KExpr c ->
            let kid = gen_kid () in
            let x = gen_id () in
            let a = mk_atom ~loc (AId x) in
            let f e = ELetK (kid, (x,etype), mk_expr @@ EApp (c, [a], []),
                                     mk_expr ~loc e) in
            f, gen_kid () in
      let f = (fun Uast.{spc_lhs; spc_rhs; _} ->
        let loc = location spc_rhs.spexp_loc in
        let ploc = location spc_lhs.ppat_loc in
        let p = pattern spc_lhs in
        let[@warning"-8"] eid = (* TODO: complete cases? *)
          match p with PCons (eid,_) ->
            { eid with id_name = mk_raise_name eid.id_name } in
        let pat = get_mlpattern_id (mk_pattern ~loc:ploc p) in
        eid, pat, mk_expr ~loc @@ expr ~etype spc_rhs (KName kid) hm) in
      let cases = List.map f cases in
      let e = mk_expr @@ expr ~etype e k hm in
      let letks = List.fold_left (fun acc (eid, pid, d) ->
        (* TODO howto reconstruct the type here? howto remove None *)
        mk_expr ~loc:eid.id_loc @@ ELetK (eid, (pid, None), d, acc)) e cases in
      ctx letks.expr_desc

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([_;_] as args))
    when is_binop (string_of_longident txt) ->
      let st = string_of_longident txt in
      let op = get_binop st in
      let[@warning "-8"] [a1;a2] =
        List.map (fun (_, e) -> identify e; atom_of_sexpr e) args in
      let a1 = mk_expr ~loc:a1.atom_loc (EAtom a1) in
      let a2 = mk_expr ~loc:a2.atom_loc (EAtom a2) in
      let a  = mk_atom ~loc:a1.expr_loc @@ ABinop (a1, op, a2) in
      let k = match k with
        | KName k -> mk_callable @@ CId k
        | KExpr k -> k in
      EApp (k, [a], [])

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, [(_, arg)])
    when is_unop (string_of_longident txt) ->
      let op = get_unop (string_of_longident txt) in
      let a = atom_of_sexpr arg in
      let a = mk_expr ~loc:a.atom_loc (EAtom a) in
      let a = mk_atom ~loc:a.expr_loc @@ AUnop (op, a) in
      let k = match k with
        | KName k -> mk_callable @@ CId k
        | KExpr k -> k in
      EApp (k, [a], [])

  | Sexp_apply (s, [ (_, arg) ]) when is_raise s.spexp_desc ->
      let a = atom_of_sexpr arg in
      let (id, args) = match a.atom_desc with
        | AId id -> { id with id_name=("raise_" ^ id.id_name)}, []
        | ACons (id, al) ->
            { id with id_name=("raise_" ^ id.id_name)}, al
        | _ -> assert false (* unreachable *) in
      EApp (mk_callable (CId id), args, [])

  | Sexp_apply (e, args) when is_atomic e ->
      let loc = location e.spexp_loc in
      let (c, id) = match e.spexp_desc with
        | Sexp_ident {txt; _} ->
            let id = mk_id ~loc (string_of_longident txt) in
            CId id, id
        | _ -> assert false (* impossible (type error) *) in
      let args = List.map (fun (_, e) -> atom_of_sexpr e) args in
      let k = match k with
        | KName k -> mk_callable @@ CId k
        | KExpr k -> k in
      let gs = try Hashtbl.find raisable_hmap id.id_name
               with Not_found -> S.empty in
      let sl = S.fold
        (fun s acc -> mk_callable (CId (mk_id s)) :: acc)
        gs [] in
      EApp (mk_callable ~loc c, args, k::sl)
  | Sexp_apply (e, args) ->
      let loc = location e.spexp_loc in
      let z = gen_id ~loc () in
      let args = List.map (fun (_, e) -> atom_of_sexpr e) args in
      let k = match k with
        | KName k -> mk_callable ~loc:k.id_loc @@ CId k
        | KExpr k -> k in
      let k = mk_callable ~loc @@
        CFun ([z, etype],[], mk_expr @@
              EApp (mk_callable @@ CId z, args, [k])) in
      expr e (KExpr k) hm

  | Sexp_match (e, cases) when is_atomic e ->
      Format.eprintf "In an atomic match@.";
      let a = atom_of_sexpr e in
      let map k = List.map
        (fun Uast.{spc_lhs; spc_rhs; spc_spec; _} ->
          let loc = location spc_rhs.spexp_loc in
          let ploc = location spc_lhs.ppat_loc in
          let pat = mk_pattern ~loc:ploc (pattern spc_lhs) in
          let e = mk_expr ~loc @@ expr ~etype spc_rhs (KName k) hm in
          let e = match spc_spec with
            | None -> e
            | Some spec ->
                mk_expr ~loc @@ EAssert (spec,
                mk_expr ~loc @@ EHide e) in
          pat, e)
        cases in
      begin match k with
      | KName k -> EMatch (a, map k) (* TODO *)
      | KExpr k ->
          let aid = gen_id  () in
          let kid = gen_kid () in
          let cases = map kid in
          ELetK (kid, (aid, etype),
                 mk_expr @@ EApp (k, [mk_atom @@ AId aid], []),
                 mk_expr @@ EMatch (a, cases))
      end

  | Sexp_match (e, cases) ->
      Format.eprintf "In a match@.";
      let map k = List.map
        (fun Uast.{spc_lhs; spc_rhs; spc_spec; _} ->
          let loc = location spc_rhs.spexp_loc in
          let ploc = location spc_lhs.ppat_loc in
          let pat = mk_pattern ~loc:ploc (pattern spc_lhs) in
          let () = match spc_spec with
            | None -> Format.eprintf "Spec is none@."
            | Some _ -> Format.eprintf "Spec is some@." in
          let e = mk_expr ~loc @@ expr ~etype spc_rhs (KName k) hm in
          let e = match spc_spec with
            | None -> e
            | Some spec ->
                mk_expr ~loc @@ EAssert (spec,
                mk_expr ~loc @@ EHide e) in
          pat, e)
        cases in
      begin match k with
      | KName k ->
          let z = gen_id ~loc () in
          let cases = map k in
          let kk = mk_callable @@
              CFun ([z, etype],[],
                    mk_expr @@ EMatch (mk_atom (AId z), cases)) in
          expr e (KExpr kk) hm
      | KExpr k ->
          let kid = gen_kid () in
          let z   = gen_id  () in
          let z2  = gen_id  () in
          let az2 = mk_atom (AId z2) in
          let cases = map kid in
          let kk = mk_callable @@
            (* TODO what is the type of [z]? -> the type of [e], what is the type of [e]? *)
            CFun ([z, None], [],
                  mk_expr @@ ELetK (kid, (z2,etype), mk_expr @@ EApp (k, [az2], []),
                  mk_expr @@ EMatch (mk_atom (AId z), cases))) in
          expr e (KExpr kk) hm
      end

  | Sexp_assert e when is_false e.spexp_desc -> EFail

  | Sexp_constraint (e, ty) ->
      expr ~etype:(Some ty) e k hm

  | Sexp_sequence (e1, e2) ->
      let k = mk_expr ~loc:(location e2.spexp_loc) @@ expr ~etype e2 k hm in
                           (* TODO: replace [None] by [unit] somehow *)
      let u = (gen_id ~prefix:"_unused" ()), None in
      let k = KExpr (mk_callable (CFun ([u],[], k))) in
      expr ~etype:tyunit e1 k hm

  | Sexp_while (e1, e2, _spec) ->
      let loc1 = location e1.spexp_loc in
      let id_loop = gen_kid ~prefix:"_loop" () in
      (* TODO factorize [cloop] with
         a local handler definition mutually recursive with [id_loop].
         ```coma
         let id_cloop = [[e1]] loop
         and loop x = if x then [[e2]] id_cloop else k () in
         id_cloop
         ```
         instead of (where [[[e1]] loop] is duplicated)
         ```coma
         let loop x = if x then [[e2]] ([[e1]] loop) else k () in
         [[e1]] loop
         ```
        *)
      let cloop = mk_expr ~loc:loc1 (expr ~etype:tybool e1 (KName id_loop) hm) in
      let u = (gen_id ~prefix:"_unused" ()), None in
      let kcloop = KExpr (mk_callable (CFun ([u],[], cloop))) in
      let z = gen_id () in
      ELetK (id_loop, (z,None), mk_expr @@
             EIf (mk_atom @@ AId z,
                  mk_expr (expr ~etype:tyunit e2 kcloop hm),
                  mk_expr (callk [atom_unit])),
             cloop)

  | Sexp_unreachable            -> EFail
  | Sexp_function _             -> assert false (* TODO *)
  | Sexp_fun (_, _, _, _, _)    -> failwith "unreachable" (* it is not true *)
  (* TBC *)
  | Sexp_assert _
  | Sexp_variant (_, _)
  | Sexp_record (_, _)
  | Sexp_field (_, _)
  | Sexp_setfield (_, _, _)
  | Sexp_array _
  | Sexp_for (_, _, _, _, _, _)
  | Sexp_coerce (_, _, _)
  | Sexp_send (_, _)
  | Sexp_new _
  | Sexp_setinstvar (_, _)
  | Sexp_override _
  | Sexp_letmodule (_, _, _)
  | Sexp_letexception (_, _)
  | Sexp_lazy _
  | Sexp_poly (_, _)
  | Sexp_object _
  | Sexp_newtype (_, _)
  | Sexp_pack _
  | Sexp_open (_, _)
  | Sexp_extension _
  | Sexp_letop _ -> assert false

and s_value_binding rec_flag (svb: Uast.s_value_binding) k =
  let get_type_expr U.{spexp_desc; _} = match spexp_desc with
    | U.Sexp_constraint (_, pty) -> Some pty
    | _ -> None in
  let ret = function
    | [r] -> labelled_arg r
    | _ -> assert false in
  let return_id_of_spec = function
    | None | Some U.{sp_header = None; _} -> mk_id "result"
    | Some U.{sp_header = Some header; _} -> ret header.sp_hd_ret in
  let id, pty = get_pattern_id svb.spvb_pat in
  (* FIXME? Honestly, I do not know what this pty is. *)
  (* Mário [12-03-2026, 15h35]: OK, I figured it out. This is the
     type of a function if, for instance, we write something like:
     ```
       let is_empty: 'a tree -> bool = fun t -> ...
     ```
     . Which means the type of the function return value is coupled with
     the body expression, when the function header is written in a
     more natural style.

     Let us ignore it, for now. *)
  ignore pty; (* TODO *)
  let params, pexp = collect_params svb.spvb_expr in
  let s = mayraise pexp in
  let spec = svb.spvb_vspec in
  let arg_id = return_id_of_spec spec in
  let return_pty = get_type_expr pexp in
  let sl = S.fold
    (fun s acc ->
      mk_kont (mk_id s) (arg_id, None) None :: acc)
    s [] in
  let () = Hashtbl.add raisable_hmap id.id_name s in
  let expr_loc = location svb.Uast.spvb_expr.spexp_loc in
  let etype = return_pty in (* return type of the function *)
  let body = mk_expr ~loc:expr_loc (expr ~etype pexp (KName k) empty_map) in
  let kont = mk_kont k (arg_id, return_pty) spec in
  (* FIXME: type of [k],

     Where is the type annotation of functions (svb)? *)
  (* Mário: it is the type of the body expression. *)
  let pre = pre_of_spec spec in
  mk_decl (rec_flag, id, params, pre, kont :: sl, body)

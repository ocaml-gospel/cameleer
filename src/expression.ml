open Why3
open Ptree
open Gospel
open Oasttypes
open Longident
open Why3ocaml_driver
module T = Uterm
module S = Vspec
module O = Oparsetree

let rec_flag = function Nonrecursive -> false | Recursive -> true

let split_on_checks sp_pre =
  let mk_split (pre, checks) (t, is_checks) =
    if is_checks then pre, t :: checks else t :: pre, checks in
  let pre, checks = List.fold_left mk_split ([], []) sp_pre in
  List.rev pre, List.rev checks

let empty_spec = {
  sp_pre     = [];
  sp_post    = [];
  sp_xpost   = [];
  sp_reads   = [];
  sp_writes  = [];
  sp_alias   = [];
  sp_variant = [];
  sp_checkrw = false;
  sp_diverge = false;
  sp_partial = false;
}

let mk_expr ?(expr_loc=T.dummy_loc) expr_desc =
  { expr_desc; expr_loc }

let unit_expr =
  mk_expr (Etuple [])

let unit_pty = PTtuple []

let rec longident ?(id_loc=T.dummy_loc) ?(prefix="") = function
  | Lident id -> (* FIXME? right place to driver lookup? *)
      let id = match query_syntax id with Some s -> s | None -> id in
      Qident (T.mk_id ~id_loc (prefix ^ id))
  | Ldot (t, id) ->
      let id = match query_syntax id with Some s -> s | None -> id in
      Qdot (longident ~id_loc t, T.mk_id ~id_loc id)
  | _ -> assert false (* TODO *)

let rec core_type O.{ptyp_desc; ptyp_loc; _} = match ptyp_desc with
  | O.Ptyp_var s ->
      PTtyvar T.(mk_id ~id_loc:(location ptyp_loc) s)
  | O.Ptyp_constr ({txt; loc}, cty_list) ->
      let args = List.map core_type cty_list in
      PTtyapp (longident ~id_loc:(T.location loc) txt, args)
  | O.Ptyp_arrow (Nolabel, cty1, cty2) ->
      PTarrow (core_type cty1, core_type cty2)
  | O.Ptyp_arrow (Labelled _, cty1, cty2) ->
      ignore (cty1);
      ignore (cty2);
      assert false (* TODO *)
  | O.Ptyp_arrow (Optional _, cty1, cty2) ->
      ignore (cty1);
      ignore (cty2);
      assert false (* TODO *)
  | _ -> assert false (* TODO *)

let binder_of_pattern O.{ppat_desc; ppat_loc; _} = match ppat_desc with
  | Ppat_var x ->
      let id  = T.(mk_id x.txt ~id_loc:(location x.loc)) in
      let loc = T.location ppat_loc in
      (loc, Some id, false, None)
  | Ppat_constraint ({ppat_desc = Ppat_var s; ppat_loc; _}, cty) ->
      let id  = T.(mk_id s.txt ~id_loc:(location s.loc)) in
      let loc = T.location ppat_loc in
      let pty = core_type cty in
      (loc, Some id, false, Some pty)
  | Ppat_construct ({txt = Lident "()"; loc}, None) ->
      let id = T.(mk_id "_" ~id_loc:(location loc)) in
      let loc = T.location ppat_loc in
      (loc, Some id, false, Some unit_pty)
  | _ -> assert false (* TODO *)

let id_of_pat O.{ppat_desc; _} = match ppat_desc with
  | Ppat_var {txt; loc} -> T.(mk_id ~id_loc:(location loc) txt)
  | _ -> assert false

let rec pattern O.{ppat_desc = p_desc; ppat_loc; _} =
  let pat_loc = T.location ppat_loc in
  let mk_pat p = T.mk_pattern ~pat_loc p in
  let pat_desc = function
    | O.Ppat_any            -> Pwild
    | O.Ppat_var id         -> Pvar T.(mk_id ~id_loc:(location id.loc) id.txt)
    | O.Ppat_tuple pat_list -> Ptuple (List.map pattern pat_list)
    | O.Ppat_construct (id, None) ->
        Papp (longident id.txt, [])
    | O.Ppat_construct (id, Some ({ppat_desc = Ppat_tuple pat_list; _})) ->
        Papp (longident id.txt, List.map pattern pat_list)
    | O.Ppat_construct (id, Some p) ->
        Papp (longident id.txt, [pattern p])
    | O.Ppat_or (pat1, pat2) ->
        Por (pattern pat1, pattern pat2)
    | O.Ppat_constant _ ->
        Loc.errorm "Constants in case expressions are not supported."
    | _ -> assert false (* TODO *) in
  mk_pat (pat_desc p_desc)

let rec expression Uast.{spexp_desc = p_desc; spexp_loc; _} =
  let expr_loc = T.location spexp_loc in
  let mk_expr e = mk_expr ~expr_loc e in
  let arg_expr (_, expr) = expression expr in
  let field_expr ({txt; _}, e) = (longident txt, expression e) in
  let is_false = function
    | Uast.Sexp_construct ({txt = Lident "false"; _}, None) -> true
    | _ -> false in
  let is_and = function
    | Uast.Sexp_ident {txt = Lident "&&"; _} -> true
    | _ -> false in
  let is_or = function
    | Uast.Sexp_ident {txt = Lident "||"; _} -> true
    | _ -> false in
  let is_not = function
    | Uast.Sexp_ident {txt = Lident "not"; _} -> true
    | _ -> false in
  let pexp_desc = function
    | Uast.Sexp_ident {txt;loc} ->
        Eident (longident ~id_loc:(T.location loc) txt)
    | Uast.Sexp_constant c ->
        Econst (T.constant c)
    | Uast.Sexp_let (Nonrecursive, [svb], expr) ->
        let id, binder_expr = s_value_binding svb in
        let expr = expression expr in
        Elet (id, false, Expr.RKnone, binder_expr, expr)
    | Uast.Sexp_let _ -> assert false (* TODO *)
    | Uast.Sexp_fun _ -> assert false (* TODO *)
    | Uast.Sexp_apply (s, [arg1; arg2]) when is_and s.spexp_desc ->
        Eand (arg_expr arg1, arg_expr arg2)
    | Uast.Sexp_apply (s, [arg1; arg2]) when is_or s.spexp_desc ->
        Eor (arg_expr arg1, arg_expr arg2)
    | Uast.Sexp_apply (s, [arg]) when is_not s.spexp_desc ->
        Enot (arg_expr arg)
    | Uast.Sexp_apply ({spexp_desc = Sexp_ident s; _}, arg_expr_list) ->
        Eidapp (longident s.txt, List.map arg_expr arg_expr_list)
    | Uast.Sexp_match (expr, case_list) ->
        Ematch (expression expr, List.map case case_list, [])
    | Uast.Sexp_try (expr, case_list) ->
        Ematch (expression expr, [], List.map case_exn case_list)
    | Uast.Sexp_tuple exp_list ->
        Etuple (List.map expression exp_list)
    | Uast.Sexp_sequence (e1, e2) ->
        Esequence (expression e1, expression e2)
    | Uast.Sexp_constraint (e, cty) ->
        Ecast (expression e, core_type cty)
    | Uast.Sexp_construct ({txt = Lident "true"; _}, None) ->
        Etrue
    | Uast.Sexp_construct ({txt = Lident "false"; _}, None) ->
        Efalse
    | Uast.Sexp_construct ({txt = Lident "()"; _}, None) ->
        Etuple []
    | Uast.Sexp_construct (id, None) ->
        Eidapp (longident id.txt, [])
    | Uast.Sexp_construct (id, Some {spexp_desc = Sexp_tuple expr_list; _}) ->
        Eidapp (longident id.txt, List.map expression expr_list)
    | Uast.Sexp_construct (id, Some e) ->
        Eidapp (longident id.txt, [expression e])
    | Uast.Sexp_record (field_list, None) ->
        Erecord (List.map field_expr field_list)
    | Uast.Sexp_record (_, Some _) ->
        assert false (* TODO *)
    | Uast.Sexp_field (expr, field) ->
        Eidapp (longident field.txt, [expression expr])
    | Uast.Sexp_ifthenelse (e1, e2, Some e3) ->
        Eif (expression e1, expression e2, expression e3)
    | Uast.Sexp_ifthenelse (e1, e2, None) ->
        Eif (expression e1, expression e2, unit_expr)
    | Uast.Sexp_assert {spexp_desc; _} when is_false spexp_desc ->
        Eabsurd
    | _ -> assert false (* TODO *) in
  mk_expr (pexp_desc p_desc)

and case Uast.{spc_lhs; spc_guard; spc_rhs} =
  let check_guard = function
    | Some _ -> Loc.errorm "Guarded expressions are not supported."
    | None   -> () in
  check_guard spc_guard;
  pattern spc_lhs, expression spc_rhs

and case_exn Uast.{spc_lhs; spc_guard; spc_rhs} =
  let check_guard = function
    | Some _ -> Loc.errorm "Guarded expressions are not supported."
    | None   -> () in
  check_guard spc_guard;
  let q, pat = match spc_lhs.O.ppat_desc with
    | Ppat_any -> Qident (T.mk_id "_"), None
    | Ppat_var s -> let id_loc = T.location s.loc in
        Qident (T.mk_id s.txt ~id_loc), None
    | Ppat_construct (id, pat) -> let id_loc = T.location id.loc in
        longident id.txt ~id_loc, Opt.map pattern pat
  | _ -> assert false in
  q, pat, expression spc_rhs

and s_value_binding svb =
  let pexp = svb.Uast.spvb_expr in
  let expr_loc = T.location svb.Uast.spvb_expr.spexp_loc in
  let spec = function None -> empty_spec | Some s -> S.vspec s in
  let rec loop acc expr = match expr.Uast.spexp_desc with
    | Sexp_fun (Nolabel, None, pat, e) ->
        let arg = binder_of_pattern pat in
        loop (arg :: acc) e
    | _ -> List.rev acc, expr in (* TODO *)
  let mk_binder expr = match expr.Uast.spexp_desc with
    | Sexp_fun (_, _, pat, e) ->
        let args, expr = loop [] e in
        let args = binder_of_pattern pat :: args in
        let expr = expression expr in
        let ret  = T.mk_pattern Pwild in
        let spec = spec svb.Uast.spvb_vspec in
        let efun = (Efun (args, None, ret, Ity.MaskVisible, spec, expr)) in
        mk_expr efun ~expr_loc
    | _ -> expression expr in
  let id = id_of_pat svb.spvb_pat in
  id, mk_binder pexp

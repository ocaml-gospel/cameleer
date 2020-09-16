open Why3
open Ptree
open Gospel
open Oasttypes
open Longident
open Why3ocaml_driver
module T = Uterm
module S = Vspec
module O = Oparsetree

type info = { (* to be completed as needed *)
  info_arith_construct: (string, int) Hashtbl.t
}

let rec string_of_longident = function
  | Longident.Lident s -> s
  | Ldot (t, s) -> string_of_longident t ^ s
  | Lapply (t1, t2) -> string_of_longident t1 ^ string_of_longident t2

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
  | O.Ptyp_arrow (Labelled _, _, _) ->
      assert false (* TODO *)
  | O.Ptyp_arrow (Optional _, _, _) ->
      assert false (* TODO *)
  | O.Ptyp_tuple cty_list ->
      PTtuple (List.map core_type cty_list)
  | _ -> assert false (* TODO *)

let binder_of_pattern O.{ppat_desc; ppat_loc; _} = match ppat_desc with
  | Ppat_any ->
      let id  = T.(mk_id "us" ~id_loc:(location ppat_loc)) in
      let loc = T.location ppat_loc in
      (loc, Some id, false, None)
  | Ppat_var x ->
      let id  = T.(mk_id x.txt ~id_loc:(location x.loc)) in
      let loc = T.location ppat_loc in
      (loc, Some id, false, None)
  | Ppat_constraint ({ppat_desc = Ppat_var s; ppat_loc; _}, cty) ->
      let id  = T.(mk_id s.txt ~id_loc:(location s.loc)) in
      let loc = T.location ppat_loc in
      let pty = core_type cty in
      (loc, Some id, false, Some pty)
  | Ppat_tuple _ -> assert false (* TODO *)
  | Ppat_construct ({txt = Lident "()"; loc}, None) ->
      let id = T.(mk_id "_" ~id_loc:(location loc)) in
      let loc = T.location ppat_loc in
      (loc, Some id, false, Some unit_pty)
  | Ppat_alias _ -> assert false (* TODO *)
  | _ -> assert false (* TODO *)

let id_of_pat O.{ppat_desc; _} = match ppat_desc with
  | Ppat_var {txt; loc} -> T.(mk_id ~id_loc:(location loc) txt)
  | Ppat_any -> assert false (* TODO *)
  | Ppat_alias _ -> assert false (* TODO *)
  | Ppat_constant _ -> assert false (* TODO *)
  | Ppat_interval _ -> assert false (* TODO *)
  | Ppat_tuple _ -> assert false (* TODO *)
  | Ppat_construct _ -> assert false (* TODO *)
  | Ppat_variant _ -> assert false (* TODO *)
  | Ppat_record _ -> assert false (* TODO *)
  | Ppat_array _ -> assert false (* TODO *)
  | Ppat_or _ -> assert false (* TODO *)
  | Ppat_constraint _ -> assert false (* TODO *)
  | Ppat_type _ -> assert false (* TODO *)
  | Ppat_lazy _ -> assert false (* TODO *)
  | Ppat_unpack _ -> assert false (* TODO *)
  | Ppat_exception _ -> assert false (* TODO *)
  | Ppat_extension _ -> assert false (* TODO *)
  | Ppat_open _ -> assert false (* TODO *)

let rec pattern info O.{ppat_desc = p_desc; ppat_loc; _} =
  let pat_loc = T.location ppat_loc in
  let mk_pat p = T.mk_pattern ~pat_loc p in
  let pat_desc = function
    | O.Ppat_any            -> Pwild
    | O.Ppat_var id         -> Pvar T.(mk_id ~id_loc:(location id.loc) id.txt)
    | O.Ppat_tuple pat_list -> Ptuple (List.map (pattern info) pat_list)
    | O.Ppat_construct (id, None) ->
        Papp (longident id.txt, [])
    | O.Ppat_construct (id, Some ({ppat_desc = Ppat_tuple pat_list; _})) ->
        let s = string_of_longident id.txt in
        let pat = List.map (pattern info) pat_list in
        if Hashtbl.find info.info_arith_construct s > 1 then
          Papp (longident id.txt, pat)
        else Papp (longident id.txt, [mk_pat (Ptuple pat)])
    | O.Ppat_construct (id, Some p) ->
        Papp (longident id.txt, [pattern info p])
    | O.Ppat_or (pat1, pat2) ->
        Por (pattern info pat1, pattern info pat2)
    | O.Ppat_constant _ ->
        Loc.errorm "Constants in case expressions are not supported."
    | Ppat_alias (pat, id) ->
        let pat_id = T.(mk_id ~id_loc:(location id.loc)) id.txt in
        Pas (pattern info pat, pat_id, false)
    | Ppat_interval _ -> assert false (* TODO *)
    | Ppat_variant _ -> assert false (* TODO *)
    | Ppat_record _ -> assert false (* TODO *)
    | Ppat_array _ -> assert false (* TODO *)
    | Ppat_constraint _ -> assert false (* TODO *)
    | Ppat_type _ -> assert false (* TODO *)
    | Ppat_lazy _ -> assert false (* TODO *)
    | Ppat_unpack _ -> assert false (* TODO *)
    | Ppat_exception _ -> assert false (* TODO *)
    | Ppat_extension _ -> assert false (* TODO *)
    | Ppat_open _ -> assert false (* TODO *) in
  mk_pat (pat_desc p_desc)

let check_guard = function
  | Some e -> Loc.errorm ~loc:(T.location e.Uast.spexp_loc)
                "Guarded expressions are not supported."
  | None   -> ()

let rec expression info Uast.{spexp_desc = p_desc; spexp_loc; _} =
  let expr_loc = T.location spexp_loc in
  let mk_expr e = mk_expr ~expr_loc e in
  let arg_expr (_, expr) = expression info expr in
  let logic_attr = "logic" in
  let lemma_attr = "lemma" in
  let is_logic =
    List.exists (fun O.{attr_name; _} -> attr_name.txt = logic_attr) in
  let is_lemma =
    List.exists (fun O.{attr_name; _} -> attr_name.txt = lemma_attr) in
  let is_logic_svb Uast.{spvb_attributes; _} = is_logic spvb_attributes in
  let is_lemma_svb Uast.{spvb_attributes; _} = is_lemma spvb_attributes in
  let field_expr ({txt; _}, e) = (longident txt, expression info e) in
  let rs_kind svb_list = if List.exists is_logic_svb svb_list then Expr.RKfunc
    else if List.exists is_lemma_svb svb_list then Expr.RKlemma
    else Expr.RKnone in
  let id_expr_rs_kind_of_svb_list svb_list =
    rs_kind svb_list, List.map (fun svb -> s_value_binding info svb) svb_list in
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
  let is_raise = function
    | Uast.Sexp_ident {txt = Lident "raise"; _} -> true
    | _ -> false in
  let pexp_desc = function
    | Uast.Sexp_ident {txt;loc} ->
        Eident (longident ~id_loc:(T.location loc) txt)
    | Uast.Sexp_constant c ->
        Econst (T.constant c)
    | Uast.Sexp_let (Nonrecursive, [svb], expr) ->
        let id, binder_expr = s_value_binding info svb in
        let expr = expression info expr in
        Elet (id, false, Expr.RKnone, binder_expr, expr)
    | Uast.Sexp_let (Recursive, svb_list, expr) ->
        let mk_fun_def rs_kind (id, fun_expr) =
          let args, ret, spec, expr = begin match fun_expr.expr_desc with
            | Efun (args, _, ret, _, spec, expr) -> args, ret, spec, expr
            | _ -> assert false (* TODO *) end in
          let mask_visible = Ity.MaskVisible in
          id, false, rs_kind, args, None, ret, mask_visible, spec, expr in
        let rs_kind, id_fun_expr_list = id_expr_rs_kind_of_svb_list svb_list in
        let expr_in = expression info expr in
        Erec (List.map (mk_fun_def rs_kind) id_fun_expr_list, expr_in)
    | Uast.Sexp_function _ -> assert false (* TODO *)
    | Uast.Sexp_fun (Nolabel, None, pat, expr_body, spec) ->
        let ret = T.mk_pattern Pwild in
        let expr_body = expression info expr_body in
        let spec = match spec with Some s -> S.fun_spec s | _ -> empty_spec in
        let mask = Ity.MaskVisible in
        Efun ([binder_of_pattern pat], None, ret, mask, spec, expr_body)
    | Uast.Sexp_apply (s, [arg1; arg2]) when is_and s.spexp_desc ->
        Eand (arg_expr arg1, arg_expr arg2)
    | Uast.Sexp_apply (s, [arg1; arg2]) when is_or s.spexp_desc ->
        Eor (arg_expr arg1, arg_expr arg2)
    | Uast.Sexp_apply (s, [arg]) when is_not s.spexp_desc ->
        Enot (arg_expr arg)
    | Uast.Sexp_apply (s, [_, arg]) when is_raise s.spexp_desc ->
        (* TODO: write a smart constructor for exceptions *)
        begin match arg.spexp_desc with
        | Sexp_construct (id, exn_arg) ->
            Eraise (longident id.txt, Opt.map (expression info) exn_arg)
        | _ -> assert false (* TODO: not supported for now *) end
    | Uast.Sexp_apply ({spexp_desc = Sexp_ident s; _}, arg_expr_list) ->
        Eidapp (longident s.txt, List.map arg_expr arg_expr_list)
    | Uast.Sexp_apply (_expr, _arg_list) ->
        assert false (* TODO *)
    | Uast.Sexp_match (expr, case_list) ->
        Ematch (expression info expr, List.map (case info) case_list, [])
    | Uast.Sexp_try (expr, case_list) ->
        Ematch (expression info expr, [], List.map (case_exn info) case_list)
    | Uast.Sexp_tuple exp_list ->
        Etuple (List.map (expression info) exp_list)
    | Uast.Sexp_sequence (e1, e2) ->
        Esequence (expression info e1, expression info e2)
    | Uast.Sexp_constraint (e, cty) ->
        Ecast (expression info e, core_type cty)
    | Uast.Sexp_construct ({txt = Lident "true"; _}, None) ->
        Etrue
    | Uast.Sexp_construct ({txt = Lident "false"; _}, None) ->
        Efalse
    | Uast.Sexp_construct ({txt = Lident "()"; _}, None) ->
        Etuple []
    | Uast.Sexp_construct (id, None) ->
        Eidapp (longident id.txt, [])
    | Uast.Sexp_construct (id, Some {spexp_desc = Sexp_tuple expr_list; _}) ->
        let s = string_of_longident id.txt in
        if Hashtbl.find info.info_arith_construct s > 1 then
          Eidapp (longident id.txt, List.map (expression info) expr_list)
        else let etuple = Etuple (List.map (expression info) expr_list) in
          Eidapp (longident id.txt, [mk_expr etuple])
    | Uast.Sexp_construct (id, Some e) ->
        Eidapp (longident id.txt, [expression info e])
    | Uast.Sexp_record (field_list, None) ->
        Erecord (List.map field_expr field_list)
    | Uast.Sexp_record (_, Some _) ->
        assert false (* TODO *)
    | Uast.Sexp_field (expr, field) ->
        Eidapp (longident field.txt, [expression info expr])
    | Uast.Sexp_ifthenelse (e1, e2, Some e3) ->
        Eif (expression info e1, expression info e2, expression info e3)
    | Uast.Sexp_ifthenelse (e1, e2, None) ->
        Eif (expression info e1, expression info e2, unit_expr)
    | Uast.Sexp_assert {spexp_desc; _} when is_false spexp_desc ->
        Eabsurd
    | Sexp_let _ -> assert false (* TODO *)
    | Sexp_fun _ -> assert false (* TODO *)
    | Sexp_variant _ -> assert false (* TODO *)
    | Sexp_setfield _ -> assert false (* TODO *)
    | Sexp_array _ -> assert false (* TODO *)
    | Sexp_while _ -> assert false (* TODO *)
    | Sexp_for _ -> assert false (* TODO *)
    | Sexp_coerce _ -> assert false (* TODO *)
    | Sexp_send _ -> assert false (* TODO *)
    | Sexp_new _ -> assert false (* TODO *)
    | Sexp_setinstvar _ -> assert false (* TODO *)
    | Sexp_override _ -> assert false (* TODO *)
    | Sexp_letmodule _ -> assert false (* TODO *)
    | Sexp_letexception _ -> assert false (* TODO *)
    | Sexp_assert _ -> assert false (* TODO *)
    | Sexp_lazy _ -> assert false (* TODO *)
    | Sexp_poly _ -> assert false (* TODO *)
    | Sexp_object _ -> assert false (* TODO *)
    | Sexp_newtype _ -> assert false (* TODO *)
    | Sexp_pack _ -> assert false (* TODO *)
    | Sexp_open _ -> assert false (* TODO *)
    | Sexp_extension _ -> assert false (* TODO *)
    | Sexp_unreachable -> assert false (* TODO *) in
  mk_expr (pexp_desc p_desc)

and case info Uast.{spc_lhs; spc_guard; spc_rhs} =
  check_guard spc_guard;
  pattern info spc_lhs, expression info spc_rhs

and case_exn info Uast.{spc_lhs; spc_guard; spc_rhs} =
  check_guard spc_guard;
  let q, pat = match spc_lhs.O.ppat_desc with
    | Ppat_any -> Qident (T.mk_id "_"), None
    | Ppat_var s -> let id_loc = T.location s.loc in
        Qident (T.mk_id s.txt ~id_loc), None
    | Ppat_construct (id, pat) -> let id_loc = T.location id.loc in
        longident id.txt ~id_loc, Opt.map (pattern info) pat
    | _ -> assert false (* TODO *) in
  q, pat, expression info spc_rhs

and s_value_binding info svb =
  let pexp = svb.Uast.spvb_expr in
  let expr_loc = T.location svb.Uast.spvb_expr.spexp_loc in
  let spec = function None -> empty_spec | Some s -> S.vspec s in
  let rec loop acc expr = match expr.Uast.spexp_desc with
    | Sexp_fun (_, None, pat, e, _) ->
        (* TODO? Should we ignore the spec that comes with [Sexp_fun]? *)
        let arg = binder_of_pattern pat in
        loop (arg :: acc) e
    | Sexp_function case_list ->
        let param_id = T.mk_id "param" in
        let param = mk_expr (Eident (Qident param_id)) ~expr_loc:T.dummy_loc in
        let arg = T.dummy_loc, Some (T.mk_id "param"), false, None in
        let ematch = Ematch (param, List.map (case info) case_list, []) in
        let expr_loc = T.location expr.spexp_loc in
        List.rev (arg :: acc), mk_expr ematch ~expr_loc
    | _ -> List.rev acc, expression info expr in (* TODO *)
  let mk_binder expr = match expr.Uast.spexp_desc with
    | Sexp_fun (_, _, pat, e, _) ->
        (* TODO? Should we ignore the spec that comes with [Sexp_fun]? *)
        let args, expr = loop [] e in
        let args = binder_of_pattern pat :: args in
        let ret  = T.mk_pattern Pwild in
        let spec = spec svb.Uast.spvb_vspec in
        let efun = (Efun (args, None, ret, Ity.MaskVisible, spec, expr)) in
        mk_expr efun ~expr_loc
    | Sexp_function case_list ->
        let ret = T.mk_pattern Pwild in
        let param_id = T.mk_id "param" in
        let arg = T.dummy_loc, Some param_id, false, None in
        let param = mk_expr (Eident (Qident param_id)) ~expr_loc:T.dummy_loc in
        let match_desc = Ematch (param, List.map (case info) case_list, []) in
        let match_expr = mk_expr match_desc ~expr_loc in
        let spec = spec svb.Uast.spvb_vspec (* TODO *) in
        let mask = Ity.MaskVisible in
        let efun = (Efun ([arg], None, ret, mask, spec, match_expr)) in
        mk_expr efun ~expr_loc
    | _ -> expression info expr in
  let id = id_of_pat svb.spvb_pat in
  id, mk_binder pexp

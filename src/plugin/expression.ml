open Why3
open Ptree
open Gospel
open Oasttypes
open Longident
open Why3ocaml_driver
module T = Uterm
module S = Vspec
module O = Oparsetree

let rec string_of_longident = function
  | Longident.Lident s -> s
  | Ldot (t, s) -> string_of_longident t ^ s
  | Lapply (t1, t2) -> string_of_longident t1 ^ string_of_longident t2

(* TO BE USED : *)
(* let rec_flag = function Nonrecursive -> false | Recursive -> true *)

let direction_flag = function Upto -> Expr.To | Downto -> Expr.DownTo

(* TO BE USED : *)
(* let split_on_checks sp_pre =
 *   let mk_split (pre, checks) (t, is_checks) =
 *     if is_checks then pre, t :: checks else t :: pre, checks in
 *   let pre, checks = List.fold_left mk_split ([], []) sp_pre in
 *   List.rev pre, List.rev checks *)

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

(** Smart constructors for Ptree pty *)

let mk_pttyvar id =
  PTtyvar id

let mk_pttyapp id args =
  PTtyapp (id, args)

let mk_ptarrow pty1 pty2 =
  PTarrow (pty1, pty2)

let mk_pttuple pty_list =
  PTtuple pty_list

let mk_binder loc id ghost pty =
  (loc, id, ghost, pty)

(** Smart constructors for Ptree pattern *)

let mk_pwild =
  Pwild

let mk_pvar id =
  Pvar id

let mk_ptuple pat_list =
  Ptuple pat_list

let mk_papp id args =
  Papp (id, args)

let mk_papp_no_args id =
  mk_papp id []

let mk_por pat1 pat2 =
  Por (pat1, pat2)

let mk_pas ?(ghost=false) pat id =
  Pas (pat, id, ghost)

(** Smart constructors for Ptree expressions *)

let mk_expr ?(expr_loc=T.dummy_loc) expr_desc =
  { expr_desc; expr_loc }

let mk_fun_def ghost rs_kind (id, fun_expr) =
  let args, ret, spec, expr = match fun_expr.expr_desc with
    | Efun (args, _, ret, _, spec, expr) -> args, ret, spec, expr
    | Erec _ -> assert false (* TODO *)
    | Ematch _ -> assert false (* TODO *)
    | _ -> assert false (* TODO *) in
  id, ghost, rs_kind, args, None, ret, Ity.MaskVisible, spec, expr

let mk_elet_none id ghost expr expr_in =
  Elet (id, ghost, Expr.RKnone, expr, expr_in)

let mk_ematch expr case_list exn_list =
  Ematch (expr, case_list, exn_list)

let mk_ematch_no_exn expr reg_branch =
  mk_ematch expr reg_branch []

let mk_ematch_no_reg expr exn_branch =
  mk_ematch expr [] exn_branch

let mk_erec fd_list expr =
  Erec (fd_list, expr)

let mk_efun binder_list pty pat mask spec expr =
  Efun (binder_list, pty, pat, mask, spec, expr)

let mk_efun_visible binder_list pty spec expr =
  mk_efun binder_list pty (T.mk_pattern Pwild) Ity.MaskVisible spec expr

let mk_eraise id expr =
  Eraise (id, expr)

let mk_eidapp id expr_list =
  Eidapp (id, expr_list)

let mk_eidapp_no_args id =
  mk_eidapp id []

let mk_etuple expr_list =
  Etuple expr_list

let mk_eseq expr1 expr2 =
  Esequence (expr1, expr2)

let mk_ecast expr pty =
  Ecast (expr, pty)

let mk_eunit =
  Etuple []

let mk_erecord field_list = function
  | None -> Erecord field_list
  | Some e -> Eupdate (e, field_list)

let unit_expr =
  mk_expr mk_eunit

let mk_eif expr1 expr2 = function
  | None -> Eif (expr1, expr2, unit_expr)
  | Some e -> Eif (expr1, expr2, e)

let mk_eassign expr_lhs id expr_rhs =
  Eassign [(expr_lhs, Some id, expr_rhs)]

let mk_ewhile expr_test invariant variant expr_body =
  Ewhile (expr_test, invariant, variant, expr_body)

let mk_efor id expr_lower flag expr_upper invariant expr_body =
  Efor (id, expr_lower, flag, expr_upper, invariant, expr_body)

let mk_eexn id pty mask expr =
  Eexn (id, pty, mask, expr)

let unit_pty = PTtuple []

let is_ghost attributes =
  List.exists (fun O.{attr_name; _} -> attr_name.txt = "ghost") attributes

let is_ghost_svb Uast.{spvb_attributes; _} = is_ghost spvb_attributes

let rec longident ?(id_loc=T.dummy_loc) ?(prefix="") = function
  | Lident id -> (* FIXME? right place to driver lookup? *)
      let id = match query_syntax id with Some s -> s | None -> id in
      Qident (T.mk_id ~id_loc (prefix ^ id))
  | Ldot (t, id) ->
      let id = match query_syntax id with Some s -> s | None -> id in
      Qdot (longident ~id_loc t, T.mk_id ~id_loc id)
  | _ -> assert false (* TODO *)

let rec core_type O.{ptyp_desc; ptyp_loc; _} = match ptyp_desc with
  | Ptyp_any ->
      assert false (* TODO *)
  | O.Ptyp_var s ->
      mk_pttyvar T.(mk_id ~id_loc:(location ptyp_loc) s)
  | O.Ptyp_constr ({txt; loc}, cty_list) ->
      let args = List.map core_type cty_list in
      mk_pttyapp (longident ~id_loc:(T.location loc) txt) args
  | O.Ptyp_arrow (Nolabel, cty1, cty2) ->
      mk_ptarrow (core_type cty1) (core_type cty2)
  | O.Ptyp_arrow (Labelled _, _, _) ->
      assert false (* TODO *)
  | O.Ptyp_arrow (Optional _, _, _) ->
      assert false (* TODO *)
  | O.Ptyp_tuple cty_list ->
      mk_pttuple (List.map core_type cty_list)
  | Ptyp_object _ ->
      assert false (* TODO *)
  | Ptyp_class _ ->
      assert false (* TODO *)
  | Ptyp_alias _ ->
      assert false (* TODO *)
  | Ptyp_variant _ ->
      assert false (* TODO *)
  | Ptyp_poly _ ->
      assert false (* TODO *)
  | Ptyp_package _ ->
      assert false (* TODO *)
  | Ptyp_extension _ ->
      assert false (* TODO *)

let binder_of_pattern O.{ppat_desc; ppat_loc; ppat_attributes; _} =
  let binder id pat_loc ghost_pat pty =
    mk_binder (T.location pat_loc) (Some id) (is_ghost ghost_pat) pty in
  match ppat_desc with
  | Ppat_any ->
      let id = T.(mk_id "us" ~id_loc:(location ppat_loc)) in
      binder id ppat_loc ppat_attributes None
  | Ppat_var x ->
      let id = T.(mk_id x.txt ~id_loc:(location x.loc)) in
      binder id ppat_loc ppat_attributes None
  | Ppat_alias _ ->
      assert false (* TODO *)
  | Ppat_constant _ ->
      assert false (* TODO *)
  | Ppat_interval _ ->
      assert false (* TODO *)
  | Ppat_tuple _ ->
      assert false (* TODO *)
  | Ppat_construct ({txt = Lident "()"; loc}, None) ->
      let id = T.(mk_id "_" ~id_loc:(location loc)) in
      binder id ppat_loc ppat_attributes (Some unit_pty)
  | Ppat_construct _ ->
      assert false (* TODO *)
  | Ppat_variant _ ->
      assert false (* TODO *)
  | Ppat_record _ ->
      assert false (* TODO *)
  | Ppat_array _ ->
      assert false (* TODO *)
  | Ppat_or _ ->
      assert false (* TODO *)
  | Ppat_constraint ({ppat_desc = Ppat_var s; ppat_loc; _}, cty) ->
      let id = T.(mk_id s.txt ~id_loc:(location s.loc)) in
      binder id ppat_loc ppat_attributes (Some (core_type cty))
  | Ppat_constraint _ ->
      assert false (* TODO *)
  | Ppat_type _ ->
      assert false (* TODO *)
  | Ppat_lazy _ ->
      assert false (* TODO *)
  | Ppat_unpack _ ->
      assert false (* TODO *)
  | Ppat_exception _ ->
      assert false (* TODO *)
  | Ppat_extension _ ->
      assert false (* TODO *)
  | Ppat_open _ ->
      assert false (* TODO *)

let rec id_of_pat O.{ppat_desc; _} = match ppat_desc with
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
  | Ppat_constraint (pat, _) ->
      id_of_pat pat
  | Ppat_type _ -> assert false (* TODO *)
  | Ppat_lazy _ -> assert false (* TODO *)
  | Ppat_unpack _ -> assert false (* TODO *)
  | Ppat_exception _ -> assert false (* TODO *)
  | Ppat_extension _ -> assert false (* TODO *)
  | Ppat_open _ -> assert false (* TODO *)

let rec pattern info O.{ppat_desc = p_desc; ppat_loc; _} =
  let pat_loc = T.location ppat_loc in
  let mk_pat p = T.mk_pattern ~pat_loc p in
  let pat_arith info s pat_list =
    let pat = List.map (pattern info) pat_list in
    if Hashtbl.find info.Odecl.info_arith_construct s > 1 then pat
    else [mk_pat (Ptuple pat)] in
  let pat_desc = function
    | O.Ppat_any    -> mk_pwild
    | O.Ppat_var id -> mk_pvar T.(mk_id ~id_loc:(location id.loc) id.txt)
    | O.Ppat_tuple pat_list ->
        mk_ptuple (List.map (pattern info) pat_list)
    | O.Ppat_construct (id, None) ->
        mk_papp_no_args (longident id.txt)
    | O.Ppat_construct (id, Some ({ppat_desc = Ppat_tuple pat_list; _})) ->
        let s = string_of_longident id.txt in
        let args = pat_arith info s pat_list in
        mk_papp (longident id.txt) args
    | O.Ppat_construct (id, Some p) ->
        mk_papp (longident id.txt) [pattern info p]
    | O.Ppat_or (pat1, pat2) ->
        mk_por (pattern info pat1) (pattern info pat2)
    | O.Ppat_constant _ ->
        Loc.errorm "Constants in case expressions are not supported."
    | Ppat_alias (pat, id) ->
        let pat_id = T.(mk_id ~id_loc:(location id.loc)) id.txt in
        mk_pas (pattern info pat) pat_id
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
  | Some e ->
      Loc.errorm ~loc:(T.location e.Uast.spexp_loc)
        "Guarded expressions are not supported."
  | None   -> ()

let exception_constructor exn_construct =
  let txt_exn = exn_construct.O.pext_name.txt in
  let loc_exn = exn_construct.pext_name.loc in
  let id_exn = T.mk_id txt_exn ~id_loc:(T.location loc_exn) in
  let pty = match exn_construct.pext_kind with
    | Pext_decl (Pcstr_tuple [cty], None) ->
        core_type cty
    | Pext_decl (Pcstr_tuple cty_list, None) ->
        PTtuple (List.map core_type cty_list)
    | Pext_decl (Pcstr_record _, _) ->
        Loc.errorm
          "Record expressions in exceptions declaration is not supported."
    | _ -> assert false (* TODO? *) in
  id_exn, pty, Ity.MaskVisible (* TODO: account for a different mask *)

let rec expression info Uast.{spexp_desc = p_desc; spexp_loc; _} =
  let expr_loc = T.location spexp_loc in
  let mk_expr e = mk_expr ~expr_loc e in
  let arg_expr (_, expr) = expression info expr in
  let logic_attr = "logic" and lemma_attr = "lemma" in
  let is_logic =
    List.exists (fun O.{attr_name; _} -> attr_name.txt = logic_attr) in
  let is_lemma =
    List.exists (fun O.{attr_name; _} -> attr_name.txt = lemma_attr) in
  let is_logic_svb Uast.{spvb_attributes; _} = is_logic spvb_attributes in
  let is_lemma_svb Uast.{spvb_attributes; _} = is_lemma spvb_attributes in
  let field_expr ({txt; loc}, e) = let id_loc = T.location loc in
    (longident txt ~id_loc, expression info e) in
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
        let_match info (expression info expr) svb
    | Uast.Sexp_let (Recursive, svb_list, expr) ->
        let rs_kind, id_fun_expr_list = id_expr_rs_kind_of_svb_list svb_list in
        let expr_in = expression info expr in
        mk_erec (List.map (mk_fun_def false rs_kind) id_fun_expr_list) expr_in
    | Sexp_let _ ->
        assert false (* TODO *)
    | Uast.Sexp_function _ ->
        assert false (* TODO *)
    | Uast.Sexp_fun (Nolabel, None, pat, expr_body, spec) ->
        let expr_body = expression info expr_body in
        let spec = match spec with Some s -> S.fun_spec s | _ -> empty_spec in
        mk_efun_visible [binder_of_pattern pat] None spec expr_body
    | Uast.Sexp_apply (s, [arg1; arg2]) when is_and s.spexp_desc ->
        Eand (arg_expr arg1, arg_expr arg2)
    | Uast.Sexp_apply (s, [arg1; arg2]) when is_or s.spexp_desc ->
        Eor (arg_expr arg1, arg_expr arg2)
    | Uast.Sexp_apply (s, [arg]) when is_not s.spexp_desc ->
        Enot (arg_expr arg)
    | Uast.Sexp_apply (s, [_, arg]) when is_raise s.spexp_desc ->
        apply_raise info arg.spexp_desc
    | Uast.Sexp_apply ({spexp_desc = Sexp_ident s; _}, arg_expr_list) ->
        let id_loc = T.location s.loc in
        mk_eidapp (longident ~id_loc s.txt) (List.map arg_expr arg_expr_list)
    | Uast.Sexp_apply _ ->
        assert false (* TODO *)
    | Uast.Sexp_match (expr, case_list) ->
        let reg_branch = List.map (case info) case_list in
        mk_ematch_no_exn (expression info expr) reg_branch
    | Uast.Sexp_try (expr, case_list) ->
        let exn_branch = List.map (case_exn info) case_list in
        mk_ematch_no_reg (expression info expr) exn_branch
    | Uast.Sexp_tuple exp_list ->
        mk_etuple (List.map (expression info) exp_list)
    | Uast.Sexp_sequence (e1, e2) ->
        mk_eseq (expression info e1) (expression info e2)
    | Uast.Sexp_constraint (e, cty) ->
        mk_ecast (expression info e) (core_type cty)
    | Uast.Sexp_construct ({txt = Lident "true"; _}, None) ->
        Etrue
    | Uast.Sexp_construct ({txt = Lident "false"; _}, None) ->
        Efalse
    | Uast.Sexp_construct ({txt = Lident "()"; _}, None) ->
        mk_eunit
    | Uast.Sexp_construct (id, None) ->
        mk_eidapp_no_args (longident id.txt)
    | Uast.Sexp_construct (id, Some {spexp_desc = Sexp_tuple expr_list; _}) ->
        let s = string_of_longident id.txt in
        let args = construct_arith info s expr_list in
        mk_eidapp (longident id.txt) args
    | Uast.Sexp_construct (id, Some e) ->
        mk_eidapp (longident id.txt) [expression info e]
    | Uast.Sexp_record (field_list, e) ->
        let update_expr = Opt.map (expression info) e in
        mk_erecord (List.map field_expr field_list) update_expr
    | Uast.Sexp_field (expr, field) ->
        mk_eidapp (longident field.txt) [expression info expr]
    | Uast.Sexp_ifthenelse (e1, e2, e3) ->
        let expr3 = Opt.map (expression info) e3 in
        mk_eif (expression info e1) (expression info e2) expr3
    | Uast.Sexp_assert {spexp_desc; _} when is_false spexp_desc ->
        Eabsurd
    | Sexp_fun _ ->
        assert false (* TODO *)
    | Sexp_variant _ ->
        assert false (* TODO *)
    | Sexp_setfield (lvalue, l, rvalue) ->
        let lexpr = expression info lvalue and rexpr = expression info rvalue in
        let id = longident ~id_loc:T.(location l.loc) l.txt in
        mk_eassign lexpr id rexpr
    | Sexp_array _ ->
        assert false (* TODO *)
    | Sexp_while (e_test, e_body, loop_annotation) ->
        let mk_variant t = (T.term t, None) in
        let inv = List.map T.term loop_annotation.loop_invariant in
        let var = List.map mk_variant loop_annotation.loop_variant in
        mk_ewhile (expression info e_test) inv var (expression info e_body)
    | Sexp_for (pat, expr_lower, expr_upper, flag, expr_body, loop_annot) ->
        let id = id_of_pat pat in
        let expr_lower = expression info expr_lower in
        let expr_upper = expression info expr_upper in
        let flag = direction_flag flag in
        let expr_body = expression info expr_body in
        let invariant = List.map T.term loop_annot.loop_invariant in
        mk_efor id expr_lower flag expr_upper invariant expr_body
    | Sexp_letexception (exn_constructor, expr) ->
        let id, pty, mask = exception_constructor exn_constructor in
        mk_eexn id pty mask (expression info expr)
    | Sexp_coerce _ ->
        assert false (* TODO *)
    | Sexp_send _ ->
        assert false (* TODO *)
    | Sexp_new _ ->
        assert false (* TODO *)
    | Sexp_setinstvar _ ->
        assert false (* TODO *)
    | Sexp_override _ ->
        assert false (* TODO *)
    | Sexp_letmodule _ ->
        assert false (* TODO *)
    | Sexp_assert _ ->
        assert false (* TODO *)
    | Sexp_lazy _ ->
        assert false (* TODO *)
    | Sexp_poly _ ->
        assert false (* TODO *)
    | Sexp_object _ ->
        assert false (* TODO *)
    | Sexp_newtype _ ->
        assert false (* TODO *)
    | Sexp_pack _ ->
        assert false (* TODO *)
    | Sexp_open _ ->
        assert false (* TODO *)
    | Sexp_extension _ ->
        assert false (* TODO *)
    | Sexp_unreachable ->
        assert false (* TODO *) in
  mk_expr (pexp_desc p_desc)

and let_match info expr svb = match svb.Uast.spvb_pat.O.ppat_desc with
  | (Ppat_tuple _) -> let svb_expr = expression info svb.spvb_expr in
      let pat = pattern info svb.spvb_pat in
      mk_ematch_no_exn svb_expr [pat, expr]
  | _ -> let id, svb_expr = s_value_binding info svb in
      mk_elet_none id (is_ghost_svb svb) svb_expr expr

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

and apply_raise info = function
  | Uast.Sexp_construct (id, exn_arg) ->
      mk_eraise (longident id.txt) (Opt.map (expression info) exn_arg)
  | _ -> assert false (* TODO: not supported for now *)

and construct_arith info s expr_list =
  if Hashtbl.find info.info_arith_construct s > 1 then
    List.map (expression info) expr_list
  else let etuple = Etuple (List.map (expression info) expr_list) in
    [mk_expr etuple]

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
  let mk_svb_expr expr = match expr.Uast.spexp_desc with
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
  id, mk_svb_expr pexp

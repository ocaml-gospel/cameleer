open Ppxlib
open Why3
open Ptree
open Gospel
open Longident
open Why3ocaml_driver
module T = Uterm
module S = Vspec
module P = Parsetree

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

(** Smart constructors for Ptree pty *)

let mk_pttyvar id = PTtyvar id
let mk_pttyapp id args = PTtyapp (id, args)
let mk_ptarrow pty1 pty2 = PTarrow (pty1, pty2)
let mk_pttuple pty_list = PTtuple pty_list
let mk_binder loc id ghost pty : Ptree.binder = (loc, id, ghost, pty)

(** Smart constructors for Ptree pattern *)

let mk_pwild = Pwild
let mk_pvar id = Pvar id
let mk_ptuple pat_list = Ptuple pat_list
let mk_papp id args = Papp (id, args)
let mk_papp_no_args id = mk_papp id []
let mk_por pat1 pat2 = Por (pat1, pat2)
let mk_pas ?(ghost = false) pat id = Pas (pat, id, ghost)

(** Smart constructors for Ptree expressions *)

let mk_expr ?(expr_loc = T.dummy_loc) expr_desc = { expr_desc; expr_loc }

let mk_fun_def ghost rs_kind (id, fun_expr) =
  let args, ret, spec, expr =
    match fun_expr.expr_desc with
    | Efun (args, _, ret, _, spec, expr) -> (args, ret, spec, expr)
    | Erec _ -> assert false (* TODO *)
    | Ematch _ -> assert false (* TODO *)
    | _ -> assert false
    (* TODO *)
  in
  (id, ghost, rs_kind, args, None, ret, Ity.MaskVisible, spec, expr)

let mk_elet_none id ghost expr expr_in =
  Elet (id, ghost, Expr.RKnone, expr, expr_in)

let mk_ematch expr case_list exn_list = Ematch (expr, case_list, exn_list)
let mk_ematch_no_exn expr reg_branch = mk_ematch expr reg_branch []
let mk_ematch_no_reg expr exn_branch = mk_ematch expr [] exn_branch
let mk_erec fd_list expr = Erec (fd_list, expr)

let mk_efun binder_list pty pat mask spec expr =
  Efun (binder_list, pty, pat, mask, spec, expr)

let mk_efun_visible binder_list pty spec expr =
  mk_efun binder_list pty (T.mk_pattern Pwild) Ity.MaskVisible spec expr

let mk_eraise id expr = Eraise (id, expr)
let mk_eidapp id expr_list = Eidapp (id, expr_list)
let mk_eidapp_no_args id = mk_eidapp id []
let mk_etuple expr_list = Etuple expr_list
let mk_eseq expr1 expr2 = Esequence (expr1, expr2)
let mk_ecast expr pty = Ecast (expr, pty)
let mk_eunit = Etuple []

let mk_erecord field_list = function
  | None -> Erecord field_list
  | Some e -> Eupdate (e, field_list)

let unit_expr = mk_expr mk_eunit

let mk_eif expr1 expr2 = function
  | None -> Eif (expr1, expr2, unit_expr)
  | Some e -> Eif (expr1, expr2, e)

let mk_eassign expr_lhs id expr_rhs = Eassign [ (expr_lhs, Some id, expr_rhs) ]

let mk_ewhile expr_test invariant variant expr_body =
  Ewhile (expr_test, invariant, variant, expr_body)

let mk_efor id expr_lower flag expr_upper invariant expr_body =
  Efor (id, expr_lower, flag, expr_upper, invariant, expr_body)

let mk_eexn id pty mask expr = Eexn (id, pty, mask, expr)
let unit_pty = PTtuple []

let is_ghost attributes =
  List.exists (fun P.{ attr_name; _ } -> attr_name.txt = "ghost") attributes

let is_ghost_svb Uast.{ spvb_attributes; _ } = is_ghost spvb_attributes

let rec longident ?(id_loc = T.dummy_loc) ?(prefix = "") = function
  | Lident id ->
      (* FIXME? right place to driver lookup? *)
      let id = match query_syntax id with Some s -> s | None -> id in
      Qident (T.mk_id ~id_loc (prefix ^ id))
  | Ldot (t, id) ->
      let id = match query_syntax id with Some s -> s | None -> id in
      Qdot (longident ~id_loc t, T.mk_id ~id_loc id)
  | _ -> assert false
(* TODO *)

let rec core_type P.{ ptyp_desc; ptyp_loc; _ } =
  match ptyp_desc with
  | Ptyp_any -> assert false (* TODO *)
  | P.Ptyp_var s -> mk_pttyvar T.(mk_id ~id_loc:(location ptyp_loc) s)
  | Ptyp_constr ({ txt; loc }, cty_list) ->
      let args = List.map core_type cty_list in
      mk_pttyapp (longident ~id_loc:(T.location loc) txt) args
  | Ptyp_arrow (Nolabel, cty1, cty2) ->
      mk_ptarrow (core_type cty1) (core_type cty2)
  | Ptyp_arrow (Labelled _, _, _) -> assert false (* TODO *)
  | Ptyp_arrow (Optional _, _, _) -> assert false (* TODO *)
  | Ptyp_tuple cty_list -> mk_pttuple (List.map core_type cty_list)
  | Ptyp_object _ -> assert false (* TODO *)
  | Ptyp_class _ -> assert false (* TODO *)
  | Ptyp_alias _ -> assert false (* TODO *)
  | Ptyp_variant _ -> assert false (* TODO *)
  | Ptyp_poly _ -> assert false (* TODO *)
  | Ptyp_package _ -> assert false (* TODO *)
  | Ptyp_extension _ -> assert false
(* TODO *)

let rec id_of_pat P.{ ppat_desc; _ } =
  match ppat_desc with
  | Ppat_var { txt; loc } -> T.(mk_id ~id_loc:(location loc) txt)
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
  | Ppat_constraint (pat, _) -> id_of_pat pat
  | Ppat_type _ -> assert false (* TODO *)
  | Ppat_lazy _ -> assert false (* TODO *)
  | Ppat_unpack _ -> assert false (* TODO *)
  | Ppat_exception _ -> assert false (* TODO *)
  | Ppat_extension _ -> assert false (* TODO *)
  | Ppat_open _ -> assert false
(* TODO *)

let mk_id_pat (id, pat) =
  let field_str = Longident.last_exn id.txt in
  let id_field = T.mk_id ~id_loc:(T.location id.loc) field_str in
  let id_pat = id_of_pat pat in
  (id_field, id_pat)

type pat_with_exn = { pat_term : pattern option; pat_exn_name : qualid option }

let rec pattern info P.({ ppat_desc; _ } as pat) =
  match ppat_desc with
  | Ppat_exception pat ->
      let q, pat = exception_name_of_pattern info pat in
      { pat_term = pat; pat_exn_name = Some q }
  | _ -> { pat_term = Some (inner_pattern info pat); pat_exn_name = None }

and inner_pattern info P.{ ppat_desc; ppat_loc; _ } =
  let pat_loc = T.location ppat_loc in
  let mk_pat p = T.mk_pattern ~pat_loc p in
  let pat_arith info s pat_list =
    let pat = List.map (inner_pattern info) pat_list in
    if Hashtbl.find info.Odecl.info_arith_construct s > 1 then pat
    else [ mk_pat (Ptuple pat) ]
  in
  let longident_pattern (id, pat) =
    (longident ~id_loc:(T.location id.loc) id.txt, inner_pattern info pat)
  in
  let pat_desc =
    match ppat_desc with
    | P.Ppat_any -> mk_pwild
    | Ppat_var id -> mk_pvar T.(mk_id ~id_loc:(location id.loc) id.txt)
    | Ppat_tuple pat_list ->
        let pats = List.map (inner_pattern info) pat_list in
        mk_ptuple pats
    | Ppat_construct ({ txt = Lident "false"; loc }, None) ->
        let id_loc = T.location loc in
        mk_papp (Qident (T.mk_id ~id_loc "False")) []
    | Ppat_construct ({ txt = Lident "true"; loc }, None) ->
        let id_loc = T.location loc in
        mk_papp (Qident (T.mk_id ~id_loc "True")) []
    | Ppat_construct (id, None) -> mk_papp_no_args (longident id.txt)
    | Ppat_construct (id, Some (_, { ppat_desc = Ppat_tuple pat_list; _ })) ->
        let s = string_of_longident id.txt in
        let args = pat_arith info s pat_list in
        mk_papp (longident id.txt) args
    | Ppat_construct (id, Some (_, p)) ->
        let pat = inner_pattern info p in
        mk_papp (longident id.txt) [ pat ]
    | Ppat_or (pat1, pat2) ->
        let pat1 = inner_pattern info pat1 in
        let pat2 = inner_pattern info pat2 in
        mk_por pat1 pat2
    | Ppat_constant _ ->
        Loc.errorm "Constants in case expressions are not supported."
    | Ppat_alias (pat, id) ->
        let pat_id = T.(mk_id ~id_loc:(location id.loc)) id.txt in
        mk_pas (inner_pattern info pat) pat_id
    | Ppat_interval _ -> assert false (* TODO *)
    | Ppat_variant _ -> assert false (* TODO *)
    | Ppat_record (id_pat_list, _) ->
        let qualid_pat_list = List.map longident_pattern id_pat_list in
        Prec qualid_pat_list
    | Ppat_array _ -> assert false (* TODO *)
    | Ppat_constraint _ -> assert false (* TODO *)
    | Ppat_type _ -> assert false (* TODO *)
    | Ppat_lazy _ -> assert false (* TODO *)
    | Ppat_unpack _ -> assert false (* TODO *)
    | Ppat_exception _ ->
        Why3.Loc.errorm ~loc:pat_loc
          "Exception patterns are not allowed in this position."
    | Ppat_extension _ -> assert false (* TODO *)
    | Ppat_open _ -> assert false
    (* TODO *)
  in
  mk_pat pat_desc

and exception_name_of_pattern info P.{ ppat_desc; _ } =
  let inner_pattern info (_, p) = inner_pattern info p in
  match ppat_desc with
  | Ppat_any -> (Qident (T.mk_id "_"), None)
  | Ppat_var s ->
      let id_loc = T.location s.loc in
      (Qident (T.mk_id s.txt ~id_loc), None)
  | Ppat_construct (id, pat) ->
      let id_loc = T.location id.loc in
      (longident id.txt ~id_loc, Option.map (inner_pattern info) pat)
  | _ -> assert false
(* TODO ?*)

type binder_info = {
  binder_info_loc : Loc.position;
  binder_info_desc : binder_info_desc;
}

and binder_info_desc =
  | BTuple of ident * pattern list
  | BRecord of ident * (ident * ident) list
  | BNone

let mk_binder_info binder_info_loc binder_info_desc =
  { binder_info_loc; binder_info_desc }

let mk_binder_info_none = mk_binder_info T.dummy_loc BNone

let binder_of_pattern =
  let counter = ref 0 in
  fun info P.{ ppat_desc; ppat_loc; ppat_attributes; _ } ->
    let binder id pat_loc ghost_pat pty =
      mk_binder (T.location pat_loc) (Some id) (is_ghost ghost_pat) pty
    in
    match ppat_desc with
    | Ppat_any ->
        let id = T.(mk_id "us" ~id_loc:(location ppat_loc)) in
        (binder id ppat_loc ppat_attributes None, mk_binder_info_none)
    | Ppat_var x ->
        let id = T.(mk_id x.txt ~id_loc:(location x.loc)) in
        (binder id ppat_loc ppat_attributes None, mk_binder_info_none)
    | Ppat_alias _ -> assert false (* TODO *)
    | Ppat_constant _ -> assert false (* TODO *)
    | Ppat_interval _ -> assert false (* TODO *)
    | Ppat_tuple pat_list ->
        incr counter;
        let id_str = "binder'" ^ string_of_int !counter in
        let id = T.(mk_id id_str ~id_loc:(location ppat_loc)) in
        let pat_list = List.map (pattern info) pat_list in
        let mk_pat p =
          assert (p.pat_exn_name = None);
          Option.get p.pat_term
        in
        let pat_list = List.map mk_pat pat_list in
        let b = binder id ppat_loc ppat_attributes None in
        (b, mk_binder_info (T.location ppat_loc) (BTuple (id, pat_list)))
    | Ppat_construct ({ txt = Lident "()"; loc }, None) ->
        let id = T.(mk_id "_" ~id_loc:(location loc)) in
        let b = binder id ppat_loc ppat_attributes (Some unit_pty) in
        (b, mk_binder_info_none)
    | Ppat_construct _ -> assert false (* TODO *)
    | Ppat_variant _ -> assert false (* TODO *)
    | Ppat_record (id_pat_list, _) ->
        incr counter;
        let id_str = "binder" ^ string_of_int !counter in
        let pat_loc = T.location ppat_loc in
        let id = T.mk_id id_str ~id_loc:pat_loc in
        let b = binder id ppat_loc ppat_attributes None in
        let id_pat_list = List.map mk_id_pat id_pat_list in
        (b, mk_binder_info pat_loc (BRecord (id, id_pat_list)))
    | Ppat_array _ -> assert false (* TODO *)
    | Ppat_or _ -> assert false (* TODO *)
    | Ppat_constraint ({ ppat_desc = Ppat_var s; ppat_loc; _ }, cty) ->
        let id = T.(mk_id s.txt ~id_loc:(location s.loc)) in
        let pty = Some (core_type cty) in
        (binder id ppat_loc ppat_attributes pty, mk_binder_info_none)
    | Ppat_constraint _ -> assert false (* TODO *)
    | Ppat_type _ -> assert false (* TODO *)
    | Ppat_lazy _ -> assert false (* TODO *)
    | Ppat_unpack _ -> assert false (* TODO *)
    | Ppat_exception _ -> assert false (* TODO *)
    | Ppat_extension _ -> assert false (* TODO *)
    | Ppat_open _ -> assert false
(* TODO *)

let check_guard = function
  | Some e ->
      Loc.errorm
        ~loc:(T.location e.Uast.spexp_loc)
        "Guarded expressions are not supported."
  | None -> ()

let exception_constructor exn_construct =
  let txt_exn = exn_construct.P.pext_name.txt in
  let loc_exn = exn_construct.pext_name.loc in
  let id_exn = T.mk_id txt_exn ~id_loc:(T.location loc_exn) in
  let pty =
    match exn_construct.pext_kind with
    | Pext_decl (_, Pcstr_tuple [ cty ], None) -> core_type cty
    | Pext_decl (_, Pcstr_tuple cty_list, None) ->
        PTtuple (List.map core_type cty_list)
    | Pext_decl (_, Pcstr_record _, _) ->
        Loc.errorm
          "Record expressions in exceptions declaration is not supported."
    | Pext_decl _ -> assert false (* TODO *)
    | Pext_rebind _ -> assert false
    (* TODO *)
  in
  (id_exn, pty, Ity.MaskVisible)
(* TODO: account for a different mask *)

let rec term info Uast.{ spexp_desc = p_desc; spexp_loc; _ } =
  let term_loc = T.location spexp_loc in
  let arg_term (_, t) = term info t in
  let mk_term e = T.mk_term ~term_loc e in
  let term_expr (_, expr) = term info expr in
  let is_false = function
    | Uast.Sexp_construct ({ txt = Lident "false"; _ }, None) -> true
    | _ -> false
  in
  let is_and = function
    | Uast.Sexp_ident { txt = Lident "&&"; _ } -> true
    | _ -> false
  in
  let is_or = function
    | Uast.Sexp_ident { txt = Lident "||"; _ } -> true
    | _ -> false
  in
  let is_not = function
    | Uast.Sexp_ident { txt = Lident "not"; _ } -> true
    | _ -> false
  in
  let is_raise = function
    | Uast.Sexp_ident { txt = Lident "raise"; _ } -> true
    | _ -> false
  in
  let is_array_get = function
    | Uast.Sexp_ident { txt = Ldot (Lident "Array", "get"); _ } -> true
    | _ -> false
  in
  let pexp_desc = function
    | Uast.Sexp_ident { txt; loc } ->
        Tident (longident ~id_loc:(T.location loc) txt)
    | Uast.Sexp_constant c -> Tconst (T.constant c)
    | Uast.Sexp_let (Nonrecursive, [ svb ], expr) ->
        ignore [ svb ];
        ignore expr;
        assert false (* TODO *)
    | Uast.Sexp_let (Recursive, svb_list, expr) ->
        ignore svb_list;
        ignore expr;
        assert false (* TODO *)
    | Sexp_let _ -> assert false (* TODO *)
    | Uast.Sexp_function _ -> assert false (* TODO *)
    | Uast.Sexp_fun (Nolabel, None, pat, expr_fun, _) ->
        let binder, binder_info = binder_of_pattern info pat in
        ignore binder_info;
        (* TODO *)
        Tquant (Why3.Dterm.DTlambda, [ binder ], [], term info expr_fun)
    | Sexp_fun _ -> assert false (* TODO *)
    | Uast.Sexp_apply (s, [ arg1; arg2 ]) when is_and s.spexp_desc ->
        Tbinop (arg_term arg1, Why3.Dterm.DTand, arg_term arg2)
    | Uast.Sexp_apply (s, [ arg1; arg2 ]) when is_array_get s.spexp_desc ->
        let id_app = Qdot (Qident (T.mk_id "Array"), T.mk_id "mixfix []") in
        Tidapp (id_app, [ arg_term arg1; arg_term arg2 ])
    | Uast.Sexp_apply (s, [ arg1; arg2 ]) when is_or s.spexp_desc ->
        ignore arg1;
        ignore arg2;
        assert false (* TODO *)
    | Uast.Sexp_apply (s, [ arg ]) when is_not s.spexp_desc ->
        ignore arg;
        assert false (* TODO *)
    | Uast.Sexp_apply (s, [ (_, arg) ]) when is_raise s.spexp_desc ->
        ignore arg;
        assert false (* TODO *)
    | Uast.Sexp_apply ({ spexp_desc = Sexp_ident s; _ }, arg_expr_list) ->
        let id_loc = T.location s.loc in
        Tidapp (longident ~id_loc s.txt, List.map term_expr arg_expr_list)
    | Uast.Sexp_apply (expr, arg_expr_list) ->
        let mk_app acc (_, e) = mk_term (Tapply (acc, term info e)) in
        let e_acc = term info expr in
        (List.fold_left mk_app e_acc arg_expr_list).term_desc
        (* :O *)
    | Uast.Sexp_match (expr, case_list) ->
        ignore expr;
        ignore case_list;
        assert false (* TODO *)
    | Uast.Sexp_try (expr, case_list) ->
        ignore expr;
        ignore case_list;
        assert false (* TODO *)
    | Uast.Sexp_tuple expr_list ->
        ignore expr_list;
        assert false (* TODO *)
    | Uast.Sexp_sequence (e1, e2) ->
        ignore e1;
        ignore e2;
        assert false (* TODO *)
    | Uast.Sexp_constraint (e, cty) ->
        ignore e;
        ignore cty;
        assert false (* TODO *)
    | Uast.Sexp_construct ({ txt = Lident "true"; _ }, None) -> Ttrue
    | Uast.Sexp_construct ({ txt = Lident "false"; _ }, None) -> Tfalse
    | Uast.Sexp_construct ({ txt = Lident "()"; _ }, None) ->
        assert false (* TODO *)
    | Uast.Sexp_construct (id, None) -> Tidapp (longident id.txt, [])
    | Uast.Sexp_construct (id, Some { spexp_desc = Sexp_tuple expr_list; _ }) ->
        let s = string_of_longident id.txt in
        let args = construct_arith info s expr_list in
        Tidapp (longident id.txt, args)
    | Uast.Sexp_construct (id, Some e) ->
        Tidapp (longident id.txt, [ term info e ])
    | Uast.Sexp_record (field_list, e) ->
        ignore field_list;
        ignore e;
        assert false (* TODO *)
    | Uast.Sexp_field (expr, field) ->
        Tidapp (longident field.txt, [ term info expr ])
    | Uast.Sexp_ifthenelse (e1, e2, e3) ->
        let term3 = term info (Option.get e3) in
        Tif (term info e1, term info e2, term3)
    | Uast.Sexp_assert { spexp_desc; _ } when is_false spexp_desc ->
        assert false (* TODO *)
    | Sexp_variant _ -> assert false (* TODO *)
    | Sexp_setfield (lvalue, l, rvalue) ->
        ignore lvalue;
        ignore l;
        ignore rvalue;
        assert false (* TODO *)
    | Sexp_array expr_list ->
        ignore expr_list;
        assert false (* TODO *)
    | Sexp_while (e_test, e_body, loop_annotation) ->
        ignore e_test;
        ignore e_body;
        ignore loop_annotation;
        assert false (* TODO *)
    | Sexp_for (pat, expr_lower, expr_upper, flag, expr_body, loop_annot) ->
        ignore pat;
        ignore expr_lower;
        ignore expr_upper;
        ignore flag;
        ignore expr_body;
        ignore loop_annot;
        assert false (* TODO *)
    | Sexp_letexception (exn_constructor, expr) ->
        ignore exn_constructor;
        ignore expr;
        assert false (* TODO *)
    | Sexp_coerce _ -> assert false (* TODO *)
    | Sexp_send _ -> assert false (* TODO *)
    | Sexp_new _ -> assert false (* TODO *)
    | Sexp_setinstvar _ -> assert false (* TODO *)
    | Sexp_override _ -> assert false (* TODO *)
    | Sexp_letmodule _ -> assert false (* TODO *)
    | Sexp_assert _ -> assert false (* TODO *)
    | Sexp_lazy _ -> assert false (* TODO *)
    | Sexp_poly _ -> assert false (* TODO *)
    | Sexp_object _ -> assert false (* TODO *)
    | Sexp_newtype _ -> assert false (* TODO *)
    | Sexp_pack _ -> assert false (* TODO *)
    | Sexp_open _ -> assert false (* TODO *)
    | Sexp_extension _ -> assert false (* TODO *)
    | Sexp_unreachable -> assert false (* TODO *)
    | Sexp_letop _ -> assert false
    (* TODO *)
  in
  mk_term (pexp_desc p_desc)

and construct_arith info s term_list =
  if Hashtbl.find info.Odecl.info_arith_construct s > 1 then
    List.map (term info) term_list
  else
    let ttuple = Ttuple (List.map (term info) term_list) in
    [ Uterm.mk_term ttuple ]

let array_empty =
  let array = Qdot (Qident (T.mk_id "Array"), T.mk_id "empty") in
  mk_eidapp array [ unit_expr ]

let rec expression_desc info expr_loc expr_desc =
  let mk_expr e = mk_expr ~expr_loc e in
  let arg_expr (_, expr) = expression info expr in
  let logic_attr = "logic" and lemma_attr = "lemma" in
  let is_logic =
    List.exists (fun P.{ attr_name; _ } -> attr_name.txt = logic_attr)
  in
  let is_lemma =
    List.exists (fun P.{ attr_name; _ } -> attr_name.txt = lemma_attr)
  in
  let is_logic_svb Uast.{ spvb_attributes; _ } = is_logic spvb_attributes in
  let is_lemma_svb Uast.{ spvb_attributes; _ } = is_lemma spvb_attributes in
  let field_expr ({ txt; loc }, e) =
    let id_loc = T.location loc in
    (longident txt ~id_loc, expression info e)
  in
  let rs_kind svb_list =
    if List.exists is_logic_svb svb_list then Expr.RKfunc
    else if List.exists is_lemma_svb svb_list then Expr.RKlemma
    else Expr.RKnone
  in
  let id_expr_rs_kind_of_svb_list svb_list =
    (rs_kind svb_list, List.map (fun svb -> s_value_binding info svb) svb_list)
  in
  let is_false = function
    | Uast.Sexp_construct ({ txt = Lident "false"; _ }, None) -> true
    | _ -> false
  in
  let is_and = function
    | Uast.Sexp_ident { txt = Lident "&&"; _ } -> true
    | _ -> false
  in
  let is_or = function
    | Uast.Sexp_ident { txt = Lident "||"; _ } -> true
    | _ -> false
  in
  let is_not = function
    | Uast.Sexp_ident { txt = Lident "not"; _ } -> true
    | _ -> false
  in
  let is_raise = function
    | Uast.Sexp_ident { txt = Lident "raise"; _ } -> true
    | _ -> false
  in
  match expr_desc with
  | Uast.Sexp_ident { txt; loc } ->
      Eident (longident ~id_loc:(T.location loc) txt)
  | Uast.Sexp_constant c -> Econst (T.constant c)
  | Uast.Sexp_let (Nonrecursive, [ svb ], expr) ->
      let_match info (expression info expr) svb
  | Uast.Sexp_let (Nonrecursive, svbs, expr) ->
      let mk_let svb acc = mk_expr (let_match info acc svb) in
      (List.fold_right mk_let svbs (expression info expr)).expr_desc
  | Uast.Sexp_let (Recursive, svb_list, expr) ->
      let rs_kind, id_fun_expr_list = id_expr_rs_kind_of_svb_list svb_list in
      let expr_in = expression info expr in
      mk_erec (List.map (mk_fun_def false rs_kind) id_fun_expr_list) expr_in
  | Uast.Sexp_function _ -> assert false (* TODO *)
  | Uast.Sexp_fun (Nolabel, None, pat, expr_fun, spec) ->
      let spec = match spec with Some s -> S.fun_spec s | _ -> empty_spec in
      let binder, binder_info = binder_of_pattern info pat in
      let expr_fun = special_binder (expression info expr_fun) binder_info in
      mk_efun_visible [ binder ] None spec expr_fun
  | Uast.Sexp_apply (s, [ arg1; arg2 ]) when is_and s.spexp_desc ->
      Eand (arg_expr arg1, arg_expr arg2)
  | Uast.Sexp_apply (s, [ arg1; arg2 ]) when is_or s.spexp_desc ->
      Eor (arg_expr arg1, arg_expr arg2)
  | Uast.Sexp_apply (s, [ arg ]) when is_not s.spexp_desc -> Enot (arg_expr arg)
  | Uast.Sexp_apply (s, [ (_, arg) ]) when is_raise s.spexp_desc ->
      apply_raise info arg.spexp_desc
  | Uast.Sexp_apply ({ spexp_desc = Sexp_ident s; _ }, arg_expr_list) ->
      let id_loc = T.location s.loc in
      mk_eidapp (longident ~id_loc s.txt) (List.map arg_expr arg_expr_list)
  | Uast.Sexp_apply (expr, arg_expr_list) ->
      let mk_app acc (_, e) = mk_expr (Eapply (acc, expression info e)) in
      let e_acc = expression info expr in
      (List.fold_left mk_app e_acc arg_expr_list).expr_desc
      (* :O *)
  | Uast.Sexp_match (expr, case_list) ->
      let reg_branch, exn_branch = case info case_list in
      mk_ematch (expression info expr) reg_branch exn_branch
  | Uast.Sexp_try (expr, case_list) ->
      let exn_branch = List.map (case_exn info) case_list in
      mk_ematch_no_reg (expression info expr) exn_branch
  | Uast.Sexp_tuple exp_list -> mk_etuple (List.map (expression info) exp_list)
  | Uast.Sexp_sequence (e1, e2) ->
      mk_eseq (expression info e1) (expression info e2)
  | Uast.Sexp_constraint (e, cty) ->
      mk_ecast (expression info e) (core_type cty)
  | Uast.Sexp_construct ({ txt = Lident "true"; _ }, None) -> Etrue
  | Uast.Sexp_construct ({ txt = Lident "false"; _ }, None) -> Efalse
  | Uast.Sexp_construct ({ txt = Lident "()"; _ }, None) -> mk_eunit
  | Uast.Sexp_construct (id, None) -> mk_eidapp_no_args (longident id.txt)
  | Uast.Sexp_construct (id, Some { spexp_desc = Sexp_tuple expr_list; _ }) ->
      let s = string_of_longident id.txt in
      let args = construct_arith info s expr_list in
      mk_eidapp (longident id.txt) args
  | Uast.Sexp_construct (id, Some e) ->
      mk_eidapp (longident id.txt) [ expression info e ]
  | Uast.Sexp_record (field_list, e) ->
      let update_expr = Option.map (expression info) e in
      mk_erecord (List.map field_expr field_list) update_expr
  | Uast.Sexp_field (expr, field) ->
      mk_eidapp (longident field.txt) [ expression info expr ]
  | Uast.Sexp_ifthenelse (e1, e2, e3) ->
      let expr3 = Option.map (expression info) e3 in
      mk_eif (expression info e1) (expression info e2) expr3
  | Uast.Sexp_assert { spexp_desc; _ } when is_false spexp_desc -> Eabsurd
  | Sexp_assert e -> Eassert (Expr.Assert, term info e)
  | Sexp_fun _ -> assert false (* TODO *)
  | Sexp_variant _ -> assert false (* TODO *)
  | Sexp_setfield (lvalue, l, rvalue) ->
      let lexpr = expression info lvalue and rexpr = expression info rvalue in
      let id = longident ~id_loc:T.(location l.loc) l.txt in
      mk_eassign lexpr id rexpr
  | Sexp_array [] -> array_empty
  | Sexp_array expr_list -> mk_array info expr_list
  | Sexp_while (e_test, e_body, None) ->
      mk_ewhile (expression info e_test) [] [] (expression info e_body)
  | Sexp_while (e_test, e_body, Some loop_annotation) ->
      let mk_variant t = (T.term false t, None) in
      let inv = List.map (T.term false) loop_annotation.loop_invariant in
      let var = List.map mk_variant loop_annotation.loop_variant in
      mk_ewhile (expression info e_test) inv var (expression info e_body)
  | Sexp_for (pat, expr_lower, expr_upper, flag, expr_body, None) ->
      let id = id_of_pat pat in
      let expr_lower = expression info expr_lower in
      let expr_upper = expression info expr_upper in
      let flag = direction_flag flag in
      let expr_body = expression info expr_body in
      mk_efor id expr_lower flag expr_upper [] expr_body
  | Sexp_for (pat, expr_lower, expr_upper, flag, expr_body, Some loop_spec) ->
      let id = id_of_pat pat in
      let expr_lower = expression info expr_lower in
      let expr_upper = expression info expr_upper in
      let flag = direction_flag flag in
      let expr_body = expression info expr_body in
      let invariant = List.map (T.term false) loop_spec.loop_invariant in
      mk_efor id expr_lower flag expr_upper invariant expr_body
  | Sexp_letexception (exn_constructor, expr) ->
      let id, pty, mask = exception_constructor exn_constructor in
      mk_eexn id pty mask (expression info expr)
  | Sexp_coerce _ -> assert false (* TODO *)
  | Sexp_send _ -> assert false (* TODO *)
  | Sexp_new _ -> assert false (* TODO *)
  | Sexp_setinstvar _ -> assert false (* TODO *)
  | Sexp_override _ -> assert false (* TODO *)
  | Sexp_letmodule _ -> assert false (* TODO *)
  | Sexp_lazy _ -> assert false (* TODO *)
  | Sexp_poly _ -> assert false (* TODO *)
  | Sexp_object _ -> assert false (* TODO *)
  | Sexp_newtype _ -> assert false (* TODO *)
  | Sexp_pack _ -> assert false (* TODO *)
  | Sexp_open _ -> assert false (* TODO *)
  | Sexp_extension _ -> assert false (* TODO *)
  | Sexp_unreachable -> assert false (* TODO *)
  | Sexp_letop _ -> assert false
(* TODO *)

and expression info Uast.({ spexp_desc; spexp_attributes; _ } as e) =
  let expr_loc = T.location e.spexp_loc in
  let is_pure P.{ attr_name; _ } = attr_name.txt = "pure" in
  let is_pure = List.exists is_pure in
  if is_pure spexp_attributes then mk_expr ~expr_loc (Epure (term info e))
  else mk_expr ~expr_loc (expression_desc info expr_loc spexp_desc)

and mk_array info expr_list =
  let c = ref 0 in
  let index_name = T.mk_id "i" in
  let q_index_name = Qident index_name in
  let const_of_pos_int n =
    assert (n >= 0);
    let s = string_of_int n in
    let n = Number.int_literal ILitDec ~neg:false s in
    let c = Econst (Constant.ConstInt n) in
    mk_expr c
  in
  let mk_test n =
    let index = mk_expr (Eident q_index_name) in
    mk_expr (Einfix (index, T.mk_id "infix =", const_of_pos_int n))
  in
  let mk_eif_expr n e1 e2 = mk_eif (mk_test n) e1 (Some e2) in
  let rec loop = function
    | [] -> assert false (* TODO *)
    | [ e ] -> e
    | e :: r ->
        let e_if =
          mk_eif_expr !c e
            (incr c;
             loop r)
        in
        mk_expr e_if
  in
  let array_init = Qdot (Qident (T.mk_id "Array"), T.mk_id "init") in
  let mk_init_expr n f = mk_eidapp array_init [ n; f ] in
  let expr_list = List.map (expression info) expr_list in
  let f_body = loop expr_list in
  let index_binder = (T.dummy_loc, Some index_name, false, None) in
  let e_fun =
    mk_expr (mk_efun_visible [ index_binder ] None empty_spec f_body)
  in
  mk_init_expr (const_of_pos_int (List.length expr_list)) e_fun

and let_match info expr svb =
  match svb.Uast.spvb_pat.P.ppat_desc with
  | Ppat_tuple _ ->
      let svb_expr = expression info svb.spvb_expr in
      let pat = pattern info svb.spvb_pat in
      assert (pat.pat_exn_name = None);
      mk_ematch_no_exn svb_expr [ (Option.get pat.pat_term, expr) ]
  | _ ->
      let id, svb_expr = s_value_binding info svb in
      mk_elet_none id (is_ghost_svb svb) svb_expr expr

and special_binder expr { binder_info_desc; binder_info_loc = loc } =
  let mk_let_pat binder_expr (id_field, id_pat) e_rhs =
    let e_app = Eidapp (Qident id_field, [ binder_expr ]) in
    let e_lhs = mk_expr ~expr_loc:id_field.id_loc e_app in
    let e_let = mk_elet_none id_pat false e_lhs e_rhs in
    mk_expr ~expr_loc:expr.expr_loc e_let
  in
  match binder_info_desc with
  | BNone -> expr
  | BTuple (id, pat_list) ->
      let e_id = Eident (Qident id) in
      let pat = T.mk_pattern ~pat_loc:loc (Ptuple pat_list) in
      let expr_loc = expr.expr_loc in
      let lhs_expr = mk_expr ~expr_loc:loc e_id in
      let expr_desc = mk_ematch_no_exn lhs_expr [ (pat, expr) ] in
      mk_expr ~expr_loc expr_desc
  | BRecord (id, id_pat_list) ->
      let binder_expr = mk_expr ~expr_loc:id.id_loc (Eident (Qident id)) in
      List.fold_right (mk_let_pat binder_expr) id_pat_list expr

and case info pat_list =
  let mk_case (acc_reg, acc_exn) Uast.{ spc_lhs; spc_guard; spc_rhs } =
    check_guard spc_guard;
    let { pat_term; pat_exn_name } = pattern info spc_lhs in
    let expr = expression info spc_rhs in
    match (pat_term, pat_exn_name) with
    | Some pat, None -> ((pat, expr) :: acc_reg, acc_exn)
    | pat, Some q -> (acc_reg, (q, pat, expr) :: acc_exn)
    | _ -> assert false
  in
  let reg_branch, exn_branch = List.fold_left mk_case ([], []) pat_list in
  (List.rev reg_branch, List.rev exn_branch)

and case_exn info Uast.{ spc_lhs; spc_guard; spc_rhs } =
  check_guard spc_guard;
  let q, pat = exception_name_of_pattern info spc_lhs in
  (q, pat, expression info spc_rhs)

and apply_raise info = function
  | Uast.Sexp_construct (id, exn_arg) ->
      mk_eraise (longident id.txt) (Option.map (expression info) exn_arg)
  | _ -> assert false
(* TODO: not supported for now *)

and construct_arith info s expr_list =
  if Hashtbl.find info.info_arith_construct s > 1 then
    List.map (expression info) expr_list
  else
    let etuple = Etuple (List.map (expression info) expr_list) in
    [ mk_expr etuple ]

and s_value_binding info svb =
  let open Uast in
  let pexp = svb.Uast.spvb_expr in
  let expr_loc = T.location svb.Uast.spvb_expr.spexp_loc in
  let spec = function None -> empty_spec | Some s -> S.vspec s in
  let mk_arg (_, _, ghost, pty) = function
    | Lnone { pid_loc; pid_str; _ }
    | Lnamed { pid_loc; pid_str; _ }
    | Loptional { pid_loc; pid_str; _ } ->
        let id_loc = T.location pid_loc in
        mk_binder id_loc (Some (T.mk_id ~id_loc pid_str)) ghost pty
    | _ -> mk_binder T.dummy_loc (Some (T.mk_id "()")) ghost pty
  in
  let pair_args binder_spec binder_code expr =
    let id_spec, id_code, ghost =
      match (binder_spec, binder_code) with
      | (_, Some id_spec, g1, _), (_, Some id_code, g2, _) ->
          (id_spec, id_code, g1 || g2)
      | _ -> assert false
    in
    let e_lhs = mk_expr ~expr_loc:id_spec.id_loc (Eident (Qident id_spec)) in
    mk_expr ~expr_loc:expr.expr_loc (mk_elet_none id_code ghost e_lhs expr)
  in
  let rec args_pos = function
    (* TODO: remove *)
    | [] -> T.location svb.spvb_loc
    | [ Lnone { pid_loc; _ } ]
    | [ Loptional { pid_loc; _ } ]
    | [ Lnamed { pid_loc; _ } ]
    | [ Lghost ({ pid_loc; _ }, _) ] ->
        T.location pid_loc
    | Lnone { pid_loc; _ } :: r
    | Loptional { pid_loc; _ } :: r
    | Lnamed { pid_loc; _ } :: r
    | Lghost ({ pid_loc; _ }, _) :: r ->
        Loc.join (T.location pid_loc) (args_pos r)
    | _ -> assert false
    (* TODO: Lunit *)
  in
  let subst_args_expr args expr = function
    | None | Some { sp_header = None; _ } -> (args, expr)
    | Some { sp_header = Some hd; _ } ->
        if List.length args <> List.length hd.sp_hd_args then
          Loc.errorm ~loc:(args_pos hd.sp_hd_args)
            "The number of arguments in spec and in the code do not match.";
        let spec_args = List.map2 mk_arg args hd.sp_hd_args in
        (spec_args, List.fold_right2 pair_args spec_args args expr)
  in
  let rec loop acc expr =
    match expr.Uast.spexp_desc with
    | Sexp_fun (_, None, pat, e, _) ->
        (* TODO? Should we ignore the spec that comes with [Sexp_fun]? *)
        let arg, binder_info = binder_of_pattern info pat in
        let binder_list, expr = loop (arg :: acc) e in
        (binder_list, special_binder expr binder_info)
    | Sexp_function case_list ->
        let param_id = T.mk_id "param" in
        let param = mk_expr (Eident (Qident param_id)) ~expr_loc:T.dummy_loc in
        let arg = (T.dummy_loc, Some (T.mk_id "param"), false, None) in
        let reg_branch, exn_branch = case info case_list in
        let ematch = mk_ematch param reg_branch exn_branch in
        let expr_loc = T.location expr.spexp_loc in
        (List.rev (arg :: acc), mk_expr ematch ~expr_loc)
    | _ -> (List.rev acc, expression info expr)
  in
  (* TODO *)
  let mk_svb_expr expr =
    match expr.Uast.spexp_desc with
    | Sexp_fun _ ->
        (* TODO? Should we ignore the spec that comes with [Sexp_fun]? *)
        (* regarding special binders: this poses a problem when the arguments
           are ephemeral data strctures. For the following example
           ```
             let f (q: 'a t) =
               let q = q in ...
               while ... do
                 invariant { (old q) ... }
                 ...
               done
           ```
           Why3 will complain the `old` tag in the invariant is never used. In
           fact, `old` only refers to the arguments of the function, hence the
           problem when introducing the `let..in` binders. One possible solution
           is to introduce a custom `'Old` label to mark the function
           effectively begins after the `let..in` list. This is as follows:
           ```
             let f (q: 'a t) =
               let q = q in
               label 'Old in ...
               while ... do
                 invariant { (q at 'Old) ... }
                 ...
               done
           ```*)
        let spec_uast = svb.Uast.spvb_vspec in
        let args, expr = loop [] expr in
        let expr_loc = expr.expr_loc in
        let old_id = T.mk_id "'Old" in
        let expr = mk_expr ~expr_loc (Elabel (old_id, expr)) in
        let args, expr = subst_args_expr args expr spec_uast in
        let ret = T.mk_pattern Pwild in
        let spec = spec svb.Uast.spvb_vspec in
        let efun = Efun (args, None, ret, Ity.MaskVisible, spec, expr) in
        mk_expr efun ~expr_loc
    | Sexp_function case_list ->
        let spec_uast = svb.Uast.spvb_vspec in
        let param_id = T.mk_id "param" in
        let arg = (T.dummy_loc, Some param_id, false, None) in
        let param = mk_expr (Eident (Qident param_id)) ~expr_loc:T.dummy_loc in
        let reg_branch, exn_branch = case info case_list in
        let match_desc = mk_ematch param reg_branch exn_branch in
        let match_expr = mk_expr match_desc ~expr_loc in
        let args, expr = subst_args_expr [ arg ] match_expr spec_uast in
        let spec = spec svb.Uast.spvb_vspec (* TODO *) in
        let efun = mk_efun_visible args None spec expr in
        mk_expr efun ~expr_loc
    | _ -> expression info expr
  in
  let id = id_of_pat svb.spvb_pat in
  (id, mk_svb_expr pexp)

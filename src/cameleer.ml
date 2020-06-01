open Why3
open Ptree
open Gospel
open Parser_frontend

let mk_field ~mut:f_mutable ~ghost:f_ghost f_loc f_ident f_pty  =
  { f_loc; f_ident; f_pty; f_mutable; f_ghost }

module Spec = struct
  module T = Uterm

  include struct
    open struct
      let get_id_of_lb_arg = function
        Uast.Lnone id | Lquestion id | Lnamed id | Lghost (id, _) -> id end

    let loc_of_lb_arg   lb = T.location (get_id_of_lb_arg lb).pid_loc
    let ident_of_lb_arg lb = T.preid (get_id_of_lb_arg lb)
  end

  (** Converts a GOSPEL postcondition of the form [Uast.term] into a Why3's
      Ptree postcondition of the form [Loc.position * (pattern * term)]. It uses
      the [sp_hd_ret] field to name the result value of the function. *)
  let sp_post sp_hd_ret sp_post =
    let term_loc = T.location sp_post.Uast.term_loc in
    let pvar_of_lb_arg_list lb_arg_list =
      let mk_pvar lb = (* create a [Pvar] pattern out of a [Tt.lb_arg] *)
        let pat_loc = loc_of_lb_arg lb in
        T.mk_pattern (Pvar (ident_of_lb_arg lb)) ~pat_loc in
      List.map mk_pvar lb_arg_list in
    let pat = match pvar_of_lb_arg_list sp_hd_ret with
      | [p] -> p
      | pl  -> T.mk_pattern (Ptuple pl) ~pat_loc:term_loc in
    term_loc, [pat, T.term sp_post]

  (** Converts a GOSPEL exception postcondition into a Why3's Ptree [xpost]. The
      two data types have the same structure, hence this is a morphism. *)
  let sp_xpost (loc, q_pat_t_option_list) =
    let loc = T.location loc in
    let pat_term (q, t) = T.pattern q, T.term t in
    let qualid_pat_term_opt (q, pt_opt) = T.qualid q, Opt.map pat_term pt_opt in
    loc, List.map qualid_pat_term_opt q_pat_t_option_list

  let vspec spec = {
    sp_pre     = List.map (fun (t, _) -> T.term t) spec.Uast.sp_pre;
    sp_post    = List.map (sp_post spec.Uast.sp_hd_ret) spec.Uast.sp_post;
    sp_xpost   = List.map sp_xpost spec.sp_xpost;
    sp_reads   = [];
    sp_writes  = List.map T.term spec.sp_writes;
    sp_alias   = [];
    sp_variant = List.map (fun t -> T.term t, None) spec.sp_variant;
    sp_checkrw = false;
    sp_diverge = spec.sp_diverge;
    sp_partial = false;
  }

end

module Expression = struct
  open Oasttypes
  open Longident
  open Why3ocaml_driver
  module T = Uterm
  module S = Spec
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
      | Uast.Sexp_apply ({spexp_desc = Sexp_ident s; _}, arg_expr_list) ->
          Eidapp (longident s.txt, List.map arg_expr arg_expr_list)
      | Uast.Sexp_match (e, case_list) ->
          Ematch (expression e, List.map case case_list, [])
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
end

module Convert = struct
  open Oasttypes
  open Oparsetree
  module T  = Uterm
  module Tt = Tterm
  module E  = Expression

  type odecl =
    | Odecl of decl
    | Omodule of Loc.position * ident * odecl list

  let td_params (cty, _) = match cty.ptyp_desc with
    | Ptyp_var s -> T.(mk_id ~id_loc:(location cty.ptyp_loc)) s
    | _ -> assert false

  let param (loc, pre_id, ty) =
    T.location loc, Some (T.preid pre_id), false, T.pty ty

  (** Visibility of type declarations. An alias type cannot be private, so we
      check whether or not the GOSPEL type manifest is [None]. *)
  let td_private private_ tkind = match private_, tkind with
    | _, Ptype_abstract    -> Ptree.Private
    | Oasttypes.Private, _ -> Ptree.Private
    | Oasttypes.Public, _  -> Ptree.Public

  let param_of_cty cty =
    let loc = T.location cty.ptyp_loc in
    (loc, None, false, E.core_type cty)

  (** Translate a list of OCaml constructors declaration list into the
      corresponding Why3's Ptree algebraic constructors list. *)
  let constructor_declaration {pcd_loc; pcd_name; pcd_args; _} =
    ignore (pcd_loc); ignore (pcd_name);
    match pcd_args with
    | Pcstr_tuple cty_list -> let id_loc = T.location pcd_name.loc in
        let id = T.mk_id ~id_loc pcd_name.txt in
        (T.location pcd_loc, id, List.map param_of_cty cty_list)
    | Pcstr_record _ -> assert false

  (** Convert a [Uast] type definition into a Why3's Ptree [type_def]. We
      follow the manifest-kind logic defined in the OCaml [Parsetree]. *)
  let td_def td_spec td_manifest td_kind =
    let field Uast.{f_preid; f_pty; f_mutable; _} =
      let id  = T.(mk_id ~id_loc:(location f_preid.pid_loc) f_preid.pid_str) in
      let pty = T.pty f_pty in
      mk_field id.id_loc id pty ~mut:f_mutable ~ghost:true in
    let field_of_label_decl lbl_decl =
      let pld_mutable = lbl_decl.pld_mutable in
      let pld_id = lbl_decl.pld_name in
      let f_loc = T.location lbl_decl.pld_loc in
      let f_id  = T.(mk_id ~id_loc:(location pld_id.loc) pld_id.txt) in
      let f_pty = E.core_type lbl_decl.pld_type in
      let f_mutable = match pld_mutable with Mutable -> true | _ -> false in
      mk_field f_loc f_id f_pty ~mut:f_mutable ~ghost:false in
    let add_reg_field lbl acc = field_of_label_decl lbl :: acc in
    match td_manifest, td_kind with
    | None, Ptype_abstract ->
        TDrecord (List.map field td_spec.Uast.ty_field)
    | Some cty, Ptype_abstract ->
        TDalias (E.core_type cty)
    | None, Ptype_variant constr_decl_list ->
        TDalgebraic (List.map constructor_declaration constr_decl_list)
    | None, Ptype_record lbl_list ->
        let ghost_fields = List.map field td_spec.Uast.ty_field in
        let all_fields = List.fold_right add_reg_field lbl_list ghost_fields in
        TDrecord all_fields
    | _ -> assert false (* TODO *)

  let type_decl Uast.({tname; tspec; tmanifest; tkind; _} as td) = {
      td_loc    = T.location td.tloc;
      td_ident  = T.(mk_id tname.txt ~id_loc:(location tname.loc));
      td_params = List.map td_params td.tparams;
      td_vis    = td_private td.tprivate tkind;
      td_mut    = tspec.ty_ephemeral;
      td_inv    = List.map Uterm.term tspec.ty_invariant;
      td_wit    = [];
      td_def    = td_def tspec tmanifest tkind
    }

  let logic_attr = "logic"

  let is_logic attributes =
    List.exists (fun {attr_name; _} -> attr_name.txt = logic_attr) attributes

  let val_decl vd g =
    let rec flat_ptyp_arrow ct = match ct.ptyp_desc with
      | Ptyp_var _ | Ptyp_tuple _ | Ptyp_constr _ -> [ct]
      | Ptyp_arrow (_, t1, t2) ->
          begin match t1.ptyp_desc with
          | Ptyp_arrow _ -> t1 :: flat_ptyp_arrow t2
          | _ -> flat_ptyp_arrow t1 @ flat_ptyp_arrow t2 end
      | _ -> assert false (* TODO *) in
    let mk_single_param lb_arg ct =
      let add_at_id at id = { id with id_ats = ATstr at :: id.id_ats } in
      let id = Spec.ident_of_lb_arg lb_arg in
      let id_loc = id.id_loc in
      let pty = E.core_type ct in
      let id, ghost, pty = match lb_arg with
        | Lnone _        -> id, false, pty
        | Lghost (_, ty) -> id, true,  T.pty ty
        | Lnamed _       -> add_at_id Ocaml.Print.named_arg id, false, pty
        | Lquestion _    -> let id = add_at_id Ocaml.Print.optional_arg id in
            id, false, PTtyapp (Qident (T.mk_id "option" ~id_loc), [pty]) in
      id_loc, Some id, ghost, pty in
    let mk_ghost_param = function
      | Uast.Lnone _ | Lnamed _ | Lquestion _ -> assert false
      | Uast.Lghost (id, ty) ->
          let id = T.preid id in
          let id_loc = id.id_loc in
          let pty = Uterm.pty ty in
          id_loc, Some id, true, pty in
    let rec mk_param lb_args core_tys = match lb_args, core_tys with
      | [], [] -> []
      | [], _  -> assert false (* there can be no more core_tys than lb_args *)
      | lb_args, [] ->         (* all the remaining arguments must be ghost  *)
          List.map mk_ghost_param lb_args
      | (Uast.Lghost _) as lb :: lb_args, core_tys ->
          mk_ghost_param lb :: mk_param lb_args core_tys
      | lb :: lb_args, ct :: core_tys ->
          (mk_single_param lb ct) :: mk_param lb_args core_tys in
    let mk_param_no_spec ct = let loc = T.location ct.ptyp_loc in
      loc, None, false, E.core_type ct in
    let mk_vals params ret pat mask =
      let vd_id_str = vd.Uast.vname.txt in
      let vd_id_loc = vd.Uast.vname.loc in
      let mk_id id_str = T.(mk_id id_str ~id_loc:(location vd_id_loc)) in
      let mk_val id params ret pat mask spec =
        let e_any = Eany (params, Expr.RKnone, ret, pat, mask, spec) in
        let e_any = E.mk_expr e_any ~expr_loc:(T.location vd.Uast.vloc) in
        Dlet (id, g, Expr.RKnone, e_any) in
      match vd.Uast.vspec with
      | None   -> mk_val (mk_id vd_id_str) params ret pat mask E.empty_spec
      | Some s -> mk_val (mk_id vd_id_str) params ret pat mask (Spec.vspec s) in
    let params, ret, pat, mask =
      let core_tys = flat_ptyp_arrow vd.Uast.vtype in
      let core_tys, last = Lists.chop_last core_tys in
      let params, pat, mask = match vd.Uast.vspec with
        | None -> let param_list = List.map mk_param_no_spec core_tys in
            (* when there is no specification, there is no pattern
               in the return tuple *)
            let pat = T.(mk_pattern Pwild ~pat_loc:(location last.ptyp_loc)) in
            param_list, pat, Ity.MaskVisible
        | Some s -> let params = mk_param s.Uast.sp_hd_args core_tys in
            let mk_pat lb = let pat_loc = Spec.loc_of_lb_arg lb in
              Uterm.mk_pattern (Pvar (Spec.ident_of_lb_arg lb)) ~pat_loc in
            let mk_mask = function
              | Uast.Lnone  _ | Lquestion _ | Lnamed _ -> Ity.MaskVisible
              | Uast.Lghost _ -> Ity.MaskGhost in
            let lb_list = s.Uast.sp_hd_ret in
            let pat_list  = List.map mk_pat lb_list in
            let mask_list = List.map mk_mask lb_list in
            let pat, mask = match pat_list, mask_list with
              | [], []   -> (* in this case, the return is of type unit *)
                  Uterm.mk_pattern Pwild ~pat_loc:T.dummy_loc, Ity.MaskVisible
              | [p], [m] -> p, m
              | pl, ml   -> assert (List.length pl = List.length ml);
                  let pat_loc = T.location vd.Uast.vloc in
                  Uterm.mk_pattern (Ptuple pl) ~pat_loc, Ity.MaskTuple ml in
            params, pat, mask in
      params, Some (E.core_type last), pat, mask in
    mk_vals params ret pat mask

  let rec s_signature s_sig =
    List.map s_signature_item s_sig

  and s_signature_item Uast.{sdesc; _} =
    s_signature_item_desc sdesc

  and s_signature_item_desc sig_item_desc =
    match sig_item_desc with
    | Sig_val s_val ->
        Odecl (val_decl s_val false)
    | Sig_type (rec_flag, type_decl_list) ->
        ignore (rec_flag); (* TODO *)
        let td_list = List.map type_decl type_decl_list in
        Odecl (Dtype td_list)
    | _ -> assert false (* TODO *)

  let rec s_structure s_str =
    List.map s_structure_item s_str

  and s_structure_item Uast.{sstr_desc; _} =
    s_structure_item_desc sstr_desc

  and s_structure_item_desc str_item_desc =
    let id_expr_of_svb_list = function
      | [svb] -> E.s_value_binding svb
      | _ -> assert false (* TODO *) in
    let is_logic_svb Uast.{spvb_attributes; _} = is_logic spvb_attributes in
    match str_item_desc with
    | Uast.Str_value (Nonrecursive, svb_list) ->
        let id, expr = id_expr_of_svb_list svb_list in
        let rs_kind = if List.exists is_logic_svb svb_list then Expr.RKfunc
          else Expr.RKnone in
        Odecl (Dlet (id, false, rs_kind, expr))
    | Uast.Str_value (Recursive, svb_list) ->
        let id, fun_expr = id_expr_of_svb_list svb_list in
        let args, ret, spec, expr = match fun_expr.expr_desc with
          | Efun (args, _, ret, _, spec, expr) -> args, ret, spec, expr
          | _ -> assert false (* TODO *) in
        let mask_visible = Ity.MaskVisible in
        let rs_kind = if List.exists is_logic_svb svb_list then Expr.RKfunc
          else Expr.RKnone in
        let fun_def =
          id, false, rs_kind, args, None, ret, mask_visible, spec, expr in
        Odecl (Drec [fun_def])
    | Uast.Str_type (rec_flag, type_decl_list) ->
        ignore (rec_flag); (* TODO *)
        let td_list = List.map type_decl type_decl_list in
        Odecl (Dtype td_list)
    | Uast.Str_function f ->
        let ld_loc = T.location f.fun_loc in
        let ld_ident = T.preid f.fun_name in
        let ld_params = List.map param f.fun_params in
        let ld_type = Opt.map T.pty f.fun_type in
        let ld_def = Opt.map T.term f.fun_def in
        let logic_decl = { ld_loc; ld_ident; ld_params; ld_type; ld_def } in
        Odecl (Dlogic [logic_decl])
    | Uast.Str_axiom a ->
        Odecl (Dprop (Decl.Paxiom, T.preid a.ax_name, T.term a.ax_term))
    | Uast.Str_module {spmb_name = {txt; loc}; spmb_expr; spmb_loc; _} ->
        let scope_loc = T.location spmb_loc in
        let scope_id  = T.(mk_id ~id_loc:(location loc) txt) in
        Omodule (scope_loc, scope_id, s_module_expr spmb_expr)
    | _ -> assert false

  and s_module_expr {spmod_desc; spmod_loc; _} =
    let decl_loc = T.location spmod_loc in
    match spmod_desc with
    | Uast.Smod_ident _ ->
        Loc.errorm "Module aliasing is not supported."
    | Uast.Smod_structure str ->
        s_structure str
    | Uast.Smod_functor (arg_name, arg, body) ->
        let id_loc = T.location arg_name.loc in
        let id = T.mk_id ~id_loc arg_name.txt in
        let body = s_module_expr body in
        Omodule (decl_loc, id, s_module_type (Opt.get arg)) :: body
    | _ -> assert false (* TODO *)

  and s_module_type {mdesc; mloc; _} =
    let _decl_loc = T.location mloc in
    match mdesc with
    | Mod_ident _ -> assert false (* TODO *)
    | Mod_signature s_sig ->
        s_signature s_sig
    | Mod_functor _
      (* of string loc * s_module_type option * s_module_type *) ->
        assert false (* TODO *)
    | Mod_with _ (* of s_module_type * s_with_constraint list *) ->
        assert false (* TODO *)
    | Mod_typeof _ (* of module_expr *) ->
        assert false (* TODO *)
    | Mod_extension _ (* of extension *) ->
        assert false
    | Mod_alias _ (* of Longident.t loc *) ->
        assert false (* TODO *)

end

let debug = ref true

open Why3.Typing
open Wstdlib
open Ident
open Convert
open Uterm
module Pm = Pmodule

let print_modules = Debug.lookup_flag "print_modules"

let use_std_lib =
  let int = Qdot (Qident (mk_id "int"), mk_id "Int") in
  let int63 = Qdot (Qdot (Qident (mk_id "mach"), mk_id "int"), mk_id "Int63") in
  let length = Qdot (Qident (mk_id "list"), mk_id "List") in
  let list = Qdot (Qident (mk_id "list"), mk_id "Length") in
  let append = Qdot (Qident (mk_id "list"), mk_id "Append") in
  let use_int = Duseimport (Loc.dummy_position, false, [int, None]) in
  let use_int63 = Duseimport (Loc.dummy_position, false, [int63, None]) in
  let use_list = Duseimport (Loc.dummy_position, false, [list, None]) in
  let use_length = Duseimport (Loc.dummy_position, false, [length, None]) in
  let use_append = Duseimport (Loc.dummy_position, false, [append, None]) in
  [Odecl use_int; Odecl use_int63; Odecl use_list; Odecl use_length;
   Odecl use_append]

let read_file file c =
  let lb = Lexing.from_channel c in
  Location.init lb file;
  let ocaml_structure = parse_ocaml_structure_lb lb in
  parse_structure_gospel ocaml_structure

let read_channel env path file c =
  if !debug then Format.eprintf "reading file '%s'@." file;
  let mod_name =
    let f = Filename.basename file in
    String.capitalize_ascii (Filename.chop_extension f) in
  let f = read_file file c in
  open_file env path; (* This is the beginning of the Why3 file construction *)
  let id = T.mk_id mod_name in
  open_module id; (* This is the beginning of the top module construction *)
  let f = s_structure f in
  let f = use_std_lib @ f in
  let rec pp_list pp fmt l = match l with
    | [] -> ()
    | x :: r -> Format.eprintf "%a" pp x; pp_list pp fmt r in
  let rec pp_decl fmt d = match d with
    | Odecl d -> Format.fprintf fmt "%a@." Mlw_printer.pp_decl d
    | Omodule (_loc, id, dl) ->
        Format.eprintf "@[<hv 2>scope %s@\n%a@]@\nend@." id.id_str
          (pp_list pp_decl) dl in
  let rec add_decl od = match od with
    | Odecl d ->
        Why3.Typing.add_decl Loc.dummy_position d;
    | Omodule (loc, id, dl) ->
        Why3.Typing.open_scope id.id_loc id;
        List.iter add_decl dl;
        Why3.Typing.close_scope ~import:true loc in
  pp_list pp_decl (Format.err_formatter) f;
  List.iter add_decl f;
  close_module Loc.dummy_position; (* Closes the top module *)
  let mm = close_file () in
  if Debug.test_flag print_modules then begin
    let print_m _ m = Format.eprintf "%a@\n@." Pm.print_module m in
    let add_m _ m mm = Mid.add m.Pm.mod_theory.Theory.th_name m mm in
    Mid.iter print_m (Mstr.fold add_m mm Mid.empty)
  end;
  mm

let () =
  Env.register_format Pm.mlw_language "ocaml" ["ml"] read_channel
    ~desc:"OCaml format"

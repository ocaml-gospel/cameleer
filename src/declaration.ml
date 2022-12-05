open Ppxlib
open Gospel
open Asttypes
open Parsetree
open Why3
open Ptree
open Vspec
module T = Uterm
module Tt = Tterm
module E = Expression
module O = Odecl

let mk_const svb_list expr =
  let p = T.mk_pattern Pwild in
  let mk_spec acc Uast.{ spvb_vspec; _ } =
    let s = match spvb_vspec with None -> empty_spec | Some s -> vspec s in
    spec_union acc s
  in
  let spec = List.fold_left mk_spec empty_spec svb_list in
  let d = Efun ([], None, p, Ity.MaskVisible, spec, expr) in
  let d = Eattr (ATstr Vc.wb_attr, E.mk_expr d) in
  E.mk_expr d

let mk_field ~mut:f_mutable ~ghost:f_ghost f_loc f_ident f_pty =
  { f_loc; f_ident; f_pty; f_mutable; f_ghost }

let td_params (cty, _) =
  match cty.ptyp_desc with
  | Ptyp_var s -> T.(mk_id ~id_loc:(location cty.ptyp_loc)) s
  | _ -> assert false

let param (loc, pre_id, ty) =
  (T.location loc, Some (T.preid pre_id), false, T.pty ty)

(** Visibility of type declarations. An alias type cannot be private, so we
    check whether or not the GOSPEL type manifest is [None]. *)
let td_private manifest private_ tkind =
  match (manifest, private_, tkind) with
  | Some _, _, _ -> Ptree.Public
  | _, _, Ptype_abstract -> Ptree.Abstract (* ???? Ptree.Private *)
  | _, Asttypes.Private, _ -> Ptree.Private
  | _, Asttypes.Public, _ -> Ptree.Public

let param_of_cty cty =
  let loc = T.location cty.ptyp_loc in
  (loc, None, false, E.core_type cty)

let field_of_label_decl lbl_decl =
  let is_ghost attributes =
    List.exists (fun { attr_name; _ } -> attr_name.txt = "ghost") attributes
  in
  let pld_mutable = lbl_decl.pld_mutable in
  let pld_id = lbl_decl.pld_name in
  let f_loc = T.location lbl_decl.pld_loc in
  let f_id = T.(mk_id ~id_loc:(location pld_id.loc) pld_id.txt) in
  let f_pty = E.core_type lbl_decl.pld_type in
  let mut = match pld_mutable with Mutable -> true | _ -> false in
  let ghost = is_ghost lbl_decl.pld_attributes in
  mk_field f_loc f_id f_pty ~mut ~ghost

(** Translate a list of OCaml constructors declaration into the corresponding
    Why3's Ptree algebraic constructors list. *)
let constructor_declaration info params er { pcd_loc; pcd_name; pcd_args; _ } =
  let add_field acc lbl = field_of_label_decl lbl :: acc in
  let id_loc = T.location pcd_name.loc in
  let id = T.mk_id ~id_loc pcd_name.txt in
  let loc = T.location pcd_loc in
  match pcd_args with
  | Pcstr_tuple cty_list ->
      let construct_arith = List.length cty_list in
      Hashtbl.add info.O.info_arith_construct pcd_name.txt construct_arith;
      (loc, id, List.map param_of_cty cty_list)
  | Pcstr_record lbl_list ->
      let id_pty = String.uncapitalize_ascii pcd_name.txt ^ "_rec" in
      let id_pty = T.mk_id ~id_loc id_pty in
      let fields = List.fold_left add_field [] lbl_list in
      let fields = List.rev fields in
      Hashtbl.add er id_pty fields;
      let td_params = List.map (fun p -> PTtyvar p) params in
      let pty = PTtyapp (Qident id_pty, td_params) in
      let param = (loc, None, false, pty) in
      (loc, id, [ param ])

type embedded_record = { er_typ : type_def; er_rec : (ident * field list) list }

let mk_embedded_record ?(er_rec = []) er_typ = { er_typ; er_rec }

(** Convert a [Uast] type definition into a Why3's Ptree [type_def]. We follow
    the manifest-kind logic defined in the OCaml [Parsetree]. *)
let td_def info params spec_fields td_manifest td_kind =
  let field Uast.{ f_preid; f_pty; f_mutable; _ } =
    let id_loc = T.location f_preid.pid_loc in
    let id = T.(mk_id ~id_loc f_preid.pid_str) in
    let pty = T.pty f_pty in
    mk_field id.id_loc id pty ~mut:f_mutable ~ghost:true
  in
  let add_reg_field lbl acc = field_of_label_decl lbl :: acc in
  match (td_manifest, td_kind) with
  | None, Ptype_abstract ->
      mk_embedded_record (TDrecord (List.map field spec_fields))
  | Some cty, Ptype_abstract -> mk_embedded_record (TDalias (E.core_type cty))
  | None, Ptype_variant cstr_list ->
      let er = Hashtbl.create 16 in
      let alg = List.map (constructor_declaration info params er) cstr_list in
      let er_rec = Hashtbl.fold (fun id lbl acc -> (id, lbl) :: acc) er [] in
      mk_embedded_record (TDalgebraic alg) ~er_rec
  | None, Ptype_record lbl_list ->
      let model_fields = List.map field spec_fields in
      let all_fields = List.fold_right add_reg_field lbl_list model_fields in
      mk_embedded_record (TDrecord all_fields)
  | _ -> assert false
(* TODO *)

let type_decl info Uast.({ tname; tspec; tmanifest; tkind; _ } as td) =
  let td_mut, invariant, spec_fields =
    match tspec with
    | None -> (false, [], [])
    | Some s -> (s.ty_ephemeral, s.ty_invariant, s.ty_field)
  in
  let td_loc = T.location td.tloc in
  let td_params = List.map td_params td.tparams in
  let td_vis = td_private tmanifest td.tprivate tkind in
  let td_inv = List.map (Uterm.term false) invariant in
  let mk_attr { attr_name; _ } = ATstr (Ident.create_attribute attr_name.txt) in
  let id_ats = List.map mk_attr td.tattributes in
  let rec_decl (td_ident, field_list) =
    {
      td_loc;
      td_ident;
      td_params;
      td_vis;
      td_mut;
      td_inv;
      td_wit = None;
      td_def = TDrecord field_list;
    }
  in
  let { er_typ; er_rec } = td_def info td_params spec_fields tmanifest tkind in
  let main_def =
    {
      td_loc;
      td_params;
      td_vis;
      td_mut;
      td_inv;
      td_wit = None;
      td_def = er_typ;
      td_ident = T.(mk_id tname.txt ~id_ats ~id_loc:(location tname.loc));
    }
  in
  let rec_def = List.fold_left (fun acc fl -> rec_decl fl :: acc) [] er_rec in
  main_def :: rec_def

let mk_type_decl info loc type_decl_list =
  let td_list = List.map (type_decl info) type_decl_list in
  O.mk_dtype loc (List.flatten td_list)

let logic_attr = "logic"
let lemma_attr = "lemma"
let ghost_attr = "ghost"

let is_logic attributes =
  List.exists (fun { attr_name; _ } -> attr_name.txt = logic_attr) attributes

let is_lemma attributes =
  List.exists (fun { attr_name; _ } -> attr_name.txt = lemma_attr) attributes

let is_ghost attributes =
  List.exists (fun { attr_name; _ } -> attr_name.txt = ghost_attr) attributes

let val_decl loc vd ghost =
  let rec flat_ptyp_arrow ct =
    match ct.ptyp_desc with
    | Ptyp_var _ | Ptyp_tuple _ | Ptyp_constr _ -> [ ct ]
    | Ptyp_arrow (_, t1, t2) -> (
        match t1.ptyp_desc with
        | Ptyp_arrow _ -> t1 :: flat_ptyp_arrow t2
        | _ -> flat_ptyp_arrow t1 @ flat_ptyp_arrow t2)
    | _ -> assert false
    (* TODO *)
  in
  let mk_single_param lb_arg ct =
    let add_at_id at id = { id with id_ats = ATstr at :: id.id_ats } in
    let id = Vspec.ident_of_lb_arg lb_arg in
    let id_loc = id.id_loc in
    let pty = E.core_type ct in
    (* since why3 1.5.0, I no longer have access to extraction attrubutes, as
     * the [ocaml] module is now oppaque *)
    let named_arg = Ident.create_attribute "ocaml:named" in
    let optional_arg = Ident.create_attribute "ocaml:optional" in
    let id, ghost, pty =
      match lb_arg with
      | Lunit -> (id, false, pty)
      | Lnone _ -> (id, false, pty)
      | Lghost (_, ty) -> (id, true, T.pty ty)
      | Lnamed _ -> (add_at_id named_arg id, false, pty)
      | Loptional _ ->
          let id = add_at_id optional_arg id in
          (id, false, PTtyapp (Qident (T.mk_id "option" ~id_loc), [ pty ]))
    in
    (id_loc, Some id, ghost, pty)
  in
  let mk_ghost_param = function
    | Uast.Lnone _ | Lnamed _ | Loptional _ | Lunit -> assert false
    | Uast.Lghost (id, ty) ->
        let id = T.preid id in
        let id_loc = id.id_loc in
        let pty = Uterm.pty ty in
        (id_loc, Some id, true, pty)
  in
  let rec mk_param lb_args core_tys =
    match (lb_args, core_tys) with
    | [], [] -> []
    | [], _ -> assert false (* there can be no more core_tys than lb_args *)
    | lb_args, [] ->
        (* all the remaining arguments must be ghost  *)
        List.map mk_ghost_param lb_args
    | (Uast.Lghost _ as lb) :: lb_args, core_tys ->
        mk_ghost_param lb :: mk_param lb_args core_tys
    | lb :: lb_args, ct :: core_tys ->
        mk_single_param lb ct :: mk_param lb_args core_tys
  in
  let mk_param_no_spec i ct =
    let loc = T.location ct.ptyp_loc in
    let id = T.mk_id ("x" ^ string_of_int i) ~id_loc:loc in
    (loc, Some id, false, E.core_type ct)
  in
  let mk_vals params ret pat mask =
    let vd_id_str = vd.Uast.vname.txt in
    let vd_id_loc = vd.Uast.vname.loc in
    let mk_id id_str = T.(mk_id id_str ~id_loc:(location vd_id_loc)) in
    let mk_val id params ret pat mask spec =
      let e_any = Eany (params, Expr.RKnone, ret, pat, mask, spec) in
      let e_any = E.mk_expr e_any ~expr_loc:(T.location vd.Uast.vloc) in
      let kind = if is_logic vd.vattributes then Expr.RKfunc else Expr.RKnone in
      O.mk_dlet loc id ghost kind e_any
    in
    match vd.Uast.vspec with
    | None -> mk_val (mk_id vd_id_str) params ret pat mask empty_spec
    | Some s -> mk_val (mk_id vd_id_str) params ret pat mask (vspec s)
  in
  let params, ret, pat, mask =
    let core_tys = flat_ptyp_arrow vd.Uast.vtype in
    let core_tys, last = Lists.chop_last core_tys in
    let params, pat, mask =
      match vd.Uast.vspec with
      | None | Some { sp_header = None; _ } ->
          let param_list = List.mapi mk_param_no_spec core_tys in
          (* when there is no specification, there is no pattern
             in the return tuple *)
          let pat = T.(mk_pattern Pwild ~pat_loc:(location last.ptyp_loc)) in
          (param_list, pat, Ity.MaskVisible)
      | Some { sp_header = Some hd; _ } ->
          let params = mk_param hd.sp_hd_args core_tys in
          let mk_pat lb =
            let pat_loc = loc_of_lb_arg lb in
            Uterm.mk_pattern (Pvar (ident_of_lb_arg lb)) ~pat_loc
          in
          let mk_mask = function
            | Uast.Lnone _ | Loptional _ | Lnamed _ | Lunit -> Ity.MaskVisible
            | Uast.Lghost _ -> Ity.MaskGhost
          in
          let lb_list = hd.sp_hd_ret in
          let pat_list = List.map mk_pat lb_list in
          let mask_list = List.map mk_mask lb_list in
          let pat, mask =
            match (pat_list, mask_list) with
            | [], [] ->
                (* in this case, the return is of type unit *)
                (Uterm.mk_pattern Pwild ~pat_loc:T.dummy_loc, Ity.MaskVisible)
            | [ p ], [ m ] -> (p, m)
            | pl, ml ->
                assert (List.length pl = List.length ml);
                let pat_loc = T.location vd.Uast.vloc in
                (Uterm.mk_pattern (Ptuple pl) ~pat_loc, Ity.MaskTuple ml)
          in
          (params, pat, mask)
    in
    (params, Some (E.core_type last), pat, mask)
  in
  mk_vals params ret pat mask

let function_ f =
  let ld_loc = T.location f.Uast.fun_loc in
  let ld_ident = T.preid f.fun_name in
  let ld_params = List.map param f.fun_params in
  let ld_type = Opt.map T.pty f.fun_type in
  let ld_def = Opt.map (T.term false) f.fun_def in
  let fun_spec = f.fun_spec in
  let coercion =
    match fun_spec with
    | None -> None
    | Some f -> if f.fun_coer then Some (Qident ld_ident) else None
  in
  ({ ld_loc; ld_ident; ld_params; ld_type; ld_def }, coercion)

let prop p =
  let kind =
    match p.Uast.prop_kind with Uast.Plemma -> Decl.Plemma | _ -> Decl.Paxiom
  in
  (T.preid p.Uast.prop_name, T.term false p.prop_term, kind)

let mk_axiom loc a =
  let prop_id = T.preid a.Uast.ax_name in
  let prop_term = T.term false a.ax_term in
  O.mk_dprop loc Decl.Paxiom prop_id prop_term

let mk_ind loc ind =
  let mk_case Uast.{ in_case_loc; in_case_name; in_case_def } =
    T.(location in_case_loc, preid in_case_name, term false in_case_def)
  in
  let in_ident = T.preid ind.Uast.in_name in
  let in_params = List.map param ind.in_params in
  let in_def = List.map mk_case ind.in_def in
  O.mk_ind loc in_ident in_params in_def

let mk_prop loc p =
  let prop_name, prop_term, prop_kind = prop p in
  O.mk_dprop loc prop_kind prop_name prop_term

let mk_exn loc ptyexn_constructor =
  let id, pty, mask = E.exception_constructor ptyexn_constructor in
  O.mk_dexn loc id pty mask

let mk_import_name_list popen_lid =
  let id_loc = T.location popen_lid.loc in
  let open_txt = popen_lid.txt in
  let mname_txt =
    match open_txt with
    | Longident.Lident s | Ldot (_, s) -> s
    | _ -> assert false
  in
  let mname = T.mk_id mname_txt ~id_loc in
  let id_str = String.uncapitalize_ascii mname_txt in
  let id_fname = T.mk_id id_str ~id_loc in
  let fname = Qident id_fname in
  (fname, mname)

open Mod_subst

(* TO BE USED *)
(* let string_list_of_qualid q =
 *   let rec sloq acc = function
 *     | Qdot (p, id) -> sloq (id.id_str :: acc) p
 *     | Qident id -> id.id_str :: acc in
 *   sloq [] q *)

let subst info ctr_list =
  let mk_subst subst = function
    | Uast.Wtype (id, s_type_decl) ->
        let td = type_decl info s_type_decl in
        let id_txt = E.string_of_longident id.txt in
        List.fold_left (add_ts_subst id_txt) subst td
    | Wtypesubst (id, s_type_decl) ->
        let td = type_decl info s_type_decl in
        let id_txt = E.string_of_longident id.txt in
        List.fold_left (add_td_subst id_txt) subst td
    | Wpredicate (id, qr) ->
        let ql = T.preid id and qr = T.qualid qr in
        add_ps_subst ql.id_str subst qr
    | Wfunction (id, qr) ->
        (* FIXME: don't really need that conversion to preid *)
        let ql = T.preid id and qr = T.qualid qr in
        add_fs_subst ql.id_str subst qr
    (* | Wfunctionsubst (ql, qr) ->
     *     let ql = T.qualid ql and qr = T.qualid qr in
     *     add_fd_subst ql qr subst
     * | Wpredicate (ql, qr) ->
     *     let ql = T.qualid ql and qr = T.qualid qr in
     *     add_ps_subst ql qr subst
     * | Wpredicatesubst (ql, qr) ->
     *     let ql = T.qualid ql and qr = T.qualid qr in
     *     add_pd_subst ql qr subst
     * | Wgoal q ->
     *     add_pr_subst (T.qualid q) Decl.Pgoal subst
     * | Waxiom q ->
     *     add_pr_subst (T.qualid q) Decl.Paxiom subst in *)
    | _ -> assert false
    (* TODO *)
  in
  List.fold_left mk_subst empty_subst ctr_list

(* TODO: *)
(* let clone_subst subst =
 *   let mk_csfsym (q1, q2) = CSfsym (q1, q2) in
 *   let csfsym = List.map mk_csfsym (Mqual.bindings subst.subst_fs) in
 *   (\* | Odecl (loc, d) -> begin match subst_decl subst d with
 *    *     | []   -> []
 *    *     | [od] -> [Odecl (loc, od)]
 *    *     | _    -> assert false end
 *    * | Omodule (loc, id, od_list) ->
 *    *     let mk_subst acc od = apply_subst subst od :: acc in
 *    *     let od_subst = List.fold_left mk_subst [] od_list in
 *    *     [Omodule (loc, id, List.rev (List.flatten od_subst))] *\)
 *   csfsym *)

let s_structure, s_signature =
  let mod_type_table : (string, O.odecl list) Hashtbl.t = Hashtbl.create 16 in

  let mod_expr_table : (string, O.odecl list) Hashtbl.t = Hashtbl.create 16 in

  let rec s_signature info s_sig =
    List.flatten (List.map (s_signature_item info) s_sig)
  and s_signature_item info Uast.{ sdesc; sloc } =
    s_signature_item_desc info (T.location sloc) sdesc
  and s_signature_item_desc info loc sig_item_desc =
    match sig_item_desc with
    | Sig_val s_val ->
        let ghost = E.is_ghost s_val.vattributes in
        [ val_decl loc s_val ghost ]
    | Sig_type (rec_flag, type_decl_list) ->
        ignore rec_flag;
        (* TODO *)
        [ mk_type_decl info loc type_decl_list ]
    | Sig_function f ->
        let f, coerc = function_ f in
        O.mk_dlogic loc coerc [ f ]
    | Sig_axiom p -> [ mk_axiom loc p ]
    | Sig_inductive ind_decl -> [ mk_ind loc ind_decl ]
    | Sig_typext _ -> assert false (* TODO *)
    | Sig_module { mdname = { txt; loc }; mdtype; mdloc; _ } ->
        let id_loc = T.location loc in
        let loc = T.location mdloc in
        let id = T.mk_id (Option.get txt) ~id_loc in
        (* let info = update_path info md_name.I.id_str in *)
        let odecl_list, _ = s_module_type info mdtype in
        [ O.mk_omodule loc id odecl_list ]
    | Sig_recmodule _ -> assert false (* TODO *)
    | Sig_modtype _ -> assert false (* TODO *)
    | Sig_exception { ptyexn_constructor; _ } ->
        [ mk_exn loc ptyexn_constructor ]
    | Sig_open _ -> assert false (* TODO *)
    | Sig_include { pincl_mod; _ } -> (
        match pincl_mod.pmty_desc with
        | Pmty_ident id ->
            let s = E.string_of_longident id.txt in
            Hashtbl.find mod_type_table s
        | Pmty_signature _ -> assert false (* TODO *)
        | Pmty_functor _ -> assert false (* TODO *)
        (* TODO *)
        (* | Pmty_with
         *     ({pmty_desc = Pmty_ident s; pmty_loc; _}, constraint_list) ->
         *      let subst = subst info constraint_list in
         *     (\* let od_list = s_module_type info mod_type in *\)
         *     (\* let mk_subst acc od = clone_subst subst od :: acc in *\)
         *      let cl_subst = clone_subst subst in
         *     (\* let od_list = List.fold_left mk_subst [] od_list in
         *      * List.rev (List.flatten od_list) *\)
         *     let id = E.longident ~id_loc:(T.location s.loc) s.txt in
         *     [O.mk_odecl (T.location pmty_loc) (Dcloneexport (id, cl_subst))] *)
        | Pmty_with _ -> assert false (* TODO *)
        | Pmty_typeof _ -> assert false (* TODO *)
        | Pmty_extension _ -> assert false (* TODO *)
        | Pmty_alias _ -> assert false (* TODO *))
    | Sig_class _ -> assert false (* TODO *)
    | Sig_class_type _ -> assert false (* TODO *)
    | Sig_attribute _ -> []
    | Sig_extension _ -> assert false (* TODO *)
    | Sig_ghost_type (rec_flag, type_decl_list) ->
        ignore rec_flag;
        (* TODO *)
        [ mk_type_decl info loc type_decl_list ]
    | Sig_ghost_val s_val -> [ val_decl loc s_val true ]
    | Sig_ghost_open _ -> assert false (* TODO *)
    | Sig_typesubst _ -> assert false (* TODO *)
    | Sig_modtypesubst _ -> assert false (* TODO *)
    | Sig_modsubst _ -> assert false (* TODO *)
  and s_structure_item info Uast.{ sstr_desc; sstr_loc } =
    s_structure_item_desc info (T.location sstr_loc) sstr_desc
  and s_structure_item_desc info loc str_item_desc =
    let is_const_svb Uast.{ spvb_expr; _ } =
      match spvb_expr.spexp_desc with
      | Sexp_function _ | Sexp_fun _ -> false
      (*FIXME: this is not all there is to test. One might have a complex
        expression that returns a function; in that case, I will mark it as
        a constant. *)
      | _ -> true
    in
    let is_logic_svb Uast.{ spvb_attributes; _ } = is_logic spvb_attributes in
    let is_lemma_svb Uast.{ spvb_attributes; _ } = is_lemma spvb_attributes in
    let is_ghost_svb Uast.{ spvb_attributes; _ } = is_ghost spvb_attributes in
    let rs_kind svb_list =
      if List.exists is_logic_svb svb_list then Expr.RKfunc
      else if List.exists is_lemma_svb svb_list then Expr.RKlemma
      else Expr.RKnone
    in
    let is_ghost_let svb_list = List.exists is_ghost_svb svb_list in
    let id_expr_rs_kind_of_svb svb_list =
      (rs_kind svb_list, List.map (E.s_value_binding info) svb_list)
    in
    match str_item_desc with
    | Uast.Str_value (Nonrecursive, svb_list) -> (
        match id_expr_rs_kind_of_svb svb_list with
        | rs_kind, [ (id, expr) ] ->
            let ghost = is_ghost_let svb_list in
            let rs_kind, expr =
              if List.exists is_const_svb svb_list then
                (Expr.RKfunc, mk_const svb_list expr)
              else (rs_kind, expr)
            in
            [ O.mk_odecl loc (Dlet (id, ghost, rs_kind, expr)) ]
        | _ -> assert false (* no multiple bindings here *))
    (* FIXME? I am not sure I agree with this last comment. I am almost
       positive that multiple bindings in non-recursive values means a
       list of `and` bindings. These could be easily translated into a
       list of `let..in` bindings *)
    | Uast.Str_value (Recursive, svb_list) ->
        let rs_kind, id_fun_expr_list = id_expr_rs_kind_of_svb svb_list in
        let ghost = is_ghost_let svb_list in
        [
          O.mk_drec loc (List.map (E.mk_fun_def ghost rs_kind) id_fun_expr_list);
        ]
    | Uast.Str_type (rec_flag, type_decl_list)
    | Uast.Str_ghost_type (rec_flag, type_decl_list) ->
        ignore rec_flag;
        (* TODO *)
        [ mk_type_decl info loc type_decl_list ]
    | Uast.Str_function f ->
        let f, coerc = function_ f in
        O.mk_dlogic loc coerc [ f ]
    | Uast.Str_prop p -> [ mk_prop loc p ]
    | Uast.Str_module mod_binding
    (* {spmb_loc; spmb_name = {txt; loc};
       spmb_expr; _} *) ->
        s_module_binding info mod_binding
    | Uast.Str_modtype { mtdname = { txt; loc }; mtdtype; mtdloc; _ } ->
        (* FIXME: do not use that [Opt.get] *)
        let scope_decls, _ = s_module_type info (Opt.get mtdtype) in
        Hashtbl.add mod_type_table txt scope_decls;
        let scope_loc = T.location mtdloc in
        let id_loc = T.location loc in
        let scope_id = T.mk_id ~id_loc txt in
        [ O.mk_omodule scope_loc scope_id scope_decls ]
    | Uast.Str_exception { ptyexn_constructor; _ } ->
        let id, pty, mask = E.exception_constructor ptyexn_constructor in
        [ O.mk_dexn loc id pty mask ]
    | Uast.Str_open
        { popen_expr = { pmod_desc = Pmod_ident lid; _ }; popen_loc; _ }
    | Uast.Str_ghost_open
        { popen_expr = { pmod_desc = Pmod_ident lid; _ }; popen_loc; _ } ->
        let loc = T.location popen_loc in
        let fname, mname = mk_import_name_list lid in
        [ O.mk_duseimport loc [ (Qdot (fname, mname), Some mname) ] ]
    | Uast.Str_ghost_val _ -> assert false (* TODO *)
    | Uast.Str_attribute _ -> []
    | Uast.Str_inductive ind_decl -> [ mk_ind loc ind_decl ]
    | _ -> assert false
  (* TODO *)
  and s_module_binding info { spmb_name = { txt; loc }; spmb_expr; spmb_loc; _ }
      =
    let open Odecl in
    let mod_bind_name = match txt with None -> assert false | Some t -> t in
    let mod_type_name = function
      (* FIXME: make it more robust *)
      | Uast.Mod_ident s | Mod_with ({ mdesc = Mod_ident s; _ }, _) ->
          Some s.txt
      | _ -> None
    in
    let rec s_module_expr Uast.{ spmod_desc; spmod_loc; _ } =
      let decl_loc = T.location spmod_loc in
      match spmod_desc with
      | Uast.Smod_ident x ->
          ignore x;
          (* FIXME: this could may be a [use import as X] *)
          Loc.errorm "Module aliasing is not supported."
      | Uast.Smod_structure str -> s_structure info str
      | Uast.Smod_functor ({ txt = None; _ }, _, _) -> assert false (* TODO *)
      | Uast.Smod_functor ({ txt = Some arg_name; loc }, arg, body) ->
          let id_loc = T.location loc in
          let id = T.mk_id ~id_loc arg_name in
          let body = s_module_expr body in
          let arg, subst_arg = s_module_type info (Opt.get arg) in
          ignore subst_arg;
          (* TODO *)
          O.mk_functor decl_loc id arg body
      | Smod_apply (funct, arg) -> s_mod_apply info funct arg
      | Smod_constraint (mod_expr, mod_type) ->
          let mod_type_name = mod_type_name mod_type.Uast.mdesc in
          let mod_type_name = Opt.map E.longident mod_type_name in
          let path = [ mod_bind_name ] in
          let mod_type, subst = s_module_type info mod_type in
          let info_ref = mk_info_refinement mod_type_name mod_type subst path in
          add_info_refinement info mod_bind_name info_ref;
          (* [O.mk_omodule scope_loc scope_id (s_module_expr mod_expr)] *)
          s_module_expr mod_expr
      | Smod_unpack _ -> assert false (* TODO *)
      | Smod_extension _ -> assert false
      (* TODO *)
    in
    let scope_loc = T.location spmb_loc in
    let scope_id = T.(mk_id ~id_loc:(location loc) mod_bind_name) in
    let scope_body = s_module_expr spmb_expr in
    Hashtbl.add mod_expr_table mod_bind_name scope_body;
    [ O.mk_omodule scope_loc scope_id scope_body ]
  and s_mod_apply _info funct arg =
    let qarg =
      match arg.spmod_desc with
      | Smod_ident { loc; txt } ->
          let id_loc = T.location loc in
          E.longident ~id_loc txt
      | _ -> assert false
      (* TODO *)
    in
    let _qfunct =
      match funct.spmod_desc with
      | Smod_ident { loc; txt } ->
          let id_loc = T.location loc in
          E.longident ~id_loc txt
      | _ -> assert false
      (* TODO *)
    in
    let _extract_functor_arg = function
      | O.Omodule (_, id, l) :: _ -> (id, l)
      | _ -> assert false
    in
    let _mk_subst id_arg_mod = function
      | O.Odecl (_, Ptree.Dtype [ { td_ident; _ } ]) ->
          let qarg_mod_type = Qident id_arg_mod in
          let qtsym = Qdot (qarg_mod_type, td_ident) in
          let idtsym = PTtyapp (Qdot (qarg, td_ident), []) in
          [ CStsym (qtsym, [], idtsym) ]
      | O.Odecl (_, Dtype _) -> assert false (* TODO *)
      | O.Odecl (_, Dlet (id, _, _, _)) ->
          let qarg_mod_type = Qident id_arg_mod in
          let lqvsym = Qdot (qarg_mod_type, id) in
          let rqvsym = Qdot (qarg, id) in
          [ CSvsym (lqvsym, rqvsym) ]
      | _ -> []
    in
    match funct.Uast.spmod_desc with
    | Smod_ident { txt = Lident _s; _ } ->
        (* let odecl_list = Hashtbl.find mod_expr_table s in
         * let id, l = extract_functor_arg odecl_list in
         * let subst = List.fold_left (fun acc d -> mk_subst id d :: acc) [] l in
         * let loc = T.location loc in
         * ignore ([O.mk_odecl loc (Ptree.Dcloneexport
         *                            (loc, qfunct, List.flatten subst))]); *)
        []
        (* TODO *)
    | Smod_ident { txt = Ldot (Lident x, y); loc } ->
        let subst =
          if x = "Map" || x = "Set" then
            let qord = Qident (T.mk_id "Ord") in
            let qtsym = Qdot (qord, T.mk_id "t") in
            let idtsym = T.(PTtyapp (Qdot (qarg, mk_id "t"), [])) in
            let lqvsym_cmp = Qdot (qord, T.mk_id "compare") in
            let rqvsym_cmp = T.(Qdot (qarg, mk_id "compare")) in
            [ CStsym (qtsym, [], idtsym); CSvsym (lqvsym_cmp, rqvsym_cmp) ]
          else
            let qhash = Qident (T.mk_id "HashedType") in
            let qtsym = Qdot (qhash, T.mk_id "t") in
            let idtsym = T.(PTtyapp (Qdot (qarg, mk_id "t"), [])) in
            let lqvsym_equal = Qdot (qhash, T.mk_id "equal") in
            let rqvsym_equal = T.(Qdot (qarg, mk_id "equal")) in
            let lqvsym_hash = T.(Qdot (qhash, mk_id "hash")) in
            let rqvsym_hash = T.(Qdot (qarg, mk_id "hash")) in
            [
              CStsym (qtsym, [], idtsym);
              CSvsym (lqvsym_equal, rqvsym_equal);
              CSvsym (lqvsym_hash, rqvsym_hash);
            ]
        in
        let x_y = T.mk_id (x ^ "_" ^ y) in
        let qualid = Qdot (Qident (T.mk_id "ocamlstdlib"), x_y) in
        let loc = T.location loc in
        [ O.mk_odecl loc (Ptree.Dcloneexport (loc, qualid, subst)) ]
    | Smod_ident { txt = Ldot (Lapply _, _); _ } -> assert false (* TODO *)
    | Smod_ident { txt = Ldot (Ldot _, _); _ } -> assert false (* TODO *)
    | Smod_ident { txt = Lapply _; _ } -> assert false (* TODO *)
    | Smod_structure _ -> assert false (* TODO *)
    | Smod_functor _ -> assert false (* TODO *)
    | Smod_apply _ -> assert false (* TODO *)
    | Smod_constraint _ -> assert false (* TODO *)
    | Smod_unpack _ -> assert false (* TODO *)
    | Smod_extension _ -> assert false
  (* TODO *)
  and s_module_type info { mdesc; _ } =
    match mdesc with
    | Mod_ident id -> (
        let s = E.string_of_longident id.txt in
        try (Hashtbl.find mod_type_table s, empty_subst)
        with Not_found -> assert false)
    | Mod_signature s_sig -> (s_signature info s_sig, empty_subst)
    | Mod_functor (Unit, _) -> assert false (* TODO *)
    | Mod_functor (Named ({ txt = None; _ }, _), _) -> assert false (* TODO *)
    | Mod_functor (Named ({ txt = Some arg_name; loc }, arg), body) ->
        let id_loc = T.location loc in
        let id = T.mk_id arg_name ~id_loc in
        let body, subst = s_module_type info body in
        let arg, subst_arg = s_module_type info arg in
        ignore subst_arg;
        (O.mk_functor id_loc id arg body, subst)
    | Mod_with (mod_type, constraint_list) ->
        let mod_type, subst_mod_type = s_module_type info mod_type in
        ignore subst_mod_type;
        (* TODO *)
        (mod_type, subst info constraint_list)
    | Mod_typeof _ (* of module_expr *) -> assert false (* TODO *)
    | Mod_extension _ (* of extension *) -> assert false
    | Mod_alias _ (* of Longident.t loc *) -> assert false
  (* TODO *)
  and s_structure info s_str =
    List.flatten (List.map (s_structure_item info) s_str)
  in

  (s_structure, s_signature)

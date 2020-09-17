open Why3
open Ptree
open Gospel
open Parser_frontend

let mk_field ~mut:f_mutable ~ghost:f_ghost f_loc f_ident f_pty  =
  { f_loc; f_ident; f_pty; f_mutable; f_ghost }

module Convert = struct
  open Oasttypes
  open Oparsetree
  open Vspec
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
  let td_private manifest private_ tkind = match manifest, private_, tkind with
    | Some _ , _, _           -> Ptree.Public
    | _, _, Ptype_abstract    -> Ptree.Private
    | _, Oasttypes.Private, _ -> Ptree.Private
    | _, Oasttypes.Public, _  -> Ptree.Public

  let param_of_cty cty =
    let loc = T.location cty.ptyp_loc in
    (loc, None, false, E.core_type cty)

  (** Translate a list of OCaml constructors declaration list into the
      corresponding Why3's Ptree algebraic constructors list. *)
  let constructor_declaration info {pcd_loc; pcd_name; pcd_args; _} =
    match pcd_args with
    | Pcstr_tuple cty_list -> let id_loc = T.location pcd_name.loc in
        let id = T.mk_id ~id_loc pcd_name.txt in
        let construct_arith = List.length cty_list in
        Hashtbl.add info.E.info_arith_construct pcd_name.txt (construct_arith);
        (T.location pcd_loc, id, List.map param_of_cty cty_list)
    | Pcstr_record _ -> assert false

  (** Convert a [Uast] type definition into a Why3's Ptree [type_def]. We
      follow the manifest-kind logic defined in the OCaml [Parsetree]. *)
  let td_def info td_spec td_manifest td_kind =
    let field Uast.{f_preid; f_pty; f_mutable; _} =
      let id_loc = T.location f_preid.pid_loc in
      let f, c1, c2, c3 = Loc.get id_loc in
      Format.eprintf "loc:%s, %d, %d, %d@." f c1 c2 c3;
      let id  = T.(mk_id ~id_loc f_preid.pid_str) in
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
        TDalgebraic (List.map (constructor_declaration info) constr_decl_list)
    | None, Ptype_record lbl_list ->
        let ghost_fields = List.map field td_spec.Uast.ty_field in
        let all_fields = List.fold_right add_reg_field lbl_list ghost_fields in
        TDrecord all_fields
    | _ -> assert false (* TODO *)

  let type_decl info Uast.({tname; tspec; tmanifest; tkind; _} as td) = {
    td_loc    = T.location td.tloc;
    td_ident  = T.(mk_id tname.txt ~id_loc:(location tname.loc));
    td_params = List.map td_params td.tparams;
    td_vis    = td_private tmanifest td.tprivate tkind;
    td_mut    = tspec.ty_ephemeral;
    td_inv    = List.map Uterm.term tspec.ty_invariant;
    td_wit    = [];
    td_def    = td_def info tspec tmanifest tkind
  }

  let logic_attr = "logic"
  let lemma_attr = "lemma"

  let is_logic attributes =
    List.exists (fun {attr_name; _} -> attr_name.txt = logic_attr) attributes

  let is_lemma attributes =
    List.exists (fun {attr_name; _} -> attr_name.txt = lemma_attr) attributes

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
      let id = Vspec.ident_of_lb_arg lb_arg in
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
      | Some s -> mk_val (mk_id vd_id_str) params ret pat mask (vspec s) in
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
            let mk_pat lb = let pat_loc = loc_of_lb_arg lb in
              Uterm.mk_pattern (Pvar (ident_of_lb_arg lb)) ~pat_loc in
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

  let function_ f =
    let ld_loc = T.location f.Uast.fun_loc in
    let ld_ident = T.preid f.fun_name in
    let ld_params = List.map param f.fun_params in
    let ld_type = Opt.map T.pty f.fun_type in
    let ld_def = Opt.map T.term f.fun_def in
    { ld_loc; ld_ident; ld_params; ld_type; ld_def }

  let axiom a =
    T.preid a.Uast.ax_name, T.term a.ax_term

  let type_exception {ptyexn_constructor = exn_construct; _} =
    let txt_exn = exn_construct.pext_name.txt in
    let loc_exn = exn_construct.pext_name.loc in
    let id_exn = T.mk_id txt_exn ~id_loc:(T.location loc_exn) in
    let pty = match exn_construct.pext_kind with
      | Pext_decl (Pcstr_tuple cty_list, None) ->
          PTtuple (List.map E.core_type cty_list)
      | Pext_decl (Pcstr_record _, _) ->
          Loc.errorm
            "Record expressions in exceptions declaration is not supported."
      | _ -> assert false (* TODO? *) in
    id_exn, pty, Ity.MaskVisible

  let rec s_signature info s_sig =
    List.map (s_signature_item info) s_sig

  and s_signature_item info Uast.{sdesc; _} =
    s_signature_item_desc info sdesc

  and s_signature_item_desc info sig_item_desc =
    match sig_item_desc with
    | Sig_val s_val ->
        [Odecl (val_decl s_val false)]
    | Sig_type (rec_flag, type_decl_list) ->
        ignore (rec_flag); (* TODO *)
        let td_list = List.map (type_decl info) type_decl_list in
        [Odecl (Dtype td_list)]
    | Sig_function f ->
        [Odecl (Dlogic [function_ f])]
    | Sig_axiom a ->
        let ax_name, ax_term = axiom a in
        [Odecl (Dprop (Decl.Paxiom, ax_name, ax_term))]
    | Sig_typext _ -> assert false (* TODO *)
    | Sig_module _ -> assert false (* TODO *)
    | Sig_recmodule _ -> assert false (* TODO *)
    | Sig_modtype _ -> assert false (* TODO *)
    | Sig_exception ty_exn ->
        let id, pty, mask = type_exception ty_exn in
        [Odecl (Dexn (id, pty, mask))]
    | Sig_open _ -> assert false (* TODO *)
    | Sig_include _ -> assert false (* TODO *)
    | Sig_class _ -> assert false (* TODO *)
    | Sig_class_type _ -> assert false (* TODO *)
    | Sig_attribute _ ->
        []
    | Sig_extension _ -> assert false (* TODO *)
    | Sig_ghost_type _ -> assert false (* TODO *)
    | Sig_ghost_val  _ -> assert false (* TODO *)
    | Sig_ghost_open  _ -> assert false (* TODO *)

  let s_structure =
    let mod_type_table : (string, odecl list) Hashtbl.t = Hashtbl.create 16 in

    let rec s_structure_item info Uast.{sstr_desc; _} =
      s_structure_item_desc info sstr_desc

    and s_structure_item_desc info str_item_desc =
      let is_logic_svb Uast.{spvb_attributes; _} = is_logic spvb_attributes in
      let is_lemma_svb Uast.{spvb_attributes; _} = is_lemma spvb_attributes in
      let rs_kind svb_list =
        if List.exists is_logic_svb svb_list then Expr.RKfunc
        else if List.exists is_lemma_svb svb_list then Expr.RKlemma
        else Expr.RKnone in
      let id_expr_rs_kind_of_svb svb_list =
        let s_value svb = E.s_value_binding info svb in
        rs_kind svb_list, List.map s_value svb_list in
      match str_item_desc with
      | Uast.Str_value (Nonrecursive, svb_list) ->
          begin match id_expr_rs_kind_of_svb svb_list with
            | rs_kind, [id, expr] -> [Odecl (Dlet (id, false, rs_kind, expr))]
            | _ -> assert false
            (* no multiple bindings in nonrecursive values *) end
      | Uast.Str_value (Recursive, svb_list) ->
          let mk_fun_def rs_kind (id, fun_expr) =
            let args, ret, spec, expr = begin match fun_expr.expr_desc with
              | Efun (args, _, ret, _, spec, expr) -> args, ret, spec, expr
              | Erec _ -> assert false (* TODO *)
              | Ematch _ -> assert false (* TODO *)
              | _ -> assert false (* TODO *) end in
            let mask_visible = Ity.MaskVisible in
            id, false, rs_kind, args, None, ret, mask_visible, spec, expr in
          let rs_kind, id_fun_expr_list = id_expr_rs_kind_of_svb svb_list in
          [Odecl (Drec (List.map (mk_fun_def rs_kind) id_fun_expr_list))]
      | Uast.Str_type (rec_flag, type_decl_list) ->
          ignore (rec_flag); (* TODO *)
          let td_list = List.map (type_decl info) type_decl_list in
          [Odecl (Dtype td_list)]
      | Uast.Str_function f ->
          [Odecl (Dlogic [function_ f])]
      | Uast.Str_axiom a ->
          [Odecl (Dprop (Decl.Paxiom, T.preid a.ax_name, T.term a.ax_term))]
      | Uast.Str_module {spmb_name = {txt; loc}; spmb_expr; spmb_loc; _} ->
          let scope_loc = T.location spmb_loc in
          let scope_id  = T.(mk_id ~id_loc:(location loc) txt) in
          [Omodule (scope_loc, scope_id, s_module_expr info spmb_expr)]
      | Uast.Str_modtype {mtdname = {txt; loc}; mtdtype; mtdloc; _} ->
          let scope_loc = T.location mtdloc in
          let scope_id  = T.(mk_id ~id_loc:(location loc) txt) in
          (* FIXME: do not use that [Opt.get] *)
          let scope_decls = s_module_type info (Opt.get mtdtype) in
          Hashtbl.add mod_type_table txt scope_decls;
          [Omodule (scope_loc, scope_id, scope_decls)]
      | Uast.Str_exception ty_exn ->
          let id, pty, mask = type_exception ty_exn in
          [Odecl (Dexn (id, pty, mask))]
      | Uast.Str_open _ -> assert false (* TODO *)
      | Uast.Str_ghost_open {popen_lid; popen_loc; _} ->
          let loc = T.location popen_loc in
          let id_loc = T.location popen_lid.loc in
          let open_txt = popen_lid.txt in
          let mname_txt = match open_txt with
            | Longident.Lident s -> s
            | Ldot (_, s) -> s
            | _ -> assert false in
          let mname = T.mk_id mname_txt ~id_loc in
          let str = String.uncapitalize_ascii mname_txt in
          let id_fname = T.mk_id str ~id_loc in
          let fname = Qident id_fname in
          [Odecl (Duseimport (loc, true, [Qdot (fname, mname), Some mname]))]
      | Uast.Str_ghost_type (rec_flag, type_decl_list) ->
          ignore (rec_flag); (* TODO *)
          let td_list = List.map (type_decl info) type_decl_list in
          [Odecl (Dtype td_list)]
      | Uast.Str_ghost_val _ ->
          assert false (* TODO *)
      | Uast.Str_attribute _ ->
          []
      | _ -> assert false (* TODO *)

    and s_module_expr info {spmod_desc; spmod_loc; _} =
      let decl_loc = T.location spmod_loc in
      match spmod_desc with
      | Uast.Smod_ident _ ->
          Loc.errorm "Module aliasing is not supported."
      | Uast.Smod_structure str ->
          s_structure info str
      | Uast.Smod_functor (arg_name, arg, body) ->
          let id_loc = T.location arg_name.loc in
          let id = T.mk_id ~id_loc arg_name.txt in
          let body = s_module_expr info body in
          Omodule (decl_loc, id, s_module_type info (Opt.get arg)) :: body
      | Smod_apply _ -> assert false (* TODO *)
      | Smod_constraint _ -> assert false (* TODO *)
      | Smod_unpack _ -> assert false (* TODO *)
      | Smod_extension _ -> assert false (* TODO *)

    and s_module_type info {mdesc; mloc; _} =
      let _decl_loc = T.location mloc in
      match mdesc with
      | Mod_ident id ->
          let s = E.string_of_longident id.txt in
          begin try Hashtbl.find mod_type_table s with
          Not_found -> assert false end
      | Mod_signature s_sig ->
          List.flatten (s_signature info s_sig)
      | Mod_functor (arg_name, arg, body) ->
          let id_loc = T.location arg_name.loc in
          let id = T.mk_id arg_name.txt ~id_loc in
          let body = s_module_type info body in
          Omodule (id_loc, id, s_module_type info (Opt.get arg)) :: body
      | Mod_with _ (* of s_module_type * s_with_constraint list *) ->
          assert false (* TODO *)
      | Mod_typeof _ (* of module_expr *) ->
          assert false (* TODO *)
      | Mod_extension _ (* of extension *) ->
          assert false
      | Mod_alias _ (* of Longident.t loc *) ->
          assert false (* TODO *)

    and s_structure info s_str =
      List.flatten (List.map (s_structure_item info) s_str) in
    s_structure

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
  let minmax = Qdot (Qident (mk_id "int"), mk_id "MinMax") in
  (* let int63 = Qdot (Qdot (Qident (mk_id "mach"), mk_id "int"), mk_id "Int63") in *)
  let length = Qdot (Qident (mk_id "list"), mk_id "List") in
  let list = Qdot (Qident (mk_id "list"), mk_id "Length") in
  let append = Qdot (Qident (mk_id "list"), mk_id "Append") in
  let reverse = Qdot (Qident (mk_id "list"), mk_id "Reverse") in
  let ocaml_exn = Qdot (Qident (mk_id "ocaml"), mk_id "Exceptions") in
  let option = Qdot (Qident (mk_id "option"), mk_id "Option") in
  let ocaml_ref = Qdot (Qident (mk_id "ref"), mk_id "Ref") in
  let use_int = Duseimport (Loc.dummy_position, false, [int, None]) in
  let use_minmax = Duseimport (Loc.dummy_position, false, [minmax, None]) in
  (* let use_int63 = Duseimport (Loc.dummy_position, false, [int63, None]) in *)
  let use_list = Duseimport (Loc.dummy_position, false, [list, None]) in
  let use_length = Duseimport (Loc.dummy_position, false, [length, None]) in
  let use_append = Duseimport (Loc.dummy_position, false, [append, None]) in
  let use_reverse = Duseimport (Loc.dummy_position, false, [reverse, None]) in
  let use_ocaml_exn =
    Duseimport (Loc.dummy_position, false, [ocaml_exn, None]) in
  let use_option = Duseimport (Loc.dummy_position, false, [option, None]) in
  let use_ref = Duseimport (Loc.dummy_position, false, [ocaml_ref, None]) in
  [Odecl use_int; Odecl use_minmax; (* Odecl use_int63; *) Odecl use_list;
   Odecl use_length; Odecl use_append; Odecl use_reverse;
   Odecl use_ocaml_exn; Odecl use_ref; Odecl use_option]

let mk_info () =
  let info = E.{ info_arith_construct = Hashtbl.create 32 } in
  Hashtbl.add info.info_arith_construct "Some" 1;
  Hashtbl.add info.info_arith_construct "::" 2;
  info

let read_file file nm c =
  let lb = Lexing.from_channel c in
  Location.init lb file;
  let ocaml_structure = parse_ocaml_structure_lb lb in
  parse_structure_gospel ocaml_structure nm

let type_check name nm structs =
  let md = Gospel.Tmodule.init_muc name in
  let penv = Gospel.Typing.penv [] (Gospel.Utils.Sstr.singleton nm) in
  let md = List.fold_left (Gospel.Typing.type_str_item penv) md structs in
  Gospel.Tmodule.wrap_up_muc md

let read_channel env path file c =
  if !debug then Format.eprintf "reading file '%s'@." file;
  let mod_name =
    let f = Filename.basename file in
    String.capitalize_ascii (Filename.chop_extension f) in
  let f = read_file file mod_name c in
  (* let f = type_check file mod_name f in *)
  open_file env path; (* This is the beginning of the Why3 file construction *)
  let id = T.mk_id mod_name in
  open_module id; (* This is the beginning of the top module construction *)
  let info = mk_info () in
  let f = s_structure info f in
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

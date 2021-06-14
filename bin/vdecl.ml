open Gospel
open Parser_frontend
open Longident
module P = Parsetree
module U = Uast

let debug = ref true

let read_file file nm c =
  let lb = Lexing.from_channel c in
  Location.init lb file;
  let ocaml_structure = parse_ocaml_structure_lb lb in
  parse_structure_gospel ocaml_structure nm

let read_channel file c =
  if !debug then Format.eprintf "reading file '%s'@." file;
  let mod_name =
    let f = Filename.basename file in
    String.capitalize_ascii (Filename.chop_extension f) in
  let f = read_file file mod_name c in
  f

module Translate = struct
  type ident = {
    id_str : string;
  } (* TO BE COMPLETED *)

  type qualid =
    | Qident of ident
    | Qdot of qualid * ident

  type pty =
    | PTtyvar of ident
    | PTtyapp of qualid * pty list
    (* TO BE COMPLETED *)

  type binop =
    | DTand
    (* TO BE COMPLETED *)

  type param  = ident option * pty
  type binder = ident option * pty option

  type term =
    | Ttrue
    | Tfalse
    | Tconst of int
    | Tident of qualid
    | Tacc   of term (* * fractional permission *)
    | Tidapp of qualid * term list
    | Tinfix of term * ident * term
    | Tbinop of term * binop * term
    | Told   of term
    (* TO BE COMPLETED *)

  type field = {
    (* f_loc     : Loc.position; *)
    f_ident   : ident;
    f_pty     : pty;
    f_mutable : bool;
  }

  let mk_field ~mut:f_mutable f_ident f_pty  =
    { f_ident; f_pty; f_mutable; }

  type type_def =
    | TDrecord of field list
    (* TO BE COMPLETED *)

  type type_decl = {
    td_ident : ident;
    td_def   : type_def;
  }

  type logic_decl = {
    ld_ident  : ident;
    ld_params : param list;
    ld_def    : term option;
  }

  type spec = {
    sp_pre  : term list;
    sp_post : term list;
  }

  type expr =
    | Econst of int
    | Evar of qualid
    | Efield of expr * qualid
    | Eassign of expr * expr
    | Einfix of expr * ident * expr
    | Efun of binder list * expr * spec option

  type decl =
    | Dtype   of type_decl
    | Dlogic  of logic_decl
    | Dmethod of ident * expr

  let mk_pttyapp id args =
    PTtyapp (id, args)

  let rec longident ?(prefix="") = function
    | Lident id -> (* FIXME? right place to driver lookup? *)
        Qident { id_str = prefix ^ id }
    | Ldot (t, id) ->
        Qdot (longident t, { id_str = id})
    | _ -> assert false (* TODO *)

  let rec core_type P.{ptyp_desc; _} = match ptyp_desc with
    | Ptyp_any ->
        assert false (* TODO *)
    | P.Ptyp_var _s ->
        assert false (* TODO *)
    | P.Ptyp_constr ({txt; _}, cty_list) ->
        let args = List.map core_type cty_list in
        mk_pttyapp (longident txt) args
    | P.Ptyp_arrow (Nolabel, _cty1, _cty2) ->
        assert false (* TODO *)
    | P.Ptyp_arrow (Labelled _, _, _) ->
        assert false (* TODO *)
    | P.Ptyp_arrow (Optional _, _, _) ->
        assert false (* TODO *)
    | P.Ptyp_tuple _cty_list ->
        assert false (* TODO *)
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

  let td_def td_manifest td_kind =
    let field_of_label_decl lbl_decl =
      let pld_mutable = lbl_decl.P.pld_mutable in
      let pld_id = lbl_decl.pld_name in
      let f_id  = { id_str = pld_id.txt } in
      let f_pty = core_type lbl_decl.pld_type in
      let mut = match pld_mutable with Mutable -> true | _ -> false in
      mk_field f_id f_pty ~mut in
    let add_reg_field lbl acc = field_of_label_decl lbl :: acc in
    match td_manifest, td_kind with
    | None, P.Ptype_record lbl_list ->
        let fields = List.fold_right add_reg_field lbl_list [] in
        TDrecord fields
    | _ -> assert false (* TODO *)

  let mk_representation_predicate td_name fields =
    let mk_acc_pr {f_ident; _} =
      Tacc (Tident (Qdot (Qident { id_str = "this" }, f_ident ))) in
    let mk_body = function
      | [] -> assert false
      | [f] -> mk_acc_pr f
      | f :: r -> let mk_and acc x = Tbinop (mk_acc_pr x, DTand, acc) in
          List.fold_left mk_and (mk_acc_pr f) r in
    let ld_ident = { id_str = td_name.id_str ^ "_representation_predicate" } in
    let param_name = { id_str = "this" } in
    let param_pty = PTtyapp (Qident { id_str = "Ref" }, []) in
    let ld_params = [Some param_name, param_pty] in
    let pr_body = mk_body fields in
    { ld_ident; ld_params; ld_def = Some pr_body }

  (* Translating type declarations into Viper.
     Ignoring type specification, for now *)
  let type_decl Uast.{tname; tmanifest; tkind; _} = {
    td_ident = { id_str = tname.txt };
    td_def   = td_def tmanifest tkind;
  }

  let ppat_desc = function
    | Parsetree.Ppat_var {txt; _} -> { id_str = txt }
    | _ -> assert false (* TODO *)

  let pattern p =
    ppat_desc p.Parsetree.ppat_desc

  let rec qualid = function
    | U.Qpreid id  -> Qident { id_str = id.pid_str }
    | Qdot (q, id) -> Qdot (qualid q, { id_str = id.pid_str })

  let rec term t =
    term_desc t.U.term_desc

  and term_desc t_desc =
    let is_infix U.Preid.{pid_str; _} = String.sub pid_str 0 5 = "infix" in
    let is_equal U.Preid.{pid_str; _} = pid_str = "infix =" in
    match t_desc with
    | U.Ttrue -> Ttrue
    | Tfalse -> Tfalse
    | Tconst (Pconst_integer (n, _)) -> Tconst (int_of_string n)
    | Tpreid q -> Tident (qualid q)
    | Tinfix (t1, op, t2) when is_equal op ->
        Tinfix (term t1, {id_str = "=="}, term t2)
    | Tinfix (t1, op, t2) ->
        let id_str = String.sub op.pid_str 6 (String.length op.pid_str - 6) in
        Tinfix (term t1, {id_str}, term t2)
    | Tidapp (Qpreid id, [lhs; rhs]) when is_infix id ->
        let id_str = String.sub id.pid_str 6 (String.length id.pid_str - 6) in
        Tinfix (term lhs, {id_str}, term rhs)
    | Tidapp (id, arg_list) ->
        Tidapp (qualid id, List.map term arg_list)
    | Tapply  _ -> assert false (* TODO *)
    | Tbinop  _ -> assert false (* TODO *)
    | Tnot    _ -> assert false (* TODO *)
    | Tif     _ -> assert false (* TODO *)
    | Tquant  _ -> assert false (* TODO *)
    | Tattr   _ -> assert false (* TODO *)
    | Tlet    _ -> assert false (* TODO *)
    | Tcase   _ -> assert false (* TODO *)
    | Tcast   _ -> assert false (* TODO *)
    | Ttuple  _ -> assert false (* TODO *)
    | Trecord _ -> assert false (* TODO *)
    | Tupdate _ -> assert false (* TODO *)
    | Tscope  _ -> assert false (* TODO *)
    | Told t -> Told (term t)
    | _ -> assert false (* TODO *)

  let mk_spec U.{fun_ens; fun_req; _} = {
    sp_pre  = List.map term fun_req; (* TODO *)
    sp_post = List.map term fun_ens;
  }

  let mk_val_spec U.{sp_pre; sp_post; _} = {
    sp_pre  = List.map term sp_pre;
    sp_post = List.map term sp_post;
  }

  let merge_spec s1 s2 = {
    sp_pre  = s1.sp_pre  @ s2.sp_pre;
    sp_post = s1.sp_post @ s2.sp_post;
  }

  let merge_spec s1 s2 = match s1, s2 with
    | None, None -> None
    | Some s, None | None, Some s -> Some s
    | Some s1, Some s2 -> Some (merge_spec s1 s2)

  let bind_spec spec = function
    | Efun (arg_list, expr, s) ->
        Efun (arg_list, expr, merge_spec s spec)
    | _ -> assert false (* TODO? *)

  let spec = function
    | None -> None
    | Some s -> Some (mk_spec s)

  let val_spec = function
    | None -> None
    | Some s -> Some (mk_val_spec s)

  let rec s_expression e =
    s_expression_desc e.Uast.spexp_desc

  and s_expression_desc expr_desc =
    let open Location in
    let is_ref  {txt; _} = match txt with Lident s -> s = ":=" | _ -> false in
    let is_get  {txt; _} = match txt with Lident s -> s = "!"  | _ -> false in
    let is_plus {txt; _} = match txt with Lident s -> s = "+"  | _ -> false in
    let rec loop_fun_arg acc expr = match expr.U.spexp_desc with
      | Sexp_fun (_, _, pat, e, _) ->
          let r, expr = loop_fun_arg acc e in pat :: r, expr
      | _ -> acc, expr in
    match expr_desc with
    | Uast.Sexp_ident {txt; _} ->
        Evar (longident txt)
    | Uast.Sexp_constant Pconst_integer (n, None) ->
        Econst (int_of_string n)
    | Sexp_fun (Nolabel, None, pat, expr, s) ->
        let arg_list, expr = loop_fun_arg [] expr in
        let mk_arg a = Some (pattern a), None in
        let arg_list = List.map mk_arg (pat :: arg_list) in
        let spec = spec s in
        Efun (arg_list, s_expression expr, spec)
    | Sexp_apply ({spexp_desc = Sexp_ident f; _}, [(_, e)]) when is_get f ->
        Efield (s_expression e, Qident { id_str = "contents" })
    | Sexp_apply ({spexp_desc = Sexp_ident f; _}, [lhs; rhs]) when is_ref f ->
        let _, lhs = lhs and _, rhs = rhs in
        let lhs = Efield (s_expression lhs, Qident { id_str = "contents"}) in
        Eassign (lhs, s_expression rhs)
    | Sexp_apply ({spexp_desc = Sexp_ident f; _}, [lhs; rhs]) when is_plus f ->
        let _, lhs = lhs and _, rhs = rhs in
        Einfix (s_expression lhs, {id_str = "+"}, s_expression rhs)
    | Sexp_field (e, {txt; _}) ->
        Efield (s_expression e, longident txt)
    | Sexp_setfield (e1, {txt; _}, e2) ->
        let lhs = Efield (s_expression e1, longident txt) in
        Eassign (lhs, s_expression e2)
    | _ -> assert false (* TODO *)

  let s_value_binding Uast.{spvb_expr; _} =
    s_expression spvb_expr

  let s_structure_item_desc = function
    | Uast.Str_type (rec_flag, [td])
    | Uast.Str_ghost_type (rec_flag, [td]) ->
        ignore (rec_flag); (* TODO *)
        let td = type_decl td in
        let pr_repr = match td.td_def with
          | TDrecord fields -> mk_representation_predicate td.td_ident fields in
        [Dtype td; Dlogic pr_repr]
    | Str_value (rec_flag, [{spvb_pat; spvb_expr; spvb_vspec; _}]) ->
        ignore rec_flag; (* TODO *)
        let fun_id = pattern spvb_pat in
        let fun_expr = s_expression spvb_expr in
        let fun_spec = val_spec spvb_vspec in
        [Dmethod (fun_id, bind_spec fun_spec fun_expr)]
    | _ -> assert false (* TODO *)

  let s_structure_item Uast.{sstr_desc; _} =
    s_structure_item_desc sstr_desc

  let s_structure s_str =
    List.flatten (List.map s_structure_item s_str)
end

module Print = struct
  open Translate
  open Format

  let comma  fmt () = fprintf fmt ",@ "
  let andand fmt () = fprintf fmt " &&@ "

  let rec pp_list sep pp_elt fmt = function
    | [] -> ()
    | [elt] -> fprintf fmt "%a" pp_elt elt
    | e :: r -> fprintf fmt "%a%a%a" pp_elt e sep () (pp_list sep pp_elt) r

  let rec pp_ident fmt = function
    | Qident id -> fprintf fmt "%s" id.id_str
    | Qdot (q, id) -> fprintf fmt "%a.%s" pp_ident q id.id_str

  let rec pp_term fmt = function
    | Ttrue -> fprintf fmt "true"
    | Tfalse -> fprintf fmt "false"
    | Tident id -> fprintf fmt "%a" pp_ident id
    | Tconst n -> fprintf fmt "%d" n
    | Tacc t -> fprintf fmt "acc(%a)" pp_term t
    | Tidapp (id, [term]) ->
        fprintf fmt "%a.%a" pp_term term pp_ident id
    | Tidapp (id, term_list) ->
        fprintf fmt "%a(%a)" pp_ident id (pp_list comma pp_term) term_list
    | Tinfix (t1, op, t2) ->
        fprintf fmt "@[%a %s@ %a@]" pp_term t1 op.id_str pp_term t2
    | Tbinop (t1, DTand, t2) ->
        fprintf fmt "@[%a &&@ %a@]" pp_term t1 pp_term t2
    | Told t -> fprintf fmt "old(%a)" pp_term t

  let pp_logic_decl fmt {ld_ident; ld_params; ld_def} =
    let pp_params fmt = function
      | [] -> ()
      | [(Some id, _)] -> fprintf fmt "%s: Ref" id.id_str
      | _ -> assert false in
    match ld_def with
    | None -> fprintf fmt "@[<hov 2>predicate %s (%a)"
        ld_ident.id_str pp_params ld_params
    | Some ld_def -> fprintf fmt "@[<hov 2>predicate %s (%a){@\n%a@]@\n}"
        ld_ident.id_str pp_params ld_params pp_term ld_def

  let pp_field fmt {f_ident; _} =
    fprintf fmt "field %s: Int" f_ident.id_str

  let pp_type_def fmt = function
    | TDrecord field_list ->
        List.iter (fun f -> fprintf fmt "@[%a@]@\n" pp_field f) field_list

  let pp_type_decl fmt {td_def; _} =
    fprintf fmt "@[%a@]" pp_type_def td_def

  let rec pp_expr fmt = function
    | Econst x -> fprintf fmt "%d" x
    | Evar q -> fprintf fmt "%a" pp_ident q
    | Efield (e, l) -> fprintf fmt "%a.%a" pp_expr e pp_ident l
    | Eassign (e1, e2) -> fprintf fmt "%a := %a" pp_expr e1 pp_expr e2
    | Einfix (e1, x, e2) ->
        fprintf fmt "%a %s %a" pp_expr e1 x.id_str pp_expr e2
    | Efun _ -> assert false (* TODO *)

  let pp_pty fmt = function
    | PTtyvar _ | PTtyapp _ -> fprintf fmt "Ref" (* TODO *)

  let pp_param fmt (id, pty) = match id with
    | None -> assert false (* TODO *)
    | Some id -> fprintf fmt "%s: %a" id.id_str pp_pty pty

  let pp_binder fmt (id, _) = match id with
    | None -> assert false (* TODO *)
    | Some id -> fprintf fmt "%s: Ref" id.id_str

  let pp_repr_pred fmt (x, _) = match x with
    | None -> assert false (* TODO *)
    | Some x -> fprintf fmt "acc(%s.contents)" x.id_str

  let pp_contract arg_list fmt = function
    | [] ->
        fprintf fmt "%a" (pp_list andand pp_repr_pred) arg_list
    | sp_pre ->
        fprintf fmt "@[%a &&@ %a@]" (pp_list andand pp_repr_pred) arg_list
          (pp_list andand pp_term) sp_pre

  let pp_spec arg_list fmt = function
    | None ->
        fprintf fmt "@[requires %a@]@\n@[ensures %a@]"
          (pp_list andand pp_repr_pred) arg_list
          (pp_list andand pp_repr_pred) arg_list
    | Some {sp_pre; sp_post} ->
        fprintf fmt "@[requires %a@]@\n@[ensures %a@]"
          (pp_contract arg_list) sp_pre (pp_contract arg_list) sp_post

  let pp_method_body fmt = function
    | Efun (binder_list, e, spec) ->
        fprintf fmt "@[(%a)@]@\n%a@\n{@\n%a@\n}"
          (pp_list comma pp_binder) binder_list (pp_spec binder_list) spec
          pp_expr e
    | _ -> assert false (* TODO *)

  let pp_decl fmt = function
    | Dtype td -> fprintf fmt "%a" pp_type_decl td
    | Dlogic logic_decl ->
        fprintf fmt "%a" pp_logic_decl logic_decl
    | Dmethod (id, body) ->
        fprintf fmt "method %s %a" id.id_str pp_method_body body

  let pp_program fmt vp =
    List.iter (fun td -> fprintf fmt "%a@\n@\n" pp_decl td) vp

  let pp_stdlib fmt () =
    fprintf fmt "field contents: Int"
end

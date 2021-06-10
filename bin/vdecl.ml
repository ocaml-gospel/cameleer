open Gospel
open Parser_frontend
open Longident
module P = Parsetree

let debug = ref true

let read_file file nm c =
  let lb = Lexing.from_channel c in
  Location.init lb file;
  let ocaml_structure = parse_ocaml_structure_lb lb in
  parse_structure_gospel ocaml_structure nm

(* let type_check name nm structs =
 *   let md = Gospel.Tmodule.init_muc name in
 *   let penv = Gospel.Typing.penv [] (Gospel.Utils.Sstr.singleton nm) in
 *   let md = List.fold_left (Gospel.Typing.type_str_item penv) md structs in
 *   Gospel.Tmodule.wrap_up_muc md *)

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

  type param = ident option * pty

  type term =
    | Ttrue
    | Tfalse
    | Tident of qualid
    | Tacc of term (* * fractional permission *)
    | Tbinop of term * binop * term
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

  type decl =
    | Dtype of type_decl
    | Dlogic of logic_decl

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
      | [f] ->
          mk_acc_pr f
      | f :: r ->
          List.fold_left (fun acc x ->
              Tbinop (mk_acc_pr x, DTand, acc)) (mk_acc_pr f) r in
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

  let s_structure_item_desc = function
    | Uast.Str_type (rec_flag, [td])
    | Uast.Str_ghost_type (rec_flag, [td]) ->
        ignore (rec_flag); (* TODO *)
        let td = type_decl td in
        let pr_repr = match td.td_def with
          | TDrecord fields -> mk_representation_predicate td.td_ident fields in
        [Dtype td; Dlogic pr_repr]
    | _ -> assert false (* TODO *)

  let s_structure_item Uast.{sstr_desc; _} =
    s_structure_item_desc sstr_desc

  let s_structure s_str =
    List.flatten (List.map s_structure_item s_str)
end

module Print = struct
  open Translate
  open Format

  let rec pp_ident fmt = function
    | Qident id -> fprintf fmt "%s" id.id_str
    | Qdot (q, id) -> fprintf fmt "%a.%s" pp_ident q id.id_str

  let rec pp_term fmt = function
    | Ttrue -> fprintf fmt "true"
    | Tfalse -> fprintf fmt "false"
    | Tident id -> fprintf fmt "%a" pp_ident id
    | Tacc t -> fprintf fmt "acc(%a)" pp_term t
    | Tbinop (t1, DTand, t2) ->
        fprintf fmt "%a && %a" pp_term t1 pp_term t2

  let pp_logic_decl fmt {ld_ident; ld_params; ld_def} =
    let pp_params fmt = function
      | [] -> ()
      | [(Some id, _)] -> fprintf fmt "%s: Ref" id.id_str
      | _ -> assert false in
    match ld_def with
    | None ->
        fprintf fmt "@[<hov 2>predicate %s (%a)"
          ld_ident.id_str pp_params ld_params
    | Some ld_def ->
        fprintf fmt "@[<hov 2>predicate %s (%a){@\n%a@]@\n}"
          ld_ident.id_str pp_params ld_params pp_term ld_def

  let pp_field fmt {f_ident; _} =
    fprintf fmt "field %s: Int" f_ident.id_str

  let pp_type_def fmt = function
    | TDrecord field_list ->
        List.iter (fun f -> fprintf fmt "@[%a@]@\n" pp_field f) field_list

  let pp_type_decl fmt {td_def; _} =
    fprintf fmt "@[%a@]" pp_type_def td_def

  let pp_decl fmt = function
    | Dtype td -> fprintf fmt "%a" pp_type_decl td
    | Dlogic logic_decl ->
        fprintf fmt "%a" pp_logic_decl logic_decl

  let pp_program fmt vp =
    List.iter (fun td -> fprintf fmt "%a@\n" pp_decl td) vp
end

open Ppxlib
open Gospel
open Asttypes
(* open Parsetree *)
(* open Why3 *)
(* open Ptree *)
(* open Vspec *)
module Tt = Tterm
module E = Expression_coma
(* module O = Odecl *)

module ML = Ml_lang

let rec_flag b = ML.(if b then Recursive else NonRecursive)

let param (_loc, pre_id, _ty) =
  E.preid pre_id

let function_ f =
  let _ld_loc = E.location f.Uast.fun_loc in
  let _ld_type = Option.map Uterm.pty f.fun_type in
  let ld_ident = E.preid f.fun_name in
  let ld_params = List.map param f.fun_params in
  let rec_flag = rec_flag f.fun_rec in
  let _fun_spec = f.fun_spec in
  match f.fun_def with None -> assert false
  | Some fun_def ->
    ML.DFun (rec_flag, ld_ident, ld_params, E.term fun_def)

let s_structure, s_signature =
  let rec s_signature s_sig =
    List.flatten (List.map s_signature_item s_sig)
  and s_signature_item Uast.{ sdesc; sloc } =
    s_signature_item_desc (E.location sloc) sdesc
  and s_signature_item_desc loc sig_item_desc =
    match sig_item_desc with
    | Sig_val s_val ->
        ignore s_val; []
    | Sig_type (rec_flag, type_decl_list) ->
        ignore (rec_flag, type_decl_list); []
    | Sig_function f ->
        [ ML.{ decl_loc = loc; decl_desc = function_ f } ]
    | _ -> assert false (* TODO *)
  and s_structure_item Uast.{ sstr_desc; sstr_loc } =
    s_structure_item_desc (E.location sstr_loc) sstr_desc
  and s_structure_item_desc loc str_item_desc =
    match str_item_desc with
    | Str_value (Nonrecursive, svb_list)
    | Str_value (Recursive, svb_list) ->
        ignore svb_list; []
        (* let rs_kind, id_fun_expr_list = id_expr_rs_kind_of_svb svb_list in
        let ghost = is_ghost_let svb_list in
        [
          O.mk_drec loc (List.map (E.mk_fun_def ghost rs_kind) id_fun_expr_list);
        ] *)
    | Str_type (rec_flag, type_decl_list) ->
        ignore (rec_flag, type_decl_list); assert false
    | Str_function f ->
        [ ML.{ decl_loc = loc; decl_desc = function_ f } ]
    | _ -> assert false

  and s_structure s_str =
    List.flatten (List.map s_structure_item s_str)
  in

  (s_structure, s_signature)

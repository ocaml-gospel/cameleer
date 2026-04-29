open Ppxlib
open Gospel
open Asttypes
module Tt = Tterm
module E = Expression_coma

module ML = Ml_lang

let (^~) a b = fun c -> a c b

let rec_flag b = if b then Recursive else Nonrecursive

let param (_loc, pre_id, _pty) = E.preid pre_id, None

let function_ f =
  ML.DFunction f

let prop p =
  ML.DProp p

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
    | Str_value (b, svb_list) ->
        let k = ML.{ id_name = gen_symbol ~prefix:"return" (); id_loc = E.dummy_loc } in
        List.map (E.s_value_binding b ^~ k) svb_list
    | Str_type (rec_flag, type_decl_list) ->
        let decl_desc = ML.DType (rec_flag, type_decl_list) in
        [ ML.{ decl_loc = loc; decl_desc } ]
    | Str_function f ->
        [ ML.{ decl_loc = loc; decl_desc = function_ f } ]
    | Str_prop p ->
        [ ML.{ decl_loc = loc; decl_desc = prop p } ]
    | _ -> [] (* TODO *)

  and s_structure s_str =
    List.flatten (List.map s_structure_item s_str)
  in

  (s_structure, s_signature)

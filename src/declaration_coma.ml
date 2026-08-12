open Ppxlib

module E = Expression_coma
module ML = Ml_lang

let (^~) a b = fun c -> a c b

let rec_flag b = if b then Recursive else Nonrecursive

let param (_loc, pre_id, _pty) = E.preid pre_id, None

let s_structure (* ml *), s_signature (* mli *) =
  let s_signature_item Gospel.Uast.{ sdesc; sloc } =
    let loc = E.location sloc in
    match sdesc with
    | Sig_val s_val ->
        ignore s_val; []
    | Sig_type (rec_flag, ty_decls) ->
        ignore (rec_flag, ty_decls); []
    | Sig_function f ->
        [ ML.{ decl_loc = loc; decl_desc = DFunction f } ]
    | _ -> assert false (* TODO *) in

  let condition (t : ML.U.s_type_declaration) =
    t.tmanifest = None &&
    (match t.tattributes with [_] -> true | _ -> false) in

  let s_structure_item Gospel.Uast.{ sstr_desc; sstr_loc } =
    let loc = E.location sstr_loc in
    match sstr_desc with
    | Str_value (b, svb_list) ->
        let k = E.gen_id ~prefix:"o" () in
        List.map (E.s_value_binding b ^~ k) svb_list
    | Str_type (_, [t]) when condition t -> (* TODO: fix this hack *)
        begin match t.tattributes with
        | [ {attr_name={txt="coma";_};
             attr_payload=PStr [ { pstr_desc=Pstr_eval ({ pexp_desc=Pexp_constant (Pconst_string (s,
             _, _)); _ }, _); _; } ] ; _}]
          ->
            let decl_desc = ML.DType2 (t.tname.txt, s) in
            [ ML.{ decl_loc = loc; decl_desc } ]
        | _ -> assert false
        end
    | Str_type (rec_flag, type_decl_list) ->
        let decl_desc = ML.DType (rec_flag, type_decl_list) in
        [ ML.{ decl_loc = loc; decl_desc } ]
    | Str_exception { ptyexn_constructor; _ } ->
      let name = E.mk_raise_name ptyexn_constructor.pext_name.txt in
      let arg_type = match ptyexn_constructor.pext_kind with
        | Pext_decl (_, Pcstr_tuple [ty], _) -> Some ty
        | _ -> None in
      Hashtbl.add E.exn_type_hmap name arg_type; []
    | Str_function f ->
        [ ML.{ decl_loc = loc; decl_desc = DFunction f } ]
    | Str_prop p ->
        [ ML.{ decl_loc = loc; decl_desc = DProp p } ]
    | _ -> [] (* TODO *) in

  let s_structure = List.concat_map s_structure_item in
  let s_signature = List.concat_map s_signature_item in
  (s_structure, s_signature)

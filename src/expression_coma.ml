open Ppxlib
open Gospel
open Ml_lang

let dummy_loc = Lexing.dummy_pos, Lexing.dummy_pos

let location {loc_start; loc_end; _} =
  (loc_start, loc_end)

let cst_true = CBool true
let cst_false = CBool false
let cst_num n = CNum n

let atom_true = ACst cst_true
let atom_false = ACst cst_false
let atom_num n = ACst (cst_num n)

let gen_id ?(loc=dummy_loc) () =
  { id_name = gen_symbol (); id_loc = loc}

let mk_atom ?(loc=dummy_loc) atom_desc =
  { atom_loc=loc ; atom_desc }

let mk_callable ?(loc=dummy_loc) callable_desc =
  { callable_loc=loc ; callable_desc }

let rec string_of_longident = function
  | Longident.Lident s -> s
  | Ldot (t, s) -> string_of_longident t ^ s
  | Lapply (t1, t2) -> string_of_longident t1 ^ string_of_longident t2

let mk_expr ?(loc=dummy_loc) expr_desc =
  { expr_loc=loc ; expr_desc }

let mk_pattern ?(loc=dummy_loc) ppat_desc =
  { ppat_loc=loc; ppat_desc }

let mk_decl (rec_flag, id, params, e) =
  { decl_loc  = id.id_loc;
    decl_desc = DFun (rec_flag, id, params, e); }

let mk_id ?(loc=dummy_loc) id_name =
  { id_name; id_loc=loc }

let eatom ?(loc=dummy_loc) a = EAtom (mk_atom ~loc a)

let get_pattern_id (pat: Parsetree.pattern) =
  match pat.ppat_desc with
  | Ppat_var {txt; loc} ->
      { id_name = txt; id_loc = location loc }
  | _ ->  assert false


let preid Uast.Preid.{ pid_str; pid_loc; _ } =
  mk_id ~loc:(location pid_loc) pid_str

let qualid = function
  | Uast.Qpreid id -> preid id
  | Uast.Qdot _ -> assert false

let mk_expr_atom ?(loc=dummy_loc) ad =
  mk_expr ~loc (eatom ~loc ad)

let constant = function
  | Pconst_integer (s, _) ->
      if s.[0] = '-' then
        let s = String.sub s 1 (String.length s - 1) in
        let n = Why3.Number.int_literal ILitDec ~neg:false s in
        let n = Why3.Number.neg_int n in
        let n = Why3.Number.to_small_integer n in
        atom_num n
      else
        let n = Why3.Number.int_literal ILitDec ~neg:false s in
        let n = Why3.Number.to_small_integer n in
        atom_num n
  | _ -> assert false

let rec term (t: Uast.term) =
  let loc = location t.term_loc in
  match t.term_desc with
    | Ttrue             -> mk_expr_atom ~loc atom_true
    | Tfalse            -> mk_expr_atom ~loc atom_false
    | Tconst c          -> mk_expr_atom ~loc (constant c)
    | Tpreid id         -> mk_expr_atom ~loc (AId (qualid id))
    | Tidapp (_, _)     -> assert false
    | Tfield (_, _)     -> assert false
    | Tapply (_, _)     -> assert false
    | Tinfix (_, _, _)  -> assert false
    | Tbinop (_, _, _)  -> assert false
    | Tnot _            -> assert false
    | Tif (_c, _t1, _t2)   ->
        (* let id = assert false in *)
        (* let c = term c in *)
        (* let l = ELet ( *)
        (* let t2 = term t2 in *)
        (* mk_expr ~loc (EIf (id, t1, t2)) *)
        assert false
    | Tquant (_, _, _)  -> assert false
    | Tattr (_, _)      -> assert false
    | Tlet (id, t1, t2) ->
        let id_loc = location id.pid_loc in
        let id = mk_pattern ~loc:id_loc (PVar (preid id)) in
        let t1 = term t1 in
        let t2 = term t2 in
        mk_expr ~loc (ELet (id, t1, t2))
    | Tcase (_, _)      -> assert false
    | Tcast (_, _)      -> assert false
    | Ttuple _          -> assert false
    | Trecord _         -> assert false
    | Tupdate (_, _)    -> assert false
    | Tscope (_, _)     -> assert false
    | Told _            -> assert false

let collect_params expr =
  let rec loop acc expr =
    match expr.Uast.spexp_desc with
    | Sexp_fun (_, None, pat, e, _) ->
        let arg = get_pattern_id pat in
        loop (arg :: acc) e
    | _ -> List.rev acc, expr
  in
  loop [] expr

let rec pattern (p: Parsetree.pattern) = match p.ppat_desc with
  | Ppat_any ->
      PWild
  | Ppat_var {txt; loc} ->
      PVar { id_name = txt; id_loc= location loc}
  | Ppat_construct ({txt; loc}, args) ->
      let args = match args with
        | Some ([], { ppat_desc = Ppat_tuple pl; _} ) ->
            List.map (fun p -> mk_pattern (pattern p)) pl
        | Some ([], p) -> [mk_pattern (pattern p)]
        | None -> []
        | _ -> assert false in
      let id = { id_name = string_of_longident txt; id_loc = location loc } in
      PCons (id, args)
  | Ppat_tuple pl ->
      let pl = List.map (fun p -> mk_pattern (pattern p)) pl in
      PTuple pl
  | Ppat_constant _
  | Ppat_interval (_, _)
  | Ppat_alias (_, _)
  | Ppat_variant (_, _)
  | Ppat_record (_, _)
  | Ppat_array _
  | Ppat_or (_, _)
  | Ppat_constraint (_, _)
  | Ppat_type _
  | Ppat_lazy _
  | Ppat_unpack _
  | Ppat_exception _
  | Ppat_extension _
  | Ppat_open (_, _) -> assert false

let is_atomic e =
  match e.Uast.spexp_desc with
  | Sexp_constant _ | Sexp_ident _ | Sexp_construct _ -> true
  | _ -> false

let construct_to_atom ?(loc=dummy_loc) c = match c with
  | ({ txt = Lident "true"; _ },  None) -> mk_atom ~loc atom_true
  | ({ txt = Lident "false"; _ }, None) -> mk_atom ~loc atom_false
  | ({ txt = Lident "()"; _ }, None) -> assert false
  | ({ txt; loc }, None) ->
      let id = {id_name = string_of_longident txt; id_loc = location loc} in
      mk_atom ~loc:id.id_loc (ACons (id, []))
  | ({ txt; loc }, Some Uast.{ spexp_desc = Sexp_tuple expr_list; _ }) ->
      let id = {id_name = string_of_longident txt; id_loc = location loc} in
      let l = List.map (fun e ->
        assert (is_atomic e); (* ANF assumption *)
        match e.spexp_desc with
        | Sexp_constant c ->
            mk_atom (constant c)
        | Sexp_ident {txt; loc} ->
            let loc = location loc in
            mk_atom ~loc @@
            AId { id_name = string_of_longident txt ; id_loc = loc}
        | Sexp_construct ({ txt; loc }, None) ->
            let loc = location loc in
            let id = {id_name = string_of_longident txt; id_loc = loc} in
            mk_atom ~loc @@
            ACons (id, [])
        | _ -> assert false (* TODO other construct cases with recursive call*)
      ) expr_list in
      mk_atom ~loc:id.id_loc (ACons (id, l))
  | (_id, Some _e) ->
      (* mk_eidapp (longident id.txt) [ expression info e ] *)
      assert false

(** CPS translation where [k] is a [CFun] callable *)
let rec expr (e: Uast.s_expression) k : expr_desc =
  let callk a = EApp (k, a, []) in
  let loc = location e.spexp_loc in
  match e.spexp_desc with
  | Sexp_constant c -> callk [mk_atom ~loc (constant c)]
  | Sexp_ident {txt; _} ->
      let id = { id_name = string_of_longident txt ; id_loc = loc} in
      callk [mk_atom ~loc (AId id)]
  | Sexp_ifthenelse (e1, e2, Some e3) when is_atomic e1 ->
      let kid = gen_id () in
      let aid = gen_id () in
      let a = match e1.spexp_desc with
        | Sexp_ident {txt; _} ->
             AId { id_name = string_of_longident txt ; id_loc = loc}
        | Sexp_constant _
        | Sexp_construct _ -> assert false (* impossible (type error) *)
        | _ -> assert false in
      let a  = mk_atom ~loc:(location e1.spexp_loc) a in
      let e2 = mk_expr ~loc:(location e2.spexp_loc) (expr2 e2 kid) in
      let e3 = mk_expr ~loc:(location e3.spexp_loc) (expr2 e3 kid) in
      ELetK (kid, aid,
             mk_expr @@ EApp (k, [mk_atom @@ AId aid], []),
             mk_expr @@ EIf (a,e2,e3))
  | Sexp_ifthenelse (e1, e2, Some e3) ->
      let kid = gen_id () in
      let e2 = mk_expr ~loc:(location e2.spexp_loc) (expr2 e2 kid) in
      let e3 = mk_expr ~loc:(location e3.spexp_loc) (expr2 e3 kid) in
      let z = gen_id ~loc:(location e1.spexp_loc) () in
      let z2 = gen_id () in
      let az2 = mk_atom (AId z2) in
      let kk = mk_callable @@
          CFun ([z],[],
                mk_expr @@ ELetK (kid, z2, mk_expr @@ EApp (k, [az2], []),
                mk_expr @@ EIf (mk_atom (AId z),e2,e3))) in
      expr e1 kk
  | Sexp_ifthenelse (_, _, None) -> assert false
  | Sexp_construct (l,e) ->
      let a = construct_to_atom (l,e) in
      callk [a]
  | Sexp_let (_, _, _)          -> assert false
  | Sexp_function _             -> assert false
  | Sexp_fun (_, _, _, _, _)    -> failwith "unreachable"
  | Sexp_apply (_, _)           -> assert false
  | Sexp_match (_, _)           -> assert false
  | Sexp_sequence (_, _)        -> assert false
  | Sexp_unreachable            -> assert false
  | Sexp_assert _               -> assert false
  (* TBC *)
  | Sexp_try (_, _)
  | Sexp_tuple _
  | Sexp_variant (_, _)
  | Sexp_record (_, _)
  | Sexp_field (_, _)
  | Sexp_setfield (_, _, _)
  | Sexp_array _
  | Sexp_while (_, _, _)
  | Sexp_for (_, _, _, _, _, _)
  | Sexp_constraint (_, _)
  | Sexp_coerce (_, _, _)
  | Sexp_send (_, _)
  | Sexp_new _
  | Sexp_setinstvar (_, _)
  | Sexp_override _
  | Sexp_letmodule (_, _, _)
  | Sexp_letexception (_, _)
  | Sexp_lazy _
  | Sexp_poly (_, _)
  | Sexp_object _
  | Sexp_newtype (_, _)
  | Sexp_pack _
  | Sexp_open (_, _)
  | Sexp_extension _
  | Sexp_letop _ -> assert false

(** CPS translation where [k] is a name *)
and expr2 (e: Uast.s_expression) k : expr_desc =
  let loc = location e.spexp_loc in
  let callk a =
    let k = mk_callable ~loc:k.id_loc (CId k) in
    EApp (k, a, []) in
  match e.spexp_desc with
  | Sexp_constant c -> callk [mk_atom ~loc (constant c)]
  | Sexp_ident {txt; _} ->
      let a = AId { id_name = string_of_longident txt ; id_loc = loc} in
      callk [mk_atom ~loc a]
  | Sexp_ifthenelse (e1, e2, Some e3) when is_atomic e1 ->
      let a = match e1.spexp_desc with
        | Sexp_ident {txt; _} ->
             AId { id_name = string_of_longident txt ; id_loc = loc}
        | Sexp_constant _
        | Sexp_construct _ -> assert false (* impossible (type error) *)
        | _ -> assert false in
      let a  = mk_atom ~loc:(location e1.spexp_loc) a in
      let e2 = mk_expr ~loc:(location e2.spexp_loc) (expr2 e2 k) in
      let e3 = mk_expr ~loc:(location e3.spexp_loc) (expr2 e3 k) in
      EIf (a,e2,e3)
  | Sexp_ifthenelse (e1, e2, Some e3) ->
      let e2 = mk_expr ~loc:(location e2.spexp_loc) (expr2 e2 k) in
      let e3 = mk_expr ~loc:(location e3.spexp_loc) (expr2 e3 k) in
      let z = gen_id ~loc:(location e1.spexp_loc) () in
      let kk = mk_callable @@
          CFun ([z],[],
                mk_expr @@ EIf (mk_atom (AId z),e2,e3)) in
      expr e1 kk
  | Sexp_ifthenelse (_, _, None) -> assert false
  | Sexp_construct (l,e) ->
      let a = construct_to_atom (l,e) in
      callk [a]
  | Sexp_let (Nonrecursive, _svb, _e) ->  assert false (* TODO *)
  | Sexp_let (Recursive, _svb, _e) ->  assert false (* TODO *)
  | Sexp_function _             -> assert false (* TODO *)
  | Sexp_apply (e, args) when is_atomic e ->
      let loc = location e.spexp_loc in
      let c = mk_callable ~loc @@ match e.spexp_desc with
        | Sexp_ident {txt; _} ->
             CId { id_name = string_of_longident txt ; id_loc = loc}
        | Sexp_constant _
        | Sexp_construct _ -> assert false (* impossible (type error) *)
        | _ -> assert false in
      let l = List.fold_right (fun (_,e) acc ->
        assert (is_atomic e);
        (* ANF assumption *)
        match e.Uast.spexp_desc with
        | Sexp_constant c ->
            mk_atom (constant c) :: acc
        | Sexp_ident {txt; loc} ->
            let loc = location loc in
            (mk_atom ~loc @@
             AId { id_name = string_of_longident txt ; id_loc = loc})
            :: acc
        | Sexp_tuple _ -> assert false (* TODO *)
        | Sexp_construct (l, e) ->
            let a = construct_to_atom (l,e) in
            a :: acc
        | _ -> assert false
      ) args [mk_atom (AId k)] in
      EApp  (c, l, [])

  | Sexp_apply (e, args) ->
      let _loc = location e.spexp_loc in
      let _l = List.map (fun (_,e) ->
        assert (is_atomic e); (* ANF assumption *)
        match e.spexp_desc with
        | Sexp_constant c ->
            mk_atom (constant c)
        | Sexp_ident {txt; loc} ->
            let loc = location loc in
            mk_atom ~loc @@
            AId { id_name = string_of_longident txt ; id_loc = loc}
        | Sexp_tuple _ -> assert false (* TODO *)
        | Sexp_construct (l, e) ->
            construct_to_atom (l,e)
        | _ -> assert false
      ) args in
      assert false
      (* EApp  (mk_expr ~loc @@ expr2 e k, l) *)
      (* let id_e = gen_id ~loc () in
      let kk =
        mk_expr_atom ~loc @@
        AFun (true, id_e, EApp (mk_expr_atom ~loc (AId id_e)))
      in
      expr e kk *)

  | Sexp_match (e, cases) when is_atomic e ->
      let a = match e.spexp_desc with
        | Sexp_constant c ->
            constant c
        | Sexp_ident {txt; _} ->
             AId { id_name = string_of_longident txt ; id_loc = loc}
        | _ -> assert false in
      let a  = mk_atom ~loc:(location e.spexp_loc) a in
      let cases = List.map
        (fun Uast.{spc_lhs; spc_rhs; _} ->
          let loc = location spc_rhs.spexp_loc in
          let ploc = location spc_lhs.ppat_loc in
          let pat = mk_pattern ~loc:ploc (pattern spc_lhs) in
          pat, mk_expr ~loc @@ expr2 spc_rhs k)
        cases in
      EMatch (a, cases)
  | Sexp_match (e, cases) ->
      let cases = List.map
        (fun Uast.{spc_lhs; spc_rhs; _} ->
          let loc = location spc_rhs.spexp_loc in
          let ploc = location spc_lhs.ppat_loc in
          let pat = mk_pattern ~loc:ploc (pattern spc_lhs) in
          pat, mk_expr ~loc @@ expr2 spc_rhs k)
        cases in
      let z = gen_id ~loc () in
      let kk = mk_callable @@
          CFun ([z],[],
                mk_expr @@ EMatch (mk_atom (AId z),cases)) in
      expr e kk
  | Sexp_unreachable            -> assert false
  | Sexp_assert _               -> assert false
  | Sexp_fun (_, _, _, _, _)    -> failwith "unreachable"
  (* TBC *)
  | _ -> assert false

and s_value_binding rec_flag (svb: Uast.s_value_binding) k =
  let id = get_pattern_id svb.spvb_pat in
  let params, pexp = collect_params svb.spvb_expr in
  let expr_loc = location svb.Uast.spvb_expr.spexp_loc in
  let body = mk_expr ~loc:expr_loc (expr2 pexp k) in
  let params = params @ [k] in
  mk_decl (rec_flag, id, params, body)

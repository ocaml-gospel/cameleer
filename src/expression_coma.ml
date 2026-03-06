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

let gen_kid ?(loc=dummy_loc) () =
  { id_name = gen_symbol ~prefix:"_k" (); id_loc = loc}

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

let mk_decl (rec_flag, id, params, konts, e, spec) =
  { decl_loc  = id.id_loc;
    decl_desc = DFun (rec_flag, id, params, konts, e, spec); }

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

(* TO BE REMOVED, debugging only *)
let rec identify e =
  let open Format in
  let pploc fmt l =
    let ({pos_lnum;pos_cnum;_},_) = location l in
    fprintf fmt "l%d, c%d" pos_lnum pos_cnum in
  match e.Uast.spexp_desc with
  | Sexp_ident {txt;_} -> eprintf "ident %s@." (string_of_longident txt)
  | Sexp_constant _ -> eprintf "constant@."
  | Sexp_let (_, _, _) -> eprintf "let@."
  | Sexp_function _ -> eprintf "function@."
  | Sexp_fun (_, _, _, _, _) -> eprintf "fun@."
  | Sexp_apply (e, _) -> eprintf "apply+(%a)..@." pploc e.spexp_loc; identify e
  | Sexp_match (_, _) -> eprintf "match@."
  | Sexp_try (_, _) -> eprintf "try@."
  | Sexp_tuple _ -> eprintf "tuple@."
  | Sexp_construct (_, _) -> eprintf "construct@."
  | Sexp_variant (_, _) -> eprintf "variant@."
  | Sexp_record (_, _) -> eprintf "record@."
  | Sexp_field (_, _) -> eprintf "field@."
  | Sexp_setfield (_, _, _) -> eprintf "setfield@."
  | Sexp_array _ -> eprintf "array@."
  | Sexp_ifthenelse (_, _, _) -> eprintf "ifthenelse@."
  | Sexp_sequence (_, _) -> eprintf "sequence@."
  | Sexp_while (_, _, _) -> eprintf "while@."
  | Sexp_for (_, _, _, _, _, _) -> eprintf "for@."
  | Sexp_constraint (_, _) -> eprintf "constraint@."
  | Sexp_coerce (_, _, _) -> eprintf "coerce@."
  | Sexp_send (_, _) -> eprintf "send@."
  | Sexp_new _ -> eprintf "new@."
  | Sexp_setinstvar (_, _) -> eprintf "setinstvar@."
  | Sexp_override _ -> eprintf "override@."
  | Sexp_letmodule (_, _, _) -> eprintf "letmodule@."
  | Sexp_letexception (_, _) -> eprintf "letexception@."
  | Sexp_assert _ -> eprintf "assert@."
  | Sexp_lazy _ -> eprintf "lazy@."
  | Sexp_poly (_, _) -> eprintf "poly@."
  | Sexp_object _ -> eprintf "object@."
  | Sexp_newtype (_, _) -> eprintf "newtype@."
  | Sexp_pack _ -> eprintf "pack@."
  | Sexp_open (_, _) -> eprintf "open@."
  | Sexp_letop _ -> eprintf "letop@."
  | Sexp_extension _ -> eprintf "extension@."
  | Sexp_unreachable -> eprintf "unreachable@."

let identify_fail e = identify e; assert false

let collect_params expr =
  let rec loop acc expr =
    match expr.Uast.spexp_desc with
    | Sexp_fun (_, None, pat, e, _) ->
        let arg = get_pattern_id pat in
        loop (arg :: acc) e
    | _ -> List.rev acc, expr
  in
  loop [] expr

let mk_kont kont_id spec =
  let mk_kont kont_pre = { kont_id; kont_pre } in
  let pre = match spec with
    | None -> []
    | Some U.{sp_post; _} -> sp_post in
  mk_kont pre

let pre_of_spec = function
  | None -> []
  | Some U.{sp_pre; _} -> sp_pre

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

  (** Returns [true] iff [e] is a constant/ident/construct/atomic-tuple. *)
let rec is_atomic e =
  match e.Uast.spexp_desc with
  | Sexp_constant _ | Sexp_ident _ | Sexp_construct (_, None) -> true
  | Sexp_construct (_, Some e) -> is_atomic e
  | Sexp_tuple el -> List.for_all is_atomic el
  | _ -> false

let is_binop, get_binop =
  let driver = Hashtbl.create 16 in
  List.iter
    (fun (x,y) -> Hashtbl.add driver x y)
    [ ("+", Some OPAdd);
      ("*", Some OPMult);
      ("-", Some OPMinus);
      ("/", Some OPDiv);
      ("infix mod", None);
      ("<=", Some OPLe);
      (">=", None);
      ("<", None);
      (">", None);
      ("<>", None);
      ("=", Some OPEq);
      ("infix ::", None);
      ("::", None);
      ("infix @", None);
      ("@", None) ];
  (fun s -> Hashtbl.mem driver s),
  (fun s -> Option.get @@ Hashtbl.find driver s)

let rec atom_of_construct ?(loc=dummy_loc) c = match c with
  | ({ txt = Lident "true"; _ },  None) -> mk_atom ~loc atom_true
  | ({ txt = Lident "false"; _ }, None) -> mk_atom ~loc atom_false
  | ({ txt = Lident "()"; _ }, None) -> assert false
  | ({ txt; loc }, None) ->
      let id = {id_name = string_of_longident txt; id_loc = location loc} in
      mk_atom ~loc:id.id_loc (ACons (id, []))
  | ({ txt; loc }, Some Uast.{ spexp_desc = Sexp_tuple expr_list; _ }) ->
      let id = {id_name = string_of_longident txt; id_loc = location loc} in
      let l = List.map atom_of_sexpr expr_list in
      mk_atom ~loc:id.id_loc (ACons (id, l))
  | ({ txt; loc }, Some e) ->
      let id = {id_name = string_of_longident txt; id_loc = location loc} in
      mk_atom ~loc:id.id_loc (ACons (id, [atom_of_sexpr e]))

and atom_of_sexpr e =
  if not (is_atomic e) then
    (Format.printf "ANF assumption broken@."; identify_fail e) else
  match e.Uast.spexp_desc with
  | Sexp_constant  c      -> mk_atom (constant c)
  | Sexp_construct (l, e) -> atom_of_construct (l,e)
  | Sexp_ident {txt; loc} ->
      let loc = location loc in
      let id = { id_name = string_of_longident txt ; id_loc = loc} in
      (mk_atom ~loc @@ AId id)
  | Sexp_tuple el ->
      let loc = location e.spexp_loc in
      let a = List.map atom_of_sexpr el in
      mk_atom ~loc (ATuple a)
  | _ -> assert false (* unreachable *)

type kont_type = KName of id | KExpr of callable

(** CPS translation where [k] is a [CFun] callable *)
let rec expr (e: Uast.s_expression) k : expr_desc =
  let expr_opt e kid =
    let loc = location e.Uast.spexp_loc in
    let e = expr e (KName kid) in
    mk_expr ~loc e in
  let callk a = match k with
    | KName k -> EApp (mk_callable ~loc:k.id_loc (CId k), a, [])
    | KExpr k -> EApp (k, a, []) in
  let loc = location e.spexp_loc in
  match e.spexp_desc with
  | Sexp_constant c -> callk [mk_atom ~loc (constant c)]

  | Sexp_ident {txt; _} ->
      let id = { id_name = string_of_longident txt ; id_loc = loc} in
      callk [mk_atom ~loc (AId id)]

  | Sexp_ifthenelse (e1, e2, Some e3) when is_atomic e1 ->
      let a = mk_atom ~loc:(location e1.spexp_loc) @@
        match e1.spexp_desc with
        | Sexp_ident {txt; _} ->
             AId { id_name = string_of_longident txt ; id_loc = loc}
        | Sexp_constant _
        | Sexp_construct _
        | Sexp_tuple _ ->
            assert false (* impossible (type error) *)
        | _ -> assert false in
      begin match k with
      | KName k -> EIf (a, expr_opt e2 k, expr_opt e3 k)
      | KExpr k ->
          let z   = gen_id () in
          let kid = gen_kid () in
          let e2  = expr_opt e2 kid in
          let e3  = expr_opt e3 kid in
          ELetK (kid, z,
                 mk_expr @@ EApp (k, [mk_atom @@ AId z], []),
                 mk_expr @@ EIf (a, e2, e3))
      end
  | Sexp_ifthenelse (e1, e2, Some e3) ->
      let z = gen_id ~loc:(location e1.spexp_loc) () in
      begin match k with
      | KName k ->
          let e2 = expr_opt e2 k in
          let e3 = expr_opt e3 k in
          let kk = mk_callable @@
            CFun ([z], [],
                  mk_expr @@ EIf (mk_atom (AId z),e2,e3)) in
          expr e1 (KExpr kk)
      | KExpr k ->
          let kid = gen_kid () in
          let e2  = expr_opt e2 kid in
          let e3  = expr_opt e3 kid in
          let z2  = gen_id () in
          let az2 = mk_atom (AId z2) in
          let kk  = mk_callable @@
            CFun ([z], [],
                  mk_expr @@ ELetK (kid, z2, mk_expr @@ EApp (k, [az2], []),
                  mk_expr @@ EIf (mk_atom (AId z),e2,e3))) in
          expr e1 (KExpr kk)
      end
  | Sexp_ifthenelse (_, _, None) -> assert false

  | Sexp_construct (l,e) ->
      let a = atom_of_construct (l,e) in
      callk [a]

  | Sexp_let (Nonrecursive, [svb], e2) ->
      let id = get_pattern_id svb.spvb_pat in
      let e1 = svb.spvb_expr in
      let loc1 = location e1.spexp_loc in
      let loc2 = location e2.spexp_loc in
      let body = mk_expr ~loc:loc2 @@ expr e2 k in
      let kid = gen_kid () in
      ELetK (kid, id, body,
             mk_expr ~loc:loc1 @@ expr e1 (KName kid))

  | Sexp_let (Nonrecursive, [], _) -> assert false
  | Sexp_let (Nonrecursive, svb::svbs, e2) ->
      let id = get_pattern_id svb.spvb_pat in
      let e1 = svb.spvb_expr in
      let loc1 = location e1.spexp_loc in
      let loc2 = location e2.spexp_loc in
      let e2 =
        { e with spexp_desc = Sexp_let (Nonrecursive, svbs, e1) } in
      let body = mk_expr ~loc:loc2 @@ expr e2 k in
      let kid = gen_kid () in
      ELetK (kid, id, body,
             mk_expr ~loc:loc1 @@ expr e1 (KName kid))

  | Sexp_let (Recursive, _svb, _e) -> assert false (* TODO *)

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([_;_] as args))
    when is_binop (string_of_longident txt) ->
      let st = string_of_longident txt in
      let op = get_binop st in
      let[@warning "-8"] [a1;a2] =
        List.map (fun (_, e) -> identify e; atom_of_sexpr e) args in
      let a1 = mk_expr ~loc:a1.atom_loc (EAtom a1) in
      let a2 = mk_expr ~loc:a2.atom_loc (EAtom a2) in
      let a = [mk_atom ~loc:a1.expr_loc @@ ABinop (a1, op, a2)] in
      let k = match k with
        | KName k -> mk_callable @@ CId k
        | KExpr k -> k in
      EApp (k, a, [])

  | Sexp_apply (e, args) when is_atomic e ->
      let loc = location e.spexp_loc in
      let c = mk_callable ~loc @@ match e.spexp_desc with
        | Sexp_ident {txt; _} ->
             CId { id_name = string_of_longident txt ; id_loc = loc}
        | Sexp_constant _ | Sexp_construct _ ->
            assert false (* impossible (type error) *)
        | _ -> assert false in
      let args = List.map (fun (_, e) -> atom_of_sexpr e) args in
      let k = match k with
        | KName k -> mk_callable @@ CId k
        | KExpr k -> k in
      EApp (c, args, [k])
  | Sexp_apply (e, args) ->
      let loc = location e.spexp_loc in
      let z = gen_id ~loc () in
      let args = List.map (fun (_, e) -> atom_of_sexpr e) args in
      let k = match k with
        | KName k -> mk_callable ~loc:k.id_loc @@ CId k
        | KExpr k -> k in
      let k = mk_callable ~loc @@
        CFun ([z],[], mk_expr @@ EApp (mk_callable @@ CId z, args, [k])) in
      expr e (KExpr k)

  | Sexp_match (e, cases) when is_atomic e ->
      let a = match e.spexp_desc with
        | Sexp_constant c     -> constant c
        | Sexp_ident {txt; _} ->
            AId { id_name = string_of_longident txt ; id_loc = loc}
        | _ -> assert false (* TODO tuples *) in
      let a = mk_atom ~loc:(location e.spexp_loc) a in
      let map k = List.map
        (fun Uast.{spc_lhs; spc_rhs; _} ->
          let loc = location spc_rhs.spexp_loc in
          let ploc = location spc_lhs.ppat_loc in
          let pat = mk_pattern ~loc:ploc (pattern spc_lhs) in
          pat, mk_expr ~loc @@ expr spc_rhs (KName k))
        cases in
      begin match k with
      | KName k -> EMatch ([a], map k)
      | KExpr k ->
          let aid = gen_id  () in
          let kid = gen_kid () in
          let cases = map kid in
          ELetK (kid, aid,
                 mk_expr @@ EApp (k, [mk_atom @@ AId aid], []),
                 mk_expr @@ EMatch ([a], cases))
      end

  | Sexp_match (e, cases) ->
      let map k = List.map
        (fun Uast.{spc_lhs; spc_rhs; _} ->
          let loc = location spc_rhs.spexp_loc in
          let ploc = location spc_lhs.ppat_loc in
          let pat = mk_pattern ~loc:ploc (pattern spc_lhs) in
          pat, mk_expr ~loc @@ expr spc_rhs (KName k))
        cases in
      begin match k with
      | KName k ->
          let z = gen_id ~loc () in
          let cases = map k in
          let kk = mk_callable @@
              CFun ([z],[],
                    mk_expr @@ EMatch ([mk_atom (AId z)],cases)) in
          expr e (KExpr kk)
      | KExpr k ->
          let kid = gen_kid () in
          let z   = gen_id  () in
          let z2  = gen_id  () in
          let az2 = mk_atom (AId z2) in
          let cases = map kid in
          let kk = mk_callable @@
            CFun ([z], [],
                  mk_expr @@ ELetK (kid, z2, mk_expr @@ EApp (k, [az2], []),
                  mk_expr @@ EMatch ([mk_atom (AId z)], cases))) in
          expr e (KExpr kk)
      end

  | Sexp_sequence (_, _)        -> assert false
  | Sexp_unreachable            -> assert false
  | Sexp_assert _               -> assert false
  | Sexp_function _             -> assert false (* TODO *)
  | Sexp_fun (_, _, _, _, _)    -> failwith "unreachable" (* its not true *)
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

and s_value_binding rec_flag (svb: Uast.s_value_binding) k =
  let id = get_pattern_id svb.spvb_pat in
  let params, pexp = collect_params svb.spvb_expr in
  let expr_loc = location svb.Uast.spvb_expr.spexp_loc in
  let body = mk_expr ~loc:expr_loc (expr pexp (KName k)) in
  let spec = svb.spvb_vspec in
  let kont = mk_kont k spec in
  let pre = pre_of_spec spec in
  mk_decl (rec_flag, id, params, pre, [kont], body)

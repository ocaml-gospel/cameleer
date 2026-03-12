open Ml_lang
open Ppxlib
open Why3
open Ptree
open Gospel
module E = Expression

let dummy_loc =
  let pos = { Lexing.dummy_pos with
    Lexing.pos_cnum = 0;
    pos_bol  = 0;
    pos_lnum = 1 } in
  (pos, pos)

let mk_id ?(loc=dummy_loc) id_name  = { id_name; id_loc = loc }

let gen_id ?(loc=dummy_loc) ?(prefix = "_x") () =
  mk_id ~loc (gen_symbol ~prefix ())

let binder (id, pty) =
  (id, Option.map E.core_type pty)

let rec pattern_to_args (p: Ml_lang.pattern) =
  match p.ppat_desc with
  | PVar id -> [id]
  | PCons (_, args) -> List.concat(List.map pattern_to_args args)
  | PWild -> [gen_id ~prefix:"_unused" ()]
  | PTuple ps -> List.concat(List.map pattern_to_args ps)
  | PCast (p, _) -> pattern_to_args p

let rec tpattern_to_args (p: Ml_lang.pattern) =
  (* problem here: we need the types! *)
  let rec loop (acc: core_type option) (p: Ml_lang.pattern) =
    match p.ppat_desc with
    | PVar id -> [id, acc]
    | PCons (_, args) -> List.concat(List.map tpattern_to_args args)
    | PWild -> [gen_id ~prefix:"_unused" (), acc]
    | PTuple ps -> List.concat (List.map tpattern_to_args ps)
    | PCast (p, t) -> loop (Some t) p in
  loop None p

(* ! PATTERN MATCHING HANDLERS CONSTRUCTION *)

(* FIXME: we should accept [t] together with a type *)

(* e.g. for `match t with Empty -> ... | Node(l,_,r) -> ...`
        args   = "[t]"
        cases = [("Empty", []); ("Node", ["l"; "_x__001_"; "r"])]   *)
type handler = {
  args:   Ml_lang.id list; (* FIXME: this should be [cbinder list] *)
  cases: (Ml_lang.id * Ml_lang.id list * Ml_lang.cprecondition) list;
}

let location loc =
  Location.{ loc_start = fst loc ; loc_end = snd loc; loc_ghost = false }

let mk_dummy_pre = [{ term_desc = Ttrue; term_loc = Loc.dummy_position }]

let ml_id_to_qualid (id : Ml_lang.id) : Uast.qualid =
  let preid = Identifier.Preid.create id.id_name ~loc:(location id.id_loc) in
  Uast.Qpreid preid

let mk_precondition (arg: Ml_lang.id) (case_id: Ml_lang.id) (vars: Ml_lang.id list) =
  Printf.eprintf "DEBUG mk_precondition: arg=%s case_id=%s vars=[%s]----------------------------------------\n%!"
    arg.id_name
    case_id.id_name
    (String.concat ", " (List.map (fun v -> v.id_name) vars));
  let mk_uast_term term_desc loc =
    let term_loc = location loc in
    Uast.{ term_desc; term_loc } in
  let arg_loc = arg.id_loc in
  let arg_term = mk_uast_term (Uast.Tpreid (ml_id_to_qualid arg)) arg_loc in
  let pp_term = match vars with
    | [] -> mk_uast_term (Uast.Tpreid (ml_id_to_qualid case_id)) case_id.id_loc
    | _ ->
        let vars_terms = List.map
          (fun v -> mk_uast_term (Uast.Tpreid (ml_id_to_qualid v)) v.id_loc)
          vars in
        let t = Uast.Tidapp (ml_id_to_qualid case_id, vars_terms) in
        mk_uast_term t case_id.id_loc in
  let eq_term = Identifier.Preid.create "infix =" ~loc:(location arg_loc) in
  let pre = mk_uast_term (Uast.Tinfix (arg_term, eq_term, pp_term)) arg_loc in
  [ Uterm.term false pre ]


(* Hashtable that stores handlers
   key: handler name (e.g. "destruct_height")
   value: handler record *)
let destructs = Hashtbl.create 10

let destructs_counter = Hashtbl.create 10

(* "t" -> "destruct_t" *)
let handler_name_of_id fn_name = "destruct_" ^ fn_name

(* Branch pattern as (case_name, bound_vars, preconditions) *)
let rec case_of_branch args (p : Ml_lang.pattern) =
  match p.ppat_desc with
  | PVar id ->
      let kont_id = mk_id ~loc:id.id_loc "default_case" in
      let var = gen_id ~loc:id.id_loc () in
      let pre = mk_precondition (List.hd args) var [] in
      (kont_id, [var], pre)
  | PCons (cid, ps) ->
      let vars = List.concat_map pattern_to_args ps in
      let pre = mk_precondition (List.hd args) cid vars in
      let id_name = String.uncapitalize_ascii cid.id_name in
      let id = mk_id ~loc:cid.id_loc id_name in
      (id, vars, pre)
  | PWild ->
      let kont_id = mk_id "default_case" in
      let var = gen_id ~prefix:"_unused" () in
      let pre = mk_precondition (List.hd args) var [] in
      (kont_id, [var], pre)
  | PTuple ps ->
      let sub_cases = List.mapi (fun i p ->
        let arg_i = [List.nth args i] in
        case_of_branch arg_i p
      ) ps in
      let name = String.concat "_" (List.map (fun (id,_,_) -> id.id_name) sub_cases) in
      let vars  = List.concat_map (fun (_,vars,_) -> vars) sub_cases in
      let pres = List.concat_map(fun (_,_,pre) -> pre) sub_cases in
      (mk_id ~loc:p.ppat_loc name, vars, pres)
  | PCast (p, _) -> case_of_branch args p

let fresh_handler_name fn_name =
  let n = match Hashtbl.find_opt destructs_counter fn_name with
    | None   -> 1
    | Some n -> n + 1 in
  Hashtbl.replace destructs_counter fn_name n;
  handler_name_of_id fn_name ^ string_of_int n

let register_handler fn_name a cases =
  let key = fresh_handler_name fn_name in
  let args = match a.atom_desc with
    | AId id -> [id]
    | ATuple al ->
        List.concat_map (fun a -> match a.atom_desc with
          | AId id -> [id]
          | _ -> failwith "A match expression must match on an identifier")
        al
    | _ -> failwith "A match expression must match on an identifier" in
  let cases = List.map (fun (p, _) -> case_of_branch args p) cases in
  Hashtbl.add destructs key { args; cases };
  key

(* ! DEALING WITH ATOMS, EXPRESSIONS AND DECLARATIONS *)

let rec atom fn_name { atom_loc; atom_desc } =
  let mk_catom catom_desc = { catom_loc = atom_loc; catom_desc } in
  let catom_desc = match atom_desc with
    | AId id -> CAId id
    | ACst c -> CACst c
    | ABinop (e1, op, e2) -> CABinop (expr fn_name e1, op, expr fn_name e2)
    | AUnop (op, e1) -> CAUnop (op, expr fn_name e1)
    | ATuple al -> CATuple (List.map (atom fn_name) al)
    | ACons (id, c) -> CACons (id, List.map (atom fn_name) c)
    | AFun (_, id, e) ->
        CAFun (binder id, expr fn_name e) in
  mk_catom catom_desc

and expr fn_name { expr_loc; expr_desc = e_desc } =
  let mk_cexpr cexpr_desc = { cexpr_loc = expr_loc; cexpr_desc } in
  let mk_ppat_expr (p, e) = (tpattern_to_args p, expr fn_name e) in
  let mk_id name loc = { id_name = name; id_loc = loc } in
  let mk_binder_cexpr (b, e) = (List.map binder b, e) in
  let expr_desc = function
    | EAtom a -> CEAtom (atom fn_name a)
    | EAssert -> CEAssert
    | ELet (x, e1, e2) ->
        CELet (pattern x, expr fn_name e1, expr fn_name e2) (* TODO *)
    | ELetK (k, x, e1, e2) ->
        CELetK (k, x, expr fn_name e1, expr fn_name e2) (* TODO *)
    | EApp (c, al, _cl) -> (* TODO *)
        let c = callable fn_name c in
        let cal = List.map (atom fn_name) al in
        let ccl = List.map (callable fn_name) _cl in
        CEApp (c, cal, ccl)
    | EIf (a, e1, e2) ->
        CEIf (atom fn_name a, expr fn_name e1, expr fn_name e2) (* TODO *)
    | EMatch (a, pel) ->
        let name  = register_handler fn_name a pel in
        let id    = mk_id name expr_loc in
        let catom = atom fn_name a in
        let cases = List.map mk_ppat_expr pel in
        let cases = List.map mk_binder_cexpr cases in
        CEDestruct (id, catom, cases) in
  mk_cexpr (expr_desc e_desc)

and callable fn_name { callable_loc; callable_desc } =
  let mk_ccalable ccallable_desc =
    { ccallable_loc = callable_loc; ccallable_desc } in
  let desc = match callable_desc with
    | CId id -> CCId id
    | CFun (data, kon, e) -> (* TODO: specification for the generated fun *)
        CCFun (List.map binder data, [], kon, expr fn_name e) in
  mk_ccalable desc

and pattern p =
  let cppat_desc =
    match p.ppat_desc with
    | PVar id -> CPVar id
    | PCons (id, args) -> CPCons (id, List.map pattern args)
    | PWild -> CPWild
    | PTuple ps -> CPTuple (List.map pattern ps)
    | PCast (p, pty) -> CPCast (pattern p, E.core_type pty) in
  { cppat_desc; cppat_loc=p.ppat_loc }

let declaration { decl_desc; decl_loc } =
  let mk_cdecl cdecl_desc = { cdecl_loc = decl_loc; cdecl_desc } in
  let mk_ckont { kont_id; kont_arg = (arg, pty); kont_pre } =
    { ckont_id  = kont_id;
      ckont_arg = arg, Option.map E.core_type pty;
      ckont_pre = List.map (Uterm.term false) kont_pre } in
  let cdecl = match decl_desc with
    | DFun (rec_flag, id, xs, pre, ks, e) ->
        let xs = List.map binder xs in
        let pre = List.map (Uterm.term false) pre in
        let ks  = List.map mk_ckont ks in
        CDFun (rec_flag, id, xs, pre, ks, (expr id.id_name e))
    | DType (rec_flag, td) -> CDType (rec_flag, td) in
  mk_cdecl cdecl

let program p = List.map declaration p

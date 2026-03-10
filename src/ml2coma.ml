open Ml_lang
open Ppxlib
open Why3
open Ptree
open Gospel

let dummy_loc =
  let pos = { Lexing.dummy_pos with
    Lexing.pos_cnum = 0;
    pos_bol  = 0;
    pos_lnum = 1 } in
  (pos, pos)

let gen_id ?(loc=dummy_loc) () = { id_name = gen_symbol (); id_loc = loc} 

let rec pattern_to_args (p: Ml_lang.pattern) =
  match p.ppat_desc with
  | PVar id -> [id]
  | PCons (_, args) -> List.concat(List.map pattern_to_args args)
  | PWild -> [gen_id ()]
  | PTuple ps -> List.concat(List.map pattern_to_args ps)
  | PCast (p, _) -> pattern_to_args p

(* ! PATTERN MATCHING HANDLERS CONSTRUCTION *)

(* e.g. for `match t with Empty -> ... | Node(l,_,r) -> ...`
        args   = "[t]"
        cases = [("Empty", []); ("Node", ["l"; "_x__001_"; "r"])]   *)
type handler = {
  args:   Ml_lang.id list;
  cases: (Ml_lang.id * Ml_lang.id list * Ml_lang.cprecondition) list;
}

let location loc = Location.{ loc_start = fst loc ; loc_end = snd loc; loc_ghost = false }

let mk_dummy_pre =[{ term_desc = Ttrue; term_loc = Loc.dummy_position }]

let ml_id_to_qualid (id : Ml_lang.id) : Uast.qualid =
  let preid = Identifier.Preid.create id.id_name ~loc:(location id.id_loc) in
  Uast.Qpreid preid

let mk_precondition (arg: Ml_lang.id) (case_id: Ml_lang.id) (vars: Ml_lang.id list) = 
  let mk_uast_term desc loc = { Uast.term_desc = desc; Uast.term_loc = location loc} in
  let arg_term = mk_uast_term (Uast.Tpreid (ml_id_to_qualid arg)) arg.id_loc in
  let pp_term = 
    match vars with 
    | [] -> mk_uast_term (Uast.Tpreid (ml_id_to_qualid case_id)) case_id.id_loc
    | _ -> let vars_terms = List.map (fun v -> mk_uast_term (Uast.Tpreid (ml_id_to_qualid v)) v.id_loc) vars in
           mk_uast_term (Uast.Tidapp (ml_id_to_qualid case_id, vars_terms)) case_id.id_loc in
  let eq_term = Identifier.Preid.create "infix =" ~loc:(location arg.id_loc) in
  let pre = mk_uast_term (Uast.Tinfix (arg_term, eq_term, pp_term)) arg.id_loc in
  [Uterm.term false pre]


(* Hashtable that stores handlers
   key: handler name (e.g. "destruct_height")
   value: handler record *)
let destructs = Hashtbl.create 10

(* "t" -> "destruct_t" *)
let handler_name_of_id fn_name = "destruct_" ^ fn_name

(* Branch pattern as (case_name, bound_vars, preconditions) *)
let rec case_of_branch args (p : Ml_lang.pattern) =
  let mk_id name loc = { id_name = name; id_loc = loc } in
  match p.ppat_desc with
  | PVar id ->
      let vars = [] in
      let pre = mk_precondition (List.hd args) id vars in
      (mk_id id.id_name id.id_loc, vars, pre)
  | PCons (cid, ps) ->
      let vars = List.concat_map pattern_to_args ps in
      let pre = mk_precondition (List.hd args) cid vars in
      (mk_id cid.id_name cid.id_loc, vars, pre)
  | PWild ->
      (mk_id "_" p.ppat_loc, [], [])
  | PTuple ps ->
      let sub_cases = List.map (case_of_branch args) ps in
      let name = String.concat "_" (List.map (fun (id,_,_) -> id.id_name) sub_cases) in
      let vars  = List.concat_map (fun (_,vars,_) -> vars) sub_cases in
      let pres = List.concat_map(fun (_,_,pre) -> pre) sub_cases in
      (mk_id name p.ppat_loc, vars, pres)
  | PCast (p, _) -> case_of_branch args p

let register_handler fn_name (atoms : atom list) cases =
  let key = handler_name_of_id fn_name in
  if not (Hashtbl.mem destructs key) then begin
    let args = List.map (fun a ->
      match a.atom_desc with
      | AId id -> id
      | _ -> failwith "A match expression must match on an identifier"
    ) atoms in
    Hashtbl.add destructs key
      { args; cases = List.map (fun (p, _) -> case_of_branch args p) cases }
  end

(* ! DEALING WITH ATOMS, EXPRESSIONS AND DECLARATIONS *)

let rec atom fn_name { atom_loc; atom_desc = a_desc } =
  let mk_catom catom_desc = { catom_loc = atom_loc; catom_desc } in
  let atom_desc = function
    | AId id -> CAId id
    | ACst c -> CACst c
    | ABinop (e1, op, e2) -> CABinop (expr fn_name e1, op, expr fn_name e2)
    | ATuple al -> CATuple (List.map (atom fn_name) al)
    | ACons (id, c) -> CACons (id, List.map (atom fn_name) c)
    | AFun (_, id, e) ->
        CAFun (id, expr fn_name e) in
        mk_catom (atom_desc a_desc)

and expr fn_name { expr_loc; expr_desc = e_desc } =
  let mk_cexpr cexpr_desc = { cexpr_loc = expr_loc; cexpr_desc } in
  let mk_ppat_expr (p, e) = (pattern_to_args p, expr fn_name e) in
  let expr_desc = function
    | EAtom a -> CEAtom (atom fn_name a)
    | EAssert -> CEAssert
    | ELet (x, e1, e2) ->
        CELet (pattern x, expr fn_name e1, expr fn_name e2) (* TODO *)
    | ELetK (k, x, e1, e2) ->
        CELetK (k, x, expr fn_name e1, expr fn_name e2) (* TODO *)
    | EApp (c, al, _cl) ->
        CEApp (callable fn_name c, List.map (atom fn_name) al, List.map (callable fn_name) _cl) (* TODO *)
    | EIf (a, e1, e2) ->
        CEIf (atom fn_name a, expr fn_name e1, expr fn_name e2) (* TODO *)
    | EMatch (al, pel) ->
        register_handler fn_name al pel;
        CEDestruct (List.map (atom fn_name) al, List.map mk_ppat_expr pel) in
  mk_cexpr (expr_desc e_desc)

and callable fn_name {callable_loc; callable_desc} =
  let mk_ccalable ccallable_desc =
    { ccallable_loc = callable_loc; ccallable_desc } in
  let desc = 
    match callable_desc with
    | CId id -> CCId id
    | CFun (data, kon, e) ->
        (* TODO: specification for the generated fun *)
        CCFun (data, [], kon, expr fn_name e) in 
  mk_ccalable desc

and pattern p =
  let desc =
    match p.ppat_desc with
    | PVar id -> CPVar id
    | PCons (id, args) -> CPCons (id, List.map pattern args)
    | PWild -> CPWild
    | PTuple ps -> CPTuple (List.map pattern ps)
    | PCast (p, pty) -> CPCast (pattern p, pty) in
  {cppat_loc = p.ppat_loc; cppat_desc = desc;}

let declaration d =
  let mk_cdecl cdecl_desc = { cdecl_loc = d.decl_loc; cdecl_desc } in
  let mk_ckont {kont_id; kont_pre} =
    {ckont_id = kont_id;
     ckont_pre = List.map (Uterm.term false) kont_pre} in
  let cdecl = match d.decl_desc with
    | DFun (rec_flag, id, xs, pre, ks, e) ->
        let pre = List.map (Uterm.term false) pre in
        let ks = List.map mk_ckont ks in
        CDFun (rec_flag, id, xs, pre, ks, (expr id.id_name e)) 
    | DType (rec_flag, td) -> CDType (rec_flag, td) in
  mk_cdecl cdecl

let program p = List.map declaration p

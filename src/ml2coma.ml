open Ml_lang

let rec pattern_to_args p =
  match p.ppat_desc with
  | PVar id -> [id]
  | PCons (_, args) -> List.concat(List.map pattern_to_args args)
  | PWild -> []
  | PTuple _ -> failwith "to be completed"

(* ! PATTERN MATCHING HANDLERS CONSTRUCTION *)

(* e.g. for `match t with Empty -> ... | Node(l,_,r) -> ...`
        arg   = "t"
        cases = [("is_empty", []); ("is_node", ["l"; "r"])]        *)
type handler = {
  arg:   id;
  cases: (id * id list) list;
}

(* Hashtable that stores handlers
    key: handler name (e.g. "destruct_height")
    value: handler record *)
let destructs = Hashtbl.create 10

(* "t" -> "destruct_t" *)
let handler_name_of_id fn_name = "destruct_" ^ fn_name

(* Branch pattern as (case_name, bound_vars) *)
let case_of_branch p =
  match p.ppat_desc with
  | PVar id         -> (id, [])
  | PCons (cid, ps) -> (cid, List.concat(List.map pattern_to_args ps))
  | PWild           -> ({ id_name = "_"; id_loc = p.ppat_loc }, [])
  | PTuple _ -> failwith "to be completed"

let register_handler fn_name a cases =
  match a.atom_desc with
  | AId id ->
      let key = handler_name_of_id fn_name in
      if not (Hashtbl.mem destructs key) then
        Hashtbl.add destructs key
          { arg = id; cases = List.map (fun (p,_) -> case_of_branch p) cases }
  | _ -> failwith "A match expression must match on an identifier"

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
    | EApp (f, al) ->
        CEApp (expr fn_name f, List.map (atom fn_name) al) (* TODO *)
    | EIf (a, e1, e2) ->
        CEIf (atom fn_name a, expr fn_name e1, expr fn_name e2) (* TODO *)
    | EMatch (a, pel) ->
        register_handler fn_name a pel;
        CEDestruct (atom fn_name a, List.map mk_ppat_expr pel) in
  mk_cexpr (expr_desc e_desc)

and pattern p =
  let desc =
    match p.ppat_desc with
    | PVar id -> CPVar id
    | PCons (id, args) -> CPCons (id, List.map pattern args)
    | PWild -> CPWild
    | PTuple _ -> failwith "to be completed" in
  {cppat_loc = p.ppat_loc; cppat_desc = desc;}

let declaration d =
  match d.decl_desc with
  | DFun (rec_flag, id, args, e) ->
      let desc = CDFun (rec_flag, id, args, (expr id.id_name e))
      in {cdecl_loc = d.decl_loc; cdecl_desc = desc}

let program p = List.map declaration p

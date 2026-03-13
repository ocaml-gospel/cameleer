open Ml_lang
open Ppxlib
open Why3
open Ptree
open Gospel
module Ut = Uterm
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

let rec tpattern_to_args ?(t=None) (p: Ml_lang.pattern) =
  (* problem here: we need the types! *)
  let rec loop (acc: core_type option) (p: Ml_lang.pattern) =
    match p.ppat_desc with
    | PVar id -> [id, acc]
    | PCons (_, args) -> List.concat(List.map (tpattern_to_args ~t:acc) args) (* FIXME not sure about this «acc» *)
    | PWild -> [gen_id ~prefix:"_unused" (), acc]
    | PTuple ps -> List.concat (List.map (tpattern_to_args ~t:acc) ps) (* FIXME not sure about this «acc» *)
    | PCast (p, t) -> loop (Some t) p in
  loop t p

(* ! PATTERN MATCHING HANDLERS CONSTRUCTION *)

(* FIXME: we should accept [t] together with a type *)

(* e.g. for `match t with Empty -> ... | Node(l,_,r) -> ...`
        args   = "[t]"
        cases = [("Empty", []); ("Node", ["l"; "_x__001_"; "r"])]   *)
type handler = {
  args:   Ml_lang.id list; (* FIXME: this should be [cbinder list] *)
  cases: (Ml_lang.id * (Ml_lang.id * pty option) list * Ml_lang.cprecondition) list;
}

let location loc =
  Location.{ loc_start = fst loc ; loc_end = snd loc; loc_ghost = false }

let mk_dummy_pre = [{ term_desc = Ttrue; term_loc = Loc.dummy_position }]

let ml_id_to_qualid (id : Ml_lang.id) : Uast.qualid =
  let loc = location id.id_loc in
  let preid = Identifier.Preid.create id.id_name ~loc in
  Uast.Qpreid preid

let mk_precondition (arg: Ml_lang.id) (case_id: Ml_lang.id)
  (vars: Ml_lang.binder list)
=
  (* Printf.eprintf "DEBUG mk_precondition: arg=%s case_id=%s vars=[%s]----------------------------------------\n%!"
    arg.id_name
    case_id.id_name
    (String.concat ", " (List.map (fun v -> v.id_name) vars)); *)
  let mk_uast_term term_desc loc =
    let term_loc = location loc in
    Uast.{ term_desc; term_loc } in
  let arg_loc = arg.id_loc in
  let arg_term = mk_uast_term (Uast.Tpreid (ml_id_to_qualid arg)) arg_loc in
  let pp_term = match vars with
    | [] -> mk_uast_term (Uast.Tpreid (ml_id_to_qualid case_id)) case_id.id_loc
    | _ ->
        let vars_terms = List.map
          (fun (v,_ty) ->
            mk_uast_term (Uast.Tpreid (ml_id_to_qualid v)) v.id_loc)
          vars in
        let t = Uast.Tidapp (ml_id_to_qualid case_id, vars_terms) in
        mk_uast_term t case_id.id_loc in
  let eq_term = Identifier.Preid.create "infix =" ~loc:(location arg_loc) in
  let pre = mk_uast_term (Uast.Tinfix (arg_term, eq_term, pp_term)) arg_loc in
  [ Uterm.term false pre ]


(* Hashtable that stores handlers
   key: handler name (e.g. "destruct_height")
   value: list of handler records *)
let destructs = Hashtbl.create 16

(* "t" -> "destruct_t" *)
let handler_name_of_id fn_name = "destruct_" ^ fn_name

(* Branch pattern as (case_name, bound_vars, preconditions) *)
let rec case_of_branch args (p : Ml_lang.pattern) =
  match p.ppat_desc with
  | PCast ({ppat_desc=PVar id; _}, t) ->
      let kont_id = mk_id ~loc:id.id_loc "default_case" in
      let var = gen_id ~loc:id.id_loc () in
      let b = binder (var, Some t) in
      let pre = mk_precondition (List.hd args) var [] in
      (kont_id, [b], pre)
  | PVar id ->
      (* FIXME:
         this case should be an error
         since we can reconstruct the type of the variable,
         which is required for Coma. *)
      let () = assert false in
      let kont_id = mk_id ~loc:id.id_loc "default_case" in
      let var = gen_id ~loc:id.id_loc () in
      let pre = mk_precondition (List.hd args) var [] in
      (kont_id, [var, None], pre)
  | PCast ({ppat_desc=PCons (cid, ps); _}, t) ->
      let vars = List.concat_map (tpattern_to_args ~t:(Some t) ) ps in
      let binders = List.map binder vars in
      let pre = mk_precondition (List.hd args) cid vars in
      let id_name = String.uncapitalize_ascii cid.id_name in
      let id = mk_id ~loc:cid.id_loc id_name in
      (id, binders, pre)
  | PCons (cid, ps) ->
      (* FIXME: same remark as in case [PVar id]? *)
      let vars = List.concat_map tpattern_to_args ps in
      let binders = List.map binder vars in
      let pre = mk_precondition (List.hd args) cid vars in
      let id_name = String.uncapitalize_ascii cid.id_name in
      let id = mk_id ~loc:cid.id_loc id_name in
      (id, binders, pre)
  | PCast ({ppat_desc=PWild; _}, t) ->
      let kont_id = mk_id "default_case" in
      let var = gen_id ~prefix:"_unused" () in
      let b = binder (var, Some t) in
      let pre = mk_precondition (List.hd args) var [] in
      (kont_id, [b], pre)
  | PWild ->
      (* FIXME: same remark as in case [PVar id]? *)
      let kont_id = mk_id "default_case" in
      let var = gen_id ~prefix:"_unused" () in
      let pre = mk_precondition (List.hd args) var [] in
      (kont_id, [var, None], pre)
  | PTuple ps ->
      let sub_cases = List.mapi (fun i p ->
        let arg_i = [List.nth args i] in
        case_of_branch arg_i p
      ) ps in
      let name = String.concat "_"
        (List.map (fun (id,_,_) -> id.id_name) sub_cases) in
      let vars = List.concat_map (fun (_,vars,_) -> vars) sub_cases in
      let pres = List.concat_map (fun (_,_,pre)  -> pre)  sub_cases in
      (mk_id ~loc:p.ppat_loc name, vars, pres)
  | PCast (p, _) -> case_of_branch args p

let register_handler fn_name a cases =
  let key = handler_name_of_id fn_name in
  let args = match a.atom_desc with
    | AId id -> [id]
    | ATuple al ->
        List.concat_map (fun a -> match a.atom_desc with
          | AId id -> [id]
          | _ -> failwith "A match expression must match on an identifier")
        al
    | _ -> failwith "A match expression must match on an identifier" in
  let new_handler = {
    args;
    cases = List.map (fun (p, _) -> case_of_branch args p) cases
  } in
  let (len, current) = match Hashtbl.find_opt destructs key with
    | None   -> 0, []
    | Some l -> l in
  let len = len + 1 in
  let full_name = Printf.sprintf "%s%d" key len in
  Hashtbl.replace destructs key (len, new_handler :: current);
  full_name

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

let td_params (cty, _) =
  match cty.ptyp_desc with
  | Ptyp_var s -> Ut.(mk_id ~id_loc:(location cty.ptyp_loc)) s
  | _ -> assert false

let mk_field ~mut:f_mutable ~ghost:f_ghost f_loc f_ident f_pty =
  { f_loc; f_ident; f_pty; f_mutable; f_ghost }

(** Visibility of type declarations. An alias type cannot be private, so we
    check whether or not the GOSPEL type manifest is [None]. *)
let td_private manifest private_ tkind =
  match (manifest, private_, tkind) with
  | Some _, _, _ -> Ptree.Public
  | _, _, Ptype_abstract -> Ptree.Abstract (* ???? Ptree.Private *)
  | _, Asttypes.Private, _ -> Ptree.Private
  | _, Asttypes.Public, _ -> Ptree.Public

let param_of_cty cty =
  let loc = Ut.location cty.ptyp_loc in
  (loc, None, false, E.core_type cty)

let field_of_label_decl lbl_decl =
  let is_ghost attributes =
    List.exists (fun { attr_name; _ } -> attr_name.txt = "ghost")
      attributes
  in
  let pld_mutable = lbl_decl.pld_mutable in
  let pld_id = lbl_decl.pld_name in
  let f_loc = Ut.location lbl_decl.pld_loc in
  let f_id = Ut.(mk_id ~id_loc:(location pld_id.loc) pld_id.txt) in
  let f_pty = E.core_type lbl_decl.pld_type in
  let mut = match pld_mutable with Mutable -> true | _ -> false in
  let ghost = is_ghost lbl_decl.pld_attributes in
  mk_field f_loc f_id f_pty ~mut ~ghost

(** Translate a list of OCaml constructors declaration into the corresponding
    Why3's Ptree algebraic constructors list. *)
let constructor_declaration params er { pcd_loc; pcd_name; pcd_args; _ } =
  let add_field acc lbl = field_of_label_decl lbl :: acc in
  let id_loc = Ut.location pcd_name.loc in
  let id = Ut.mk_id ~id_loc pcd_name.txt in
  let loc = Ut.location pcd_loc in
  match pcd_args with
  | Pcstr_tuple cty_list ->
      (* let construct_arith = List.length cty_list in *)
      (* Hashtbl.add info.O.info_arith_construct pcd_name.txt construct_arith; *)
      (loc, id, List.map param_of_cty cty_list)
  | Pcstr_record lbl_list ->
      let id_pty = String.uncapitalize_ascii pcd_name.txt ^ "_rec" in
      let id_pty = Ut.mk_id ~id_loc id_pty in
      let fields = List.fold_left add_field [] lbl_list in
      let fields = List.rev fields in
      Hashtbl.add er id_pty fields;
      let td_params = List.map (fun p -> PTtyvar p) params in
      let pty = PTtyapp (Qident id_pty, td_params) in
      let param = (loc, None, false, pty) in
      (loc, id, [ param ])

type embedded_record = { er_typ : type_def; er_rec : (ident * field list) list }

let mk_embedded_record ?(er_rec = []) er_typ = { er_typ; er_rec }

(** Convert a [Uast] type definition into a Why3's Ptree [type_def]. We follow
    the manifest-kind logic defined in the OCaml [Parsetree]. *)
let td_def params spec_fields td_manifest td_kind =
  let field Uast.{ f_preid; f_pty; f_mutable; _ } =
    let id_loc = Ut.location f_preid.pid_loc in
    let id = Ut.(mk_id ~id_loc f_preid.pid_str) in
    let pty = Ut.pty f_pty in
    mk_field id.id_loc id pty ~mut:f_mutable ~ghost:true
  in
  let add_reg_field lbl acc = field_of_label_decl lbl :: acc in
  match (td_manifest, td_kind) with
  | None, Ptype_abstract ->
      mk_embedded_record (TDrecord (List.map field spec_fields))
  | Some cty, Ptype_abstract -> mk_embedded_record (TDalias (E.core_type cty))
  | None, Ptype_variant cstr_list ->
      let er = Hashtbl.create 16 in
      let alg = List.map (constructor_declaration params er) cstr_list in
      let er_rec = Hashtbl.fold (fun id lbl acc -> (id, lbl) :: acc) er [] in
      mk_embedded_record (TDalgebraic alg) ~er_rec
  | None, Ptype_record lbl_list ->
      let model_fields = List.map field spec_fields in
      let all_fields = List.fold_right add_reg_field lbl_list model_fields in
      mk_embedded_record (TDrecord all_fields)
  | _ -> assert false
(* TODO *)

let type_decl Uast.({ tname; tspec; tmanifest; tkind; _ } as td) =
  let td_mut, invariant, spec_fields =
    match tspec with
    | None -> (false, [], [])
    | Some s -> (s.ty_ephemeral, s.ty_invariant, s.ty_field)
  in
  let td_loc = Ut.location td.tloc in
  let td_params = List.map td_params td.tparams in
  let td_vis = td_private tmanifest td.tprivate tkind in
  let td_inv = List.map (Uterm.term false) invariant in
  let mk_attr { attr_name; _ } = ATstr (Ident.create_attribute attr_name.txt) in
  let id_ats = List.map mk_attr td.tattributes in
  let rec_decl (td_ident, field_list) =
    {
      td_loc;
      td_ident;
      td_params;
      td_vis;
      td_mut;
      td_inv;
      td_wit = None;
      td_def = TDrecord field_list;
    }
  in
  let { er_typ; er_rec } = td_def td_params spec_fields tmanifest tkind in
  let main_def =
    {
      td_loc;
      td_params;
      td_vis;
      td_mut;
      td_inv;
      td_wit = None;
      td_def = er_typ;
      td_ident = Ut.(mk_id tname.txt ~id_ats ~id_loc:(location tname.loc));
    }
  in
  let rec_def = List.fold_left (fun acc fl -> rec_decl fl :: acc) [] er_rec in
  main_def :: rec_def

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
    | DType (_, td) ->
        let type_decls = List.map type_decl td in
        let decl = Dtype (List.flatten type_decls) in
        CDType decl in
  mk_cdecl cdecl

let program p = List.map declaration p

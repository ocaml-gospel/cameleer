open Ml_lang
open Ppxlib
open Why3
open Ptree
open Gospel

module Ut = Uterm
module E = Expression
module Ec = Expression_coma
module Ms = Map.Make(String)

open Location

let dummy_loc = Ec.dummy_loc
let (^~) f y = fun x -> f x y

let map_pty pty = Option.map E.core_type pty

let binder (id, pty) = (id, map_pty pty)

let rec tpattern_to_args ?(ty=None) (p: Ml_lang.pattern) =
  (* problem here: we need the types! *)
  let rec loop ty p =
    match p.Ml_lang.ppat_desc with
    | PVar id -> [id, ty]
    | PCst _n -> assert false
    | PCons (_, args) -> List.concat_map (tpattern_to_args ~ty) args (* FIXME not sure about this «acc» *)
    | PWild ->
        (* assert (ty <> None); *)
        [Ec.gen_id ~prefix:"_unused_ml2coma" (), ty]
    | PTuple ps -> List.concat_map (tpattern_to_args ~ty) ps (* FIXME not sure about this «acc» *)
    | PCast (p, t) -> loop (Some t) p in
  loop ty p

(* ! PATTERN MATCHING HANDLERS CONSTRUCTION *)

(* FIXME: we should accept [t] together with a type *)

(* e.g. for `match t with Empty -> ... | Node(l,_,r) -> ...`
        args   = "[t]"
        cases = [("Empty", []); ("Node", ["l"; "_x__001_"; "r"])]   *)
type handler = {
  args:   Ml_lang.cbinder list; (* FIXME: this should be [cbinder list] *)
  cases: (Ml_lang.id * (Ml_lang.id * pty option) list * Ml_lang.cprecondition) list;
}

let location loc =
  Location.{ loc_start = fst loc ; loc_end = snd loc; loc_ghost = false }

let mk_dummy_pre = [{ term_desc = Ttrue; term_loc = Loc.dummy_position }]

let ml_id_to_qualid (id : Ml_lang.id) : Uast.qualid =
  let loc = location id.id_loc in
  let preid = Identifier.Preid.create id.id_name ~loc in
  Uast.Qpreid preid

let mk_ccalable ?(loc=dummy_loc) ccallable_desc =
  { ccallable_loc = loc; ccallable_desc }

module TMP = struct
open Format
open Ml_lang
open Gospel
module UPrint = Upretty_printer

open Why3
module WPrint = Mlw_printer

let pp_cpre = (WPrint.pp_term ~attr:false).closed
let pp_pty = (WPrint.pp_pty ~attr:false).closed
let pp_type_decl = WPrint.pp_decl

let pp_cbinder fmt (id, pty) =
  match pty with
  | None -> fprintf fmt "%s" id.id_name
  | Some pty -> fprintf fmt "@[%s: %a@]" id.id_name pp_pty pty
end

let mk_precondition (arg: id) (case_id: id) (vars: Ml_lang.binder list list) =
  (* Printf.eprintf "DEBUG mk_precondition: arg=%s case_id=%s vars=[%s]----------------------------------------\n%!"
  arg.id_name
  case_id.id_name
  (String.concat ", "
    (List.concat_map (fun vs ->
      List.map (fun (v, _) -> v.id_name) vs) vars)); *)
  let mk_uast_term ~loc term_desc =
    Uast.{ term_desc; term_loc=loc } in
  let loc_l = location arg.id_loc in
  let loc_r = location case_id.id_loc in
  let lhs = mk_uast_term ~loc:loc_l (Uast.Tpreid (ml_id_to_qualid arg)) in
  let qid = ml_id_to_qualid case_id in
  let rhs_args = List.map (fun vs ->
    let vars_terms = List.map
      (fun ((v:Ml_lang.id),_ty) ->
        let loc = location v.id_loc in
        mk_uast_term ~loc (Uast.Tpreid (ml_id_to_qualid v)))
      vs in
    match vars_terms with
    | [] -> assert false
    | [x] -> x
    | xs -> mk_uast_term ~loc:loc_r (Uast.Ttuple xs)) vars in
  let rhs = match rhs_args with
    | [] -> mk_uast_term ~loc:loc_r (Uast.Tpreid qid)
    | rs -> mk_uast_term ~loc:loc_r (Uast.Tidapp (qid, rs)) in
  let eq_term = Identifier.Preid.create ~loc:loc_l "infix =" in
  let dif_term = Identifier.Preid.create ~loc:loc_l "infix <>" in
  let positive_pre = mk_uast_term ~loc:loc_l (Uast.Tinfix (lhs, eq_term, rhs)) in
  let negative_pre_bare = mk_uast_term ~loc:loc_l (Uast.Tinfix (lhs, dif_term, rhs)) in
  let negative_pre = match List.concat vars with
    | [] -> negative_pre_bare
    | bound_vars ->
        let binders = List.map (fun (v, _) ->
          let v = Identifier.Preid.create ~loc:loc_l v.id_name in
          (v, None)) bound_vars in
          mk_uast_term ~loc:loc_l (Uast.Tquant (Uast.Tforall, binders, negative_pre_bare)) in
  (Uterm.term false positive_pre, Uterm.term false negative_pre)

(* Hashtable that stores handlers
   key: handler name (e.g. "destruct_height")
   value: list of handler records *)
let destructs: (string, int * handler list) Hashtbl.t = Hashtbl.create 16

let handler_name_of_id fn_name = "destruct_" ^ fn_name

(* Branch pattern as (case_name, bound_vars, preconditions) *)
let rec case_of_branch ?(ty=None) args (p : Ml_lang.pattern) =
  match p.ppat_desc with
  | PCast (p, ty) -> case_of_branch ~ty:(Some ty) args p
  | PVar id ->
      let kont_id = Ec.mk_id ~loc:id.id_loc "default_case" in
      let var = Ec.gen_id ~loc:id.id_loc () in
      let b = binder (var, ty) in
      let (positive_pre, negative_pre) = mk_precondition (List.hd args) var [] in
      (kont_id, [b], [positive_pre], [negative_pre])
  | PCst _n -> assert false
  | PCons (cid, ps) ->
      let vars = List.map (tpattern_to_args ~ty) ps in
      let binders = List.map (List.map binder) vars in
      let (positive_pre, negative_pre) = mk_precondition (List.hd args) cid vars in
      let id_name = String.uncapitalize_ascii cid.id_name in
      let id_name = match id_name with
        | "::" -> "cons"
        | "[]" -> "nil"
        | _ -> id_name in
      let id = Ec.mk_id ~loc:cid.id_loc id_name in
      (id, List.flatten binders, [positive_pre], [negative_pre])
  | PWild ->
      let kont_id = Ec.mk_id "default_case" in
      let var = Ec.gen_id ~prefix:"_unused" () in
      let b = binder (var, ty) in
      let (positive_pre, negative_pre) = mk_precondition (List.hd args) var [] in
      (kont_id, [b], [positive_pre], [negative_pre])
  | PTuple ps ->
      let sub_cases = List.map2 (fun a p ->
        let arg_i = [a] in
        case_of_branch arg_i p
      ) args ps in
      let name = String.concat "_"
        (List.map (fun (id,_,_,_) -> id.id_name) sub_cases) in
      let vars = List.concat_map (fun (_,vars,_,_) -> vars) sub_cases in
      let pos_pres = List.concat_map (fun (_,_,pos,_) -> pos) sub_cases in
      let neg_pres = List.concat_map (fun (_,_,_,neg) -> neg) sub_cases in
      (Ec.mk_id ~loc:p.ppat_loc name, vars, pos_pres, neg_pres)

let register_handler fn_name a cases m =
  let key = handler_name_of_id fn_name in
  let args =
    let rec loop a =
      match a.atom_desc with
      | AId id ->
          let ty = try Ms.find id.id_name m with Not_found -> None in
          [ id, ty ]
      | ATuple al ->
          List.concat_map loop al
      | ACast (a,_) -> loop a
      | _ -> failwith "A match expression must match on an identifier" in
    loop a in

    let rec process_cases cases acc_pre =
      match cases with
      | [] -> []
      | (p, _) :: rest ->
          let case_id, vars, pos_pre, neg_pre = case_of_branch (List.map fst args) p in
          let case = (case_id, vars, pos_pre @ acc_pre) in
          let new_pre = acc_pre @ neg_pre in
          case :: process_cases rest new_pre in

  let cases = process_cases cases [] in
  let new_handler = {
    args;
    cases;
  } in
  let (len, current) = match Hashtbl.find_opt destructs key with
    | None   -> 0, []
    | Some l -> l in
  let len = len + 1 in
  let full_name = Printf.sprintf "%s%d" key len in
  Hashtbl.replace destructs key (len, new_handler :: current);
  full_name

(* ! DEALING WITH ATOMS, EXPRESSIONS AND DECLARATIONS *)

let rec atom fn_name { atom_loc; atom_desc } mty =
  let mk_catom catom_desc = { catom_loc = atom_loc; catom_desc } in
  let catom_desc = match atom_desc with
    | AId id -> CAId id
    | ACst c -> CACst c
    | ABinop (a1, op, a2) ->
        CABinop (atom fn_name a1 mty, op, atom fn_name a2 mty)
    | AUnop (op, a1) ->
        CAUnop (op, atom fn_name a1 mty)
    | ATuple al ->
        CATuple (List.map (atom fn_name ^~ mty) al)
    | ACons (id, c) ->
        CACons (id, List.map (atom fn_name ^~ mty) c)
    | AFun (_, id, e) ->
        CAFun (binder id, expr fn_name e mty)
    | ACast (a, t) ->
        CACast (atom fn_name a mty, E.core_type t) in
  mk_catom catom_desc

and expr fn_name { expr_loc; expr_desc = e_desc } (mty : pty option Ms.t) =
  let mk_pre tl = List.map (Ut.term false) tl in
  let mk_cexpr cexpr_desc =
    { cexpr_loc = expr_loc; cexpr_desc } in
  let mk_ppat_expr (p, e) =
    let info = tpattern_to_args p in
    let cexpr = expr fn_name e mty in
    (info, cexpr) in
  let mk_id name loc = { id_name = name; id_loc = loc } in
  let mk_binder_cexpr (b, e) = (List.map binder b, e) in
  let expr_desc = function
    | EFail -> CEFail
    | EAssert (phi,e) ->
        CEAssert (mk_pre phi, expr fn_name e mty)
    | EHide e -> CEHide (expr fn_name e mty)
    | ELet (x, a, e2) ->
        let ({id_name;_}, t) as x = binder x in
        let table = Ms.add id_name t mty in
        CELet (x, atom fn_name a mty, expr fn_name e2 table)
    | ELetK (k, x, None, e1, e2) ->
        Format.printf "---%a@." (Pp_ml_lang.pp_binder) x;
        let ({id_name;_}, t) as x = binder x in
        let types = Ms.add id_name t mty in
        CELetK (k, x, None, expr fn_name e1 types, expr fn_name e2 types)
    | ELetK (k, x, o, e1, e2) ->
        let ({id_name;_}, t) as x = binder x in
        let types = Ms.add id_name t mty in
        let o = Option.map (fun (x,t) -> x, E.core_type t) o in
        CELetK (k, x, o, expr fn_name e1 types, expr fn_name e2 types)
    | EApp (c, al, cl) ->
        let c = callable fn_name c mty in
        let cal = List.map (atom fn_name ^~ mty) al in
        let ccl = List.map (callable fn_name ^~ mty) cl in
        CEApp (c, cal, ccl)
    | EIf (a, e1, e2) ->
        CEIf (atom fn_name a mty,
              expr fn_name e1 mty,
              expr fn_name e2 mty) (* TODO *)
    | EMatch (a, pel) ->
        let name  = register_handler fn_name a pel mty in
        let id    = mk_id name expr_loc in
        let cid   = mk_ccalable ~loc:expr_loc @@ CCId id in
        let catom = atom fn_name a mty in
        let cases = List.map (fun pe ->
          let i,e = mk_ppat_expr pe |> mk_binder_cexpr in
          mk_ccalable ~loc:e.cexpr_loc @@ CCFun (i,[],e)) pel in
        CEApp (cid, [catom], cases) in
  mk_cexpr (expr_desc e_desc)

and callable fn_name { callable_loc=loc; callable_desc } types =
  let desc = match callable_desc with
    | CId id -> CCId id
    | CFun (data, kon, e) -> (* TODO: specification for the generated fun *)
        Format.printf "-%d-@." (List.length data);
        List.iter (fun b -> Format.printf "-->%a@." Pp_ml_lang.pp_binder b) data;
        CCFun (List.map binder data, kon, expr fn_name e types) in
  mk_ccalable ~loc desc

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
  let rec mk_ckont { kont_id; kont_arg; kont_kont; kont_pre } =
    let ckont_kont = List.map mk_ckont kont_kont in
    let ckont_arg = List.map (fun (i,t) -> i, Option.map E.core_type t) kont_arg in
    { ckont_id  = kont_id;
      ckont_arg;
      ckont_kont;
      ckont_pre = List.map (Uterm.term false) kont_pre } in
  let cdecl = match decl_desc with
    | DFun (rec_flag, id, xs, pre, ks, e) ->
        let xs = List.map binder xs in
        let b, pre = List.fold_left (fun (b,acc) e ->
          match e with
          | Uast.{ term_desc=Tbang; _ } -> true, acc
          | _ -> b, Uterm.term false e :: acc
        ) (false, []) pre in
        let ks  = List.map mk_ckont ks in
        let m = List.fold_left (fun acc (x, t) ->
          Ms.add x.id_name t acc) Ms.empty xs in
        CDFun (rec_flag, id, xs, (pre, b), ks, (expr id.id_name e m))
    | DType (_, td) ->
        let type_decls = List.map type_decl td in
        let decl = Dtype (List.flatten type_decls) in
        CDLogic decl
    | DFunction fd -> begin match Declaration.gospel_function fd with
        | Odecl.Odecl (_, fd) -> CDLogic fd
        | Odecl.Omodule (_, _, _) -> assert false end
    | DProp pd -> begin match Declaration.gospel_prop pd with
        | Odecl.Odecl (_, pd) -> CDLogic pd
        | Odecl.Omodule (_, _, _) -> assert false end
  in
  mk_cdecl cdecl

let program p = List.map declaration p

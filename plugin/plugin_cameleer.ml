open Why3
open Ptree
open Gospel
open Parser_frontend

let debug = ref false

open Why3.Typing
open Wstdlib
open Ident
open Cameleer
module Pm = Pmodule
module E = Cameleer.Expression
module T = Cameleer.Uterm

let print_modules = Debug.lookup_flag "print_modules"

let use_std_lib =
  let dummy_pos = Loc.dummy_position in
  let stdlib = Qdot (Qident (T.mk_id "ocamlstdlib"), T.mk_id "Stdlib") in
  let use_stdlib = Odecl.mk_duseimport dummy_pos ~import:false [stdlib, None] in
  [use_stdlib]

let mk_info () =
  let info = Odecl.empty_info () in
  Odecl.add_info info "Some" 1;
  Odecl.add_info info "::" 2;
  info

let read_file file nm c =
  let lb = Lexing.from_channel c in
  Location.init lb file;
  let ocaml_structure = parse_ocaml_structure_lb lb in
  parse_structure_gospel ocaml_structure nm

(* TODO: type-checking structure items *)
(* let type_check name nm structs =
 *   let md = Gospel.Tmodule.init_muc name in
 *   let penv = Gospel.Typing.penv [] (Gospel.Utils.Sstr.singleton nm) in
 *   let md = List.fold_left (Gospel.Typing.type_str_item penv) md structs in
 *   Gospel.Tmodule.wrap_up_muc md *)

let rec add_decl od =
  match od with
  | Odecl.Odecl (loc, d) ->
      Why3.Typing.add_decl loc d
  | Odecl.Omodule (loc, id, dl) ->
      Why3.Typing.open_scope id.id_loc id;
      List.iter add_decl dl;
      Why3.Typing.close_scope ~import:false loc

open Format

let rec pp_qualid fmt = function
  | Qident id -> fprintf fmt "%s" id.id_str
  | Qdot (q, id) -> fprintf fmt "%a.%s" pp_qualid q id.id_str

open Mod_subst

let mk_refine_modules info top_mod_name =
  let rec merge_qualid q = function
    | Qident id -> Qdot (q, id)
    | Qdot (q', id) -> Qdot (merge_qualid q q', id) in
  let open_module_id id = open_module id in
  let use_top_mod id =
    let ouse = Odecl.mk_duseimport Loc.dummy_position [id, None] in
    add_decl ouse in
  let top_mod_qualid = Qident (T.mk_id top_mod_name) in
  let mk_ref_q mod_name id = Qdot (mod_name, id) in
  let mk_clone_subst mod_refinee mod_refiner subst acc odecl =
    let open Odecl in
    let mk_id_refinee id = mk_ref_q mod_refinee id in
    let mk_id_refiner id = mk_ref_q mod_refiner id in
    let mk_id_ref id =
      let id = Ptree.{ id with id_loc = Loc.dummy_position } in (* FIXME *)
      (mk_id_refinee id, mk_id_refiner id) in
    let mk_cstsym id td_params = let id_refee, id_refer = mk_id_ref id in
      let pty_params = List.map (fun x -> PTtyvar x) td_params in
      CStsym (id_refee, td_params, PTtyapp (id_refer, pty_params)) in
    (* let mk_cspsym id = let id_refee, id_refer = mk_id_ref id in
     *   CSpsym (id_refee, id_refer) in *)
    match odecl with
    | Odecl (_, Dlet (id, _, _, _)) ->
        let id = { id with id_loc = Loc.dummy_position } in (* FIXME *)
        let id_refinee = mk_id_refinee id in
        let id_refiner = try (Mstr.find id.id_str subst.subst_ts).td_ident
          with Not_found -> id in
        let id_refiner = mk_id_refiner id_refiner in
        CSvsym (id_refinee, id_refiner) :: acc
    | Odecl (_, Dtype [{td_ident; td_params; _}]) ->
        mk_cstsym td_ident td_params :: acc
    | Odecl (_, Dlogic [{ld_ident; ld_type = None; _}]) ->
        let ld_id = { ld_ident with id_loc = Loc.dummy_position } in
        let id_refinee = mk_id_refinee ld_id in
        let id_refiner = try let id = Mstr.find ld_id.id_str subst.subst_ps in
          merge_qualid mod_refiner id
        with Not_found -> mk_id_refiner ld_id in
        CSpsym (id_refinee, id_refiner) :: acc
    | Odecl (_, Dlogic [{ld_ident; ld_type = Some _; _}]) ->
        let ld_id = { ld_ident with id_loc = Loc.dummy_position } in
        let id_refinee = mk_id_refinee ld_id in
        let id_refiner = try let id = Mstr.find ld_id.id_str subst.subst_fs in
          merge_qualid mod_refiner id
        with Not_found -> mk_id_refiner ld_id in
        CSfsym (id_refinee, id_refiner) :: acc
    | Odecl (_, Dexn (id, _, _)) ->
        let id = { id with id_loc = Loc.dummy_position } in
        let id_refinee = mk_id_refinee id in
        let id_refiner = mk_id_refiner id in
        CSxsym (id_refinee, id_refiner) :: acc
    | Odecl (_, Dprop (Decl.Paxiom, id, _)) ->
        let id = { id with id_loc = Loc.dummy_position } in
        CSlemma (mk_id_refinee id) ::acc
    | _ -> acc (* TODO *) in
  let mk_module refines_name info_refinement =
    let mod_id = "Refinement__" ^ refines_name in
    open_module_id (T.mk_id mod_id);
    use_top_mod top_mod_qualid;
    let mod_refinee = match info_refinement.Odecl.info_ref_name with
      | Some s -> s | None -> assert false (* TODO *) in
    let mod_refiner = Qident (T.mk_id refines_name) in
    let odecl_ref = info_refinement.Odecl.info_ref_decl in
    let subst = info_refinement.info_subst in
    let mk_subst = mk_clone_subst mod_refinee mod_refiner subst in
    let acc = [CSprop Decl.Paxiom] in
    let clone_subst = List.fold_left mk_subst acc odecl_ref in
    let odecl_clone = Odecl.mk_cloneexport top_mod_qualid clone_subst in
    add_decl odecl_clone;
    close_module Loc.dummy_position in
  Hashtbl.iter mk_module info.Odecl.info_refinement

let read_channel env path file c =
  if !debug then Format.eprintf "reading file '%s'@." file;
  let mod_name =
    let f = Filename.basename file in
    String.capitalize_ascii (Filename.chop_extension f) in
  let f = read_file file mod_name c in
  (* let f = type_check file mod_name f in *)
  open_file env path; (* This is the beginning of the Why3 file construction *)
  let id = T.mk_id mod_name in
  open_module id; (* This is the beginning of the top module construction *)
  let info = mk_info () in
  let f = Declaration.s_structure info f in
  let f = use_std_lib @ f in
  let rec pp_list pp fmt l = match l with
    | [] -> ()
    | x :: r -> Format.eprintf "%a" pp x; pp_list pp fmt r in
  let rec pp_decl fmt d = match d with
    | Odecl.Odecl (_loc, d) ->
        Format.fprintf fmt "%a@." (Mlw_printer.pp_decl ~attr:false) d
    | Odecl.Omodule (_loc, id, dl) ->
        Format.eprintf "@[<hv 2>scope %s@\n%a@]@\nend@." id.id_str
          (pp_list pp_decl) dl in
  if !debug then pp_list pp_decl (Format.err_formatter) f;
  List.iter add_decl f;
  close_module Loc.dummy_position; (* Closes the top module *)
  mk_refine_modules info mod_name;
  let mm = close_file () in
  if Debug.test_flag print_modules then begin
    let print_m _ m = Format.eprintf "%a@\n@." Pm.print_module m in
    let add_m _ m mm = Mid.add m.Pm.mod_theory.Theory.th_name m mm in
    Mid.iter print_m (Mstr.fold add_m mm Mid.empty)
  end;
  mm

let () =
  Env.register_format Pm.mlw_language "ocaml" ["ml"] read_channel
    ~desc:"OCaml format"

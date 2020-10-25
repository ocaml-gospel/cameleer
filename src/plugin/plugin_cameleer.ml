open Why3
open Ptree
open Gospel
open Parser_frontend

let debug = ref true

open Why3.Typing
open Wstdlib
open Ident
open Declaration
module Pm = Pmodule
module E = Expression
module T = Uterm

let print_modules = Debug.lookup_flag "print_modules"

let use_std_lib =
  let dummy_pos = Loc.dummy_position in
  (* let array = Qdot (Qident (T.mk_id "array"), T.mk_id "Array") in *)
  let stdlib = Qdot (Qident (T.mk_id "ocamlstdlib"), T.mk_id "OCamlStdLib") in
  (* let use_array = mk_duseimport dummy_pos ~import:false [array, None] in *)
  let use_stdlib = mk_duseimport dummy_pos ~import:false [stdlib, None] in
  [(* use_array;  *)use_stdlib]

let mk_info () =
  let info = E.empty_info () in
  E.add_info info "Some" 1;
  E.add_info info "::" 2;
  info

let read_file file nm c =
  let lb = Lexing.from_channel c in
  Location.init lb file;
  let ocaml_structure = parse_ocaml_structure_lb lb in
  parse_structure_gospel ocaml_structure nm

let type_check name nm structs =
  let md = Gospel.Tmodule.init_muc name in
  let penv = Gospel.Typing.penv [] (Gospel.Utils.Sstr.singleton nm) in
  let md = List.fold_left (Gospel.Typing.type_str_item penv) md structs in
  Gospel.Tmodule.wrap_up_muc md

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
  let f = s_structure info f in
  let f = use_std_lib @ f in
  let rec pp_list pp fmt l = match l with
    | [] -> ()
    | x :: r -> Format.eprintf "%a" pp x; pp_list pp fmt r in
  let rec pp_decl fmt d = match d with
    | Odecl (_loc, d) -> Format.fprintf fmt "%a@." Mlw_printer.pp_decl d
    | Omodule (_loc, id, dl) ->
        Format.eprintf "@[<hv 2>scope %s@\n%a@]@\nend@." id.id_str
          (pp_list pp_decl) dl in
  let rec add_decl od = match od with
    | Odecl (loc, d) ->
        Why3.Typing.add_decl loc d;
    | Omodule (loc, id, dl) ->
        Why3.Typing.open_scope id.id_loc id;
        List.iter add_decl dl;
        Why3.Typing.close_scope ~import:true loc in
  pp_list pp_decl (Format.err_formatter) f;
  List.iter add_decl f;
  close_module Loc.dummy_position; (* Closes the top module *)
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

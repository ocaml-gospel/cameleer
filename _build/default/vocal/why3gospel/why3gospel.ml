(**************************************************************************)
(*                                                                        *)
(*  GOSPEL -- A Specification Language for OCaml                          *)
(*                                                                        *)
(*  Copyright (c) 2018- The VOCaL Project                                 *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

open Format
open Why3
open Pmodule
open Typing
open Ident
open Wstdlib
open Ptree
open Why3gospel_trans
open Filename

let debug = ref true

let print_modules = Debug.lookup_flag "print_modules"

let mk_id ?(loc=Loc.dummy_position) name =
  { id_str = name; id_ats = []; id_loc = loc; }

let use ?(import=false) q =
  let id = match q with Qident id | Qdot (_, id) -> id in
  let loc = id.id_loc in
  Typing.open_scope loc id;
  let use_import = Duseimport (loc, import, [q, None]) in
  Typing.add_decl loc use_import;
  Typing.close_scope loc ~import

module I = Gospel.Longident
module T = Gospel.Tast

let extra_use ?(import=false) s =
  use ~import:true (Qdot (Qident (mk_id "gospel"), mk_id s))

let use_array loc =
  use ~import:true (Qdot (Qident (mk_id ~loc "array"), mk_id ~loc "Array"))

let read_file file nm c =
  let lb = Lexing.from_channel c in
  Gospel.Location.init lb file;
  let ocaml_signature = Gospel.Parser_frontend.parse_ocaml_signature_lb lb in
  Gospel.Parser_frontend.(parse_signature_gospel ocaml_signature nm)

let type_check name nm sigs =
  let md = Gospel.Tmodule.init_muc name in
  let penv = Gospel.Typing.penv [] (Gospel.Utils.Sstr.singleton nm) in
  let md = List.fold_left (Gospel.Typing.type_sig_item penv) md sigs in
  Gospel.Tmodule.wrap_up_muc md

module Ut = Gospel.Uast

(* extract additional uses and vals from file.mli.why3, if any *)
let extract_use sig_item = match sig_item.Ut.sdesc with
  | Ut.Sig_ghost_open {popen_lid = {txt = Lident s}} when s = "Gospelstdlib" ->
      None
  | Ut.Sig_ghost_open {popen_lid = {txt = Lident s}; popen_loc} ->
      Some s
  | _ -> None

let extract_vals m sig_item = match sig_item.Ut.sdesc with
  | Ut.Sig_val {vname; vtype} -> Mstr.add vname.txt vtype m
  | _ -> m

let include_extra_vals extra_vals sig_item = match sig_item.Ut.sdesc with
  | Ut.Sig_val ({vname} as sval) -> begin try
      let vtype = Mstr.find vname.txt extra_vals in
      {sig_item with sdesc = Ut.Sig_val {sval with vtype}}
    with Not_found -> sig_item end
  | _ -> sig_item

let read_extra_file file =
  let why3_file = file ^ ".why3" in
  if Sys.file_exists why3_file then begin
    let c = open_in why3_file in
    let nm =
      let f = Filename.basename file in
      String.capitalize_ascii (Filename.chop_extension f) in
    let f = read_file why3_file nm c in
    close_in c;
    Lists.map_filter extract_use f,
    List.fold_left extract_vals Mstr.empty f
  end else
    [], Mstr.empty

(* TODO equivalent clauses
let print_equiv file dl =
  let f_equiv = let file = file ^ ".equiv" in
    if Sys.file_exists file then begin
      let backup = file ^ ".bak" in Sys.rename file backup end;
    open_out file in
  let fmt_equiv = formatter_of_out_channel f_equiv in
  let print_args fmt = function
    | Lnone id -> fprintf fmt "%s" id.id_str
    | Lquestion id -> fprintf fmt "?%s" id.id_str
    | Lnamed id -> fprintf fmt "~%s" id.id_str
    | Lghost _ -> assert false in
  let print_decl fmt = function
    | Ddecl _ | Duse _ | Dmodule _ -> () (* FIXME: equiv inside sub-module? *)
    | Dequivalent (fid, argsl, body) ->
      fprintf fmt "let %s @[%a@]@ =@;<1 2>%s@\n@\n"
        fid.id_str (Pp.print_list Pp.space print_args) argsl body in
  List.iter (fun x -> print_decl fmt_equiv x) dl;
  fprintf fmt_equiv "@.";
  close_out f_equiv

let filter_equiv =
  let mk_equiv acc = function Dequivalent _ as e -> e::acc | _ -> acc in
  List.fold_left mk_equiv []
*)

let use_std_lib =
  let int63 = Qdot (Qdot (Qident (mk_id "mach"), mk_id "int"), mk_id "Int63") in
  let array =
    Qdot (Qdot (Qident (mk_id "mach"), mk_id "array"), mk_id "Array63") in
  let use_int63 = Duseimport (Loc.dummy_position, false, [int63, None]) in
  let use_array = Duseimport (Loc.dummy_position, false, [array, None]) in
  [Gdecl use_int63; Gdecl use_array;]

let read_channel env path file c =
  if !debug then eprintf "reading file '%s'@." file;
  let extra_uses, extra_vals = read_extra_file file in
  let nm =
    let f = Filename.basename file in
    String.capitalize_ascii (Filename.chop_extension f) in
  let f = read_file file nm c in
  let f = List.map (include_extra_vals extra_vals) f in
  let f = type_check file nm f in
  let sigs = Why3gospel_trans.signature f.fl_sigs in
  open_file env path;
  let id = mk_id (String.capitalize_ascii (chop_extension (basename file))) in
  open_module id;
  use_array id.id_loc;
  List.iter extra_use extra_uses;
  let rec add_decl = function
    | Gdecl d -> Typing.add_decl Loc.dummy_position d;
    | Gmodule (loc, id, dl) ->
       Typing.open_scope id.id_loc id;
       List.iter add_decl dl;
       Typing.close_scope ~import:true loc in
  let f = use_std_lib @ List.flatten sigs in (* FIXME *)
  (* For debugging only: *)
  let rec pp_list pp fmt l = match l with
    | [] -> ()
    | x :: r -> Format.eprintf "%a" pp x; pp_list pp fmt r in
  let rec pp_decl fmt d = match d with
    | Gdecl d -> Format.eprintf "%a@." Mlw_printer.pp_decl d
    | Gmodule (_loc, id, dl) ->
        Format.eprintf "@[<hv 2>scope %s@\n%a@]@\nend@." id.id_str
          (pp_list pp_decl) dl in
  pp_list pp_decl (Format.err_formatter) f;
  List.iter add_decl f;
  close_module Loc.dummy_position;
  let mm = close_file () in
  (* TODO *)
  (* let f = filter_equiv f in
   * if f <> [] then print_equiv file f; *)
  if Debug.test_flag print_modules then begin
    let print_m _ m = Format.eprintf "%a@\n@." print_module m in
    let add_m _ m mm = Mid.add m.mod_theory.Theory.th_name m mm in
    Mid.iter print_m (Mstr.fold add_m mm Mid.empty)
  end;
  mm

let () =
  Env.register_format mlw_language "gospel" ["mli"] read_channel
    ~desc:"GOSPEL format"

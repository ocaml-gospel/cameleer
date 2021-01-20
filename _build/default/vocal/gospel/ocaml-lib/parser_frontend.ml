(**************************************************************************)
(*                                                                        *)
(*  GOSPEL -- A Specification Language for OCaml                          *)
(*                                                                        *)
(*  Copyright (c) 2018- The VOCaL Project                                 *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

open Oparser
open Uattr2spec

exception Ocaml_syntax_error of Location.t

let () = Location.register_error_of_exn (function
             | Ocaml_syntax_error loc ->
                Some (Location.errorf ~loc "OCaml syntax error")
             | _ -> None )

let gospelstdlib = "Gospelstdlib"
let gospelstdlib_file = "gospelstdlib.mli"

let with_loadpath load_path file =
  let exception Break of string in
  let try_open d =
    try
      let f = Filename.concat d file in
      if Sys.file_exists f then raise (Break f)
    with Sys_error _ -> () in
  if file = gospelstdlib_file then file
  else if Filename.is_relative file then
    try List.iter try_open load_path; raise Not_found
    with Break c -> c
  else if Sys.file_exists file then file
  else raise Not_found

let parse_ocaml_signature_lb lb =
  try interface Olexer.token lb with
    Error -> begin
      let spos,fpos = lb.lex_start_p, lb.lex_curr_p in
      let loc = Location.{loc_start=spos; loc_end=fpos;loc_ghost=false}  in
      raise (Ocaml_syntax_error loc) end

let parse_ocaml_structure_lb lb =
  try implementation Olexer.token lb with
    Error -> begin
      let spos,fpos = lb.lex_start_p, lb.lex_curr_p in
      let loc = Location.{loc_start=spos; loc_end=fpos;loc_ghost=false}  in
      raise (Ocaml_syntax_error loc) end

let parse_ocaml_signature file =
  let lb =
    if file = gospelstdlib_file then
      Lexing.from_string Gospelstdlib.contents
    else
      open_in file |> Lexing.from_channel
  in
  Location.init lb file;
  parse_ocaml_signature_lb lb

let parse_ocaml_structure file =
  let lb = Lexing.from_channel (open_in file) in
  Location.init lb file;
  parse_ocaml_structure_lb lb

let default_open =
  let open Uast in
  let open Oparsetree in
  let od nm =
    let id = Location.{txt = Longident.Lident nm; loc = none} in
    let od = {popen_lid = id; popen_override = Fresh;
              popen_loc = Location.none; popen_attributes = []} in
    Sig_ghost_open od in
  {sdesc = od gospelstdlib; sloc = Location.none}

let default_open_str =
  let open Uast in
  let open Oparsetree in
  let od nm =
    let id = Location.{txt = Longident.Lident nm; loc = none} in
    let od = {popen_lid = id; popen_override = Fresh;
              popen_loc = Location.none; popen_attributes = []} in
    Str_ghost_open od in
  {sstr_desc = od gospelstdlib; sstr_loc = Location.none}

(** Parse the attributes as GOSPEL specification. *)
let parse_signature_gospel sign nm =
  if nm = gospelstdlib then signature sign else
    default_open :: signature sign

let parse_structure_gospel str nm =
  if nm = gospelstdlib then structure str else
  (* TODO: default open of stdlib as a structure item *)
  (* default_open_str :: *) structure str

let parse_ocaml_signature_gospel file =
  parse_ocaml_signature file |> parse_signature_gospel

let parse_ocaml_structure_gospel file =
  parse_ocaml_structure file |> parse_structure_gospel

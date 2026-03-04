open Format
open Gospel
open Parser_frontend
open Cameleer
module E = Cameleer.Expression
module T = Cameleer.Uterm

let fname = ref None
let debug = ref false
let coma = ref false

let spec =
  [
    ("--debug", Arg.Unit (fun () -> debug := true), "print debug information");
    ("--coma", Arg.Unit (fun () -> coma := true), "compile to Coma");
  ]

let usage_msg = sprintf "%s <file>.ml\nCompile <file> to Coma\n" Sys.argv.(0)

let usage () =
  Arg.usage spec usage_msg;
  exit 1

let set_file f =
  match !fname with
  | None when Filename.check_suffix f ".ml" -> fname := Some f
  | _ -> usage ()

let () = Arg.parse spec set_file usage_msg
let fname = match !fname with None -> usage () | Some f -> f

let read_file filename nm c =
  let lb = Lexing.from_channel c in
  Location.init lb filename;
  let ocaml_structure = parse_ocaml_structure_lb lb in
  parse_structure_gospel ~filename ocaml_structure nm

let main file c =
  if !debug then Format.eprintf "Reading file '%s'@." file;
  let mod_name =
    let f = Filename.basename file in
    String.capitalize_ascii (Filename.chop_extension f) in
  let f = read_file file mod_name c in
  let f = Declaration_coma.s_structure f in
  printf "%a@\n" (pp_print_list ~pp_sep:pp_print_newline Pp_ml_lang.pp_decl) f;

  if !coma then begin
    let fc = List.map Ml2coma.declaration f in
    printf "-------@\n";
    printf "%a@." Pp_coma.pp_program fc
  end

let () = main fname (open_in fname)

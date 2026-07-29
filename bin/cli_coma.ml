open Cameleer

module GP     = Gospel.Parser_frontend
module PPML   = Pp_ml_lang
module PPComa = Pp_coma

let fname = ref None
let debug = ref false
let coma = ref false
let compile_patterns = ref false

let spec =
  [
    ("--debug", Arg.Unit (fun () -> debug := true), "print debug information");
    ("--coma", Arg.Unit (fun () -> coma := true), "compile to Coma");
    ("--pat", Arg.Unit (fun () -> compile_patterns := true), "compile pattern matchings");
  ]

let usage_msg = Format.sprintf "%s <file>.ml\nCompile <file> to Coma\n" Sys.argv.(0)

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
  let ocaml_structure = GP.parse_ocaml_structure_lb lb in
  GP.parse_structure_gospel ~filename ocaml_structure nm

let main file c =
  if !debug then Format.eprintf "Reading file '%s'@." file;
  let mod_name =
    let f = Filename.basename file in
    String.capitalize_ascii (Filename.chop_extension f) in
  let f = read_file file mod_name c in
  let f = Declaration_coma.s_structure f in
  PPML.print_program f;
  let f = if not !compile_patterns then f else
    begin
      if !debug then Format.printf "== BEGIN PM@\n";
      let f = List.map Pattern_coma.compile_pattern f in
      if !debug then Format.printf "== END PM @\n";
      PPML.print_program f;
      f
    end in

  if !coma then begin
    let dir, file = Filename.(dirname file, basename file) in
    let f_coma = Filename.(concat dir (chop_extension file ^ ".coma")) in
    let fout =
      let cout = open_out f_coma in
      Format.formatter_of_out_channel cout in
    let fc = List.map Ml2coma.declaration f in
    let stdlist = [] in
    Format.fprintf fout "%a@." (PPComa.pp_program stdlist) fc
  end

let () = main fname (open_in fname)

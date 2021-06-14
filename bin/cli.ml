open Format

let fname = ref None
let debug = ref false
let viper = ref false

let path = Queue.create ()

let version = "0.1~dev"

let spec = [ "-L", Arg.String (fun s -> Queue.add s path),
             "add <dir> to the search path";
             "--debug", Arg.Unit (fun () -> debug := true),
             "print debug information";
             "--version",
             Arg.Unit (fun () -> printf "Cameleer %s@." version; exit 0),
             " print version information";
             "--viper", Arg.Unit (fun () -> viper := true),
             "translate OCaml program into Viper (experimental)"; ]

let usage_msg =
  sprintf "%s <file>.ml\n\
           Verify OCaml program\n" Sys.argv.(0)

let usage () = Arg.usage spec usage_msg; exit 1

let set_file f = match !fname with
  | None when Filename.check_suffix f ".ml" -> fname := Some f
  | _ -> usage ()

let () = Arg.parse spec set_file usage_msg

let fname = match !fname with None -> usage () | Some f -> f
let debug = if !debug then "--debug=print_modules" else ""

let path = Queue.fold (fun acc s -> sprintf "-L %s %s" s acc) "" path

let viper = !viper

let _ =
  if viper then begin
    Format.eprintf "It is Viper time!@.";
    let cin = open_in fname in
    let p = Vdecl.read_channel fname cin in
    let vp = Vdecl.Translate.s_structure p in
    let fbase = Filename.chop_extension fname in
    let cout = open_out (fbase ^ "_viper.vpr") in
    let fout = Format.formatter_of_out_channel cout in
    Format.fprintf fout "%a@." Vdecl.Print.pp_stdlib ();
    Format.fprintf fout "%a@." Vdecl.Print.pp_program vp;
    close_out cout;
    exit 0 end;
  exit (Sys.command (sprintf "why3 ide %s %s %s" fname path debug))

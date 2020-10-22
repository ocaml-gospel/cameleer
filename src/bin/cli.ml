open Format

let fname = ref None

let path = Queue.create ()

let version = "0.1~dev"

let spec = [ "-L", Arg.String (fun s -> Queue.add s path),
             "add <dir> to the search path";
             "--version",
             Arg.Unit (fun () -> printf "Cameleer %s@." version; exit 0),
             " print version information" ]

let usage_msg =
  sprintf "%s <file>.ml\n\
           Verify OCaml program\n" Sys.argv.(0)

let usage () = Arg.usage spec usage_msg; exit 1

let set_file f = match !fname with
  | None when Filename.check_suffix f ".ml" -> fname := Some f
  | _ -> usage ()

let () = Arg.parse spec set_file usage_msg

let fname = match !fname with None -> usage () | Some f -> f

let path = Queue.fold (fun acc s -> sprintf "-L %s %s" s acc) "" path

let _ =
  exit (Sys.command (sprintf "why3 ide %s %s" fname path))

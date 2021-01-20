# 1 "vocal/gospel/tools/gospelwc.mll"
 
  open Format

  let files = Queue.create ()

  type counter =
    { mutable spec: int; mutable code: int; mutable comment: int }

  let new_counter () =
    { spec = 0; code = 0; comment = 0 }

  let (+=) c1 c2 =
    c1.spec <- c1.spec + c2.spec;
    c1.code <- c1.code + c2.code;
    c1.comment <- c1.comment + c2.comment

  let reset c =  c.spec <- 0; c.code <- 0; c.comment <- 0

  let current_file = new_counter ()
  let grand_total  = new_counter ()

  let update_total () = grand_total += current_file

  type state = Nothing | Spec | Code | Comment
  let state = ref Nothing

  let new_line () = match !state with
    | Nothing -> ()
    | Spec    -> current_file.spec <- current_file.spec + 1
    | Code    -> current_file.code <- current_file.code + 1
    | Comment -> current_file.comment <- current_file.comment + 1


# 36 "vocal/gospel/tools/gospelwc.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\249\255\250\255\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\004\000\251\255\255\255\009\000\254\255\011\000\
    \000\000\252\255\000\000\001\000\000\000\000\000\002\000\001\000\
    \001\000\001\000\003\000\009\000\004\000\005\000\015\000\006\000\
    \021\000\016\000\252\255\253\255\003\000\014\000\018\000\006\000\
    \004\000\255\255\022\000\040\000\251\255\252\255\005\000\010\000\
    \046\000\020\000\022\000\011\000\255\255\052\000\254\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\005\000\005\000\005\000\005\000\005\000\
    \002\000\005\000\000\000\255\255\255\255\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\002\000\002\000\001\000\001\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\003\000\003\000\
    \003\000\002\000\002\000\255\255\255\255\255\255\255\255";
  Lexing.lex_default =
   "\002\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\000\000\000\000\255\255\000\000\255\255\
    \255\255\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\035\000\000\000\000\000\255\255\255\255\255\255\255\255\
    \255\255\000\000\255\255\045\000\000\000\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\000\000\255\255\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\008\000\015\000\014\000\013\000\012\000\015\000\
    \039\000\013\000\013\000\012\000\015\000\014\000\013\000\042\000\
    \015\000\037\000\038\000\042\000\039\000\037\000\050\000\042\000\
    \050\000\000\000\015\000\042\000\013\000\000\000\000\000\000\000\
    \009\000\013\000\010\000\015\000\041\000\041\000\042\000\054\000\
    \037\000\048\000\049\000\052\000\052\000\048\000\042\000\053\000\
    \040\000\000\000\036\000\053\000\040\000\053\000\051\000\000\000\
    \040\000\053\000\000\000\000\000\011\000\000\000\000\000\000\000\
    \048\000\000\000\000\000\000\000\000\000\000\000\053\000\000\000\
    \046\000\000\000\047\000\000\000\053\000\000\000\000\000\000\000\
    \051\000\000\000\000\000\000\000\000\000\000\000\051\000\000\000\
    \000\000\016\000\000\000\022\000\017\000\005\000\017\000\023\000\
    \029\000\032\000\026\000\017\000\017\000\004\000\020\000\028\000\
    \019\000\024\000\027\000\003\000\006\000\025\000\007\000\017\000\
    \021\000\018\000\030\000\031\000\017\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \034\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \044\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\008\000\008\000\010\000\010\000\008\000\
    \039\000\010\000\013\000\013\000\015\000\015\000\013\000\037\000\
    \015\000\033\000\033\000\037\000\038\000\033\000\049\000\042\000\
    \050\000\255\255\008\000\042\000\010\000\255\255\255\255\255\255\
    \000\000\013\000\009\000\015\000\036\000\040\000\037\000\046\000\
    \033\000\043\000\043\000\047\000\051\000\043\000\042\000\048\000\
    \037\000\255\255\033\000\048\000\038\000\053\000\049\000\255\255\
    \042\000\053\000\255\255\255\255\010\000\255\255\255\255\255\255\
    \043\000\255\255\255\255\255\255\255\255\255\255\048\000\255\255\
    \043\000\255\255\043\000\255\255\053\000\255\255\255\255\255\255\
    \048\000\255\255\255\255\255\255\255\255\255\255\053\000\255\255\
    \255\255\007\000\255\255\021\000\020\000\000\000\019\000\022\000\
    \028\000\003\000\025\000\031\000\016\000\000\000\005\000\004\000\
    \018\000\023\000\026\000\000\000\000\000\024\000\000\000\027\000\
    \005\000\006\000\029\000\030\000\032\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \033\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \043\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec scan lexbuf =
   __ocaml_lex_scan_rec lexbuf 0
and __ocaml_lex_scan_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 40 "vocal/gospel/tools/gospelwc.mll"
      ( state := Comment; comment lexbuf; scan lexbuf )
# 163 "vocal/gospel/tools/gospelwc.ml"

  | 1 ->
# 42 "vocal/gospel/tools/gospelwc.mll"
      ( new_line (); state := Nothing; scan lexbuf )
# 168 "vocal/gospel/tools/gospelwc.ml"

  | 2 ->
# 44 "vocal/gospel/tools/gospelwc.mll"
      ( new_line (); scan lexbuf )
# 173 "vocal/gospel/tools/gospelwc.ml"

  | 3 ->
# 46 "vocal/gospel/tools/gospelwc.mll"
      ( state := Code; scan lexbuf )
# 178 "vocal/gospel/tools/gospelwc.ml"

  | 4 ->
# 48 "vocal/gospel/tools/gospelwc.mll"
      ( state := Spec; spec lexbuf; scan lexbuf )
# 183 "vocal/gospel/tools/gospelwc.ml"

  | 5 ->
# 50 "vocal/gospel/tools/gospelwc.mll"
      ( scan lexbuf )
# 188 "vocal/gospel/tools/gospelwc.ml"

  | 6 ->
# 52 "vocal/gospel/tools/gospelwc.mll"
      ( )
# 193 "vocal/gospel/tools/gospelwc.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_scan_rec lexbuf __ocaml_lex_state

and spec lexbuf =
   __ocaml_lex_spec_rec lexbuf 33
and __ocaml_lex_spec_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 56 "vocal/gospel/tools/gospelwc.mll"
           ( () )
# 205 "vocal/gospel/tools/gospelwc.ml"

  | 1 ->
# 57 "vocal/gospel/tools/gospelwc.mll"
           ( new_line (); spec lexbuf )
# 210 "vocal/gospel/tools/gospelwc.ml"

  | 2 ->
# 58 "vocal/gospel/tools/gospelwc.mll"
           ( spec lexbuf )
# 215 "vocal/gospel/tools/gospelwc.ml"

  | 3 ->
# 59 "vocal/gospel/tools/gospelwc.mll"
           ( failwith "Unterminated specification block.\n" )
# 220 "vocal/gospel/tools/gospelwc.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_spec_rec lexbuf __ocaml_lex_state

and comment lexbuf =
   __ocaml_lex_comment_rec lexbuf 43
and __ocaml_lex_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 63 "vocal/gospel/tools/gospelwc.mll"
          ( () )
# 232 "vocal/gospel/tools/gospelwc.ml"

  | 1 ->
# 64 "vocal/gospel/tools/gospelwc.mll"
          ( comment lexbuf; comment lexbuf )
# 237 "vocal/gospel/tools/gospelwc.ml"

  | 2 ->
# 65 "vocal/gospel/tools/gospelwc.mll"
          ( new_line (); comment lexbuf )
# 242 "vocal/gospel/tools/gospelwc.ml"

  | 3 ->
# 66 "vocal/gospel/tools/gospelwc.mll"
          ( comment lexbuf )
# 247 "vocal/gospel/tools/gospelwc.ml"

  | 4 ->
# 67 "vocal/gospel/tools/gospelwc.mll"
          ( failwith "Unterminated comment.\n" )
# 252 "vocal/gospel/tools/gospelwc.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_comment_rec lexbuf __ocaml_lex_state

;;

# 69 "vocal/gospel/tools/gospelwc.mll"
 
  let legend =
    let first = ref true in
    fun () -> if !first then begin
      printf "    spec     code comments@."; first := false end

  let print_file file c =
    legend ();
    (* print spec, code and comments statistics *)
    printf "%8d" c.spec; printf " %8d" c.code; printf " %8d" c.comment;
    (* print file name *)
    printf " %s@." file

  let print_total () =
    print_file "total" grand_total

  let process_file f =
    let ch = open_in f in
    let lb = Lexing.from_channel ch in
    reset current_file; (* a new file begins *)
    scan lb; (* entry point for file scanning *)
    close_in ch;
    print_file f current_file;
    update_total ()

  (* Command line parsing and entry point for the program *)
  let spec = Arg.align [
    "-l", Arg.Unit (fun () -> ()), "count lines (default)"
  ]

  let add_file file =
    if not (Sys.file_exists file) then begin
      eprintf "%s: no such file@." file; exit 1
    end;
    Queue.add file files

  let usage = Format.sprintf "Usage: %s [options] files \n\n\
    Count lines in VOCAL source files.\n" (Filename.basename Sys.argv.(0))

  let () = Arg.parse spec add_file usage

  let () =
    Queue.iter process_file files;
    if Queue.length files <> 1 then print_total ()

# 305 "vocal/gospel/tools/gospelwc.ml"

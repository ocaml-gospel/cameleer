(* CPS --> COMA *)

open Format
open Ml_lang

open Gospel
module UPrint = Upretty_printer

(* some useful combinators *)
let pp_newline fmt () = fprintf fmt "@\n"
let pp_newline_newline fmt () = fprintf fmt "@\n@\n"
let pp_space fmt () = fprintf fmt " "
let pp_coma fmt () = fprintf fmt ", "

let pp_paren fmt () = fprintf fmt ". "

let protect_on b f =
  if b then "(" ^^ f ^^ ")"
  else f

let curly_braces b f =
  if b then "{" ^^ f ^^ "}"
  else f

let pp_constant fmt (c: constant) =
  match c with
  | CNum n -> fprintf fmt "%d" n
  | CBool b -> fprintf fmt "%b" b

let pp_op fmt (op: op) =
  match op with
  | OPAdd -> fprintf fmt "+"
  | OPMinus -> fprintf fmt "-"
  | OPMult -> fprintf fmt "*"
  | OPDiv -> fprintf fmt "/"
  | OPEq -> fprintf fmt "="
  | OPLe -> fprintf fmt "<="

let rec pp_pattern ?(_paren=false) fmt {cppat_desc; _} =
  let non_wild_args args = List.filter (fun p -> match p.cppat_desc with
    | CPWild -> false
    | _ -> true) args in
  match cppat_desc with
  | CPWild -> () (* FIXME? *)
  | CPVar x -> fprintf fmt "%s" x.id_name (* FIXME *)
  | CPCons (_, []) -> () (* TODO *)
  | CPCons (_, args) ->
      let al = non_wild_args args in
      fprintf fmt "@[fun %a@]@ "
        (pp_print_list ~pp_sep:pp_space pp_pattern) al
  | CPTuple args ->
      let al = non_wild_args args in
      fprintf fmt "@[fun %a@]@ "
        (pp_print_list ~pp_sep:pp_space pp_pattern) al

let pp_id ?(paren=false) fmt {id_name; _} = fprintf fmt (protect_on paren "%s") id_name

let rec pp_expr ?(_fn_name="") fmt (e: cexpr) =
  match e.cexpr_desc with
  | CEAtom a ->
      fprintf fmt "%a" (pp_atom ~paren:true ~curly:false) a
  | CEAssert -> fprintf fmt "fail"
  | CELet (x, e1, e2) ->
      fprintf fmt "let %a =@ @[<hov 2>%a@] in@ @[%a@]"
        (pp_pattern ~_paren:false) x
        (fun fmt e -> pp_expr fmt e) e1
        (fun fmt e -> pp_expr fmt e) e2 (* TODO *)
  | CEApp (f, al) ->
      fprintf fmt ("@[<hov 2>%a @[%a@]@]")
        (fun fmt e -> pp_expr fmt e) f
        (pp_print_list ~pp_sep:pp_space (pp_atom ~curly:true)) al
  | CEIf (a, e1, e2) ->
      fprintf fmt "if @[%a@] @\n (-> %a) @\n @[(-> %a)@]"
        (pp_atom ~paren:false ~curly:true) a
        (fun fmt e -> pp_expr fmt e) e1
        (fun fmt e -> pp_expr fmt e) e2 (* TODO *)
  | CEDestruct (a, pel) ->
      fprintf fmt "@[%s @[%a@]@\n@[%a@]@]"
        (Ml2coma.handler_name_of_id (_fn_name))
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:false ~curly:true)) a
        (pp_print_list ~pp_sep:pp_newline pp_ppat_cexpr) pel

and pp_atom ?(paren=false) ?(curly=false) fmt (a: catom) =
  match a.catom_desc with
  | CABinop (e1, op, e2) ->
      fprintf fmt
        (protect_on paren (curly_braces curly "@[%a %a %a@]"))
        (fun fmt e -> pp_expr fmt e) e1 pp_op op
        (fun fmt e -> pp_expr fmt e) e2 (* TODO *)
  | CACst c -> fprintf fmt (curly_braces curly "%a") pp_constant c
  | CAFun (x, e) ->
      fprintf fmt (protect_on true "@[fun %s -> @[<hov 2>%a@]@]")
        x.id_name
        (fun fmt e -> pp_expr fmt e) e
  | CAId x -> fprintf fmt (curly_braces curly "%s") x.id_name
  | CATuple al ->
      fprintf fmt "@[(%a)@]" (pp_print_list ~pp_sep:pp_coma pp_atom) al (* TODO *)
  | CACons (c, []) -> fprintf fmt "%s" c.id_name (* TODO *)
  | CACons (c, [a]) ->
      fprintf fmt (curly_braces curly "%s %a")
        c.id_name
        (pp_atom ~paren:false ~curly:true) a (* TODO *)
  | CACons (c, al) ->
      fprintf fmt (curly_braces curly "%s @[%a@]")
        c.id_name
        (pp_print_list ~pp_sep:pp_space (pp_atom ~curly:false)) al (* TODO *)

and pp_ppat_expr fmt (p, e) =
  fprintf fmt "@[<hov 2>(%a->@ @[%a@])@]"
    (pp_pattern ~_paren:false) p
    (fun fmt e -> pp_expr fmt e) e

and pp_ppat_cexpr fmt (p, e) =
  match p with
  | [] -> fprintf fmt "@[<hov 2>(->@ @[%a@])@]" (fun fmt e -> pp_expr fmt e) e
  | _ -> fprintf fmt "@[<hov 2>(fun %a->@ @[%a@])@] "
    (pp_print_list ~pp_sep:pp_space (fun fmt id -> pp_id fmt id)) p
    (fun fmt e -> pp_expr fmt e) e (* TODO *)

let pp_rec fmt = function
  | Asttypes.Recursive -> fprintf fmt " rec"
  | Nonrecursive -> ()

let pp_decl fmt (d: cdeclaration) =
  match d.cdecl_desc with
  | CDFun (rec_flag, id, args, e) ->
      fprintf fmt "@[<hov 2>letttttt%a %s %a =@\n%a@]"
        pp_rec rec_flag
        id.id_name
        (pp_print_list ~pp_sep:pp_space (fun fmt id -> pp_id fmt id)) args
        (fun fmt e -> pp_expr ~_fn_name:(id.id_name) fmt e) e
  | CDType (rec_flag, td) ->
      fprintf fmt "@[%a@]"
        UPrint.s_type_declaration_rec_flag (rec_flag, td)

let pp_handler_case fmt (case_id, vars) =
  match vars with
  | [] -> fprintf fmt "(%a)" (fun fmt id -> pp_id fmt id) case_id
  | _  -> fprintf fmt "(%a %a)"
            (fun fmt id -> pp_id fmt id) case_id
            (pp_print_list ~pp_sep:pp_space (fun fmt id -> pp_id ~paren:true fmt id)) vars

let pp_handler fmt name (h : Ml2coma.handler) =
  fprintf fmt "@[<hov 2>let %s %a@\n @[%a@]\n= any@]"
    name
    (pp_print_list ~pp_sep:pp_space (fun fmt id -> pp_id ~paren:true fmt id)) h.args
    (pp_print_list ~pp_sep:pp_newline pp_handler_case) h.cases

let pp_program fmt =
  Hashtbl.iter (fun name h ->
    pp_handler fmt name h;
    pp_newline_newline fmt ()
  ) Ml2coma.destructs;
  pp_print_list ~pp_sep:pp_newline_newline pp_decl fmt

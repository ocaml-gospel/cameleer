(* CPS --> COMA *)

open Format
open Ml_lang

open Gospel
module UPrint = Upretty_printer

open Why3
module WPrint = Mlw_printer

(* some useful combinators *)
let pp_newline fmt () = fprintf fmt "@\n"
let pp_newline_newline fmt () = fprintf fmt "@\n@\n"
let pp_space fmt () = fprintf fmt " "
let pp_coma fmt () = fprintf fmt ", "
let pp_and fmt () = fprintf fmt " && "
let pp_paren fmt () = fprintf fmt ". "

let protect_on b f =
  if b then "(" ^^ f ^^ ")"
  else f

let curly_braces b f =
  if b then "{" ^^ f ^^ "}"
  else f

let pp_op, pp_constant = Pp_ml_lang.(pp_op, pp_constant)

let pp_cpre = (WPrint.pp_term ~attr:false).closed
let pp_pty = (WPrint.pp_pty ~attr:false).closed

let pp_cpre fmt = function
  | [] -> ()
  | pre ->
      fprintf fmt "{@[%a@]}"
        (pp_print_list ~pp_sep:pp_and pp_cpre) pre

let rec pp_pattern ?(paren=false) fmt {cppat_desc; _} =
  let non_wild_args args = List.filter (fun p -> match p.cppat_desc with
    | CPWild -> false
    | _ -> true) args in
  match cppat_desc with
  | CPWild -> () (* FIXME? *)
  | CPVar x -> fprintf fmt "%s" x.id_name (* FIXME *)
  | CPCons (_, []) -> () (* TODO *)
  | CPCons (_, args) ->
      let al = non_wild_args args in
      fprintf fmt (protect_on paren "@[fun @[%a@]@]@ ")
        (pp_print_list ~pp_sep:pp_space pp_pattern) al
  | CPTuple args ->
      let al = non_wild_args args in
      fprintf fmt (protect_on paren "@[fun @[%a@]@]@ ")
        (pp_print_list ~pp_sep:pp_space pp_pattern) al
  | CPCast (p, pty) ->
      fprintf fmt "@[(%a: %a)@]" (pp_pattern ~paren) p pp_pty pty

let pp_id ?(paren=false) fmt {id_name; _} =
  fprintf fmt (protect_on paren "%s") id_name

let pp_cbinder ?(paren=false) fmt (id, pty) =
  match pty with
  | None -> fprintf fmt "%a" (pp_id ~paren) id
  | Some pty ->
      fprintf fmt "@[(%a: %a)@]" (pp_id ~paren) id
        pp_pty pty

let pp_pre fmt = function
  | [] -> ()
  | l ->
      fprintf fmt "{@[%a@]}"
        (pp_print_list ~pp_sep:pp_and UPrint.term) l

let rec pp_expr ?(_fn_name="") fmt (e: cexpr) =
  match e.cexpr_desc with
  | CEAtom a ->
      fprintf fmt "%a" (pp_atom ~paren:true ~curly:false) a
  | CEAssert -> fprintf fmt "fail"
  | CELet (x, e1, e2) ->
      fprintf fmt "@[%a@]@\n[%a : _todo_type_ =@ @[<hov 2>%a@]]"
        (pp_pattern ~paren:false) x
        (fun fmt e -> pp_expr fmt e) e1
        (fun fmt e -> pp_expr fmt e) e2
  | CEApp (c, al, cl) ->
      fprintf fmt ("@[<hov 2>%a @[%a %a@]@]")
        (pp_callable ~_fn_name) c
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:true ~curly:true)) al
        (pp_print_list ~pp_sep:pp_space (pp_callable ~_fn_name)) cl
  | CEIf (a, e1, e2) ->
      fprintf fmt "@[if @[%a@]@;<1 3>@[(-> @[%a@])@\n(-> @[%a@])@]@]"
        (pp_atom ~paren:false ~curly:true) a
        (fun fmt e -> pp_expr fmt e) e1
        (fun fmt e -> pp_expr fmt e) e2 (* TODO *)
  | CEDestruct (id, a, pel) ->
      fprintf fmt "@[%s @[%a@]@\n@[%a@]@]"
        (id.id_name)
        (pp_atom ~paren:false ~curly:true) a
        (pp_print_list ~pp_sep:pp_newline pp_ppat_cexpr) pel
  | CELetK(k, x, e1, e2) ->
      fprintf fmt "@[%a@]@ @[[ %s (%s: _todo_type_)@;<1 2>@[<hov 2>=@ %a@]@]"
        (fun fmt e -> pp_expr fmt e) e2
        k.id_name
        x.id_name
        (fun fmt e -> pp_expr fmt e) e1

and pp_atom ?(paren=false) ?(curly=false) fmt (a: catom) =
  match a.catom_desc with
  | CABinop (e1, op, e2) ->
      fprintf fmt
        (protect_on paren (curly_braces curly "@[%a %a %a@]"))
        (fun fmt e -> pp_expr fmt e) e1 pp_op op
        (fun fmt e -> pp_expr fmt e) e2 (* TODO *)
  | CAUnop (op, e1) ->
      fprintf fmt
        (protect_on paren (curly_braces curly "@[%a %a@]"))
        pp_op op (fun fmt e -> pp_expr fmt e) e1
  | CACst c -> fprintf fmt (curly_braces curly "%a") pp_constant c
  | CAFun (binder, e) ->
      fprintf fmt (protect_on true "@[fun @[%a@] -> @[<hov 2>%a@]@]")
        (pp_cbinder ~paren:true) binder
        (fun fmt e -> pp_expr fmt e) e
  | CAId x -> fprintf fmt (curly_braces curly "%s") x.id_name
  | CATuple al -> (* i think this should be curly braces *)
      fprintf fmt (curly_braces curly "@[(%a)@]")
        (pp_print_list ~pp_sep:pp_coma pp_atom) al (* TODO *)
  | CACons (c, []) -> fprintf fmt (curly_braces curly "%s") c.id_name (* TODO *)
  | CACons (c, [a]) ->
      fprintf fmt (curly_braces curly "%s %a")
        c.id_name
        (pp_atom ~paren:false ~curly:false) a (* TODO *)
  | CACons (c, al) ->
      fprintf fmt (curly_braces curly "%s @[%a@]")
        c.id_name
        (pp_print_list ~pp_sep:pp_space (pp_atom ~curly:false)) al (* TODO *)

and pp_callable ?(_fn_name="") fmt c =
  match c.ccallable_desc with
  | CCId id -> fprintf fmt "%s" id.id_name
  | CCFun (data, pre, kon, e) ->
      fprintf fmt (protect_on true "@[fun @[%a@]%s@[%a@]%s@[%a@]%s-> @[<hov 2>%a@]@]")
        (pp_print_list ~pp_sep:pp_space pp_cbinder) data
        (if data = [] && pre = [] then "" else " ")
        pp_pre pre
        (if kon = [] && pre = [] then "" else " ")
        (pp_print_list ~pp_sep:pp_space (pp_id ~paren:true)) kon
        (if kon = [] then "" else " ")
        (fun fmt e -> pp_expr fmt e) e

and pp_ppat_expr fmt (p, e) =
  fprintf fmt "@[<hov 2>(%a->@ @[%a@])@]"
    (pp_pattern ~paren:false) p
    (fun fmt e -> pp_expr fmt e) e

and pp_ppat_cexpr fmt (p, e) =
  fprintf fmt "@[<hov 2>(%s@[%a@]%s->@ @[%a@])@] "
    (if p = [] then "" else "fun ")
    (pp_print_list ~pp_sep:pp_space pp_cbinder) p
    (if p = [] then "" else " ")
    (fun fmt e -> pp_expr fmt e) e (* TODO *)

let pp_rec fmt = function
  | Asttypes.Recursive -> fprintf fmt " rec"
  | Nonrecursive -> ()

let pp_kont fmt {ckont_id; ckont_pre; ckont_arg} =
  fprintf fmt (protect_on true "@[%a @[%a@] @[%a@]@]")
    (pp_id ~paren:false) ckont_id
    (pp_cbinder ~paren:false) ckont_arg
    pp_cpre ckont_pre

let pp_decl fmt (d: cdeclaration) =
  match d.cdecl_desc with
  | CDFun (rec_flag, id, xs, pre, ks, e) ->
      fprintf fmt "let%a %s @[%a@]@;<1 4>@[%a@]@;<1 4>@[%a@]@\n= @[%a@]"
        pp_rec rec_flag
        id.id_name
        (pp_print_list ~pp_sep:pp_space pp_cbinder) xs
        pp_cpre pre
        (pp_print_list ~pp_sep:pp_space pp_kont) ks
        (pp_expr ~_fn_name:id.id_name) e
  | CDType (rec_flag, td) ->
      fprintf fmt "@[%a@]"
        UPrint.s_type_declaration_rec_flag (rec_flag, td)

let pp_handler_case fmt (case_id, vars, pre) =
  match vars with
  | [] ->
      fprintf fmt "(%a %a)" (pp_id ~paren:false) case_id pp_cpre pre
  | _ ->
      fprintf fmt "(%s @[%a@ %a@])"
        case_id.id_name
        (pp_print_list ~pp_sep:pp_space (pp_id ~paren:true)) vars
        pp_cpre pre

let pp_handler fmt name (h : Ml2coma.handler) =
  fprintf fmt "@[<hov 2>let %s %a@\n @[%a@]\n= any@]"
    name
    (pp_print_list ~pp_sep:pp_space (pp_id ~paren:true)) h.args
    (pp_print_list ~pp_sep:pp_newline pp_handler_case) h.cases

let pp_program fmt =
  Hashtbl.iter (fun name h ->
    pp_handler fmt name h;
    pp_newline_newline fmt ()
  ) Ml2coma.destructs;
  pp_print_list ~pp_sep:pp_newline_newline pp_decl fmt


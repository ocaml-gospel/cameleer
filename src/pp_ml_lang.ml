open Format
open Ml_lang

open Gospel
module UPrint = Upretty_printer

(* some useful combinators *)
let pp_newline fmt () = fprintf fmt "@\n"
let pp_newline_newline fmt () = fprintf fmt "@\n@\n"
let pp_space fmt () = fprintf fmt " "
let pp_coma fmt () = fprintf fmt ", "

let protect_on b f =
  if b then "(" ^^ f ^^ ")"
  else f

let pp_constant fmt (c: constant) =
  match c with
  | CNum n -> fprintf fmt "%d" n
  | CBool b -> fprintf fmt "%b" b
  | CUnit -> fprintf fmt "()"

let pp_op fmt (op: op) =
  match op with
  | OPAdd -> fprintf fmt "+"
  | OPMinus -> fprintf fmt "-"
  | OPMult -> fprintf fmt "*"
  | OPDiv -> fprintf fmt "/"
  | OPEq -> fprintf fmt "="
  | OPLe -> fprintf fmt "<="
  | OPMod -> fprintf fmt "%%"
  | OPLt -> fprintf fmt "<"
  | OPGe -> fprintf fmt ">="
  | OPGt -> fprintf fmt ">"
  | OPAnd -> fprintf fmt "&&"
  | OPOr -> fprintf fmt "||"
  | OPNot -> fprintf fmt "not"

let pp_id fmt id =
  fprintf fmt "%s" id.id_name

let pp_binder fmt (id, pty) =
  match pty with
  | None -> fprintf fmt "%a" pp_id id
  | Some pty ->
      ignore pty; (* TODO: print type *)
      fprintf fmt "%a: ..." pp_id id
  
let rec pp_pattern ?(paren=false) fmt {ppat_desc; _} =
  match ppat_desc with
  | PWild ->
      fprintf fmt "_"
  | PVar x ->
      fprintf fmt "%s" x.id_name
  | PCons (id, []) ->
      fprintf fmt "%s" id.id_name
  | PCons (id, [a]) ->
      fprintf fmt "%s %a" id.id_name (pp_pattern ~paren:true) a
  | PCons (id, args) ->
      fprintf fmt (protect_on paren "%s @[(%a)@]") id.id_name
        (pp_print_list ~pp_sep:pp_coma pp_pattern) args
  | PTuple (args) ->
      fprintf fmt (protect_on paren "@[%a@]")
        (pp_print_list ~pp_sep:pp_coma pp_pattern) args
  | PCast (p, _) ->
      fprintf fmt (protect_on paren "@[%a: ...@]")
        (pp_pattern ~paren:true) p

let rec pp_expr fmt (e: expr) =
  match e.expr_desc with
  | EAtom a ->
      fprintf fmt "%a" (pp_atom ~paren:true) a
  | EAssert ->
      fprintf fmt "fail"
  | ELet (x, e1, e2) ->
      fprintf fmt "let %a =@;<1 2>@[%a@]@ in@ @[%a@]"
        (pp_pattern ~paren:false) x pp_expr e1 pp_expr e2
  | EApp (c, al, cl) ->
      fprintf fmt "@[<hov 2>%a @[%a@] @[%a@]@]" pp_callable c
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:true)) al
        (pp_print_list ~pp_sep:pp_space pp_callable) cl
  | EIf (a, e1, e2) ->
      fprintf fmt "if@ %a@ @[then@;<1 2>@[%a@]@\nelse@;<1 2>@[%a@]@]"
      (* "if @[%a@] then@;<1 2>@[%a@]@ else@;<1 2>@[%a@]" *)
        (pp_atom ~paren:false) a pp_expr e1 pp_expr e2

  | EMatch (a, pel) ->
      (* List.iter (fun (p, _) ->
        Format.eprintf "DEBUG pattern: %a\n%!" (pp_pattern ~paren:false) p
      ) pel; *)
      fprintf fmt "@[match @[%a@] with@\n@[%a@]@]"
        (pp_atom ~paren:false) a
        (pp_print_list ~pp_sep:pp_newline pp_ppat_expr) pel
  | ELetK (k, x, e1, e2) ->
      fprintf fmt "let %s %s =@;<1 2>@[%a@]@ in@ @[%a@]"
        k.id_name x.id_name
        pp_expr e1 pp_expr e2

and pp_atom ?(paren=false) fmt (a: atom) =
  match a.atom_desc with
  | ABinop (e1, op, e2) ->
      fprintf fmt (protect_on paren "@[%a %a %a@]") pp_expr e1 pp_op op
        pp_expr e2
  | AUnop (op, e1) ->
      fprintf fmt (protect_on paren "@[%a %a@]") pp_op op pp_expr e1
  | ACst c -> fprintf fmt "%a" pp_constant c
  | AFun (_, binder, e) ->
      let (x, _) = binder in
      fprintf fmt (protect_on paren "fun %s ->@;<1 2>@[%a@]")
        x.id_name pp_expr e
  | AId x -> fprintf fmt "%s" x.id_name
  | ATuple al ->
      fprintf fmt "@[(%a)@]" (pp_print_list ~pp_sep:pp_coma pp_atom) al
  | ACons (c, []) -> fprintf fmt "%s" c.id_name
  | ACons (c, [a]) ->
      fprintf fmt (protect_on paren "%s %a") c.id_name
        (pp_atom ~paren) a
  | ACons (c, al) ->
      fprintf fmt (protect_on paren "%s @[(%a)@]") c.id_name
        (pp_print_list ~pp_sep:pp_coma pp_atom) al

and pp_ppat_expr fmt (p, e) =
  fprintf fmt "@[<hov 4>| %a ->@ @[%a@]@]"
    (pp_pattern ~paren:false) p pp_expr e

and pp_callable fmt c =
  match c.callable_desc with
  | CId id -> fprintf fmt "%a" pp_id id
  | CFun (xs, ks, e) ->
      fprintf fmt "fun %a%s%a ->@;<1 2>@[%a@]"
        (pp_print_list pp_binder) xs
        (if xs <> [] && ks <> [] then " " else "")
        (pp_print_list pp_id) ks
        pp_expr e

let pp_rec fmt = function
  | Asttypes.Recursive -> fprintf fmt " rec"
  | Nonrecursive -> ()

let pp_id fmt {id_name; _} =
  fprintf fmt "%s" id_name

let pp_kont fmt {kont_id; _} =
  fprintf fmt "%a" pp_id kont_id

let pp_decl fmt (d: declaration) =
  match d.decl_desc with
  | DFun (rec_flag, id, xs, pre, ks, e) ->
      ignore pre; (* TODO *)
      fprintf fmt "@[let%a %s %a%s%a@ =@;<1 2>@[%a@]@]"
        pp_rec rec_flag id.id_name
        (pp_print_list ~pp_sep:pp_space pp_binder) xs
        (if xs <> [] && ks <> [] then " " else "")
        (pp_print_list ~pp_sep:pp_space pp_kont) ks
        pp_expr e
  | DType (rec_flag, td) ->
      fprintf fmt "@[%a@]"
        UPrint.s_type_declaration_rec_flag (rec_flag, td)
  | DFunction fd ->
      fprintf fmt "@[%a@]" UPrint.function_ fd

let pp_program fmt =
  pp_print_list ~pp_sep:pp_newline_newline pp_decl fmt

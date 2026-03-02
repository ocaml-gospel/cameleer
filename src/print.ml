open Format
open Ast

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

let pp_op fmt (op: op) =
  match op with
  | OPAdd -> fprintf fmt "+"
  | OPMinus -> fprintf fmt "-"
  | OPMult -> fprintf fmt "*"
  | OPDiv -> fprintf fmt "/"
  | OPEq -> fprintf fmt "="
  | OPLe -> fprintf fmt "<="

let rec pp_pattern ?(paren=false) fmt {ppat_desc; _} =
  match ppat_desc with
  | PWild -> fprintf fmt "_"
  | PVar x -> fprintf fmt "%s" x.id_name
  | PCons (id, []) ->
    fprintf fmt "%s" id.id_name
  | PCons (id, [a]) ->
    fprintf fmt "%s %a" id.id_name (pp_pattern ~paren:true) a
  | PCons (id, args) ->
    fprintf fmt (protect_on paren "%s @[(%a)@]") id.id_name
      (pp_print_list ~pp_sep:pp_coma pp_pattern) args

let rec pp_expr fmt (e: expr) =
  match e.expr_desc with
  | EAtom a ->
      fprintf fmt "%a" (pp_atom ~paren:true) a
  | EAssert ->
      fprintf fmt "absurd"
  | ELet (x, e1, e2) ->
      fprintf fmt "let %a =@ @[<hov 2>%a@] in@ @[%a@]"
        (pp_pattern ~paren:false) x pp_expr e1 pp_expr e2
  | EApp (f, al) ->
      fprintf fmt "@[<hov 2>%a @[%a@]@]" pp_expr f
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:true)) al
  | EIf (a, e1, e2) ->
      fprintf fmt "if @[%a@] then@ @[%a@]@ else@ @[%a@]"
        (pp_atom ~paren:false) a pp_expr e1 pp_expr e2
  | EMatch (a, pel) ->
      fprintf fmt "@[match @[%a@] with@\n@[%a@]@]"
        (pp_atom ~paren:false) a (pp_print_list ~pp_sep:pp_newline pp_ppat_expr) pel

and pp_atom ?(paren=false) fmt (a: atom) =
  match a.atom_desc with
  | ABinop (e1, op, e2) ->
    fprintf fmt (protect_on paren "@[%a %a %a@]") pp_expr e1 pp_op op
      pp_expr e2
  | ACst c -> fprintf fmt "%a" pp_constant c
  | AFun (x, e) ->
    fprintf fmt (protect_on paren "@[fun %s -> @[<hov 2>%a@]@]")
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

let pp_rec fmt = function
  | Recursive -> fprintf fmt " rec"
  | NonRecursive -> ()

let pp_id fmt {id_name; _} =
  fprintf fmt "%s" id_name

let pp_decl fmt (d: declaration) =
  match d.decl_desc with
  | DFun (rec_flag, id, args, e) ->
      fprintf fmt "@[<hov 2>let%a %s %a@ = %a@]"
        pp_rec rec_flag id.id_name
        (pp_print_list ~pp_sep:pp_space pp_id) args
        pp_expr e

let pp_program fmt =
  pp_print_list ~pp_sep:pp_newline_newline pp_decl fmt

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
let pp_comma fmt () = fprintf fmt ", "
let pp_and fmt () = fprintf fmt " &&@ "
let pp_bar fmt () = fprintf fmt " | "
let pp_paren fmt () = fprintf fmt ". "

let pp_sep f fmt () =
  fprintf fmt f

let protect_on b f =
  if b then "(" ^^ f ^^ ")"
  else f

let curly_braces b f =
  if b then "{" ^^ f ^^ "}"
  else f

let pp_op, pp_constant = Pp_ml_lang.(pp_op, pp_constant)

(* TODO: special case for [+++] *)
let pp_cpre = (WPrint.pp_term ~attr:false).closed
let pp_pty = (WPrint.pp_pty ~attr:false).closed
let pp_type_decl = WPrint.pp_decl
(* FIXME? Why marked? *)

let pp_cpre fmt = function
  | [] -> ()
  | pre ->
      fprintf fmt "{ @[%a@] }"
        (pp_print_list ~pp_sep:pp_and pp_cpre) pre

let pp_id fmt {id_name; _} =
  fprintf fmt "%s" id_name

let pp_cbinder ?(paren=true) fmt (id, pty) =
  match pty with
  | None -> fprintf fmt "%a" pp_id id
  | Some (Ptree.PTtyapp (Qident {id_str="ref";_}, [pty])) ->
      fprintf fmt (protect_on paren "@[%a: %a@]") pp_id id
        pp_pty pty
  | Some pty ->
      fprintf fmt (protect_on paren "@[%a: %a@]") pp_id id
        pp_pty pty

let simple_callable c =
  match c.ccallable_desc with
  | CCId { id_name; _ } -> String.length id_name < 4
  | _ -> false

let _pp_pre fmt = function
  | [] -> ()
  | l ->
      fprintf fmt "{ @[%a@] }"
        (pp_print_list ~pp_sep:pp_and UPrint.term) l

let rec pp_expr ?(_fn_name="") fmt (e: cexpr) =
  match e.cexpr_desc with
  | CEFail -> fprintf fmt "fail"
  | CEAssert (phi, e) ->
      fprintf fmt "@[%a@]@ @[%a@]"
        pp_cpre phi
        (fun fmt e -> pp_expr fmt e) e
  | CEHide e -> fprintf fmt "(! @[%a@])" (fun fmt e -> pp_expr fmt e) e
  | CELet (x, a, e2) ->
      fprintf fmt "@[%a@]@\n[%a =@ @[<hov 2>%a@]]"
        (fun fmt e -> pp_expr fmt e) e2
        (pp_cbinder ~paren:false) x
        (fun fmt e -> pp_atom fmt e) a
  | CELetRef (x, a, e2) ->
      fprintf fmt "@[%a@]@\n[&%a =@ @[<hov 2>%a@]]"
        (fun fmt e -> pp_expr fmt e) e2
        (pp_cbinder ~paren:false) x
        (fun fmt e -> pp_atom fmt e) a
  | CEAssignRef (r, a, e2) ->
      fprintf fmt "@[[&%a <-@ @[<hov 2>%a@]]@]@\n@[%a@]"
        pp_id r
        (fun fmt e -> pp_atom fmt e) a
        (fun fmt e -> pp_expr fmt e) e2
  | CEApp (c, al, []) ->
      fprintf fmt "@[%a @[%a@]@]"
        (pp_callable ~_fn_name) c
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:false ~curly:true)) al
  | CEApp (c, al, [cl1]) ->
      fprintf fmt "@[%a @[%a %a@]@]"
        (pp_callable ~_fn_name) c
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:false ~curly:true)) al
        (pp_callable ~_fn_name) cl1
  | CEApp (c, al, cl) when List.for_all simple_callable cl ->
      fprintf fmt "@[%a @[%a %a@]@]"
        (pp_callable ~_fn_name) c
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:false ~curly:true)) al
        (pp_print_list ~pp_sep:pp_space (pp_callable ~_fn_name)) cl
  | CEApp (c, al, cl) ->
      fprintf fmt "@[%a @[%a@]@\n  @[%a@]@]"
        (pp_callable ~_fn_name) c
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:false ~curly:true)) al
        (pp_print_list ~pp_sep:pp_newline (pp_callable ~_fn_name)) cl
  | CEIf (a, e1, e2) ->
      fprintf fmt "@[if @[%a@]@;<1 3>@[(-> @[%a)@]@\n(-> @[%a)@]@]@]"
        (pp_atom ~comma_tuple:true ~paren:false ~curly:true) a
        (fun fmt e -> pp_expr fmt e) e1
        (fun fmt e -> pp_expr fmt e) e2 (* TODO *)
  | CELetK(k, xs, o, e1, e2) ->
      fprintf fmt "@[%a@]@ @[[ %s %a %a@;<1 2>= @[%a@]]@]"
        (fun fmt e -> pp_expr fmt e) e2
        k.id_name
        (pp_print_list ~pp_sep:pp_space (pp_cbinder ~paren:true)) xs
        (pp_print_list ~pp_sep:pp_newline pp_kont) o
        (fun fmt e -> pp_expr fmt e) e1

and pp_atom ?(comma_tuple=true) ?(paren=false) ?(curly=false) fmt (a: catom) =
  match a.catom_desc with
  | CABinop (a1, op, a2) ->
      fprintf fmt
        (protect_on paren (curly_braces curly "@[%a %a %a@]"))
        (fun fmt a -> pp_atom ~paren fmt a) a1
         pp_op op
        (fun fmt a -> pp_atom ~paren fmt a) a2
  | CAUnop (op, a1) ->
      fprintf fmt
        (protect_on paren (curly_braces curly "@[%a %a@]"))
        pp_op op (fun fmt a -> pp_atom ~paren fmt a) a1
  | CACst c -> fprintf fmt (curly_braces curly "%a") pp_constant c
  | CAFun (binder, e) ->
      fprintf fmt (protect_on true "@[fun @[%a@] -> @[<hov 2>%a@]@]")
        (pp_cbinder ~paren:true) binder
        (fun fmt e -> pp_expr fmt e) e
  | CAId x -> fprintf fmt (protect_on paren @@ curly_braces curly "%s") x.id_name
  | CATuple al ->
      let pp_sep = if comma_tuple then pp_comma else pp_space in
      fprintf fmt (protect_on paren (curly_braces curly "@[%a@]"))
        (pp_print_list ~pp_sep (pp_atom ~curly:false)) al
  (* case of list *)
  | CACons ({id_name="[]";_}, []) -> fprintf fmt (curly_braces curly "Nil")
  | CACons ({id_name="::";_}, [h;t]) ->
      fprintf fmt (curly_braces curly "Cons @[%a@] @[%a@]")
        (pp_atom ~comma_tuple ~paren:true ~curly:false) h
        (pp_atom ~comma_tuple ~paren:false ~curly:false) t
  (* standard constructors *)
  | CACons (c, []) -> fprintf fmt (curly_braces curly "%s") c.id_name (* TODO *)
  | CACons (c, [a]) ->
      fprintf fmt (curly_braces curly "%s %a")
        c.id_name
        (pp_atom ~comma_tuple ~paren:false ~curly:false) a (* TODO *)
  | CACons (c, al) ->
      fprintf fmt (protect_on paren @@ curly_braces curly "%s @[%a@]")
        c.id_name
        (pp_print_list ~pp_sep:pp_space (pp_atom ~paren:true ~curly:false)) al (* TODO *)
  | CACast ({ catom_desc=CAId x; _ }, t) ->
      fprintf fmt (protect_on paren @@ curly_braces curly "@[%s: %a@]")
        x.id_name pp_pty t
  | CACast (a, t) ->
      fprintf fmt (protect_on paren @@ curly_braces curly "@[%a: %a@]")
        (pp_atom ~comma_tuple ~paren:true ~curly:false) a
        pp_pty t

and pp_callable ?(_fn_name="") fmt c =
  match c.ccallable_desc with
  | CCId id -> fprintf fmt "%s" id.id_name
  | CCFun (data, kon, e) ->
      fprintf fmt (protect_on true "@[%s@[%a@]%s@[%a@]%s->@;<1 2>@[%a@]@]")
        (if data = [] && kon = [] then "" else "fun ")
        (pp_print_list ~pp_sep:pp_space pp_cbinder) data
        (if data = [] then "" else " ")
        (pp_print_list ~pp_sep:pp_space pp_id) kon
        (if kon = [] then "" else " ")
        (fun fmt e -> pp_expr fmt e) e

and pp_ppat_cexpr fmt (p, e) =
  List.iter (fun (x,b) ->
    if b = None then (Format.printf "ppcoma --> (%s)@." x.id_name)) p;
  fprintf fmt "(%s@[%a@]%s->@;<1 2>@[%a)@]"
    (if p = [] then "" else "fun ")
    (pp_print_list ~pp_sep:pp_space pp_cbinder) p
    (if p = [] then "" else " ")
    (fun fmt e -> pp_expr fmt e) e

and pp_kont fmt {ckont_id; ckont_writes; ckont_pre; ckont_kont; ckont_arg} =
  fprintf fmt (protect_on true "@[%a%s@,%a%s@,@[%a@]%s@,@[%a@]%s@,@[%a@]@]")
    pp_id ckont_id
    (if ckont_writes = [] then "" else " ")
    pp_writes ckont_writes
    (if ckont_arg = [] then "" else " ")
    (pp_print_list ~pp_sep:pp_space (pp_cbinder ~paren:true)) ckont_arg
    (if ckont_pre = [] then "" else " ")
    pp_cpre ckont_pre
    (if ckont_kont = [] then "" else " ")
    (pp_print_list ~pp_sep:pp_space pp_kont) ckont_kont

and pp_writes fmt ws =
  if ws <> [] then
    fprintf fmt "[%a]" (pp_print_list ~pp_sep:pp_space pp_id) ws

let pp_handler_case fmt (case_id, vars, pre) =
  match vars with
  | [] ->
      fprintf fmt "(%a %a)" pp_id case_id pp_cpre pre
  | _ ->
      fprintf fmt "(%s @[%a@ @[%a@]@])"
        case_id.id_name
        (pp_print_list ~pp_sep:pp_space (pp_cbinder ~paren:true)) vars
        pp_cpre pre

let print_destructs fn_name fmt =
    let key = Ml2coma.handler_name_of_id fn_name in
    let value = Hashtbl.find_opt Ml2coma.destructs key in
    match value with
    | None -> ()
    | Some (len, handlers) ->
      List.iteri (fun i (h : Ml2coma.handler) ->
        Format.fprintf fmt "@[let %s%d@;<1 4>@[@[%a@]@ @[%a@]@]@]@\n= any%a"
          key (len - i)
          (pp_print_list ~pp_sep:pp_space (pp_cbinder ~paren:true)) h.args
          (pp_print_list ~pp_sep:pp_newline pp_handler_case) h.cases
          pp_newline_newline ()
      ) handlers

let pp_olds fmt = function
  | [] -> ()
  | olds ->
      let pp_binding fmt (x, a) =
        fprintf fmt "%a =@ @[<hov 2>%a@]"
          (pp_cbinder ~paren:false) x
          (fun fmt e -> pp_atom fmt e) a in
      fprintf fmt "@ [@[%a@]]"
        (pp_print_list ~pp_sep:pp_bar pp_binding) olds

let pp_decl fmt (d: cdeclaration) =
  match d.cdecl_desc with
  | CDFun (rec_flag, id, xs, (pre, b), olds, ks, e) ->
      print_destructs id.id_name fmt;
      fprintf fmt "let%a %s@;<1 4>@[@[%a@]@,%s@[%a%s@]%a@ @[%a@]@]@\n= @[%a@]"
        Pp_ml_lang.pp_rec rec_flag
        id.id_name
        (pp_print_list ~pp_sep:pp_space pp_cbinder) xs
        (if pre = [] then "" else " ")
        pp_cpre pre
        (if b then " {..}" else "")
        pp_olds olds
        (pp_print_list ~pp_sep:pp_newline pp_kont) ks
        (pp_expr ~_fn_name:id.id_name) e
| CDLogic decl ->
      fprintf fmt "%a" (pp_type_decl ~attr:false) decl
| CDType2 (name, model) ->
      fprintf fmt "(* abstract in .ml *)@\ntype %s = %s" name model

let preamble stdlist =
  let pp fmt = fprintf fmt "use %s" in
  let pp_sep = pp_newline in
  asprintf
"%a@\n
let halt = any
let fail { false } = any
let if (b: bool) (then {b}) (else {not b}) = any@\n
"
  (pp_print_list ~pp_sep pp) stdlist

let pp_program stdlist fmt =
  fprintf fmt "%s" (preamble ("ocamlstdlib.Stdlib" :: stdlist));
  pp_print_list ~pp_sep:pp_newline_newline pp_decl fmt

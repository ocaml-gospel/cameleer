open Ppxlib
open Gospel
open Ml_lang

module E = Expression

let rec string_of_longident = function
  | Longident.Lident s -> s
  | Ldot (t, s) -> string_of_longident t ^ s
  | Lapply (t1, t2) -> string_of_longident t1 ^ string_of_longident t2

module VARS = struct
  let names: (string, unit) Hashtbl.t = Hashtbl.create 16

  let id id =
    Hashtbl.replace names id.id_name ()

  let register s =
    Hashtbl.replace names s ()

  let binder (id1, _) =
    id id1

  let binders bl =
    List.iter binder bl

  let mem id =
    match Hashtbl.find names id with
    | _ -> true
    | exception Not_found -> false

  let rec kont { kont_id; kont_arg ; kont_kont ; _ } =
    id kont_id;
    binders kont_arg;
    konts kont_kont

  and konts ks = List.iter kont ks

  let rec ppattern (p: Parsetree.pattern) =
    match p.ppat_desc with
    | Ppat_any -> ()
    | Ppat_var {txt;_} -> register txt
    | Ppat_alias (p, {txt;_}) -> register txt; ppattern p
    | Ppat_array pl
    | Ppat_tuple pl -> List.iter ppattern pl
    | Ppat_construct (_, o) -> Option.iter (fun (_, p) -> ppattern p) o
    | Ppat_variant (_, o) ->  Option.iter ppattern o
    | Ppat_record (l, _) -> List.iter (fun (_, p) -> ppattern p) l
    | Ppat_or (p1, p2) -> ppattern p1; ppattern p2
    | Ppat_lazy p
    | Ppat_exception p
    | Ppat_open (_, p)
    | Ppat_constraint (p, _) -> ppattern p
    | Ppat_constant _
    | Ppat_interval _
    | Ppat_type _
    | Ppat_unpack _ -> ()
    | Ppat_extension _ -> ()

  let rec s_case = function Uast.{ spc_lhs=p; spc_guard=o; spc_rhs=e; _ } ->
    ppattern p;
    Option.iter s_expr o;
    s_expr e

  and s_expr e =
    match e.Uast.spexp_desc with
    | Sexp_fun (_, o, p, e, _) ->
        Option.iter s_expr o; ppattern p; s_expr e
    | Sexp_ident {txt;_} -> register (string_of_longident txt)
    | Sexp_constant _ -> ()
    | Sexp_let (_, bl, e) ->
        List.iter (fun Uast.{ spvb_pat; spvb_expr; _ } ->
          ppattern spvb_pat; s_expr spvb_expr) bl;
        s_expr e
    | Sexp_function c -> List.iter s_case c
    | Sexp_apply (e, el) ->
        s_expr e;
        List.iter (fun (_,e) -> s_expr e) el
    | Sexp_try (e, cl)
    | Sexp_match (e, cl) ->
        s_expr e; List.iter s_case cl
    | Sexp_array el
    | Sexp_tuple el ->
        List.iter s_expr el
    | Sexp_construct (_, o)
    | Sexp_variant   (_, o) ->
        Option.iter s_expr o
    | Sexp_record (l, o) ->
        Option.iter s_expr o;
        List.iter (fun (_, e) -> s_expr e) l
    | Sexp_constraint (e, _)
    | Sexp_coerce (e, _, _)
    | Sexp_send (e, _)
    | Sexp_setinstvar (_, e)
    | Sexp_letmodule (_, _, e)
    | Sexp_field (e, _)
    | Sexp_letexception (_, e)
    | Sexp_assert e
    | Sexp_lazy e
    | Sexp_poly (e, _)
    | Sexp_newtype (_, e)
    | Sexp_open (_, e) ->
        s_expr e
    | Sexp_sequence (e1, e2)
    | Sexp_while (e1, e2, _)
    | Sexp_setfield (e1, _, e2) ->
        s_expr e1;
        s_expr e2
    | Sexp_ifthenelse (e1, e2, o) ->
        s_expr e1;
        s_expr e2;
        Option.iter s_expr o;
    | Sexp_for (p, e1, e2, _, e3, _) ->
        ppattern p;
        s_expr e1;
        s_expr e2;
        s_expr e3
    | Sexp_override l ->
        List.iter (fun (_,e) -> s_expr e) l
    | Sexp_new _
    | Sexp_object _
    | Sexp_pack _
    | Sexp_letop _
    | Sexp_extension _
    | Sexp_unreachable            -> ()

end

let (^~) a b = fun c -> a c b

let rec split_at i l =
  if i <= 0 then [], l else
  match l with
  | [] -> assert false
  | h :: t ->
      let a, b = split_at (i-1) t in
      (h :: a), b

let dummy_pos = Lexing.{ pos_fname = ""; pos_lnum = 0; pos_bol = 0; pos_cnum = 0; }

let dummy_loc =
  (* WARN: the less we use this the better it is *)
  dummy_pos, dummy_pos

let location {loc_start; loc_end; _} =
  (loc_start, loc_end)

module Mh = Map.Make(struct type t = id let compare = Stdlib.compare end)
let empty_map = Mh.empty

let cst_true = CBool true
let cst_false = CBool false
let cst_num n = CNum n

let mk_atom ?(loc=dummy_loc) atom_desc =
  { atom_loc=loc ; atom_desc }

let atom_true = ACst cst_true
let atom_false = ACst cst_false
let atom_num n = ACst (cst_num n)
let atom_unit = mk_atom (ACst CUnit)

let is_false = function
  | Uast.Sexp_construct ({ txt = Lident "false"; _ }, None) -> true
  | _ -> false

let is_raise = function
  | Uast.Sexp_ident { txt = Lident "raise"; _ } -> true
  | _ -> false

(** The function [get_ident] is valid iff [is_ident] succeded. *)
let (is_ident, get_ident) =
  (function
  | Uast.Sexp_ident { txt = Lident _; _ } -> true
  | _ -> false),
  (function[@warning "-8"] Uast.Sexp_ident { txt = Lident f; _ } -> f)

let mk_raise_name eid = "raise_" ^ eid

let mk_id ?(loc=dummy_loc) id =
  { id_name = id; id_loc = loc}

let gen_symbol =
  let cnt = ref 0 in
  fun prefix ->
    cnt := !cnt + 1;
    Printf.sprintf "%s%i" prefix !cnt

let rec gen_id ?(prefix = "x") ?(loc=dummy_loc) () =
  let id = gen_symbol prefix in
  if VARS.mem id then
    gen_id ~prefix ~loc ()
  else
    mk_id ~loc id

let gen_kid ?(prefix = "k") ?(loc=dummy_loc) () =
  let id = gen_symbol prefix in
  if VARS.mem id then
    gen_id ~prefix ~loc ()
  else
    mk_id ~loc id

let mk_prefix t =
  match t with
  | Some { ptyp_desc = Ptyp_constr ({txt;_}, _); _ } ->
      String.make 1 (string_of_longident txt).[0]
  | _ -> "x"

let mk_callable ?(loc=dummy_loc) callable_desc =
  { callable_loc=loc ; callable_desc }

let mk_expr ?(loc=dummy_loc) expr_desc =
  { expr_loc=loc ; expr_desc }

let mk_pattern ?(loc=dummy_loc) ppat_desc =
  { ppat_loc=loc; ppat_desc }

let mk_tpattern ?(loc=dummy_loc) ppat_desc ty =
  mk_pattern ~loc @@ PCast (mk_pattern ~loc ppat_desc, ty)

let mk_wild_typed ?(loc=dummy_loc) t = mk_tpattern ~loc PWild t

let mk_decl (rec_flag, id, params, pre, olds, konts, e) =
  { decl_loc  = id.id_loc;
    decl_desc = DFun (rec_flag, id, params, pre, olds, konts, e); }

let map_pty pty = Option.map E.core_type pty

let rec get_pattern_id (pat: Parsetree.pattern) =
  match pat.ppat_desc with
  | Ppat_var {txt; loc} ->
      let loc = location loc in
      mk_id ~loc txt, None
  | Ppat_constraint (p, pty) ->
      let id, _ = get_pattern_id p in
      id, Some pty
  | Ppat_any -> assert false | Ppat_alias (_, _) -> assert false | Ppat_constant _ -> assert false
  | Ppat_interval (_, _) -> assert false
  | Ppat_tuple _ -> assert false
  | Ppat_construct (_, _) -> assert false
  | Ppat_variant (_, _) -> assert false
  | Ppat_record (_, _) -> assert false
  | Ppat_array _ -> assert false
  | Ppat_or (_, _) -> assert false
  | Ppat_type _ -> assert false
  | Ppat_lazy _ -> assert false
  | Ppat_unpack _ -> assert false
  | Ppat_exception _ -> assert false
  | Ppat_extension _ -> assert false
  | Ppat_open (_, _) -> assert false

let preid Uast.Preid.{ pid_str; pid_loc; _ } =
  mk_id ~loc:(location pid_loc) pid_str

let labelled_arg = function
  | Uast.Lunit -> mk_id "()"
  | Lnone p
  | Loptional p
  | Lnamed p
  | Lghost (p, _) -> preid p

let constant_int = function
  | Pconst_integer (s, _) ->
      if s.[0] = '-' then
        let s = String.sub s 1 (String.length s - 1) in
        let n = Why3.Number.int_literal ILitDec ~neg:false s in
        let n = Why3.Number.neg_int n in
        let n = Why3.Number.to_small_integer n in
        cst_num n
      else
        let n = Why3.Number.int_literal ILitDec ~neg:false s in
        let n = Why3.Number.to_small_integer n in
        cst_num n
  | _ -> assert false

let constant s = match s with
  | Pconst_integer _ -> ACst (constant_int s)
  | _ -> assert false

let rec identify e =
  (* debugging only *)
  let open Format in
  let pploc fmt l =
    let ({pos_lnum;pos_cnum;_},_) = location l in
    fprintf fmt "l%d, c%d" pos_lnum pos_cnum in
  match e.Uast.spexp_desc with
  | Sexp_ident {txt;_} -> eprintf "ident %s@." (string_of_longident txt)
  | Sexp_constant _ -> eprintf "constant@."
  | Sexp_let (_, _, _) -> eprintf "let@."
  | Sexp_function _ -> eprintf "function@."
  | Sexp_fun (_, _, _, _, _) -> eprintf "fun@."
  | Sexp_apply (e, _) -> eprintf "apply+(%a)..@." pploc e.spexp_loc; identify e
  | Sexp_match (_, _) -> eprintf "match@."
  | Sexp_try (_, _) -> eprintf "try@."
  | Sexp_tuple _ -> eprintf "tuple@."
  | Sexp_construct (_, _) -> eprintf "construct@."
  | Sexp_variant (_, _) -> eprintf "variant@."
  | Sexp_record (_, _) -> eprintf "record@."
  | Sexp_field (_, _) -> eprintf "field@."
  | Sexp_setfield (_, _, _) -> eprintf "setfield@."
  | Sexp_array _ -> eprintf "array@."
  | Sexp_ifthenelse (_, _, _) -> eprintf "ifthenelse@."
  | Sexp_sequence (_, _) -> eprintf "sequence@."
  | Sexp_while (_, _, _) -> eprintf "while@."
  | Sexp_for (_, _, _, _, _, _) -> eprintf "for@."
  | Sexp_constraint (_, _) -> eprintf "constraint@."
  | Sexp_coerce (_, _, _) -> eprintf "coerce@."
  | Sexp_send (_, _) -> eprintf "send@."
  | Sexp_new _ -> eprintf "new@."
  | Sexp_setinstvar (_, _) -> eprintf "setinstvar@."
  | Sexp_override _ -> eprintf "override@."
  | Sexp_letmodule (_, _, _) -> eprintf "letmodule@."
  | Sexp_letexception (_, _) -> eprintf "letexception@."
  | Sexp_assert _ -> eprintf "assert@."
  | Sexp_lazy _ -> eprintf "lazy@."
  | Sexp_poly (_, _) -> eprintf "poly@."
  | Sexp_object _ -> eprintf "object@."
  | Sexp_newtype (_, _) -> eprintf "newtype@."
  | Sexp_pack _ -> eprintf "pack@."
  | Sexp_open (_, _) -> eprintf "open@."
  | Sexp_letop _ -> eprintf "letop@."
  | Sexp_extension _ -> eprintf "extension@."
  | Sexp_unreachable -> eprintf "unreachable@."

let identify_fail ?(msg="ANF assumption broken") e =
  identify e;
  Why3.Loc.errorm
    ~loc:(Uterm.location e.Uast.spexp_loc)
    "%s" msg

let collect_params e =
  let rec loop (accd, acck) e =
    match e.Uast.spexp_desc with
    | Sexp_fun (_, None, pat, e, _) ->
        let name, pty = get_pattern_id pat in
        begin match pty with
        | Some ({ ptyp_desc = Ptyp_arrow (_,a,b); _ } as _tarr) ->
            let kont = {
              kont_id   = name;
              kont_writes = [];
              kont_arg  = [mk_id "result", map_pty (Some a)];
              kont_kont = [
                { kont_id   = { name with id_name = "_" ^ name.id_name };
                  kont_writes = [];
                  kont_arg  = [mk_id "result2", map_pty (Some b)];
                  kont_kont = [];
                  kont_pre  = [];
                } ];
              kont_pre  = [];
            } in
            loop (accd, kont :: acck) e
        | _ ->
            let b = name, pty in
            loop (b :: accd, acck) e
        end
    | _ -> List.rev accd, List.rev acck, e
  in
  loop ([], []) e

(** Rewrites [old x] (for a plain identifier [x]) into a reference to
    [old_x], and collects the names of every variable found under [old].
    [old] applied to anything other than a bare identifier is not
    supported yet. *)
let rec extract_old (t: Uast.term) : Uast.term * string list =
  let mk d = Uast.{ t with term_desc = d } in
  match t.Uast.term_desc with
  | Uast.Ttrue | Uast.Tfalse | Uast.Tbang | Uast.Tconst _ | Uast.Tpreid _ ->
      t, []
  | Uast.Tidapp (Uast.Qpreid {Uast.Preid.pid_str; _}, [t1])
    when pid_str = "!" || pid_str = "prefix !" ->
      (* COMA specs reference a mutable variable directly (no deref
         operator) — drop the "!" and keep translating the inner term
         (which may itself contain [old]). *)
      extract_old t1
  | Uast.Tidapp (q, tl) ->
      let tl', ns = extract_old_list tl in
      mk (Uast.Tidapp (q, tl')), ns
  | Uast.Tfield (t1, q) ->
      let t1', ns = extract_old t1 in
      mk (Uast.Tfield (t1', q)), ns
  | Uast.Tapply (t1, t2) ->
      let t1', ns1 = extract_old t1 in
      let t2', ns2 = extract_old t2 in
      mk (Uast.Tapply (t1', t2')), ns1 @ ns2
  | Uast.Tnot t1 ->
      let t1', ns = extract_old t1 in
      mk (Uast.Tnot t1'), ns
  | Uast.Tattr (a, t1) ->
      let t1', ns = extract_old t1 in
      mk (Uast.Tattr (a, t1')), ns
  | Uast.Tcast (t1, ty) ->
      let t1', ns = extract_old t1 in
      mk (Uast.Tcast (t1', ty)), ns
  | Uast.Ttuple tl ->
      let tl', ns = extract_old_list tl in
      mk (Uast.Ttuple tl'), ns
  | Uast.Trecord q_t_list ->
      let qs, ts = List.split q_t_list in
      let ts', ns = extract_old_list ts in
      mk (Uast.Trecord (List.combine qs ts')), ns
  | Uast.Tscope (q, t1) ->
      let t1', ns = extract_old t1 in
      mk (Uast.Tscope (q, t1')), ns
  | Uast.Tcase (t1, pt_list) ->
      let t1', ns1 = extract_old t1 in
      let ps, ts = List.split pt_list in
      let ts', ns2 = extract_old_list ts in
      mk (Uast.Tcase (t1', List.combine ps ts')), ns1 @ ns2
  | Uast.Tlet (id, t1, t2) ->
      let t1', ns1 = extract_old t1 in
      let t2', ns2 = extract_old t2 in
      mk (Uast.Tlet (id, t1', t2')), ns1 @ ns2
  | Uast.Tinfix (t1, id, t2) ->
      let t1', ns1 = extract_old t1 in
      let t2', ns2 = extract_old t2 in
      mk (Uast.Tinfix (t1', id, t2')), ns1 @ ns2
  | Uast.Tbinop (t1, op, t2) ->
      let t1', ns1 = extract_old t1 in
      let t2', ns2 = extract_old t2 in
      mk (Uast.Tbinop (t1', op, t2')), ns1 @ ns2
  | Uast.Told t1 ->
      (match t1.Uast.term_desc with
       | Uast.Tpreid (Uast.Qpreid preid) ->
           let old_preid = Identifier.Preid.create
             ("old_" ^ preid.Uast.Preid.pid_str) ~loc:preid.Uast.Preid.pid_loc in
           mk (Uast.Tpreid (Uast.Qpreid old_preid)), [preid.Uast.Preid.pid_str]
       | _ -> failwith "old: only 'old <var>' is supported for now")
  | Uast.Tif (t1, t2, t3) ->
      let t1', ns1 = extract_old t1 in
      let t2', ns2 = extract_old t2 in
      let t3', ns3 = extract_old t3 in
      mk (Uast.Tif (t1', t2', t3')), ns1 @ ns2 @ ns3
  | Uast.Tupdate (t1, q_t_list) ->
      let t1', ns1 = extract_old t1 in
      let qs, ts = List.split q_t_list in
      let ts', ns2 = extract_old_list ts in
      mk (Uast.Tupdate (t1', List.combine qs ts')), ns1 @ ns2
  | Uast.Tquant (q, bl, t1) ->
      let t1', ns = extract_old t1 in
      mk (Uast.Tquant (q, bl, t1')), ns

and extract_old_list tl =
  let tl', nss = List.split (List.map extract_old tl) in
  tl', List.concat nss

(** Extracts the variable names appearing in a [modifies] clause
    ([sp_writes]). Only plain identifiers are supported. *)
let writes_of_spec = function
  | None -> []
  | Some U.{ sp_writes; _ } ->
      List.filter_map (fun (t: Uast.term) ->
        match t.Uast.term_desc with
        | Uast.Tpreid (Uast.Qpreid preid) -> Some (mk_id preid.Uast.Preid.pid_str)
        | _ -> None
      ) sp_writes

let mk_kont kont_id kont_arg spec =
  let mk_kont kont_pre =
    { kont_id; kont_writes = writes_of_spec spec; kont_arg; kont_kont=[]; kont_pre } in
  let pre = match spec with
    | None -> []
    | Some U.{sp_post; _} -> sp_post in
  mk_kont pre

let pre_of_spec = function
  | None -> []
  | Some U.{sp_pre; _} -> sp_pre

let rec pattern (p: Parsetree.pattern) = match p.ppat_desc with
  | Ppat_any ->
      PWild
  | Ppat_var {txt; loc} ->
      PVar (mk_id ~loc:(location loc) txt)
  | Ppat_construct ({txt; loc}, args) ->
      let args = match args with
        | Some ([], { ppat_desc = Ppat_tuple pl; _} ) ->
            List.map (fun p -> mk_pattern (pattern p)) pl
        | Some ([], p) -> [mk_pattern (pattern p)]
        | None -> []
        | _ -> assert false in
      let id = mk_id ~loc:(location loc) (string_of_longident txt) in
      PCons (id, args)
  | Ppat_tuple pl ->
      let pl = List.map (fun p -> mk_pattern (pattern p)) pl in
      PTuple pl
  | Ppat_constraint (p, c) ->
      PCast (mk_pattern (pattern p), c)
  | Ppat_constant c -> PCst (constant_int c)
  | Ppat_or (_, _)
  | Ppat_interval (_, _)
  | Ppat_alias (_, _)
  | Ppat_variant (_, _)
  | Ppat_record (_, _)
  | Ppat_array _
  | Ppat_type _
  | Ppat_lazy _
  | Ppat_unpack _
  | Ppat_exception _
  | Ppat_extension _
  | Ppat_open (_, _) -> assert false

let is_unop = function
  | "not" | "-" -> true
  | _ -> false

let get_unop = function
  | "not" -> OPNot
  | "-" -> OPMinus
  | _ -> assert false

let is_binop, get_binop =
  let driver = Hashtbl.create 16 in
  List.iter
    (fun (x,y) -> Hashtbl.add driver x y)
    [ ("+", Some OPAdd);
      ("*", Some OPMult);
      ("-", Some OPMinus);
      ("/", Some OPDiv);
      ("infix mod", Some OPMod);
      ("<=", Some OPLe);
      (">=", Some OPGe);
      ("<", Some OPLt);
      (">", Some OPGt);
      ("&&", Some OPAnd);
      ("||", Some OPOr);
      ("<>", Some OPNe);
      ("=", Some OPEq);
      ("infix ::", None);
      ("::", None);
      ("infix @", None);
      ("@", None) ];
  (fun s -> Hashtbl.mem driver s),
  (fun s -> Option.get @@ Hashtbl.find driver s)

let is_and s = s = "&&"
let is_or s = s = "||"

(* let is_deref = function
  | Uast.Sexp_apply ({ spexp_desc = Sexp_ident {txt = Lident "!"; _}; _ }, [_]) -> true
  | _ -> false *)

let is_ref = function
  | Uast.Sexp_apply ({ spexp_desc = Sexp_ident {txt = Lident "ref"; _}; _ }, [_]) -> true
  | _ -> false

(** Returns [true] iff [e] is a constant/ident/construct/atomic-tuple. *)
let rec is_atomic e =
  match e.Uast.spexp_desc with
  | Sexp_constant _ | Sexp_ident _ | Sexp_construct (_, None) -> true
  | Sexp_constraint (e, _) | Sexp_construct (_, Some e) -> is_atomic e
  | Sexp_tuple el -> List.for_all is_atomic el
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([(_, e1);(_, e2)]))
    when is_binop (string_of_longident txt) ->
      is_atomic e1 && is_atomic e2
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, [(_, e1)])
    when is_unop (string_of_longident txt) ->
      is_atomic e1
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt = Lident "!"; _}; _ }, [(_, e1)]) ->
      is_atomic e1
  | _ ->
      identify e; false

let rec atom_of_construct ?(loc=dummy_loc) c = match c with
  | ({ txt = Lident "true"; _ },  None) -> mk_atom ~loc atom_true
  | ({ txt = Lident "false"; _ }, None) -> mk_atom ~loc atom_false
  | ({ txt = Lident "()"; _ }, None)    -> atom_unit
  | ({ txt; loc }, None) ->
      let loc = location loc in
      let id = mk_id ~loc (string_of_longident txt) in
      mk_atom ~loc (ACons (id, []))
  | ({ txt; loc }, Some Uast.{ spexp_desc = Sexp_tuple expr_list; _ }) ->
      let loc = location loc in
      let id = mk_id ~loc (string_of_longident txt) in
      let l = List.map atom_of_sexpr expr_list in
      mk_atom ~loc (ACons (id, l))
  | ({ txt; loc }, Some e) ->
      let loc = location loc in
      let id = mk_id ~loc (string_of_longident txt) in
      mk_atom ~loc (ACons (id, [atom_of_sexpr e]))

and atom_of_sexpr e =
  let loc = location e.spexp_loc in
  if not (is_atomic e) then identify_fail e else
  match e.Uast.spexp_desc with
  | Sexp_constant  c      -> mk_atom ~loc (constant c)
  | Sexp_construct (l, e) -> atom_of_construct (l,e)
  | Sexp_ident {txt; loc} ->
      let loc = location loc in
      let id = mk_id ~loc (string_of_longident txt) in
      (mk_atom ~loc @@ AId id)
  | Sexp_tuple el ->
      let loc = location e.spexp_loc in
      let a = List.map atom_of_sexpr el in
      mk_atom ~loc (ATuple a)
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([(_, e1);(_, e2)]))
    when is_binop (string_of_longident txt) ->
      let loc = location e1.spexp_loc in
      let op = get_binop (string_of_longident txt) in
      mk_atom ~loc (ABinop (atom_of_sexpr e1, op, atom_of_sexpr e2))
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, [(_, e1)])
    when is_unop (string_of_longident txt) ->
      let loc = location e1.spexp_loc in
      let op = get_binop (string_of_longident txt) in
      mk_atom ~loc (AUnop (op, atom_of_sexpr e1))
  | Sexp_apply ({ spexp_desc = Sexp_ident {txt = Lident "!"; _}; _ }, [(_, e1)]) ->
      atom_of_sexpr e1
  | Sexp_constraint (e, t) ->
      let loc = location e.spexp_loc in
      let a = atom_of_sexpr e in
      mk_atom ~loc (ACast (a, t))
  | _ -> assert false (* unreachable *)


module S = struct
  module Sstr = Set.Make(String)
  include Sstr
  let not_mem l s = not (Sstr.mem l s)
end

type raise_set = S.t
(* Maps function's name -> set of exceptions that can be raised *)
let raisable_hmap: (string, S.t) Hashtbl.t = Hashtbl.create 32
let toplevel_fun_types:
  (string, (int * binder list) * (int * kont list)) Hashtbl.t = Hashtbl.create 32

(* Maps exception names -> their argument types *)
let exn_type_hmap : (string, Ppxlib.core_type option) Hashtbl.t = Hashtbl.create 16

(** Computes the set of exceptions that can escape expression [e]. *)
let mayraise e =
  let rec loop acc e =
    match e.Uast.spexp_desc with
    (* {1 expr} *)
    | Sexp_fun (_,_,_,e,_)
    | Sexp_field (e, _) | Sexp_constraint (e, _) | Sexp_variant (_, Some e)
    | Sexp_send (e, _) | Sexp_setinstvar (_, e) | Sexp_assert e
    | Sexp_lazy e | Sexp_poly (e, _) | Sexp_newtype (_, e)
    | Sexp_coerce (e, _, _) | Sexp_construct (_, Some e) -> loop acc e
    (* {2 expr} *)
    | Sexp_sequence (e1,e2) | Sexp_while (e1, e2, _)
    | Sexp_setfield (e1, _, e2) | Sexp_ifthenelse (e1, e2, None) ->
        let acc = loop acc e1 in
        loop acc e2
    (* {3 expr} *)
    | Sexp_for (_, e1, e2, _, e3, _) | Sexp_ifthenelse (e1, e2, Some e3) ->
        let acc = loop acc e1 in
        let acc = loop acc e2 in
        loop acc e3
    (* {expr list} *)
    | Sexp_tuple el | Sexp_array el ->
        List.fold_left loop acc el
    (* {0 expr} *)
    | Sexp_variant (_, None) | Sexp_construct (_, None) | Sexp_new _
    | Sexp_unreachable | Sexp_ident _ | Sexp_constant _ ->
        acc
    (* {special cases} *)
    | Sexp_let (_, el, e) ->
        let acc2 = List.fold_left
          (fun acc Uast.{spvb_expr=e;_} -> loop acc e) acc el in
        loop acc2 e
    | Sexp_apply (e, [ (_, arg) ]) when is_raise e.spexp_desc ->
        (* raise E x -->  adds "raise_E" to the set *)
        let a = atom_of_sexpr arg in
        let s = match a.atom_desc with
          | AId _id -> assert false (* how? *)
          | ACons (id, _) -> mk_raise_name id.id_name
          | ATuple _ | ACst _ | AFun _ | AUnop _ | ABinop _
          | ACast _ -> assert false in
        loop (S.add s acc) e
    | Sexp_apply (f, el) when is_ident f.spexp_desc ->
        (* f a b --> checks what f can raise *)
        let acc2 = List.fold_left
          (fun acc (_,e) -> loop acc e) acc el in
        let fname = get_ident f.spexp_desc in
        let ef =
          try Hashtbl.find raisable_hmap fname
          with Not_found -> S.empty in
        S.union acc2 ef
    | Sexp_apply (e, el) ->
        let acc2 = List.fold_left
          (fun acc (_,e) -> loop acc e) acc el in
        loop acc2 e
    | Sexp_match (e, cases) ->
        let acc = loop acc e in
        List.fold_left (fun acc Uast.{spc_rhs=e;_} -> loop acc e) acc cases
    | Sexp_try (e, cases) ->
        (* subtract from the set of e the exceptions caught by the cases *)
        let se = loop S.empty e in
        let rmv, add = List.fold_left
          (fun (r,a) Uast.{spc_lhs=x;spc_rhs=e;_} ->
            let x = match x.ppat_desc with
              | Ppat_construct ({txt;_},_) ->
                  mk_raise_name (string_of_longident txt)
              | _ -> assert false in
            S.add x r, loop a e)
          (S.empty,S.empty) cases in
        let se = S.filter (S.not_mem ^~ rmv) se in
        S.union (S.union acc se) add
    (* TODO *)
    | Sexp_function _ -> assert false (* TODO *)
    | Sexp_record (_, _)
    | Sexp_object _
    | Sexp_override _
    | Sexp_letmodule (_, _, _)
    | Sexp_letexception (_, _)
    | Sexp_pack _
    | Sexp_open (_, _)
    | Sexp_letop _
    | Sexp_extension _ -> identify_fail ~msg:"unsupported language construct" e in
  loop S.empty e

type kont_type = KName of id | KExpr of callable


let caml_dummy_loc =
  { loc_start = dummy_pos ;
    loc_end = dummy_pos;
    loc_ghost = false; }

let mk_typ s =
  { ptyp_desc = Ptyp_constr ({ txt = Lident s; loc = caml_dummy_loc }, []);
    ptyp_loc = caml_dummy_loc;
    ptyp_loc_stack = [];
    ptyp_attributes = []; }

let tyunit = Some (mk_typ "unit")
let tybool = Some (mk_typ "bool")
let tyint = Some (mk_typ "int")

let mk_preid_term ?(loc=Location.none) name =
  Uast.{ term_desc = Tpreid (Qpreid (Identifier.Preid.create ~loc name));
         term_loc = loc }

let rec term_of_atomic_sexpr (e: Uast.s_expression) : Uast.term =
  let loc = e.spexp_loc in
  match e.spexp_desc with
  | Sexp_constant c -> Uast.{ term_desc = Tconst c; term_loc = loc }
  | Sexp_ident {txt; _} -> mk_preid_term ~loc (string_of_longident txt)
  | Sexp_constraint (e, _) -> term_of_atomic_sexpr e
  | _ -> identify_fail ~msg:"for-loop bounds must be atomic (variable or constant)" e

let mk_le_term ?(loc=Location.none) t1 t2 =
  let op = Identifier.Preid.create ~loc "infix <=" in
  Uast.{ term_desc = Tinfix (t1, op, t2); term_loc = loc }

let bind_cast ty a =
  match ty with
  | None -> a
  | Some ty -> mk_atom ~loc:a.atom_loc @@ ACast (a, ty)

(** CPS translation of [e] where [k] is its normal continuation
    and [hm] is the map of exceptional ones (TODO: unused yet, do we need this?).

    The translation is freely inspired by
    “Compiling with continuation, continued” by Andrew Kennedy.
 *)
let rec expr ?(etype: core_type option=None) (e: Uast.s_expression) k hm : expr_desc =
  let expr_opt ?(etype=etype) e kid hm =
    let loc = location e.Uast.spexp_loc in
    let e = expr ~etype e (KName kid) hm in
    mk_expr ~loc e in
  let callk a = match k with
    | KName k -> EApp (mk_callable ~loc:k.id_loc (CId k), a, [])
    | KExpr k -> EApp (k, a, []) in
  let loc = location e.spexp_loc in
  match e.spexp_desc with
  | Sexp_constant c ->
      let a = mk_atom ~loc (constant c) in
      callk [bind_cast etype a]

  | Sexp_ident {txt; _} ->
      let id = mk_id ~loc (string_of_longident txt) in
      callk [mk_atom ~loc (AId id)]

  | Sexp_tuple el ->
      let a = mk_atom ~loc (ATuple (List.map atom_of_sexpr el)) in
      callk [bind_cast etype a]

  | Sexp_ifthenelse (e1, e2, e3) when is_atomic e1 ->
      let exp e k = match e.Uast.spexp_spec with
        | None -> expr_opt e k hm
        | Some spec ->
            let kid = gen_kid () in
            let ckid = mk_callable (CId k) in
            let e = expr_opt e kid hm in
            let result = mk_id "result" in
            let aresult = mk_atom (AId result) in
            mk_expr @@
              ELetK (kid, [(result, etype)], None,
                       mk_expr ~loc @@ EAssert (spec.fun_ens,
                       mk_expr ~loc @@ EHide (
                       mk_expr ~loc @@ EApp (ckid, [aresult], []))),
                     mk_expr ~loc @@ EAssert (spec.fun_req,
                     mk_expr ~loc @@ EHide e)) in
      let a = atom_of_sexpr e1 in
      let e3 kid = match e3 with
        | Some e3 -> exp e3 kid
        | None -> mk_expr @@ EApp (mk_callable (CId kid), [atom_unit], []) in
      begin match k with
      | KName k -> EIf (a, exp e2 k , e3 k)
      | KExpr k ->
          let z   = gen_id ~prefix:"b" () in
          let kid = gen_kid () in
          let e2  = exp e2 kid in
          ELetK (kid, [(z,tybool)], None,
                       mk_expr @@ EApp (k, [mk_atom @@ AId z], []),
                       mk_expr @@ EIf (a, e2, e3 kid))
      end
  | Sexp_ifthenelse (e1, e2, e3) ->
      let exp e k =
        match e.Uast.spexp_spec with
        | None -> expr_opt e k hm
        | Some spec ->
            let kid = gen_kid () in
            let ckid = mk_callable (CId k) in
            let e = expr_opt e kid hm in
            let result = mk_id "result" in
            let aresult = mk_atom (AId result) in
            mk_expr @@
              ELetK (kid, [(result, etype)], None,
                       mk_expr ~loc @@ EAssert (spec.fun_ens,
                       mk_expr ~loc @@ EHide (
                       mk_expr ~loc @@ EApp  (ckid, [aresult], []))),
                     mk_expr ~loc @@ EAssert (spec.fun_req,
                     mk_expr ~loc @@ EHide e)) in
      let z = gen_id ~prefix:"b" ~loc:(location e1.spexp_loc) () in
      let f, kid = match k with
      | KName k ->
          let f e2 e3 = mk_callable @@
            CFun ([z, tybool], [], mk_expr @@ EIf (mk_atom (AId z),e2,e3)) in
          f, k
      | KExpr k ->
          let kid = gen_kid () in
          let prefix = mk_prefix etype in
          let z2  = gen_id ~prefix () in
          let az2 = mk_atom (AId z2) in
          let f e2 e3 = mk_callable @@ CFun ([z, tybool], [],
            mk_expr @@ ELetK (kid, [(z2, etype)], None,
            mk_expr @@ EApp (k, [az2], []),
            mk_expr @@ EIf (mk_atom (AId z), e2, e3))) in
          f, kid in
      let e2 = exp e2 kid in
      let e3 = match e3 with
       | Some e3 -> exp e3 kid
       | None -> mk_expr @@ EApp (mk_callable (CId kid), [atom_unit], []) in
      expr ~etype:tybool e1 (KExpr (f e2 e3)) hm

  | Sexp_construct (l,e) ->
      let a = atom_of_construct (l,e) in
      callk [bind_cast etype a]

  | Sexp_let ((Nonrecursive | Recursive), [svb], e2)
    when is_ref svb.spvb_expr.spexp_desc ->
      let id, pty = get_pattern_id svb.spvb_pat in
      let[@warning "-8"] Uast.Sexp_apply (_, [(_, e0)]) = svb.spvb_expr.spexp_desc in
      let a = atom_of_sexpr e0 in
      let loc2 = location e2.spexp_loc in
      let body = mk_expr ~loc:loc2 @@ expr ~etype e2 k hm in
      ELetRef ((id, pty), a, body)

  | Sexp_let ((Nonrecursive | Recursive), [svb], e2) ->
      let id, (pty : core_type option) = get_pattern_id svb.spvb_pat in
      begin match pty with
      | Some ({ ptyp_desc = Ptyp_arrow _; _ } as ty) ->
          let rec loop ty e acc ty_out =
            match ty.ptyp_desc, e.Uast.spexp_desc with
            | Ptyp_arrow (_, ty, tys), Sexp_fun (_, _, pat, e, _) ->
                let p = ty, get_pattern_id pat in
                loop tys e (p :: acc) (Some tys)
            | _ -> List.rev acc, e, ty_out in
          let _ty, x, ek, ty_k =
            match loop ty svb.spvb_expr [] None with
            | [(ty_x, x)], ek, Some ty_o -> ty_x, x, ek, ty_o
            | _, e, _ ->
                Why3.Loc.errorm ~loc:(Uterm.location e.Uast.spexp_loc)
                  "assumption broken: only 1 argument per closure is allowed" in
          let loc1 = location ek.spexp_loc in
          let loc2 = location e2.spexp_loc in
          let retkid = gen_kid () in
          let bodyk = mk_expr ~loc:loc1 @@ expr ek (KName retkid) hm in
          ELetK (id, [x], Some (retkid, ty_k), bodyk,
                 mk_expr ~loc:loc2 @@ expr ~etype e2 k hm)
      | _ ->
          let e1 = svb.spvb_expr in
          let loc1 = location e1.spexp_loc in
          let loc2 = location e2.spexp_loc in
          let body = mk_expr ~loc:loc2 @@ expr ~etype e2 k hm in
          let kid = gen_kid () in
          ELetK (kid, [(id, pty)], None, body,
                 mk_expr ~loc:loc1 @@ expr ~etype:pty e1 (KName kid) hm)
      end

  | Sexp_let (Nonrecursive, svb::svbs, e2) -> (* TODO: extend this to lambdas *)
      let id, pty = get_pattern_id svb.spvb_pat in
      let e1 = svb.spvb_expr in
      let loc1 = location e1.spexp_loc in
      let loc2 = location e2.spexp_loc in
      let e2 =
        { e with spexp_desc = Sexp_let (Nonrecursive, svbs, e1) } in
      let body = mk_expr ~loc:loc2 @@ expr ~etype e2 k hm in
      let kid = gen_kid () in
      ELetK (kid, [(id,pty)], None, body,
             mk_expr ~loc:loc1 @@ expr ~etype:pty e1 (KName kid) hm)
  | Sexp_let (Recursive, _svb::_svbs, _e) -> assert false (* TODO *)
  | Sexp_let ((Nonrecursive|Recursive), [], _) -> assert false (* unreachable *)

  | Sexp_try (e, cases) ->
      (* remark:
           for now we only consider `try-catch` of the form
           `try e with E x -> e` and
           `try e with E _ -> e`
       *)
      let rec get_mlpattern_binders pat exn_name =
        match pat.ppat_desc with
        | PVar id ->
          let xpty = Hashtbl.find_opt exn_type_hmap exn_name |> Option.join in
          [(id, xpty)]
        | PCast (p, pty) ->
          let id, _ = match get_mlpattern_binders p exn_name with
            | [(id, xpty)] -> id, xpty
            | _ -> assert false in
          [(id, Some pty)]
        | PWild ->
          let id = gen_id ~prefix:"u" () in
          let xpty = Hashtbl.find_opt exn_type_hmap exn_name |> Option.join in
          [(id, xpty)]
        | PCons (_, [p]) -> get_mlpattern_binders p exn_name
        | PCons (_, []) -> []
        | PCst _ -> assert false
        | PCons (_, _) -> assert false
        | PTuple _ -> assert false in
      let ctx, kid = match k with
        | KName k -> Fun.id, k
        | KExpr c ->
            let kid = gen_kid () in
            let prefix = mk_prefix etype in
            let x = gen_id ~prefix () in
            let a = mk_atom ~loc (AId x) in
            let f e = ELetK (kid, [(x,etype)], None,
                                   mk_expr @@ EApp (c, [a], []),
                                   mk_expr ~loc e) in
            f, gen_kid () in
      let f = (fun Uast.{spc_lhs; spc_rhs; spc_spec; _} ->
        let ploc = location spc_lhs.ppat_loc in
        let p = pattern spc_lhs in
        let[@warning"-8"] eid =
          match p with PCons (eid,_) ->
            { eid with id_name = mk_raise_name eid.id_name } in
        let binders = get_mlpattern_binders (mk_pattern ~loc:ploc p) eid.id_name in
        let d = match spc_spec with
          | None -> expr_opt spc_rhs kid hm
          | Some spec ->
              let kid2 = gen_kid () in
              let ckid = mk_callable (CId kid) in
              let e = expr_opt spc_rhs kid2 hm in
              let result = mk_id "result" in
              let aresult = mk_atom (AId result) in
              let loc = location spc_rhs.spexp_loc in
              mk_expr @@
                ELetK (kid2, [(result, etype)], None,
                         mk_expr ~loc @@ EAssert (spec.fun_ens,
                         mk_expr ~loc @@ EHide (
                         mk_expr ~loc @@ EApp (ckid, [aresult], []))),
                       mk_expr ~loc @@ EAssert (spec.fun_req,
                       mk_expr ~loc @@ EHide e)) in
        eid, binders, d) in
      let cases = List.map f cases in  (* each branch -> ELetK with raise_E name *)
      let e = mk_expr @@ expr ~etype e k hm in
      let letks = List.fold_left (fun acc (eid, binders, d) ->
        let loc = eid.id_loc in
        mk_expr ~loc @@ ELetK (eid, binders, None, d, acc)) e cases in
      ctx letks.expr_desc

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([(_,a1);(_,a2)]))
    when is_or (string_of_longident txt) ->
      let a1 = atom_of_sexpr a1 in
      let loc = a1.atom_loc in
      let loc2 = location a2.spexp_loc in
      let _true = mk_atom ~loc @@ ACst (CBool true) in
      let _then = mk_expr ~loc @@ callk [_true] in
      let _else = mk_expr ~loc:loc2 @@ expr ~etype a2 k hm in
      EIf (a1, _then, _else)

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([(_,a1);(_,a2)]))
    when is_and (string_of_longident txt) ->
      let a1 = atom_of_sexpr a1 in
      let loc = a1.atom_loc in
      let loc2 = location a2.spexp_loc in
      let _false = mk_atom ~loc @@ ACst (CBool false) in
      let _else = mk_expr ~loc @@ callk [_false] in
      let _then = mk_expr ~loc:loc2 @@ expr ~etype a2 k hm in
      EIf (a1, _then, _else)

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, ([(_,a1);(_,a2)]))
    when is_binop (string_of_longident txt) ->
      let st = string_of_longident txt in
      let op = get_binop st in
      let a1 = atom_of_sexpr a1 in
      let a2 = atom_of_sexpr a2 in
      let a  = mk_atom ~loc:a1.atom_loc @@ ABinop (a1, op, a2) in
      callk [a]

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt;_}; _ }, [(_, arg)])
    when is_unop (string_of_longident txt) ->
      let op = get_unop (string_of_longident txt) in
      let a = atom_of_sexpr arg in
      let a = mk_atom ~loc:a.atom_loc @@ AUnop (op, a) in
      callk [a]

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt = Lident "!"; _}; _ }, [(_, e1)]) ->
      callk [atom_of_sexpr e1]

  | Sexp_apply ({ spexp_desc = Sexp_ident {txt = Lident ":="; _}; _ },
                [(_, x_e); (_, rhs_e)]) ->
      let id = match x_e.spexp_desc with
        | Sexp_ident {txt; loc} -> mk_id ~loc:(location loc) (string_of_longident txt)
        | _ -> assert false (* LHS of := must be a plain reference identifier *) in
      let a = atom_of_sexpr rhs_e in
      EAssignRef (id, a, mk_expr ~loc (callk [atom_unit]))

  | Sexp_apply (s, [ (_, arg) ]) when is_raise s.spexp_desc ->
      let a = atom_of_sexpr arg in
      let (id, args) = match a.atom_desc with
        | AId id -> { id with id_name=("raise_" ^ id.id_name)}, []
        | ACons (id, al) ->
            { id with id_name=("raise_" ^ id.id_name)}, al
        | _ -> assert false (* unreachable *) in
      EApp (mk_callable (CId id), args, [])

  | Sexp_apply (e, args) when is_atomic e ->
      let loc = location e.spexp_loc in
      let (c, id) = match e.spexp_desc with
        | Sexp_ident {txt; _} ->
            let id = mk_id ~loc (string_of_longident txt) in
            CId id, id
        | _ -> assert false (* impossible (type error) *) in
      let args = List.map (fun (_, e) -> atom_of_sexpr e) args in
      let pargs, kargs =
        try
          let (lp, _), _ = Hashtbl.find toplevel_fun_types id.id_name in
          let pargs, kargs = split_at lp args in
          let kargs = List.map (function
              | { atom_loc = loc; atom_desc = AId id } -> mk_callable ~loc @@ CId id
              | _ -> assert false) kargs in
          pargs, kargs
        with Not_found -> args, [] in
      let k = match k with
        | KName k -> mk_callable @@ CId k
        | KExpr k -> k in
      let gs = try Hashtbl.find raisable_hmap id.id_name
               with Not_found -> S.empty in
      let sl = S.fold
        (fun s acc -> mk_callable (CId (mk_id s)) :: acc)
        gs [] in
      EApp (mk_callable ~loc c, pargs, kargs @ (k::sl))

  | Sexp_apply (e, args) ->
      let loc = location e.spexp_loc in
      let z = gen_id ~loc () in
      let args = List.map (fun (_, e) -> atom_of_sexpr e) args in
      let k = match k with
        | KName k -> mk_callable ~loc:k.id_loc @@ CId k
        | KExpr k -> k in
      let k = mk_callable ~loc @@
        CFun ([z, etype],[], mk_expr @@
              EApp (mk_callable @@ CId z, args, [k])) in
      expr e (KExpr k) hm

  | Sexp_match (e, cases) when is_atomic e ->
      let a = atom_of_sexpr e in
      let map k = List.map
        (fun Uast.{spc_lhs; spc_rhs; spc_spec; _} ->
          let loc = location spc_rhs.spexp_loc in
          let ploc = location spc_lhs.ppat_loc in
          let pat = mk_pattern ~loc:ploc (pattern spc_lhs) in
          let e = match spc_spec with
            | None -> expr_opt spc_rhs k hm
            | Some spec ->
                let kid = gen_kid () in
                let ckid = mk_callable (CId k) in
                let e = expr_opt spc_rhs kid hm in
                let result = mk_id "result" in
                let aresult = mk_atom (AId result) in
                mk_expr @@
                  ELetK (kid, [(result, etype)], None,
                           mk_expr ~loc @@ EAssert (spec.fun_ens,
                           mk_expr ~loc @@ EHide (
                           mk_expr ~loc @@ EApp (ckid, [aresult], []))),
                         mk_expr ~loc @@ EAssert (spec.fun_req,
                         mk_expr ~loc @@ EHide e)) in
          pat, e)
        cases in
      begin match k with (* TODO inline this somehow *)
      | KName k -> EMatch (a, map k) (* TODO *)
      | KExpr k ->
          let prefix = mk_prefix etype in
          let aid = gen_id ~prefix () in
          let kid = gen_kid () in
          let cases = map kid in
          ELetK (kid, [(aid, etype)], None,
                 mk_expr @@ EApp (k, [mk_atom @@ AId aid], []),
                 mk_expr @@ EMatch (a, cases))
      end

  | Sexp_match (e, cases) ->
      let map k = List.map
        (fun Uast.{spc_lhs; spc_rhs; spc_spec; _} ->
          let ploc = location spc_lhs.ppat_loc in
          let pat = mk_pattern ~loc:ploc (pattern spc_lhs) in
          let e = match spc_spec with
            | None -> expr_opt spc_rhs k hm
            | Some spec ->
                let kid = gen_kid () in
                let ckid = mk_callable (CId k) in
                let e = expr_opt spc_rhs kid hm in
                let result = mk_id "result" in
                let aresult = mk_atom (AId result) in
                let loc = location spc_rhs.spexp_loc in
                mk_expr @@
                  ELetK (kid, [(result, etype)], None,
                           mk_expr ~loc @@ EAssert (spec.fun_ens,
                           mk_expr ~loc @@ EHide (
                           mk_expr ~loc @@ EApp (ckid, [aresult], []))),
                         mk_expr ~loc @@ EAssert (spec.fun_req,
                         mk_expr ~loc @@ EHide e)) in
          pat, e)
        cases in
      begin match k with (* TODO inline this somehow *)
      | KName k ->
          let prefix = mk_prefix etype in
          let z = gen_id ~prefix ~loc () in
          let cases = map k in
          let kk = mk_callable @@
              CFun ([z, etype],[],
                    mk_expr @@ EMatch (mk_atom (AId z), cases)) in
          expr e (KExpr kk) hm
      | KExpr k ->
          let kid = gen_kid () in
          let z   = gen_id  () in
          let prefix = mk_prefix etype in
          let z2  = gen_id ~prefix () in
          let az2 = mk_atom (AId z2) in
          let cases = map kid in
          let kk = mk_callable @@
            (* TODO what is the type of [z]? -> the type of [e], what is the type of [e]? *)
            CFun ([z, None], [],
                  mk_expr @@ ELetK (kid, [(z2,etype)], None,
                    mk_expr @@ EApp (k, [az2], []),
                  mk_expr @@ EMatch (mk_atom (AId z), cases))) in
          expr e (KExpr kk) hm
      end

  | Sexp_assert e when is_false e.spexp_desc -> EFail

  | Sexp_constraint (e, ty) ->
      expr ~etype:(Some ty) e k hm

  | Sexp_sequence
      ({ spexp_desc =
           Sexp_apply ({ spexp_desc = Sexp_ident {txt = Lident ":="; _}; _ },
                       [(_, x_e); (_, rhs_e)]); _ }, e2) ->
      let id = match x_e.spexp_desc with
        | Sexp_ident {txt; loc} -> mk_id ~loc:(location loc) (string_of_longident txt)
        | _ -> assert false (* LHS of := must be a plain reference identifier *) in
      let a = atom_of_sexpr rhs_e in
      let loc2 = location e2.spexp_loc in
      let body = mk_expr ~loc:loc2 @@ expr ~etype e2 k hm in
      EAssignRef (id, a, body)

  | Sexp_sequence (e1, e2) ->
      let k = mk_expr ~loc:(location e2.spexp_loc) @@ expr ~etype e2 k hm in
      let u = (gen_id ~prefix:"u" ()), tyunit in
      let k = KExpr (mk_callable (CFun ([u],[], k))) in
      expr ~etype:tyunit e1 k hm

  | Sexp_while (e1, e2, _spec) ->
      let loc1 = location e1.spexp_loc in
      let id_loop = gen_kid ~prefix:"i" () in
      (* TODO factorize [cloop] with
         a local handler definition mutually recursive with [id_loop].
         ```coma
         let id_cloop = [[e1]] loop
         and loop x = if x then [[e2]] id_cloop else k () in
         id_cloop
         ```
         instead of (where [[[e1]] loop] is duplicated)
         ```coma
         let loop x = if x then [[e2]] ([[e1]] loop) else k () in
         [[e1]] loop
         ```
        *)
      let cloop = mk_expr ~loc:loc1 (expr ~etype:tybool e1 (KName id_loop) hm) in
      let u = (gen_id ~prefix:"u" ()), tyunit in
      let kcloop = KExpr (mk_callable (CFun ([u], [], cloop))) in
      let z = gen_id ~prefix:"b" () in
      (* TODO types instead of None *)
      ELetK (id_loop, [(z,tybool)], None, mk_expr @@
             EIf (mk_atom @@ AId z,
                  mk_expr (expr ~etype:tyunit e2 kcloop hm),
                  mk_expr (callk [atom_unit])),
             cloop)

  | Sexp_for (pat, expr_lower, expr_higher, flag, expr_body, _spec) ->
      let loc1 = location expr_lower.spexp_loc in
      (* let loc2 = location expr_higher.spexp_loc in *)
      let id_loop = gen_kid ~prefix:"loop" () in
      let r, _ = get_pattern_id pat in
      let hi = gen_id ~prefix:"hi" () in
      let lo_a = atom_of_sexpr expr_lower in
      let hi_a = atom_of_sexpr expr_higher in
      let lo_t = term_of_atomic_sexpr expr_lower in
      let hi_t = term_of_atomic_sexpr expr_higher in
      let r_t  = mk_preid_term ~loc:pat.ppat_loc r.id_name in
      let cmp_op, step_op = match flag with
        | Upto   -> OPLe, OPAdd
        | Downto -> OPGe, OPMinus in
      let invariant = match flag with
        | Upto   ->
            [ mk_le_term ~loc:expr_lower.spexp_loc lo_t r_t;
              mk_le_term ~loc:expr_higher.spexp_loc r_t hi_t ]
        | Downto ->
            [ mk_le_term ~loc:expr_higher.spexp_loc hi_t r_t;
              mk_le_term ~loc:expr_lower.spexp_loc r_t lo_t ] in
      let cond = (* Decides if there's more iterations or not *)
        mk_atom ~loc (ABinop (mk_atom ~loc (AId r), cmp_op, mk_atom ~loc (AId hi))) in
      let next_r = (* Computes the next value of the loop variable *)
        mk_atom ~loc (ABinop (mk_atom ~loc (AId r), step_op, mk_atom ~loc (atom_num 1))) in
      let u = gen_id ~prefix:"u" () in
      let recurse = (* The recursive call to the loop, loop {r+1} {hi} *)
       mk_expr ~loc:loc1 @@
        EApp (mk_callable ~loc (CId id_loop), [next_r; mk_atom ~loc (AId hi)], []) in
      let next_k = KExpr (mk_callable ~loc (CFun ([(u, tyunit)], [], recurse))) in 
      let cont_body =
        mk_expr ~loc:(location expr_body.spexp_loc) @@
        expr ~etype:tyunit expr_body next_k hm in
      let loop_body =
        mk_expr ~loc @@ EAssert (invariant,
          mk_expr ~loc @@ EIf (cond, cont_body, mk_expr ~loc @@ callk [atom_unit])) in
      ELetK (id_loop, [(r, tyint); (hi, tyint)], None, loop_body,
             mk_expr ~loc @@ EApp (mk_callable ~loc (CId id_loop), [lo_a; hi_a], []))

  | Sexp_fun (_, _, pat, e, _) ->
      let x, tx = match get_pattern_id pat with
        | (_,Some tx) as x -> x, tx
        | _ -> failwith "arbitrary closures are not implemented, we allow only 1 arg" in
      let jid = gen_kid () in
      let sub =
        let eloc = location e.spexp_loc in
        mk_expr ~loc:eloc @@ expr e (KName jid) hm in
      let f = gen_kid () in
      let c = mk_callable ~loc @@ CId f in
      let ine = mk_expr ~loc @@ match k with
        | KName k -> EApp (mk_callable ~loc:k.id_loc (CId k), [], [c])
        | KExpr k -> EApp (k, [], [c]) in
      ELetK (f, [x], Some (jid, tx), sub, ine)

  | Sexp_unreachable            -> EFail
  | Sexp_function _             -> assert false (* TODO *)
  (* TBC *)
  | Sexp_assert _
  | Sexp_variant (_, _)
  | Sexp_record (_, _)
  | Sexp_field (_, _)
  | Sexp_setfield (_, _, _)
  | Sexp_array _
  | Sexp_coerce (_, _, _)
  | Sexp_send (_, _)
  | Sexp_new _
  | Sexp_setinstvar (_, _)
  | Sexp_override _
  | Sexp_letmodule (_, _, _)
  | Sexp_letexception (_, _)
  | Sexp_lazy _
  | Sexp_poly (_, _)
  | Sexp_object _
  | Sexp_newtype (_, _)
  | Sexp_pack _
  | Sexp_open (_, _)
  | Sexp_extension _
  | Sexp_letop _ -> assert false

and s_value_binding rec_flag (svb: Uast.s_value_binding) k =
  let get_type_expr U.{spexp_desc; _} = match spexp_desc with
    | U.Sexp_constraint (_, pty) -> Some pty
    | _ -> None in
  let ret = function
    | [r] -> labelled_arg r
    | _ -> assert false in
  let return_id_of_spec = function
    | None | Some U.{sp_header = None; _} -> mk_id "result"
    | Some U.{sp_header = Some header; _} -> ret header.sp_hd_ret in
  let id, pty = get_pattern_id svb.spvb_pat in
  VARS.id id;
  (* FIXME? Honestly, I do not know what this pty is. *)
  (* Mário [12-03-2026, 15h35]: OK, I figured it out. This is the
     type of a function if, for instance, we write something like:
     ```
       let is_empty: 'a tree -> bool = fun t -> ...
     ```
     . Which means the type of the function return value is coupled with
     the body expression, when the function header is written in a
     more natural style.

     Let us ignore it, for now. *)
  ignore pty; (* TODO *)
  let params, kparams, pexp = collect_params svb.spvb_expr in
  let () =
    VARS.binders params;
    VARS.konts kparams;
    VARS.s_expr pexp
  in

  let lp, lk = List.length params, List.length kparams in
  let () = Hashtbl.add toplevel_fun_types id.id_name ((lp, params), (lk, kparams)) in
  let _params_id_of_spec = function
    (* FIXME? Paul [27-03-2026 11h42]
       Use this function to apply a substitution of variable names
       inside the specifiation.
       Currently, these names are not used at all and the following does not work
       ```ocaml
       let f a b = a + b
       (*@ r = f c d
               ensures P c d *)
       ```
       To solve this problem we can either:
       - apply a substitution [c->a, d->b]
         (either in the body of f, or in the logical terms)
       - ouse the «contract-let» of Coma:
         ```coma
         let f (a b: int) [c: int = a] [d: int = b] { P c d } (return ...) = ...
                          ^^^^^^^^^^^^ ^^^^^^^^^^^^
                          this is valid Coma where [c] and [d] are bound as if
                          they where parameters
                          -> in the contract *and* the body of f
         ``` *)
    | None | Some U.{sp_header = None; _} -> List.map fst params
    | Some U.{sp_header = Some header; _} ->
        List.map labelled_arg header.sp_hd_args in
  let s = mayraise pexp in
  let spec = svb.spvb_vspec in
  let xpost_of_exn spec exn_name =
    let string_of_uast_qualid = function
      | Uast.Qpreid { pid_str; _ } -> pid_str
      | Uast.Qdot (_, { pid_str; _ }) -> pid_str in
    let rec id_and_type_args exn_name pat =
      match pat.Uast.pat_desc with
      | Uast.Pvar preid ->
        let xpty = Hashtbl.find_opt exn_type_hmap exn_name |> Option.join in
        let xpty = map_pty xpty in
        mk_id ~loc:(location preid.pid_loc) preid.pid_str, xpty
      | Uast.Pwild ->
        let id = gen_id ~prefix:"u" () in
        let xpty = Hashtbl.find_opt exn_type_hmap exn_name |> Option.join in
        let xpty = map_pty xpty in
        id, xpty
      | Uast.Pcast (p, pty) ->
        let id, _ = id_and_type_args exn_name p in
        let pty = Uterm.pty pty in
        id, Some pty
      | _ -> gen_id (), None in
    match spec with
    | None -> None
    | Some U.{ sp_xpost; _ } ->
        List.find_map (fun (_loc, q_pat_t_list) ->
          List.find_map (fun (qid, opt) ->
            if mk_raise_name (string_of_uast_qualid qid) = exn_name then
              Option.map (fun (pat, term) ->
                let (id, pty) = id_and_type_args exn_name pat in
                (id, pty, [term])) opt
            else None
          ) q_pat_t_list
        ) sp_xpost in
  let arg_id = return_id_of_spec spec in
  let return_pty = get_type_expr pexp in
  let sl = S.fold
    (fun s acc ->
      let has_args = Hashtbl.find_opt exn_type_hmap s |> Option.join |> Option.is_some in
      let (kont_arg, pre) = match xpost_of_exn spec s with
        | None ->
            (if has_args then [(arg_id, None)] else []), []
        | Some (id, pty, terms) ->
            (if has_args then [(id, pty)] else []), terms in
      { kont_id   = mk_id s;
        kont_writes = [];
        kont_arg;
        kont_kont = [];
        kont_pre  = pre }
      :: acc)
    s [] in
  let () = Hashtbl.add raisable_hmap id.id_name s in
  let old_names, spec =
    match spec with
    | None -> [], None
    | Some (U.{ sp_post; _ } as vspec) ->
        let posts, nss = List.split (List.map extract_old sp_post) in
        let names = List.sort_uniq compare (List.concat nss) in
        names, Some { vspec with U.sp_post = posts } in
  let old_bindings = List.filter_map (fun name ->
    match List.find_opt (fun (i,_) -> i.id_name = name) params with
    | None -> None
    | Some (pid, pty) ->
        let inner_ty = match pty with
          | Some { ptyp_desc = Ptyp_constr ({txt=Lident "ref";_}, [t]); _ } -> Some t
          | other -> other in
        let old_id = mk_id ("old_" ^ name) in
        Some ((old_id, inner_ty), mk_atom (AId pid))
    ) old_names in
  let expr_loc = location svb.Uast.spvb_expr.spexp_loc in
  let etype = return_pty in
  let body = mk_expr ~loc:expr_loc (expr ~etype pexp (KName k) empty_map) in
  let kont = mk_kont k [(arg_id, map_pty return_pty)] spec in
  let pre = pre_of_spec spec in
  mk_decl (rec_flag, id, params, pre, old_bindings, kparams @ (kont :: sl), body)

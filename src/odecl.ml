open Why3
open Ptree
open Mod_subst
module P = Ptree
module T = Uterm

type odecl =
  | Odecl of Loc.position * decl
  | Omodule of Loc.position * ident * odecl list

type let_function = {
  let_func_loc : Loc.position;
  let_func_def : let_function_node;
}

and let_function_node =
  | RKfunc of
      Loc.position * ident * bool * binder list * pty option * spec * expr
  | RKpure of Loc.position * ident * param list * pty option * term option

let mk_odecl loc d = Odecl (loc, d)
let mk_omodule loc id mod_expr = Omodule (loc, id, mod_expr)

type path = string list

type info_refinement = {
  info_ref_name : qualid option;
  info_ref_decl : odecl list;
  info_subst : subst;
  info_path : path;
}

let mk_info_refinement info_ref_name info_ref_decl info_subst info_path =
  { info_ref_name; info_ref_decl; info_subst; info_path }

type info = {
  (* to be completed as needed *)
  info_arith_construct : (string, int) Hashtbl.t;
  info_refinement : (string, info_refinement) Hashtbl.t;
}

let empty_info () =
  {
    info_arith_construct = Hashtbl.create 32;
    info_refinement = Hashtbl.create 32;
  }

let add_info info id arith = Hashtbl.add info.info_arith_construct id arith

let add_info_refinement info id info_refinement =
  Hashtbl.add info.info_refinement id info_refinement

let mk_dtype loc td_list = mk_odecl loc (Dtype td_list)
(* let mk_coercion loc f = mk_odecl loc (Dmeta (T.mk_id "coercion", [ Mfs f ])) *)

let mk_dlogic loc f =
  (* let coerc = match coerc with None -> [] | Some c -> [ mk_coercion loc c ] in *)
  mk_odecl loc (Dlogic f)

let mk_dprop loc prop_kind id t = mk_odecl loc (Dprop (prop_kind, id, t))

let mk_ind loc in_ident in_params in_def =
  let ind_decl = { in_loc = loc; in_ident; in_params; in_def } in
  mk_odecl loc (Dind (Decl.Ind, [ ind_decl ]))

let mk_dlet loc id ghost rs_kind expr =
  mk_odecl loc (Dlet (id, ghost, rs_kind, expr))

let mk_drec loc fd_list = mk_odecl loc (Drec fd_list)

let mk_function { let_func_loc = loc; let_func_def } =
  match let_func_def with
  | RKfunc (expr_loc, id, drec, binders, dtype, spec, expr) ->
      let ret = T.mk_pattern Pwild in
      let mask = Ity.MaskVisible in
      if drec then
        let fundef =
          (id, true, Expr.RKfunc, binders, dtype, ret, mask, spec, expr)
        in
        mk_drec loc [ fundef ]
      else
        let expr_desc = Efun (binders, dtype, ret, mask, spec, expr) in
        let efun = { expr_loc; expr_desc } in
        mk_dlet loc id true Expr.RKfunc efun
  | RKpure (ld_loc, ld_ident, ld_params, ld_type, ld_def) ->
      let f = { ld_loc; ld_ident; ld_params; ld_type; ld_def } in
      mk_dlogic loc [ f ]

let mk_dexn loc id pty mask = mk_odecl loc (Dexn (id, pty, mask))

let mk_duseimport loc ?(import = true) q_list =
  mk_odecl loc (Duseimport (loc, import, q_list))

let mk_functor loc id arg body = mk_omodule loc id arg :: body

let mk_cloneexport ?odecl_loc id clone_subst =
  let loc = match odecl_loc with Some l -> l | None -> Loc.dummy_position in
  mk_odecl loc (Dcloneexport (loc, id, clone_subst))

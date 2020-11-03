open Why3
open Ptree

module T = Uterm

type odecl =
  | Odecl   of Loc.position * decl
  | Omodule of Loc.position * ident * odecl list

let mk_odecl loc d =
  Odecl (loc, d)

let mk_omodule loc id mod_expr =
  Omodule (loc, id, mod_expr)

type info_refinement = {
  info_ref_name : string option;
  info_ref_decl : odecl list;
}

type info = { (* to be completed as needed *)
  info_arith_construct : (string, int) Hashtbl.t;
  info_refinement      : (string, info_refinement) Hashtbl.t
  (* TODO: include here information to generate refinement modules *)
}

let empty_info () = {
  info_arith_construct = Hashtbl.create 32;
  info_refinement = Hashtbl.create 32;
}

let add_info info id arith =
  Hashtbl.add info.info_arith_construct id arith

let mk_dtype loc td_list =
  mk_odecl loc (Dtype td_list)

let mk_coercion loc f =
  mk_odecl loc (Dmeta (T.mk_id "coercion", [Mfs f]))

let mk_dlogic loc coerc f =
  let coerc = match coerc with None -> [] | Some c -> [mk_coercion loc c] in
  (mk_odecl loc (Dlogic f)) :: coerc

let mk_dprop loc prop_kind id t =
  mk_odecl loc (Dprop (prop_kind, id, t))

let mk_dlet loc id ghost rs_kind expr =
  mk_odecl loc (Dlet (id, ghost, rs_kind, expr))

let mk_drec loc fd_list =
  mk_odecl loc (Drec fd_list)

let mk_dexn loc id pty mask =
  mk_odecl loc (Dexn (id, pty, mask))

let mk_duseimport loc ?(import=true) q_list =
  mk_odecl loc (Duseimport (loc, import, q_list))

let mk_functor loc id arg body =
  (mk_omodule loc id arg) :: body

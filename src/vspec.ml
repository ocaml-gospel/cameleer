open Why3
open Ptree
open Gospel
module T = Uterm

include struct
  open struct
    let get_id_of_lb_arg = function
      | Uast.Lunit -> assert false
      | Uast.Lnone id | Loptional id | Lnamed id | Lghost (id, _) -> id
  end

  let loc_of_lb_arg = function
    | Uast.Lunit -> T.dummy_loc
    | lb -> T.location (get_id_of_lb_arg lb).pid_loc

  let ident_of_lb_arg = function
    | Uast.Lunit -> T.mk_id "()"
    | lb -> T.preid (get_id_of_lb_arg lb)
end

(** Converts a GOSPEL postcondition of the form [Uast.term] into a Why3's Ptree
    postcondition of the form [Loc.position * (pattern * term)]. It uses the
    [sp_hd_ret] field to name the result value of the function. *)
let sp_post sp_hd_ret sp_post =
  let term_loc = T.location sp_post.Uast.term_loc in
  let mk_pvar lb =
    (* create a [Pvar] pattern out of a [Tt.lb_arg] *)
    let pat_loc = loc_of_lb_arg lb in
    T.mk_pattern (Pvar (ident_of_lb_arg lb)) ~pat_loc
  in
  let pvar_of_lb_arg_list lb_arg_list = List.map mk_pvar lb_arg_list in
  let pat =
    match pvar_of_lb_arg_list sp_hd_ret with
    | [ p ] -> p
    | pl -> T.mk_pattern (Ptuple pl) ~pat_loc:term_loc
  in
  (term_loc, [ (pat, T.term true sp_post) ])

let sp_post_no_ret sp_post =
  let term_loc = T.location sp_post.Uast.term_loc in
  let id_result = T.mk_id "result" in
  (term_loc, [ (T.mk_pattern (Pvar id_result), T.term true sp_post) ])

(** Converts a GOSPEL exception postcondition into a Why3's Ptree [xpost]. The
    two data types have the same structure, hence this is a morphism. *)
let sp_xpost (loc, q_pat_t_option_list) =
  let loc = T.location loc in
  let pat_term (q, t) = (T.pattern q, T.term true t) in
  let qualid_pat_term_opt (q, pt_opt) =
    (T.qualid q, Option.map pat_term pt_opt)
  in
  (loc, List.map qualid_pat_term_opt q_pat_t_option_list)

let empty_spec =
  {
    sp_pre = [];
    sp_post = [];
    sp_xpost = [];
    sp_reads = [];
    sp_writes = [];
    sp_alias = [];
    sp_variant = [];
    sp_checkrw = false;
    sp_diverge = false;
    sp_partial = false;
  }

let vspec spec =
  let sp_writes = List.map (T.term false) spec.Uast.sp_writes in
  let sp_checkrw = match sp_writes with [] -> false | _ -> true in
  let sp_post =
    match spec.Uast.sp_header with
    | None -> List.map sp_post_no_ret spec.sp_post
    | Some hd -> List.map (sp_post hd.sp_hd_ret) spec.sp_post
  in
  {
    sp_pre = List.map (T.term false) spec.Uast.sp_pre;
    sp_post;
    sp_xpost = List.map sp_xpost spec.sp_xpost;
    sp_reads = [];
    sp_writes;
    sp_alias = [];
    sp_variant = List.map (fun t -> (T.term false t, None)) spec.sp_variant;
    sp_checkrw;
    sp_diverge = spec.sp_diverge;
    sp_partial = false;
  }

let fun_spec spec =
  {
    sp_pre = List.map (T.term false) spec.Uast.fun_req;
    sp_post = List.map sp_post_no_ret spec.fun_ens;
    sp_xpost = [] (* TODO: cannot be done with [fun_spec] argument *);
    sp_reads = [];
    sp_writes = [];
    sp_alias = [];
    sp_variant = List.map (fun t -> (T.term false t, None)) spec.fun_variant;
    sp_checkrw = false;
    sp_diverge = false;
    sp_partial = false;
  }

let spec_union s1 s2 =
  {
    sp_pre = s1.sp_pre @ s2.sp_pre;
    sp_post = s1.sp_post @ s2.sp_post;
    sp_xpost = s1.sp_xpost @ s2.sp_xpost;
    sp_reads = s1.sp_reads @ s2.sp_reads;
    sp_writes = s1.sp_writes @ s2.sp_writes;
    sp_alias = s1.sp_alias @ s2.sp_alias;
    sp_variant = s1.sp_variant @ s2.sp_variant;
    sp_checkrw = s1.sp_checkrw || s2.sp_checkrw;
    sp_diverge = s1.sp_diverge || s2.sp_diverge;
    sp_partial = s1.sp_partial || s2.sp_partial;
  }

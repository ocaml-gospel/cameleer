open Why3
open Ptree
open Gospel

module T = Uterm

include struct
  open struct
    let get_id_of_lb_arg = function
      Uast.Lnone id | Lquestion id | Lnamed id | Lghost (id, _) -> id
  end

  let loc_of_lb_arg   lb = T.location (get_id_of_lb_arg lb).pid_loc
  let ident_of_lb_arg lb = T.preid (get_id_of_lb_arg lb)
end

(** Converts a GOSPEL postcondition of the form [Uast.term] into a Why3's
    Ptree postcondition of the form [Loc.position * (pattern * term)]. It uses
    the [sp_hd_ret] field to name the result value of the function. *)
let sp_post sp_hd_ret sp_post =
  let term_loc = T.location sp_post.Uast.term_loc in
  let pvar_of_lb_arg_list lb_arg_list =
    let mk_pvar lb = (* create a [Pvar] pattern out of a [Tt.lb_arg] *)
      let pat_loc = loc_of_lb_arg lb in
      T.mk_pattern (Pvar (ident_of_lb_arg lb)) ~pat_loc in
    List.map mk_pvar lb_arg_list in
  let pat = match pvar_of_lb_arg_list sp_hd_ret with
    | [p] -> p
    | pl  -> T.mk_pattern (Ptuple pl) ~pat_loc:term_loc in
  term_loc, [pat, T.term sp_post]

(** Converts a GOSPEL exception postcondition into a Why3's Ptree [xpost]. The
    two data types have the same structure, hence this is a morphism. *)
let sp_xpost (loc, q_pat_t_option_list) =
  let loc = T.location loc in
  let pat_term (q, t) = T.pattern q, T.term t in
  let qualid_pat_term_opt (q, pt_opt) = T.qualid q, Opt.map pat_term pt_opt in
  loc, List.map qualid_pat_term_opt q_pat_t_option_list

let vspec spec = {
  sp_pre     = List.map (fun (t, _) -> T.term t) spec.Uast.sp_pre;
  sp_post    = List.map (sp_post spec.Uast.sp_hd_ret) spec.Uast.sp_post;
  sp_xpost   = List.map sp_xpost spec.sp_xpost;
  sp_reads   = [];
  sp_writes  = List.map T.term spec.sp_writes;
  sp_alias   = [];
  sp_variant = List.map (fun t -> T.term t, None) spec.sp_variant;
  sp_checkrw = false;
  sp_diverge = spec.sp_diverge;
  sp_partial = false;
}
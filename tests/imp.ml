module Imp (Eq: sig
    type t
    val eq : t -> t -> bool
    (*@ b = eq x y
          ensures b <-> x = y *)
  end)
= struct
  type arith_expr =
    | AConst of int
    | AVar   of Eq.t
    | APlus  of arith_expr * arith_expr
    | ATimes of arith_expr * arith_expr
    | AMinus of arith_expr * arith_expr

  type bool_expr =
    | BTrue
    | BFalse
    | BEqual of arith_expr * arith_expr
    | BLeq   of arith_expr * arith_expr
    | BNot   of bool_expr
    | BAnd   of bool_expr * bool_expr

  type stmt_expr =
    | SAssign of Eq.t * arith_expr
    | SSkip
    | SSeq    of stmt_expr * stmt_expr
    | SIf     of bool_expr * stmt_expr * stmt_expr
    | SWhile  of bool_expr * stmt_expr

  type state = Eq.t -> int

  let[@logic] rec eval_arith a s = match a with
    | AConst  n       -> n
    | AVar    x       -> s x
    | APlus  (a1, a2) -> eval_arith a1 s + eval_arith a2 s
    | ATimes (a1, a2) -> eval_arith a1 s * eval_arith a2 s
    | AMinus (a1, a2) -> eval_arith a1 s - eval_arith a2 s

  let[@logic] rec eval_bool b s = match b with
    | BTrue -> true
    | BFalse -> false
    | BEqual (a1, a2) -> eval_arith a1 s  = eval_arith a2 s
    | BLeq   (a1, a2) -> eval_arith a1 s <= eval_arith a2 s
    | BNot   b        -> not (eval_bool b s)
    | BAnd   (b1, b2) -> eval_bool b1 s && eval_bool b2 s

  let[@lemma] rec same_eval_arith a (s1: state) (s2: state) = match a with
    | AConst _ | AVar _ -> ()
    | APlus (a1, a2)
    | ATimes (a1, a2)
    | AMinus (a1, a2) -> same_eval_arith a1 s1 s2; same_eval_arith a2 s1 s2
  (*@ same_eval_arith a s1 s2
       requires forall x: t. s1 x = s2 x
       ensures  eval_arith a s1 = eval_arith a s2 *)

  let[@logic] rec subst_arith a y a0 = match a with
    | AConst n -> AConst n
    | AVar x   -> if Eq.eq x y then AVar y else AVar x
    | APlus (a1, a2)  -> APlus  (subst_arith a1 y a0, subst_arith a2 y a0)
    | ATimes (a1, a2) -> ATimes (subst_arith a1 y a0, subst_arith a2 y a0)
    | AMinus (a1, a2) -> AMinus (subst_arith a1 y a0, subst_arith a2 y a0)

  let[@logic] subst_state s y v =
    fun x -> if Eq.eq x y then v else s x

  (*@ function eval_stmt (e: stmt_expr) (s: state) : state *)

  (*@ axiom eval_assign: forall x: Eq.t, a: arith_expr, s: state.
        eval_stmt (SAssign x a) s = subst_state s x (eval_arith a s) *)

  (*@ axiom eval_skip: forall s: state.
        eval_stmt SSkip s = s *)

  (*@ axiom eval_seq: forall e1 e2: stmt_expr, s: state.
        let s1 = eval_stmt e1 s in
        eval_stmt (SSeq e1 e2) s = eval_stmt e2 s1 *)

  (*@ axiom eval_if_true: forall e1 e2: stmt_expr, b: bool_expr, s: state.
        eval_bool b s -> eval_stmt (SIf b e1 e2) s = eval_stmt e1 s *)

  (*@ axiom eval_if_false: forall e1 e2: stmt_expr, b: bool_expr, s: state.
        not eval_bool b s -> eval_stmt (SIf b e1 e2) s = eval_stmt e2 s *)

  (*@ axiom eval_while_true: forall e: stmt_expr, b: bool_expr, s: state.
        let s' = eval_stmt e s in
        eval_bool b s ->
        eval_stmt (SWhile b e) s = eval_stmt (SWhile b e) s' *)

  (*@ axiom eval_while_false: forall e: stmt_expr, b: bool_expr, s: state.
        not eval_bool b s -> eval_stmt (SWhile b e) s = s *)

  let rec eval_stmt e s = match e with
    | SAssign (x, a)   -> subst_state s x (eval_arith a s)
    | SSkip            -> s
    | SSeq (e1, e2)    -> let s1 = eval_stmt e1 s in eval_stmt e2 s1
    | SIf  (b, e1, e2) ->
        if eval_bool b s then eval_stmt e1 s else eval_stmt e2 s
    | SWhile (b, e) ->
        if eval_bool b s then let s' = eval_stmt e s in
          eval_stmt (SWhile (b, e)) s'
        else s
  (*@ r = eval_stmt e s
        diverges
        ensures r = eval_stmt e s *)

  let[@lemma] (* rec *) eval_determ (e: stmt_expr) (s: state) (s': state) = ()
  (*@ eval_determ e s s'
        requires eval_stmt e s = s'
        ensures  forall s'': state. eval_stmt e s = s'' -> s' = s'' *)
end

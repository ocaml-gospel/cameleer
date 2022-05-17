module Arith (X: sig
    type elt

    val eq : elt -> elt -> bool
  end) =
struct

  type arith =
    | AConst of int
    | AVar of X.elt
    | AMul of arith * arith
    | APlus of arith * arith
    | AMinus of arith * arith

  type store = X.elt -> int

  (*@ inductive sems_arith (a: arith) (s: store) (n: int) =
      | const: forall s n. sems_arith (AConst n) s n
      | var: forall s x. sems_arith (AVar x) s (s x)
      | mul: forall s: store, a1: arith, a2: arith, n1 n2.
             sems_arith a1 s n1 -> sems_arith a2 s n2 ->
             sems_arith (AMul a1 a2) s (n1 * n2)
      | plus: forall s a1 a2 n1 n2.
             sems_arith a1 s n1 -> sems_arith a2 s n2 ->
             sems_arith (APlus a1 a2) s (n1 + n2)
      | minus: forall s a1 a2 n1 n2.
             sems_arith a1 s n1 -> sems_arith a2 s n2 ->
             sems_arith (AMinus a1 a2) s (n1 - n2) *)

  let rec interpreter store = function
    | AConst n -> n
    | AVar x -> store x
    | AMul (a1, a2) ->
        interpreter store a1 * interpreter store a2
    | APlus (a1, a2) ->
        interpreter store a1 + interpreter store a2
    | AMinus (a1, a2) ->
        interpreter store a1 - interpreter store a2
  (*@ r = interpreter s a
        variant a
        ensures sems_arith a s r *)

end

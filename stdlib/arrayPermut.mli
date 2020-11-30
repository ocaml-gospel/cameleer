(*@ open SeqPerm *)

(*@ predicate occ_eq (a1: 'a array) (a2: 'a array) (l: integer) (u: integer) =
      forall v: 'a. SeqPerm.occ v a1 l u = SeqPerm.occ v a2 l u *)

(*@ predicate permut (a1: 'a array) (a2: 'a array) (l: integer) (u: integer) =
      Array.length a1 = Array.length a2 /\ 0 <= l <= Array.length a1 /\
      0 <= u <= Array.length a1 /\ occ_eq a1 a2 l u *)

(*@ predicate permut_all (a1: 'a array) (a2: 'a array) =
      Array.length a1 = Array.length a2 /\
      permut a1 a2 0 (Array.length a1) *)

(*@ open Permut *)

module type PRE_ORD = sig
  type t

  (*@ function le: t -> t -> bool *)

  (*@ predicate total_preorder (leq: t -> t -> bool) =
      (forall x. leq x x) /\
      (forall x y. leq x y \/ leq y x) /\
      (forall x y z. (leq x y -> leq y z -> leq x z)) *)

  (*@ axiom is_total_preorder: total_preorder le *)

  val leq : t -> t -> bool
  (*@ b = leq x y
        ensures b <-> le x y *)

  (*@ predicate sorted_list (l: t list) *)
  (*@ axiom sorted_nil: sorted_list [] *)
  (*@ axiom sorted_singleton: forall x. sorted_list (x :: []) *)
  (*@ axiom sorted_cons: forall x y l.
        le x y -> sorted_list (y :: l) -> sorted_list (x :: (y :: l)) *)
  (*@ axiom sorted_list_inversion: forall l.
        sorted_list l ->
          (l = []) \/ (exists x. l = x :: []) \/
          (exists x y ll. le x y /\ sorted_list (y :: ll) /\ l = x :: y :: l) *)
end

module Make (E: PRE_ORD) = struct

  type elt = E.t

  (*@ lemma sorted_mem: forall x l.
        (forall y. List.mem y l -> le x y) /\ sorted_list l <->
        sorted_list (x :: l) *)

  (*@ lemma sorted_append: forall l1 l2.
        (sorted_list l1 && sorted_list l2 &&
          (forall x y. List.mem x l1 -> List.mem y l2 -> le x y)) <->
        sorted_list (l1 ++ l2) *)

  let rec merge l1 l2 = match l1, l2 with
    | [], l | l, [] -> l
    | x :: xs, y :: ys ->
        if E.leq x y then x :: (merge xs l2)
        else y :: (merge l1 ys)
  (*@ r = merge l1 l2
        requires sorted_list l1 && sorted_list l2
        variant  l1, l2
        ensures  sorted_list r
        ensures  permut r (l1 @ l2) *)

  let split l0 =
    let rec split_aux (pref: elt list) (n0 : int [@ghost]) n l =
      if n = 0 then List.rev pref, l
      else match l with
        | [] -> assert false
        | x :: xs -> split_aux (x :: pref) n0 (n-1) xs
    (*@ (l1, l2) = split_aux pref n0 n l
          requires 0 <= n <= List.length l
          requires n <= n0 <= List.length l0
          requires List.length pref = n0 - n
          requires l0 = List.rev pref @ l
          variant  n
          ensures  permut l0 (l1 @ l2)
          ensures  List.length l1 = n0 &&
                   List.length l2 = List.length l0 - n0 *)
    in
    let n = List.length l0 / 2 in
    split_aux [] n n l0
  (*@ (l1, l2) = split l0
        requires List.length l0 >= 2
        ensures  permut l0 (l1 @ l2)
        ensures  1 <= List.length l1 /\ 1 <= List.length l2 *)

  let rec mergesort l = match l with
    | [] | [_] -> l
    | _ -> let l1, l2 = split l in merge (mergesort l1) (mergesort l2)
  (*@ r = mergesort l
        variant List.length l
        ensures sorted_list r && permut r l *)
end

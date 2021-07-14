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
end

module Make (E: PRE_ORD) = struct

  type elt = E.t

  let[@logic] rec sorted_list = function
    | [] | [_] -> true
    | x :: (y :: r) -> E.leq x y && sorted_list (y :: r)
  (*@ sorted_list l
        variant l *)

  (*@ lemma sorted_mem: forall x l.
        (forall y. List.mem y l -> le x y) /\ sorted_list l <->
        sorted_list (x :: l) *)

  (*@ lemma sorted_append: forall l1 l2.
        (sorted_list l1 && sorted_list l2 &&
          (forall x y. List.mem x l1 -> List.mem y l2 -> le x y)) <->
        sorted_list (l1 ++ l2) *)

  let rec merge_aux acc l1 l2 =
    match l1, l2 with
    | [], l | l, [] -> List.rev_append acc l
    | x :: xs, y :: ys ->
        if E.leq x y then merge_aux (x :: acc) xs l2
                     else merge_aux (y :: acc) l1 ys
  (*@ r = merge_aux acc l1 l2
        requires sorted_list (List.rev acc) && sorted_list l1 && sorted_list l2
        requires forall x y. List.mem x acc -> List.mem y l1 -> le x y
        requires forall x y. List.mem x acc -> List.mem y l2 -> le x y
        ensures  sorted_list r
        ensures  permut r (acc @ l1 @ l2)
        variant  l1, l2 *)

  let merge l1 l2 = merge_aux [] l1 l2
  (*@ r = merge l1 l2
        requires sorted_list l1 && sorted_list l2
        ensures  sorted_list r  && permut r (l1 @ l2) *)

  let split l0 =
    let n0 = List.length l0 / 2 in
    let rec split_aux (pref: elt list) n l =
      if n = 0 then List.rev pref, l
      else match l with
        | [] -> assert false
        | x :: xs -> split_aux (x :: pref) (n-1) xs
    (*@ (l1, l2) = split_aux pref n l
          requires 0 <= n <= List.length l
          requires n <= n0 <= List.length l0
          requires List.length pref = n0 - n
          requires l0 = List.rev pref @ l
          ensures  permut l0 (l1 @ l2)
          ensures  List.length l1 = n0 &&
                   List.length l2 = List.length l0 - n0
          variant  n *)
    in
    split_aux [] n0 l0
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

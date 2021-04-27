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

module InsertionSort (E: PRE_ORD) = struct

  type elt = E.t

  (*@ lemma sorted_mem: forall x l.
        (forall y. List.mem y l -> le x y) /\ sorted_list l <->
        sorted_list (x :: l) *)

  (*@ lemma sorted_append: forall l1 l2.
        (sorted_list l1 && sorted_list l2 &&
          (forall x y. List.mem x l1 -> List.mem y l2 -> le x y)) <->
        sorted_list (l1 ++ l2) *)

  let rec insert x = function
    | [] -> [x]
    | y :: l -> if E.leq x y then x :: y :: l else y :: (insert x l)
  (*@ l = insert x param
        requires sorted_list param
        variant  param
        ensures  permut (x :: param) l
        ensures  sorted_list l *)

  let rec insertion_sort = function
    | [] -> []
    | x :: l -> insert x (insertion_sort l)
  (*@ l = insertion_sort param
        variant param
        ensures permut param l
        ensures sorted_list l *)
end

(*@ predicate mem (x: 'a) (l: 'a list) =
      match l with
      | []     -> false
      | y :: r -> x = y \/ mem x r *)

(*@ function num_occ (x: 'a) (l: 'a list) : integer =
      match l with
      | [] -> 0
      | y :: r -> (if x = y then 1 else 0) + num_occ x r *)

(*@ predicate permut (l1 l2: 'a list) =
      forall x: 'a. num_occ x l1 = num_occ x l2 *)

(*@ lemma permut_refl: forall l: 'a list. permut l l *)

(*@ lemma permut_sym: forall l1 l2: 'a list. permut l1 l2 -> permut l2 l1 *)

(*@ lemma permut_trans:
      forall l1 l2 l3: 'a list. permut l1 l2 -> permut l2 l3 -> permut l1 l3 *)

(*@ lemma permut_cons:
      forall x: 'a, l1 l2: 'a list.
      permut l1 l2 -> permut (x :: l1) (x :: l2) *)

(*@ lemma permut_swap:
      forall x y: 'a, l: 'a list. permut (x :: y :: l) (y :: x :: l) *)

(*@ lemma permut_cons_append:
      forall x : 'a, l1 l2 : 'a list.
      permut ((x :: l1) ++ l2) (l1 ++ (x :: l2)) *)

(*@ lemma permut_assoc:
      forall l1 l2 l3: 'a list.
      permut ((l1 ++ l2) ++ l3) (l1 ++ (l2 ++ l3)) *)

(*@ lemma permut_append:
      forall l1 l2 k1 k2 : 'a list.
      permut l1 k1 -> permut l2 k2 -> permut (l1 ++ l2) (k1 ++ k2) *)

(*@ lemma permut_append_swap:
      forall l1 l2 : 'a list.
      permut (l1 ++ l2) (l2 ++ l1) *)

(*@ lemma permut_mem:
      forall x: 'a, l1 l2: 'a list. permut l1 l2 -> mem x l1 -> mem x l2 *)

(*@ lemma permut_length:
      forall l1 [@induction] l2: 'a list. permut l1 l2 ->
      length l1 = length l2 *)

module type PRE_ORD = sig
  type t

  (*@ function le: t -> t -> bool *)

  (*@ predicate total_preorder (leq: t -> t -> bool) =
      (forall x. leq x x) /\
      (forall x y. leq x y \/ leq y x) /\
      (forall x y z. (leq x y -> leq y z -> leq x z)) *)

  (*@ axiom is_total_preorder: total_preorder le *)

  (*@ axiom trans: forall x y z. le x y -> le y z -> le x z *)

  val leq : t -> t -> bool
  (** [leq x y] shall return [true] iff [x] is lower or equal to [y]. *)
  (*@ b = leq x y
        ensures b <-> le x y *)

  (*@ predicate sorted_list (l: t list) *)
  (*@ axiom sorted_nil: sorted_list [] *)
  (*@ axiom sorted_singleton: forall x. sorted_list (x :: []) *)
  (*@ axiom sorted_cons: forall x y l.
        le x y -> sorted_list (y :: l) -> sorted_list (x :: (y :: l)) *)

  (*@ lemma sorted_mem: forall x l.
        (forall y. mem y l -> le x y) /\ sorted_list l <->
        sorted_list (x :: l) *)

  (*@ lemma sorted_append: forall l1 l2.
        (sorted_list l1 && sorted_list l2 &&
          (forall x y. mem x l1 -> mem y l2 -> le x y))
        <->
        sorted_list (l1 ++ l2) *)

end

module InsertionSort (E: PRE_ORD) = struct

  type elt = E.t

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

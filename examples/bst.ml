module type OrderedType = sig
  type t

  (*@ function cmp : t -> t -> integer *)

  (*@ predicate is_pre_order (cmp: 'a -> 'a -> int) =
        (forall x. cmp x x = 0) /\
        (forall x y. cmp x y = 0 <-> cmp y x = 0) /\
        (forall x y. cmp x y < 0 <-> cmp y x > 0) /\
        (forall x y z.
          (cmp x y = 0 -> cmp y z = 0 -> cmp x z = 0) /\
          (cmp x y = 0 -> cmp y z < 0 -> cmp x z < 0) /\
          (cmp x y < 0 -> cmp y z = 0 -> cmp x z < 0) /\
          (cmp x y < 0 -> cmp y z < 0 -> cmp x z < 0)) *)

  (*@ predicate equal (cmp: 'a -> 'a -> int) =
        forall x y: 'a. cmp x y = 0 -> x = y *)

  (*@ axiom is_pre_order: is_pre_order cmp && equal cmp *)

  val compare : t -> t -> int
  (*@ r = compare x y
        ensures r = cmp x y *)
end

module Make (Ord: OrderedType) = struct
  type elt = Ord.t

  type t = E | T of t * elt * t

  (*@ function occ (x: elt) (t: t) : integer = match t with
        | E -> 0
        | T l v r -> occ x l + occ x r + (if Ord.cmp x v = 0 then 1 else 0) *)

  (*@ lemma occ_nonneg: forall x: elt, t: t. occ x t >= 0 *)

  (*@ predicate mem (x: elt) (t: t) = occ x t > 0 *)

  (*@ predicate bst (t: t) = match t with
        | E -> true
        | T l v r ->
            (forall lv. mem lv l -> Ord.cmp lv v < 0) &&
            (forall rv. mem rv r -> Ord.cmp rv v > 0) &&
            bst l && bst r *)

  let empty = E
  (*@ r = empty
        ensures forall x. occ x r = 0
        ensures bst r *)

  let rec insert x = function
    | E -> T (E, x, E)
    | T (l, y, r) ->
        if Ord.compare x y = 0 then T (l, y, r)
        else if Ord.compare x y < 0 then T (insert x l, y, r)
        else T (l, y, insert x r)
  (*@ t = insert x param
        requires bst param
        variant  param
        ensures  forall y. y <> x -> occ y t = occ y param
        ensures  occ x t = occ x param || occ x t = 1 + occ x param
        ensures  bst t *)

  let rec mem x = function
    | E -> false
    | T (l, v, r) ->
        let c = Ord.compare x v in
        c = 0 || mem x (if c < 0 then l else r)
  (*@ b = mem x param
        requires bst param
        variant  param
        ensures  b <-> mem x param *)
end

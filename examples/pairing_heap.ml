module type Ord = sig
  type t

  (*@ function cmp: t -> t -> int *)

  (*@ predicate is_pre_order (cmp: 'a -> 'a -> int) =
    (forall x. cmp x x = 0) /\
    (forall x y. cmp x y = 0 <-> cmp y x = 0) /\
    (forall x y. cmp x y < 0 <-> cmp y x > 0) /\
    (forall x y z.
      (cmp x y = 0 -> cmp y z = 0 -> cmp x z = 0) /\
      (cmp x y = 0 -> cmp y z < 0 -> cmp x z < 0) /\
      (cmp x y < 0 -> cmp y z = 0 -> cmp x z < 0) /\
      (cmp x y < 0 -> cmp y z < 0 -> cmp x z < 0)) *)

  (*@ axiom is_pre_order: is_pre_order cmp *)

  val compare : t -> t -> int
  (*@ r = compare x y
        ensures r = cmp x y *)
end

module Make (O: Ord) = struct

  type elt = O.t

  type tree =
    | E
    | T of O.t * tree list

  type heap = tree

  (*@ function mod (h: heap) : O.t Bag.bag *)

  let is_empty t =
    match t with
    | E -> true
    | T (_, _) -> false
  (*@ r = is_empty t
        ensures r <-> mod t = Bag.empty_bag *)

end

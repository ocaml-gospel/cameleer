
module Make (O: sig
    type t

    (*@ function cmp: t -> t -> int *)

    (*@ axiom is_pre_order: Order.is_pre_order cmp *)

    val compare : t -> t -> int
    (*@ r = compare x y
          ensures r = cmp x y *)
  end)
= struct

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

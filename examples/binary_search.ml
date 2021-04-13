(*@ predicate is_sorted (a: int array) =
      forall i1 i2. 0 <= i1 <= i2 < Array.length a -> a.(i1) <= a.(i2) *)

let binary_search a v =
  let l = ref 0 in
  let u = ref (Array.length a - 1) in
  let exception Found of int in
  try while !l <= !u do
      (*@ variant   !u - !l
          invariant 0 <= !l && !u < Array.length a
          invariant forall i. 0 <= i < Array.length a -> a.(i) = v ->
            !l <= i <= !u *)
      let m = !l + (!u - !l) / 2 in
      if a.(m) < v then
        l := m + 1
      else if a.(m) > v then
        u := m - 1
      else
        raise (Found m)
    done;
    raise Not_found
  with Found i -> i
(*@ i = binary_search a v
      requires is_sorted a
      raises   Not_found -> forall i. 0 <= i < Array.length a -> a.(i) <> v
      ensures  0 <= i < Array.length a && a.(i) = v *)

module BinarySearch = struct
  let binary_search (compare: 'a -> 'a -> int) (a: 'a array) (v: 'a) =
    let l = ref 0 in
    let u = ref (Array.length a - 1) in
    let exception Found of int in
    try while !l <= !u do
      (*@ variant   !u - !l
          invariant 0 <= !l && !u < Array.length a
          invariant forall i. 0 <= i < Array.length a ->
            compare a.(i) v = 0 -> !l <= i <= !u *)
        let m = !l + (!u - !l) / 2 in
        let c = compare a.(m) v in
        if c < 0 then
          l := m + 1
        else if c > 0 then
          u := m - 1
        else
          raise (Found m)
      done;
      raise Not_found
    with Found i -> i
  (*@ i = binary_search_1 compare a v
          requires is_pre_order compare
          requires forall i j. 0 <= i <= j < Array.length a ->
                     compare a.(i) a.(j) <= 0
          raises   Not_found -> forall i. 0 <= i < Array.length a ->
                     compare a.(i) v <> 0
          ensures  0 <= i < Array.length a && compare a.(i) v = 0 *)
end

module type OrderedType = sig
  type t

  val[@logic] cmp: t -> t -> int
  (*@ axiom is_pre_order_cmp: is_pre_order cmp *)
end

module type BS = sig
  type elt

  (*@ function cmp (x: elt) (y: elt) : int *)
  (*@ axiom is_pre_order_cmp : is_pre_order cmp *)

  val binary_search : elt array -> elt -> int
  (*@ i = binary_search_2 a v
        requires forall i j. 0 <= i <= j < Array.length a ->
          cmp a.(i) a.(j) <= 0
        raises   Not_found -> forall i. 0 <= i < Array.length a ->
          cmp a.(i) v <> 0
        ensures  0 <= i < Array.length a && cmp a.(i) v = 0 *)
end

module Make (Ord: OrderedType) : BS with type elt = Ord.t
                                 [@gospel "with function cmp = Ord.cmp"]
= struct
  type elt = Ord.t

  (*@ function cmp (x: elt) (y: elt) : int = Ord.cmp x y *)

  (*@ predicate is_sorted (a: elt array) = forall i1 i2.
        0 <= i1 <= i2 < Array.length a -> cmp a.(i1) a.(i2) <= 0 *)

  let binary_search a v =
    let l = ref 0 in
    let u = ref (Array.length a - 1) in
    let exception Found of int in
    try while !l <= !u do
      (*@ variant   !u - !l
          invariant 0 <= !l && !u < Array.length a
          invariant forall i. 0 <= i < Array.length a ->
            cmp a.(i) v = 0 -> !l <= i <= !u *)
        let m = !l + (!u - !l) / 2 in
        let c = Ord.cmp a.(m) v in
        if c < 0 then
          l := m + 1
        else if c > 0 then
          u := m - 1
        else
          raise (Found m)
      done;
      raise Not_found
    with Found i -> i
  (*@ i = binary_search a v
          requires is_sorted a
          raises   Not_found -> forall i. 0 <= i < Array.length a ->
                     cmp a.(i) v <> 0
          ensures  0 <= i < Array.length a && cmp a.(i) v = 0 *)
end

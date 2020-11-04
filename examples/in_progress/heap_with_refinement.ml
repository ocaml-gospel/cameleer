module type S = sig
  type elt
  type t

  val [@logic] size : t -> int
  (** Number of elements (linear complexity). *)

  (*@ function occ (x: elt) (t: t) : integer *)

  (*@ function minimum (t: t) : elt *)

  val [@logic] empty : t
  (** Empty heap. *)
  (*@ r = empty
        ensures size r = 0
        ensures forall x. occ x r = 0 *)

  val is_empty : t -> bool
  (** Is the heap empty? *)
  (*@ b = is_empty t
        ensures b <-> size t = 0 *)

  exception Empty

  val merge : t -> t -> t
  (** Merge two heaps. *)
  (*@ r = merge h1 h2
        ensures forall x. occ x r = occ x h1 + occ x h2
        ensures size r = size h1 + size h2 *)
end

module Make : S = struct
  type elt = int

  type t = E | N of int * elt * t * t

  let empty = E
  (*@ r = empty
        ensures r = E *)

    (*@ function occ (x: elt) (h: t) : integer = match h with
        | E -> 0
        | N _ e l r -> let occ_lr = occ x l + occ x r in
            if x = e then 1 + occ_lr else occ_lr *)

  let [@lemma] rec occ_nonneg (y: elt) = function
    | E -> ()
    | N (_, _, l, r) -> occ_nonneg y l; occ_nonneg y r
  (*@ occ_nonneg y param
        ensures 0 <= occ y param *)

  (*@ predicate mem_heap (x: elt) (h: t) =
        0 < occ x h *)

  (*@ predicate le_root (e: elt) (h: t) = match h with
        | E -> true
        | N _ x _ _ -> e <= x *)

  let [@lemma] le_root_trans (_x: elt) (_y: elt) = function
    | E -> ()
    | N (_, _, _, _) -> ()
  (*@ le_root_trans x y param
        requires _x <= _y
        requires le_root _y param
        ensures  le_root _x param *)

  (*@ predicate is_heap (h: t) = match h with
        | E -> true
        | N _ x l r -> le_root x l && is_heap l && le_root x r && is_heap r *)

  (*@ function minimum (h: t) : elt *)
  (*@ axiom minimum_def: forall l x r n. minimum (N n x l r) = x *)

  let is_empty = function
    | E -> true
    | N (_, _, _, _) -> false
  (*@ b = is_empty param
        ensures b <-> param = E *)

  exception Empty

  let _rank = function
    | E -> 0
    | N (r, _, _, _) -> r

  (* Make a balanced node labelled with [x], and subtrees [a] and [b].
     We ensure that the right child's rank is ≤ to the rank of the
     left child (leftist property). The rank of the resulting node
     is the length of the rightmost path. *)
  let _make_node x a b =
    if _rank a >= _rank b
    then N (_rank b + 1, x, a, b)
    else N (_rank a + 1, x, b, a)

  let[@logic] rec size = function
    | E -> 0
    | N (_,_ , l, r) -> 1 + size l + size r
  (*@ r = size param
        ensures 0 <= r
        ensures r = 0 <-> param = E *)

  let rec merge t1 t2 =
    match t1, t2 with
    | t, E -> t
    | E, t -> t
    | N (_, x, a1, b1), N (_, y, a2, b2) ->
        if x <= y
        then _make_node x a1 (merge b1 t2)
        else _make_node y a2 (merge t1 b2)
  (*@ r = merge t1 t2
        ensures size r = size t1 + size t2
        ensures forall x. occ x r = occ x t1 + occ x t2
        variant size t1 + size t2 *)
end

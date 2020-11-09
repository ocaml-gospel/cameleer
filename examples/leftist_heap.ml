module type PRE_ORD = sig
  type t

  (*@ predicate le (x: t) (y: t) *)

  (*@ axiom reflexive : forall x. le x x *)
  (*@ axiom total     : forall x y. le x y \/ le y x *)
  (*@ axiom transitive: forall x y z. le x y -> le y z -> le x z *)

  val leq : t -> t -> bool
  (*@ b = leq x y
        ensures b <-> le x y *)
end

module type S = sig
  type elt
  (*@ predicate le (x: elt) (y: elt) *)

  (*@ axiom reflexive : forall x. le x x *)
  (*@ axiom total     : forall x y. le x y \/ le y x *)
  (*@ axiom transitive: forall x y z. le x y -> le y z -> le x z *)

  type t

  (*@ predicate leftist (h: t) *)

  val [@logic] size : t -> int
  (** Number of elements (linear complexity). *)
  (*@ r = size t
        ensures 0 <= r *)

  (*@ function occ (x: elt) (t: t) : integer *)

  (*@ predicate mem (x: elt) (h: t) *)

  (*@ function minimum (t: t) : elt *)

  (*@ predicate is_minimum (x: elt) (h: t) *)

  (*@ axiom is_minimum_def: forall x h.
        is_minimum x h <->
        (mem x h && forall e. mem e h -> le x e) *)

  (*@ predicate is_heap (t: t) *)

  (*@ axiom min_def:
        forall h. 0 < size h -> is_heap h -> is_minimum (minimum h) h *)

  (*@ predicate leftist_heap (h: t) *)

  val [@logic] empty : t
  (** Empty heap. *)
  (*@ r = empty
        ensures size r = 0
        ensures forall x. occ x r = 0 *)

  val [@logic] is_empty : t -> bool
  (** Is the heap empty? *)
  (*@ b = is_empty t
        requires leftist_heap t
        ensures  b <-> size t = 0 *)

  exception Empty

  val merge : t -> t -> t
  (** Merge two heaps. *)
  (*@ r = merge h1 h2
        requires leftist_heap h1 && leftist_heap h2
        ensures  leftist_heap r
        ensures  forall x. occ x r = occ x h1 + occ x h2
        ensures  size r = size h1 + size h2 *)

  val insert : elt -> t -> t
  (** Insert a value in the heap. *)
  (*@ r = insert x t
        requires leftist_heap t
        ensures  leftist_heap r
        ensures  occ x r = occ x t + 1
        ensures  forall y. y <> x -> occ y t = occ y r
        ensures  size r = size t + 1 *)

  val filter :  (elt -> bool) -> t -> t
  (** Filter values, only retaining the ones that satisfy the predicate.
      Linear time at least. *)
  (*@ r = filter p t
        requires leftist_heap t
        ensures  leftist_heap r
        ensures  forall x. not (p x) -> occ x r = 0
        ensures  forall x. p x -> occ x r = occ x t *)

  val find_min : t -> elt option
  (** Find minimal element. *)
  (*@ r = find_min t
        requires leftist_heap t
        ensures match r with
                | None -> is_empty t
                | Some x -> x = minimum t *)

  val find_min_exn : t -> elt
  (** Like {!find_min} but can fail.
      @raise Empty if the heap is empty. *)
  (*@ r = find_min_exn t
        requires leftist_heap t
        raises   Empty -> is_empty t
        ensures  r = minimum t *)

  val delete_all : (elt -> elt -> bool) -> elt -> t -> t
  (** Delete all occurrences of a value in the heap.
      [delete_all eq x h], use [eq] to find all [x] in [h] and delete them.
      If [h] do not contain [x] then it return [h].
      The difference with {!filter} is that [delete_all] stops as soon as
      it enters a subtree whose root is bigger than the element.
      @since 2.0 *)
  (*@ r = delete_all eq x t
        requires forall a b. a = b <-> eq a b
        requires leftist_heap t
        ensures  leftist_heap r
        ensures  occ x r = 0
        ensures  forall y. x <> y -> occ y r = occ y t
        ensures  size r = size t - occ x t *)

end

module Make (E: PRE_ORD) : S with type elt = E.t
                             [@gospel "with predicate le = E.le"] = struct
  type elt = E.t

  (*@ predicate le (x: elt) (y: elt) = E.le x y *)

  type t =
    | E
    | N of int * elt * t * t

  (*@ function rank (h: t) : integer = match h with
        | E -> 0
        | N _ _ l r -> 1 + min (rank l) (rank r) *)

  (*@ predicate leftist (h: t) = match h with
        | E -> true
        | N n _ l r ->
            n = rank h && leftist l && leftist r && rank l >= rank r *)

  let[@logic] rec size = function
    | E -> 0
    | N (_,_ , l, r) -> 1 + size l + size r
  (*@ r = size param
        ensures 0 <= r
        ensures r = 0 <-> param = E *)

  (*@ function occ (x: elt) (h: t) : integer = match h with
        | E -> 0
        | N _ e l r -> let occ_lr = occ x l + occ x r in
            if x = e then 1 + occ_lr else occ_lr *)

  let [@lemma] rec occ_nonneg (y: elt) = function
    | E -> ()
    | N (_, _, l, r) -> occ_nonneg y l; occ_nonneg y r
  (*@ occ_nonneg y param
        ensures 0 <= occ y param *)

  (*@ predicate mem (x: elt) (h: t) =
        0 < occ x h *)

  (*@ predicate le_root (e: elt) (h: t) = match h with
        | E -> true
        | N _ x _ _ -> E.le e x *)

  let [@lemma] le_root_trans (x: elt) (y: elt) = function
    | E -> ()
    | N (_, _, _, _) -> ()
  (*@ le_root_trans x y param
        requires E.le x y
        requires le_root y param
        ensures  le_root x param *)

  (*@ predicate is_heap (h: t) = match h with
        | E -> true
        | N _ x l r -> le_root x l && is_heap l && le_root x r && is_heap r *)

  (*@ function minimum (h: t) : elt *)
  (*@ axiom minimum_def: forall l x r n. minimum (N n x l r) = x *)

  (*@ predicate is_minimum (x: elt) (h: t) =
        mem x h && forall e. mem e h -> le x e *)

  let [@lemma] rec root_is_minimum = function
    | E -> assert false
    | N (_, _, l, r) ->
        begin match l with E -> () | _ -> root_is_minimum l end;
        match r with E -> () | _ -> root_is_minimum r
  (*@ root_is_minimum param
       requires is_heap param && 0 < size param
       ensures  is_minimum (minimum param) param
       variant  param *)

  (*@ predicate leftist_heap (h: t) =
        is_heap h && leftist h *)

  let empty = E
  (*@ r = empty
        ensures r = E *)

  let[@logic] is_empty = function
    | E -> true
    | N (_, _, _, _) -> false
  (*@ b = is_empty param
        ensures b <-> param = E *)

  exception Empty

  (* Rank of the tree *)
  let _rank = function
    | E -> 0
    | N (r, _, _, _) -> r
  (*@ r = _rank param
        requires leftist_heap param
        ensures  r = rank param *)

  let _make_node x a b =
    if _rank a >= _rank b
    then N (_rank b + 1, x, a, b)
    else N (_rank a + 1, x, b, a)
  (*@ h = _make_node x a b
        requires leftist_heap a && leftist_heap b
        requires le_root x a && le_root x b
        ensures  leftist_heap h
        ensures  minimum h = x
        ensures  size h = 1 + size a + size b
        ensures  occ x h = 1 + occ x a + occ x b
        ensures  forall y. x <> y -> occ y h = occ y a + occ y b *)

  let rec merge t1 t2 = match t1, t2 with
    | t, E | E, t -> t
    | N (_, x, a1, b1), N (_, y, a2, b2) ->
        if E.leq x y
        then _make_node x a1 (merge b1 t2)
        else _make_node y a2 (merge t1 b2)
  (*@ h = merge t1 t2
        requires leftist_heap t1 && leftist_heap t2
        ensures  size h = size t1 + size t2
        ensures  forall x. occ x h = occ x t1 + occ x t2
        ensures  leftist_heap h
        variant  size t1 + size t2 *)

  let insert x h =
    merge (N(1,x,E,E)) h
  (*@ new_h = insert x h
        requires leftist_heap h
        ensures  leftist_heap new_h
        ensures  size new_h = 1 + size h
        ensures  occ x new_h = 1 + occ x h
        ensures  forall y. x <> y -> occ y new_h = occ y h *)

  let add h x = insert x h
  (*@ new_h = insert x h
        requires leftist_heap h
        ensures  leftist_heap new_h *)

  let rec filter p = function
    | E -> E
    | N (_, x, l, r) ->
        if p x then _make_node x (filter p l) (filter p r)
        else merge (filter p l) (filter p r)
  (*@ h = filter p param
        requires leftist_heap param
        variant  param
        ensures  leftist_heap h
        ensures  forall x. not (p x) -> occ x h = 0
        ensures  forall x. p x -> occ x h = occ x param *)

  let find_min_exn = function
    | E -> raise Empty
    | N (_, x, _, _) -> x
  (*@ r = find_min_exn param
        requires leftist_heap param
        raises   Empty -> is_empty param
        ensures  r = minimum param *)

  let find_min = function
    | E -> None
    | N (_, x, _, _) -> Some x
  (*@ r = find_min param
        requires leftist_heap param
        ensures  match r with
                 | None -> is_empty param
                 | Some x -> x = minimum param *)

  let take = function
    | E -> None
    | N (_, x, l, r) -> Some (merge l r, x)
  (*@ r = take param
        requires leftist_heap param
        ensures  match r with
                 | None -> is_empty param
                 | Some (h, x) ->
                     x = minimum param && (* minimum element *)
                     occ (minimum param) h = occ (minimum param) param - 1 &&
                     forall y. y <> minimum param -> occ y param = occ y h &&
                     size h = size param - 1 &&
                     leftist_heap h *)

  let rec delete_all eq x = function
    | E -> E
    | N (_, y, l, r) as h ->
        if eq x y then merge (delete_all eq x l) (delete_all eq x r)
        else if E.leq y x then
          _make_node y (delete_all eq x l) (delete_all eq x r)
        else h
  (*@ h = delete_all eq x param
        requires leftist_heap param
        requires forall a b. a = b <-> eq a b
        variant  param
        ensures  leftist_heap h
        ensures  occ x h = 0
        ensures  forall y. x <> y -> occ y h = occ y param
        ensures  size h = size param - occ x param *)
end


(* This file is free software, part of containers. See file "license" for more details. *)

(** {1 Leftist Heaps} *)

(* type 'a iter = ('a -> unit) -> unit
 * type 'a gen = unit -> 'a option
 * type 'a printer = Format.formatter -> 'a -> unit
 * type 'a ktree = unit -> [`Nil | `Node of 'a * 'a ktree list] *)

module type PRE_ORD = sig
  type t

  (*@ function le: t -> t -> bool *)

  (*@ predicate total_preorder (leq: t -> t -> bool) =
      (forall x. leq x x) /\
      (forall x y. leq x y \/ leq y x) /\
      (forall x y z. (leq x y -> leq y z -> leq x z)) *)

  (*@ axiom is_total_preorder: total_preorder le *)

  val leq : t -> t -> bool
  (** [leq x y] shall return [true] iff [x] is lower or equal to [y]. *)
  (*@ b = leq x y
        ensures b <-> le x y *)
end

module type TOTAL_ORD = sig
  type t
  val compare : t -> t -> int
  (** [compare a b] shall return
      a negative value if [a] is smaller than [b],
      [0] if [a] and [b] are equal or
      a positive value if [a] is greater than [b] *)
end

module type S = sig
  type elt
  type t

  val empty : t
  (** Empty heap. *)

  val is_empty : t -> bool
  (** Is the heap empty? *)

  exception Empty

  val merge : t -> t -> t
  (** Merge two heaps. *)

  val insert : elt -> t -> t
  (** Insert a value in the heap. *)

  val add : t -> elt -> t
  (** Synonym to {!insert}. *)

  val filter :  (elt -> bool) -> t -> t
  (** Filter values, only retaining the ones that satisfy the predicate.
      Linear time at least. *)

  val find_min : t -> elt option
  (** Find minimal element. *)

  val find_min_exn : t -> elt
  (** Like {!find_min} but can fail.
      @raise Empty if the heap is empty. *)

  val take : t -> (t * elt) option
  (** Extract and return the minimum element, and the new heap (without
      this element), or [None] if the heap is empty. *)

  val take_exn : t -> t * elt
  (** Like {!take}, but can fail.
      @raise Empty if the heap is empty. *)

  val delete_one : (elt -> elt -> bool) -> elt -> t -> t
  (** Delete one occurrence of a value if it exist in the heap.
      [delete_one eq x h], use [eq] to find one [x] in [h] and delete it.
      If [h] do not contain [x] then it return [h].
      @since 2.0 *)

  val delete_all : (elt -> elt -> bool) -> elt -> t -> t
  (** Delete all occurrences of a value in the heap.
      [delete_all eq x h], use [eq] to find all [x] in [h] and delete them.
      If [h] do not contain [x] then it return [h].
      The difference with {!filter} is that [delete_all] stops as soon as
      it enters a subtree whose root is bigger than the element.
      @since 2.0 *)

  val iter : (elt -> unit) -> t -> unit
  (** Iterate on elements. *)

  val fold : ('a -> elt -> 'a) -> 'a -> t -> 'a
  (** Fold on all values. *)

  val size : t -> int
  (** Number of elements (linear complexity). *)

  (** {2 Conversions} *)

  val to_list : t -> elt list
  (** Return the elements of the heap, in no particular order. *)

  val to_list_sorted : t -> elt list
  (** Return the elements in increasing order.
      @since 1.1 *)

  val add_list : t -> elt list -> t
  (** Add the elements of the list to the heap. An element occurring several
      times will be added that many times to the heap.
      @since 0.16 *)

  val of_list : elt list -> t
  (** [of_list l] is [add_list empty l]. Complexity: [O(n log n)]. *)

end

module Make(E : PRE_ORD) (*: S with type elt = E.t *) = struct
  type elt = E.t

  (*@ type 'a bag *)

  (*@ function nb_occ (x: 'a) (b: 'a bag): integer *)

  (*@ axiom occ_non_negative: forall b: 'a bag, x: 'a.
        nb_occ x b >= 0 *)

  (*@ predicate mem (x: 'a) (b: 'a bag) =
        nb_occ x b > 0 *)

  (*@ predicate eq_bag (a b: 'a bag) =
        forall x:'a. nb_occ x a = nb_occ x b *)

  (*@ axiom bag_extensionality: forall a b: 'a bag.
        eq_bag a b -> a = b *)

  (*@ function empty_bag: 'a bag *)

  (*@ axiom occ_empty: forall x: 'a. nb_occ x empty_bag = 0 *)

  (*@ function singleton (x: 'a) : 'a bag *)

  (*@ axiom occ_singleton: forall x y: 'a.
        nb_occ y (singleton x) = if x = y then 1 else 0 *)

  (*@ function union (x:'a bag) (y:'a bag) : 'a bag *)

  (* axiom occ_union: forall x: 'a, a b: 'a bag.
      nb_occ x (union a b) = nb_occ x a + nb_occ x b *)

    (** add operation *)

  (*@ function add (x: 'a) (b: 'a bag) : 'a bag =
        union (singleton x) b *)

  (** cardinality of bags *)

  (*@ function card (x:'a bag): integer *)

  (*@ axiom card_nonneg: forall x: 'a bag.
        card x >= 0 *)

  (*@ axiom card_empty: card (empty_bag: 'a bag) = 0 *)

  (*@ axiom card_zero_empty: forall x: 'a bag.
        card x = 0 -> x = empty_bag *)

  (*@ axiom card_singleton: forall x:'a.
        card (singleton x) = 1 *)

  (*@ axiom card_union: forall x y: 'a bag.
        card (union x y) = card x + card y *)

  (** bag difference *)

  (*@ function diff (x: 'a bag) (y: 'a bag) : 'a bag *)

  (*@ axiom diff_occ: forall b1 b2: 'a bag, x:'a.
      nb_occ x (diff b1 b2) = max 0 (nb_occ x b1 - nb_occ x b2) *)

  (** arbitrary element *)

  (*@ function choose (b: 'a bag) : 'a *)

  (*@ axiom choose_mem: forall b: 'a bag.
        empty_bag <> b -> mem (choose b) b *)

  type tree =
    | E
    | N of int * elt * tree * tree

  let[@logic] rec size = function
    | E -> 0
    | N (_,_,l,r) -> 1 + size l + size r
  (*@ r = size param
        ensures 0 <= r
        ensures r = 0 <-> param = E *)

  (*@ function occ (x: elt) (h: tree) : integer = match h with
        | E -> 0
        | N _ e l r -> let occ_lr = occ x l + occ x r in
            if x = e then 1 + occ_lr else occ_lr *)

  let [@lemma] rec occ_nonneg (y: elt) = function
    | E -> ()
    | N (_, _, l, r) -> occ_nonneg y l; occ_nonneg y r
  (*@ occ_nonneg y param
        ensures 0 <= occ y param *)

  (*@ predicate mem_heap (x: elt) (h: tree) =
        0 < occ x h *)

  (*@ predicate le_root (e: elt) (h: tree) = match h with
        | E -> true
        | N _ x _ _ -> E.le e x *)

  let [@lemma] le_root_trans (x: elt) (y: elt) = function
    | E -> ()
    | N (_, _, _, _) -> ()
  (*@ le_root_trans x y param
        requires E.le x y
        requires le_root y param
        ensures  le_root x param *)

  (*@ predicate is_heap (h: tree) = match h with
        | E -> true
        | N _ x l r -> le_root x l && is_heap l && le_root x r && is_heap r *)

  (*@ function minimum (h: tree) : elt *)
  (*@ axiom minimum_def: forall l x r n. minimum (N n x l r) = x *)

  (*@ predicate is_minimum (x: elt) (h: tree) =
        mem_heap x h && forall e. mem_heap e h -> le x e *)

  let [@lemma] rec root_is_miminum = function
    | E -> assert false
    | N (_, _, l, r) ->
        begin match l with E -> () | _ -> root_is_miminum l end;
        match r with E -> () | _ -> root_is_miminum r
  (*@ is_minimum param
       requires is_heap param && 0 < size param
       ensures  is_minimum (minimum param) param
       variant  param *)

  (*@ function rank (h: tree) : integer = match h with
        | E -> 0
        | N _ _ l r -> 1 + min (rank l) (rank r) *)

  (*@ predicate leftist (h: tree) = match h with
        | E -> true
        | N n _ l r ->
            n = rank h && leftist l && leftist r && rank l >= rank r *)

  (*@ predicate leftist_heap (h: tree) =
        is_heap h && leftist h *)

  type t = {
    h : tree;
  } (*@ model view : elt bag *)
    (*@ invariant leftist_heap h *)

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

  (* Make a balanced node labelled with [x], and subtrees [a] and [b].
     We ensure that the right child's rank is ≤ to the rank of the
     left child (leftist property). The rank of the resulting node
     is the length of the rightmost path. *)
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

  let rec merge t1 t2 =
    match t1, t2 with
      | t, E -> t
      | E, t -> t
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
        ensures  leftist_heap new_h *)

  let add h x = insert x h
  (*@ new_h = insert x h
        requires leftist_heap h
        ensures  leftist_heap new_h *)

  (* TODO: support guarded expressions *)
  (* let rec filter p h = match h with
   *   | E -> E
   *   | N(_, x, l, r) when p x -> _make_node x (filter p l) (filter p r)
   *   | N(_, _, l, r) ->
   *     merge (filter p l) (filter p r) *)

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
                 | Some x -> is_minimum x param *)

  let take = function
    | E -> None
    | N (_, x, l, r) -> Some (merge l r, x)
  (*@ r = take param
        requires leftist_heap param
        ensures  match r with
                 | None -> is_empty param
                 | Some (h, x) ->
                     is_minimum x param && (* minimum element *)
                     occ (minimum param) h = occ (minimum param) param - 1 &&
                     forall y. y <> minimum param -> occ y param = occ y h &&
                     size h = size param - 1 &&
                     leftist_heap h *)

  (* let take_exn = function
   *   | E -> raise Empty
   *   | N (_, x, l, r) -> merge l r, x *)

  (* let delete_one eq x h =
   *   let rec aux = function
   *     | E -> false, E
   *     | N(_, y, l, r) as h ->
   *       if eq x y then true, merge l r
   *       else (
   *         if E.leq y x
   *         then (
   *           let found_left, l1 = aux l in
   *           let found, r1 = if found_left then true, r else aux r in
   *           if found
   *           then true, _make_node y l1 r1
   *           else false, h
   *         )
   *         else false, h
   *       )
   *   in
   *   snd (aux h) *)

  let rec delete_all eq x = function
    | E -> E
    | N (_, y, l, r) as h ->
      if eq x y then merge (delete_all eq x l) (delete_all eq x r)
      else (
        if E.leq y x
        then _make_node y (delete_all eq x l) (delete_all eq x r)
        else h
      )

  let rec iter f h = match h with
    | E -> ()
    | N(_,x,l,r) -> f x; iter f l; iter f r

  let rec fold f acc h = match h with
    | E -> acc
    | N (_, x, a, b) ->
      let acc = f acc x in
      let acc = fold f acc a in
      fold f acc b

  (** {2 Conversions} *)

  let to_list h =
    let rec aux acc h = match h with
      | E -> acc
      | N(_,x,l,r) ->
        x::aux (aux acc l) r
    in aux [] h

  (* let to_list_sorted heap =
   *   let rec recurse acc h = match take h with
   *     | None -> List.rev acc
   *     | Some (h',x) -> recurse (x::acc) h'
   *   in
   *   recurse [] heap *)

  (* let add_list h l = List.fold_left add h l *)

  (* let of_list l = add_list empty l *)

  (* let add_iter h i =
   *   let h = ref h in
   *   i (fun x -> h := insert x !h);
   *   !h *)

  (* let add_seq h seq =
   *   let h = ref h in
   *   Seq.iter (fun x -> h := insert x !h) seq;
   *   !h *)

  (* let of_iter i = add_iter empty i
   * let of_seq seq = add_seq empty seq *)

  let to_iter h k = iter k h

  (* let to_seq h =
   *   (\* use an explicit stack [st] *\)
   *   let rec aux st () =
   *     match st with
   *     | [] -> Seq.Nil
   *     | E :: st' -> aux st' ()
   *     | N(_,x,l,r) :: st' -> Seq.Cons (x, aux (l::r::st'))
   *   in aux [h] *)

  (* let to_iter_sorted heap =
   *   let rec recurse h k = match take h with
   *     | None -> ()
   *     | Some (h',x) -> k x; recurse h' k
   *   in
   *   fun k -> recurse heap k *)

  (* let rec to_seq_sorted h () = match take h with
   *   | None -> Seq.Nil
   *   | Some (h', x) -> Seq.Cons (x, to_seq_sorted h') *)

  let rec add_gen h g = match g () with
    | None -> h
    | Some x ->
      add_gen (add h x) g

  let of_gen g = add_gen empty g

  (* let to_gen h =
   *   let stack = Stack.create () in
   *   Stack.push h stack;
   *   let rec next () =
   *     if Stack.is_empty stack
   *     then None
   *     else match Stack.pop stack with
   *       | E -> next()
   *       | N (_, x, a, b) ->
   *         Stack.push a stack;
   *         Stack.push b stack;
   *         Some x
   *   in next *)

  (*$Q
    Q.(list int) (fun l -> \
      extract_list (H.of_list l) = \
        extract_list (H.of_gen (CCList.to_gen l)))
    Q.(list int) (fun l -> \
      let h = H.of_list l in \
      (H.to_gen h |> CCList.of_gen |> List.sort Stdlib.compare) \
        = (H.to_list h |> List.sort Stdlib.compare))
  *)

  (* let rec to_tree h () = match h with
   *   | E -> `Nil
   *   | N (_, x, l, r) -> `Node(x, [to_tree l; to_tree r]) *)

  (* let to_string ?(sep=",") elt_to_string h =
   *   to_list_sorted h
   *   |> List.map elt_to_string
   *   |> String.concat sep *)

  (*$Q
    Q.(list int) (fun l -> \
      let h = H.of_list l in \
      (H.to_string string_of_int h) \
        = (List.sort Stdlib.compare l |> List.map string_of_int |> String.concat ","))
    Q.(list int) (fun l -> \
      let h = H.of_list l in \
      (H.to_string ~sep:" " string_of_int h) \
        = (List.sort Stdlib.compare l |> List.map string_of_int |> String.concat " "))
  *)

  (* let pp ?(pp_start=fun _ () -> ()) ?(pp_stop=fun _ () -> ())
   *     ?(pp_sep=fun out () -> Format.fprintf out ",") pp_elt out h =
   *   let first=ref true in
   *   pp_start out ();
   *   iter
   *     (fun x ->
   *        if !first then first := false else pp_sep out ();
   *        pp_elt out x)
   *     h;
   *   pp_stop out (); *)
end

(* module Make_from_compare(E : TOTAL_ORD) =
 *   Make(struct
 *     type t = E.t
 *     let leq a b = E.compare a b <= 0
 *   end) *)

(*$QR
  Q.(list_of_size Gen.(return 1_000) int) (fun l ->
    let module H' = Make_from_compare(CCInt) in
    let h = H'.of_list l in
    let l' = H'.to_list_sorted h in
    is_sorted l'
  )
*)

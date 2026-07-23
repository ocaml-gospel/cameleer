type elt = int
type tree = Empty | Node of tree * elt * tree
type heap_type = E | T of elt * tree

(*@ predicate le (x y: int) = x <= y *)

(*@ axiom reflexive : forall x. le x x *)

(*@ axiom total     : forall x y. le x y \/ le y x *)

(*@ axiom transitive: forall x y z. le x y -> le y z -> le x z *)

(** Tree functions, predicates, lemmas *)
(*@ function tree_size (t: tree) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + tree_size l + tree_size r *)

(*@ lemma size_nonneg_tree: forall t: tree. tree_size t >= 0 *)

(*@ lemma size_empty_tree: forall t: tree. 0 = tree_size t <-> t = Empty *)

(*@ function tree_occ (v: elt) (t: tree) : integer = match t with
      | Empty -> 0
      | Node l x r -> tree_occ v l + tree_occ v r + (if x = v then 1 else 0) *)

(*@ lemma occ_nonneg_tree0: forall t: tree, x: elt. tree_occ x t >= 0 *)
(*@ lemma occ_nonneg_tree: forall x: elt, t: tree. tree_occ x t >= 0 *)

(*@ predicate mem_tree (x: elt) (t: tree) = 0 < tree_occ x t *)

(*@ predicate le_root_tree (e: elt) (t: tree) = match t with
      | Empty      -> true
      | Node _ x r -> le e x && le_root_tree e r *)

(*@ lemma le_root_tree_trans: forall x y t. le x y -> le_root_tree y t -> le_root_tree x t*)

(*@ predicate heap_tree (t: tree) = match t with
      | Empty      -> true
      | Node l x r -> le_root_tree x l && heap_tree l && heap_tree r *)

(*@ function minimum_tree (t: tree) : elt *)

(*@ axiom minimum_def_tree: forall l x r. minimum_tree (Node l x r) = x *)

(*@ predicate is_minimum_tree (x: elt) (t: tree) = mem_tree x t && forall e. mem_tree e t -> le x e *)

(** Heap functions, predicates, lemmas *)
(*@ function size (h: heap_type) : integer = match h with
      | E -> 0
      | T _ r -> 1 + tree_size r *)

(*@ lemma size_nonneg: forall h: heap_type. size h >= 0 *)

(*@ lemma size_empty: forall h: heap_type. size h = 0 <-> h = E *)

(*@ function occ (x: elt) (h: heap_type) : integer = match h with
      | E -> 0
      | T e t -> (if x = e then 1 else 0) + tree_occ x t *)

(*@ lemma occ_nonneg: forall x: elt, h: heap_type. occ x h >= 0 *)

(*@ predicate mem (x: elt) (h: heap_type) = 0 < occ x h *)

(*@ predicate le_root (e: elt) (h: heap_type) = match h with
      | E -> true
      | T x  _ -> le e x *)

(*@ lemma le_root_trans: forall x y h. le x y -> le_root y h -> le_root x h*)

(*@ predicate heap (h: heap_type) = match h with
      | E -> true
      | T x r -> le_root_tree x r && heap_tree r *)

(*@ function minimum (h: heap_type) : elt *)

(*@ axiom minimum_def: forall x r. minimum (T x r) = x *)

(*@ predicate is_minimum (x: elt) (h: heap_type) = mem x h && forall e. mem e h -> le x e *)

(*@ lemma mem_heap_tree: forall t. heap_tree t -> forall x. le_root_tree x t -> forall y. mem_tree y t -> le x y *)

(*@ lemma mem_heap: forall h. heap h -> forall x. le_root x h -> forall y. mem y h -> le x y *)

(*@ lemma root_is_minimum: forall h: heap_type. heap h -> 0 < size h -> is_minimum (minimum h) h *)

(** Pairing heaps specification *)

let empty: heap_type = (E: heap_type)

let merge (h1: heap_type) (h2: heap_type) : heap_type =
    match (h1 : heap_type), (h2 : heap_type) with
    | (E, (_: heap_type)) -> h2
    | ((_: heap_type), E) -> h1
    | (T ((x1: elt), (t1: tree)),
       T ((x2: elt), (t2: tree)))
      [@gospel "requires heap h1 && heap h2
                ensures  heap result
                ensures  forall x. occ x result = occ x h1 + occ x h2
                ensures  size result = size h1 + size h2"]
       -> if x1 < x2 then
            let (o1: tree) = Node (t2, x2, t1) in T (x1, o1)
           else
            let (o2: tree) = Node (t1, x1, t2) in T (x2, o2)

let insert (x: elt) (h: heap_type) : heap_type =
  merge (T (x, Empty)) h

let find_min (h: heap_type) : elt =
  match (h: heap_type) with
  | E -> assert false
  | T ((x: elt), (_: tree)) -> x

let rec merge_pairs (t: tree) : heap_type =
  match (t: tree) with
  | Empty -> E
  | Node ((l: tree), (x: elt), (Empty: tree)) -> T (x, l)
  | Node ((l: tree), (x: elt), Node ((l2: tree), (y: elt), (r2: tree)))
    [@gospel "requires heap_tree t
              ensures  heap result
              ensures  forall e. occ e result = tree_occ e t
              ensures  size result = tree_size t"] ->
      let (h1: heap_type) = T (x, l) in
      let (h2: heap_type) = T (y, l2) in
      let (mp: heap_type) = merge_pairs r2 in
      let (m: heap_type) = merge h1 h2 in
      merge m mp

let delete_min (h: heap_type) : heap_type =
  match (h: heap_type) with
  | E -> assert false
  | T ((_: elt), (t: tree)) -> merge_pairs t

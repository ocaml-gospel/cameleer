type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

type elt = int
type heap_type = E | T of elt * elt tree

(*@ function tree_size (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + tree_size l + tree_size r *)

(*@ function tree_occ (v: 'a) (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l x r -> tree_occ v l + tree_occ v r + (if x = v then 1 else 0) *)

(*@ function size (h: heap_type) : integer = match h with
      | E -> 0
      | T _ r -> 1 + tree_size r *)

(*@ lemma size_nonneg: forall h: heap_type. size h >= 0 *)

(*@ lemma size_empty: forall h: heap_type. size h = 0 <-> h = E *)

(*@ function occ (x: elt) (h: heap_type) : integer = match h with
      | E -> 0
      | T e t -> (if x = e then 1 else 0) + tree_occ x t *)

(*@ lemma occ_nonneg: forall x: elt, h: heap_type. occ x h >= 0 *)

(*@ predicate mem (x: elt) (h: heap_type) =
      0 < occ x h *)

(*@ predicate le (x y: int) = x <= y *)

(*@ predicate le_root (e: elt) (h: heap_type) = match h with
      | E -> true
      | T x  _ -> le e x *)

(*@ lemma le_root_trans: forall x y h. le x y -> le_root y h -> le_root x h*)

(*@ predicate le_root_tree (e: elt) (t: elt tree) = match t with
      | Empty      -> true
      | Node _ x r -> le e x && le_root_tree e r *)

(*@ lemma le_root_tree_trans: forall x y t. le x y -> le_root_tree y t -> le_root_tree x t*)

(*@ predicate heap_tree (t: elt tree) = match t with
      | Empty      -> true
      | Node l x r -> le_root_tree x l && heap_tree l && heap_tree r *)

(*@ predicate heap (h: heap_type) = match h with
      | E -> true
      | T x r -> le_root_tree x r && heap_tree r *)

(*@ function minimum (h: heap_type) : elt *)
(*@ axiom minimum_def: forall x r. minimum (T x r) = x *)

(*@ predicate is_minimum (x: elt) (h: heap_type) = mem x h && forall e. mem e h -> le x e *)

(* let[@lemma] rec mem_heap_tree (t: elt tree) = 
  match t with
  | Empty -> ()
  | Node l _ r ->
      mem_heap_tree l;
      mem_heap_tree r *)
(* @ mem_heap_tree t
    requires heap_tree t
    variant t
    forall x. le_root_tree x t -> forall y. mem y t -> le x y *)

(* let [@lemma] mem_heap (h: heap_type) = 
  match h with
  | E -> ()
  | T _ r ->
      mem_heap_tree r *)
(* @ mem_heap h
    requires heap h
    ensures forall x. le_root x h -> forall y. mem y h -> le x y *)

(*@ lemma root_is_minimum: forall h: heap_type. heap h -> 0 < size h -> is_minimum (minimum h) h *)

(** Pairing heaps specification *)

let empty: heap_type = (E: heap_type)
(*@ r = empty
      ensures heap r
      ensures size r = 0
      ensures forall e. not (mem e r) *)
      
let[@logic] is_empty (h: heap_type) : bool =
  match (h: heap_type) with
  | E -> true
  | (_: heap_type) -> false
(*@ r = is_empty h
      ensures r <-> size h = 0 *)

(* TODO: FALTA O SIZE *)

let merge (h1: heap_type) (h2: heap_type) : heap_type =
    match (h1 : heap_type), (h2 : heap_type) with
    | (E, (_: heap_type)) -> h2
    | ((_: heap_type), E) -> h1
    | (T ((x1: elt), (t1: elt tree)), 
       T ((x2: elt), (t2: elt tree))) 
      [@gospel {| requires heap h1 && heap h2 
                  ensures  heap result
                  ensures  forall x. occ x result = occ x h1 + occ x h2
                  ensures  size result = size h1 + size h2|}]
      ->
       if x1 < x2 then
        let (o1: elt tree) = Node (t2, x2, t1) in T (x1, o1)
       else
        let (o2: elt tree) = Node (t1, x1, t2) in T (x2, o2)
(*@ r = merge h1 h2 *)

let insert (x: elt) (h: heap_type) : heap_type =
  merge (T (x, Empty)) h
(* @ r = insert x h
      requires heap h
      ensures  heap r
      ensures  occ x r = occ x h + 1
      ensures  forall y. x <> y -> occ y r = occ y h
      ensures  size r = size h + 1 *)

let find_min (h: heap_type) : elt =
  match (h: heap_type) with
  | E -> assert false
  | T ((x: elt), (_: elt tree)) 
    [@gospel {|ensures result = minimum h |}]-> x
(*@ r = find_min h
      requires heap h && 0 < size h
      requires !! *)

let rec merge_pairs (t: elt tree) : heap_type =
  match (t: elt tree) with
  | Empty -> E
  | Node ((l: elt tree), (x: elt), (r: elt tree)) ->
      match r with
      | Empty -> T (x, l)
      | Node ((l2: elt tree), (y: elt), (r2: elt tree)) 
      [@gospel {| requires heap_tree t
                  ensures  heap result
                  ensures  forall e. occ e result = tree_occ e t
                  ensures  size result = tree_size t |}]
      ->
        let (h1: heap_type) = T (x, l) in
        let (h2: heap_type) = T (y, l2) in
        let (mp: heap_type) = merge_pairs r2 in
        let (m: heap_type) = merge h1 h2 in
        merge m mp
(*@ r = merge_pairs t
      variant  tree_size t*)

let delete_min (h: heap_type) : heap_type =
  match (h: heap_type) with
  | E -> assert false
  | T ((_: elt), (t: elt tree)) 
  [@gospel {| ensures  heap result
              ensures  occ (minimum h) result = occ (minimum h) h - 1
              ensures  forall e. e <> minimum h -> occ e result = occ e h
              ensures  size result = size h - 1|}]
  -> merge_pairs t
(*@ r = delete_min h
      requires heap h && 0 < size h
      requires !! *)
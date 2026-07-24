type 'a tree = Empty | Node of 'a tree * 'a * 'a tree
type elt = int

(*@ function occ (x: elt) (t: elt tree) : elt = match t with
      | Empty -> 0
      | Node l v r ->
          occ x l + occ x r + (if x = v then 1 else 0) *)

(*@ lemma occ_nonneg: forall x: elt, t: elt tree. occ x t >= 0 *)

(*@ predicate mem (x: elt) (t: elt tree) = occ x t > 0 *)

(*@ predicate bst (t: elt tree) = match t with
      | Empty -> true
      | Node l v r ->
      (forall lv. mem lv l -> lv < v) &&
      (forall rv. mem rv r -> rv > v) &&
      bst l && bst r *)

let empty: elt tree = (Empty: elt tree)
(*@ ensures forall x. occ x result = 0
    ensures bst result *)

let rec insert (x: elt) (t: elt tree): elt tree =
  match (t: elt tree) with
  | Empty -> Node (Empty, x, Empty)
  | Node ((l: elt tree), (y: elt), (r: elt tree)) ->
      if x = y then Node (l, y, r)
      else if x < y then
        let (o1: elt tree) = insert x l in Node (o1, y, r)
      else
        let (o2: elt tree) = insert x r in Node (l, y, o2)
(*@ requires bst t
    ensures  forall y. y <> x -> occ y result = occ y t
    ensures  occ x result = occ x t || occ x result = 1 + occ x t
    ensures  bst result *)

let rec mem (x: elt) (t: elt tree) : bool =
  match (t: elt tree) with
  | Empty -> false
  | Node ((l: elt tree), (v: elt), (r: elt tree)) ->
      if x = v then true
      else if x < v then mem x l
      else mem x r
(*@ requires bst t
    ensures  result <-> mem x t *)

(*@ function size (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + size l + size r *)

(*@ lemma size_nonneg: forall t: 'a tree. size t >= 0 *)

(*@ lemma size_empty: forall t: 'a tree. size t = 0 <-> t = Empty *)

(*@ function minimum (t: elt tree) : elt *)

(*@ axiom minimum_def_empty: forall v r. minimum (Node Empty v r) = v *)

(*@ axiom minimum_def_node: forall l v r. l <> Empty -> minimum (Node l v r) = minimum l *)

(*@ predicate is_minimum (x: elt) (t: elt tree) = mem x t && forall e. mem e t -> x <= e *)

(*@ lemma is_min: forall t: elt tree.
      bst t -> size t > 0 ->
      is_minimum (minimum t) t *)

let rec remove_min (t: elt tree) : elt tree =
  match (t: elt tree) with
  | Empty -> assert false
  | Node (Empty, (v: elt), (r: elt tree)) -> r
  | Node ((l: elt tree), (v: elt), (r: elt tree)) ->
      let (o1: elt tree) = remove_min l in Node (o1, v, r)
(*@ requires bst t
    requires size t > 0
    ensures  occ (minimum t) result = occ (minimum t) t - 1
    ensures  forall e. e <> minimum t -> occ e result = occ e t
    ensures  size result = size t - 1
    ensures  bst result *)

(* NEW -------------------------------------------------------- *)

(* trees have the same structure *)
let rec struct_equal (t1: elt tree) (t2: elt tree) : bool =
  match ((t1: elt tree), (t2: elt tree)) with
  | (Empty, Empty) -> true
  | (Node ((l1: elt tree), (v1: elt), (r1: elt tree)), Node ((l2: elt tree), (v2: elt), (r2: elt tree))) ->
    let (el: bool) = struct_equal l1 l2 in
    let (er: bool) = struct_equal r1 r2 in
    v1 = v2 && el && er
  | (_ , _) -> false
(*@ requires bst t1 && bst t2
    ensures result <-> forall x. occ x t1 = occ x t2 
    ensures result <-> size t1 = size t2 *)

let rec remove (x: elt) (t: elt tree) : elt tree =
  match (t: elt tree) with
  | Empty -> Empty
  | Node ((l: elt tree), (v: elt), (r: elt tree)) ->
      if x = v then
        begin match (r: elt tree) with
         | Empty -> l
         | Node ((_: elt tree), (_: elt), (_: elt tree)) ->
             let (o1: elt tree) = remove_min r in 
             let (min_val: elt) = get_min r in
             Node (l, min_val, o1)
        end
      else if x < v then
        let (o2: elt tree) = remove x l in Node (o2, v, r)
      else
        let (o3: elt tree) = remove x r in Node (l, v, o3)
(*@ requires bst t
    ensures  forall y. y <> x -> occ y result = occ y t
    ensures  occ x result = occ x t - 1 || occ x result = 0
    ensures  bst result *)
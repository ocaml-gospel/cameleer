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

let empty: elt tree = Empty
(*@ ensures forall x. not (mem x result)
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
    ensures  forall y. y <> x -> mem y result = mem y t
    ensures  mem x result
    ensures  bst result *)

let singleton (x: elt) : elt tree =
  insert x (Empty: elt tree)
(*@ requires true
    ensures  bst result
    ensures  forall y. y <> x -> not (mem y result)
    ensures  mem x result *)

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
      let (o: elt tree) = remove_min l in
      Node (o, v, r)
(*@ requires bst t
    requires size t > 0
    ensures  not (mem (minimum t) result)
    ensures  forall e. e <> minimum t -> mem e result = mem e t
    ensures  size result = size t - 1
    ensures  bst result *)

let rec get_min (t: elt tree) : elt =
  match (t: elt tree) with
  | Empty -> assert false
  | Node (Empty, (v: elt), (_: elt tree)) -> v
  | Node ((l: elt tree), (_: elt), (_: elt tree)) -> get_min l
(*@ requires bst t
    requires size t > 0
    ensures  result = minimum t *)

(* let rec struct_equal (t1: elt tree) (t2: elt tree) : bool =
  match ((t1: elt tree), (t2: elt tree)) with
  | (Empty, Empty) -> true
  | (Node ((l1: elt tree), (v1: elt), (r1: elt tree)), Node ((l2: elt tree), (v2: elt), (r2: elt tree))) ->
    let (el: bool) = struct_equal l1 l2 in
    let (er: bool) = struct_equal r1 r2 in
    v1 = v2 && el && er
  | (_ , _) -> false
(*@ requires bst t1 && bst t2
    ensures result <-> forall x. occ x t1 = occ x t2
    ensures result <-> size t1 = size t2 *) *)

let rec union (src : elt tree) (dst : elt tree) : elt tree =
  match (src : elt tree) with
  | Empty -> dst
  | Node ((l : elt tree), (v : elt), (r : elt tree)) ->
      let (dst1 : elt tree) = union l dst in
      let (dst2 : elt tree) = insert v dst1 in
      union r dst2
(*@ requires bst dst
    ensures  forall e. mem e result <-> mem e src || mem e dst
    ensures  bst result *)

let rec inter (t1 : elt tree) (t2 : elt tree) : elt tree =
  match (t1 : elt tree) with
  | Empty -> Empty
  | Node ((l : elt tree), (v : elt), (r : elt tree)) ->
      let (l : elt tree) = inter l t2 in
      let (r : elt tree) = inter r t2 in
      if mem v t2 then Node (l, v, r)
      else union l r
(*@ requires bst t1 && bst t2
    ensures forall e. mem e result <-> mem e t1 && mem e t2
    ensures bst result *)

let rec diff (t1 : elt tree) (t2 : elt tree) : elt tree =
  match (t1 : elt tree) with
  | Empty -> Empty
  | Node ((l : elt tree), (v : elt), (r : elt tree)) ->
      let (l : elt tree) = diff l t2 in
      let (r : elt tree) = diff r t2 in
      if mem v t2 then union l r
      else Node (l, v, r)
(*@ requires bst t1 && bst t2
    ensures forall e. mem e result <-> mem e t1 && not (mem e t2)
    ensures bst result *)

let rec remove (x: elt) (t: elt tree) : elt tree =
  match (t: elt tree) with
  | Empty -> Empty
  | Node ((l: elt tree), (v: elt), (r: elt tree)) ->
      if x = v then
        if r = Empty then l else
        let (o1: elt tree) = remove_min r in
        let (min_val: elt) = get_min r in
        Node (l, min_val, o1)
      else if x < v then
        let (o2: elt tree) = remove x l in Node (o2, v, r)
      else
        let (o3: elt tree) = remove x r in Node (l, v, o3)
(*@ requires bst t
    ensures  forall e. e <> x -> mem e result = mem e t
    ensures  not (mem x result)
    ensures  bst result *)

let remove2 (x: elt) (t: elt tree) : elt tree =
  let (tx : elt tree) = singleton x in
  diff t tx
(*@ requires bst t
    ensures  forall e. e <> x -> mem e result = mem e t
    ensures  not (mem x result)
    ensures  bst result *)

let rec pop_all (t : elt tree) : elt list =
  if t = Empty then [] else
  let (m : elt) = get_min t in
  let (t : elt tree) = remove_min t in
  let (l : elt list) = pop_all t in
  m :: l
(*@ requires bst t
    ensures  forall e. mem e t <-> LM.mem e result
    ensures  sorted result *)

let rec of_list (l : elt list) : elt tree =
  match (l : elt list) with
  | ([] : elt list) -> Empty
  | (x : elt) :: (l : elt list) ->
      let (t : elt tree) = of_list l in
      insert x t
(*@ requires true
    ensures  forall e. mem e result <-> LM.mem e l
    ensures  bst result *)

let nop (t : elt tree) : elt tree =
  let (l : elt list) = pop_all t in
  of_list l
(*@ requires bst t
    ensures  forall e. mem e t <-> mem e result *)

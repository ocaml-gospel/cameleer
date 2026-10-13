type 'a tree = Empty | Node of 'a tree * 'a * 'a tree
type elt = int

(*@ function size (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + size l + size r *)

(*@ lemma size_nonneg: forall t: 'a tree. size t >= 0 *)

(*@ lemma size_empty: forall t: 'a tree. 0 = size t <-> t = Empty *)

(*@ function occ (v: 'a) (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l x r -> occ v l + occ v r + (if x = v then 1 else 0) *)

(*@ lemma occ_nonneg: forall x: 'a, t: 'a tree. occ x t >= 0 *)

(*@ predicate mem (v: 'a) (t: 'a tree) = 0 < occ v t *)

(*@ predicate le (x y: int) = x <= y *)

(* [e] is no greater than the root of [t], if any *)
(*@ predicate le_root (e: elt) (t: elt tree) = match t with
      | Empty      -> true
      | Node _ x _ -> le e x *)

(* [t] is a heap *)
(*@ predicate heap (t: elt tree) = match t with
      | Empty      -> true
      | Node l x r -> le_root x l && heap l && le_root x r && heap r *)

(*@ function minimum (t: elt tree) : elt *)

(*@ axiom minimum_def: forall l x r. minimum (Node l x r) = x *)

(*@ predicate is_minimum (x: elt) (t: elt tree) = mem x t && forall e. mem e t -> le x e *)

(* the root is the smallest element *)
(*@ lemma is_min: forall t: elt tree. heap t -> size t > 0 -> is_minimum (minimum t) t *)

let empty: int tree = (Empty: int tree)
(*@ r = empty
      ensures heap r
      ensures size r = 0
      ensures forall e. not (mem e r) *)

let rec merge (t1: int tree) (t2: int tree) : int tree =
  match (t1 : elt tree), (t2 : elt tree) with
  | Empty, _ -> t2
  | _, Empty -> t1
  | Node (l1, x1, r1), Node (l2, x2, r2) ->
      if x1 < x2 then
        let (l: int tree) = merge r1 t2 in
        Node (l, x1, l1)
      else
        let (l: int tree) = merge r2 t1 in
        Node (l, x2, l2)
(*@ requires heap t1 && heap t2
    ensures  heap result
    ensures  forall x. occ x result = occ x t1 + occ x t2
    ensures  size result = size t1 + size t2 *)

let add (x: int) (t: int tree) : int tree =
  merge (Node (Empty, x, Empty)) t
(*@ requires heap t
    ensures  heap result
    ensures  size result = size t + 1
    ensures  occ x result = occ x t + 1
    ensures  forall y. y <> x -> occ y result = occ y t *)

let remove_min (t: int tree) : int tree =
  match (t : elt tree) with
  | Empty -> assert false
  | Node (l, _, r) -> merge l r
(*@ requires heap t
    requires size t > 0
    ensures  heap result
    ensures  occ (minimum t) result = occ (minimum t) t - 1
    ensures  forall e. e <> minimum t -> occ e result = occ e t
    ensures  size result = size t - 1 *)

let get_min (t: int tree) : int =
  match (t : elt tree) with
  | Empty -> assert false
  | Node (_, x, _) -> x
(*@ requires heap t
    requires size t > 0
    ensures  result = minimum t *)

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

let rec merge (t1: int tree) (t2: int tree) : int tree =
  match (t1 : elt tree), (t2 : elt tree) with
  | Empty, _ -> t2
  | _, Empty -> t1
  | Node (l1, x1, r1), Node (l2, x2, r2)
     [@gospel  "requires heap t1 && heap t2
                ensures  heap result
                ensures  forall x. occ x result = occ x t1 + occ x t2
                ensures  size result = size t1 + size t2" ] ->
       if x1 < x2 then
         let (l: int tree) = merge r1 t2 in
         Node (l, x1, l1)
       else
         let (l: int tree) = merge r2 t1 in
         Node (l, x2, l2)

let add (x: int) (t: int tree) : int tree =
  merge (Node (Empty, x, Empty)) t

let remove_min (t: int tree) : int tree =
  match (t : elt tree) with
  | Empty      -> assert false
  | Node (l, _, r) -> merge l r

let get_min (t: int tree) : int =
  match (t : elt tree) with
  | Empty      -> assert false
  | Node (_, x, _) -> x

let main : int tree =
  let (r: int tree) = add 0 (Empty: int tree) in
  r
(*@ requires true
    ensures heap result
    ensures is_minimum 0 result *)

let main2 : int tree =
  let (r: int tree) = add 1 (Empty: int tree) in
  let (r: int tree) = add 2  r in
  let (r: int tree) = add 3  r in
  let (r: int tree) = add 4  r in
  let (r: int tree) = add 5  r in
  let (r: int tree) = add 6  r in
  let (r: int tree) = add 7  r in
  let (r: int tree) = add 8  r in
  let (r: int tree) = add 9  r in
  let (r: int tree) = add 10 r in
  let (r: int tree) = add 11 r in
  let (r: int tree) = add 12 r in
  let (r: int tree) = add 13 r in
  let (r: int tree) = add 14 r in
  let (r: int tree) = add 15 r in
  let (r: int tree) = add 16 r in
  r
(*@ requires true
    ensures heap result
    ensures is_minimum 1 result *)

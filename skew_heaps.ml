(** Binary trees specification *)

type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

(*@ function size (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + size l + size r *)
                                 
(*@ lemma size_nonneg: forall t: 'a tree. size t >= 0 *)

(*@ lemma size_empty: forall t: 'a tree. 0 = size t <-> t = Empty *)

(*@ function occ (v: 'a) (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l x r -> occ v l + occ v r + (if x = v then 1 else 0) *)

(*@ lemma occ_nonneg: forall x: 'a, t: 'a tree. occ x t >= 0 *)

(*@ predicate mem (v: 'a) (t: 'a tree) =
      0 < occ v t *)

let[@logic] is_empty (t: int tree) : bool =
  match t with
  | Empty -> true
  | Node ((_l: int tree), (_x: int), (_r: int tree)) -> false
(*@ r = is_empty t
      ensures r <-> t = Empty *)

(** Skew Heaps specification *)

type elt = int

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

(*@ predicate is_minimum (x: elt) (t: elt tree) =
      mem x t && forall e. mem e t -> le x e *)

(* the root is the smallest element *)
let[@lemma] rec is_min (t: elt tree) =
  match t with
  | Empty -> assert false
  | Node (l, _, r) ->
      if not (is_empty l) then is_min l;
      if not (is_empty r) then is_min r
(*@ root_is_min t
      variant  t
      requires heap t && size t > 0
      ensures  is_minimum (minimum t) t *)

(** Skew Heaps operations *)

let empty: int tree = Empty
(*@ r = empty
      ensures heap r
      ensures size r = 0
      ensures forall e. not (mem e r) *)

(* let le a b = true (* TODO *) *)

let rec merge (t1: int tree) (t2: int tree) : int tree =
    match t1, t2 with
    | Empty, (_: int tree) -> t2
    | (_: int tree), Empty -> t1
    | Node ((l1: int tree), (x1: int), (r1: int tree)),
      Node ((l2: int tree), (x2: int), (r2: int tree)) ->
       if x1 < x2 then
         let l = merge r1 t2 in
         Node (l, x1, l1)
       else
         let l = merge r2 t1 in
         Node (l, x2, l2)
(*@ r = merge t1 t2
      variant  size t1 + size t2
      requires heap t1
      requires heap t2
      ensures  heap r
      ensures  forall x. occ x r = occ x t1 + occ x t2
      ensures  size r = size t1 + size t2 *)

let add (x: int) (t: int tree) : int tree =
  merge (Node (Empty, x, Empty)) t
(*@ r = add x t
      requires heap t
      ensures  heap r
      ensures  size r = size t + 1
      ensures  occ x r = occ x t + 1
      ensures  forall y. y <> x -> occ y r = occ y t *)

let remove_min (t: int tree) : int tree =
  match t with
  | Empty      -> assert false
  | Node ((l: int tree), (_: int), (r: int tree)) -> merge l r
(*@ r = remove_min t
      requires heap t
      requires size t > 0
      ensures  heap r
      ensures  occ (minimum t) r = occ (minimum t) t - 1
      ensures  forall e. e <> minimum t -> occ e r = occ e t
      ensures  size r = size t - 1 *)

let get_min (t: int tree) : int =
  match t with
  | Empty      -> assert false
  | Node ((_: int tree), (x: int), (_: int tree)) -> x
(*@ r = get_min t
      requires heap t
      requires size t > 0
      ensures  r = minimum t *)

type 'a tree = Empty | Node of int * 'a tree * 'a * 'a tree
type elt = int

(*@ predicate le (x y: int) = x <= y *)

(*@ axiom reflexive : forall x. le x x *)

(*@ axiom total     : forall x y. le x y \/ le y x *)

(*@ axiom transitive: forall x y z. le x y -> le y z -> le x z *)

(*@ function size (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node _ l _ r -> 1 + size l + size r *)

(*@ lemma size_nonneg: forall t: 'a tree. size t >= 0 *)

(*@ lemma size_empty: forall t: 'a tree. 0 = size t <-> t = Empty *)

(*@ function occ (x: 'a) (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node _ l e r -> occ x l + occ x r + (if x = e then 1 else 0) *)

(*@ lemma occ_nonneg: forall x: 'a, t: 'a tree. occ x t >= 0 *)

(*@ predicate mem (x: elt) (t: elt tree) = 0 < occ x t *)

(*@ predicate le_root (e: elt) (t: elt tree) = match t with
      | Empty      -> true
      | Node _ _ x _ -> le e x *)

(*@ lemma le_root_trans: forall x y t. le x y -> le_root y t -> le_root x t*)

(*@ predicate is_heap (t: elt tree) = match t with
      | Empty      -> true
      | Node _ l x r -> le_root x l && is_heap l && le_root x r && is_heap r *)

(*@ function minimum (t: elt tree) : elt *)

(*@ axiom minimum_def: forall l x r s. minimum (Node s l x r) = x *)

(*@ predicate is_minimum (x: elt) (t: elt tree) = mem x t && forall e. mem e t -> le x e *)

(*@ axiom is_minimum_def: forall x h.is_minimum x h <-> (mem x h && forall e. mem e h -> le x e)*)

(*@ lemma root_is_minimum: forall t. is_heap t -> size t > 0 -> is_minimum (minimum t) t *)

(*@ function min (x y: int) : int = if x <= y then x else y *)

(*@ function max (x y: int) : int = if x <= y then y else x *)

(*@ function rank (t: elt tree) : int = match t with
      | Empty -> 0
      | Node _ l _ r -> 1 + min (rank l) (rank r) *)

(*@ predicate leftist (t: elt tree) = match t with
      | Empty -> true
      | Node s l _ r -> s = rank t && leftist l && leftist r && rank l >= rank r *)

(*@ predicate leftist_heap (t: elt tree) = is_heap t && leftist t *)

let empty: elt tree = (Empty: elt tree)

let rank (t: elt tree) : int =
  match (t: elt tree) with
  | Empty -> 0
  | Node (r, _, _, _) -> r

let make_n (x: elt) (l: elt tree) (r: elt tree) : elt tree =
  let (rl: int) = rank l in
  let (rr: int) = rank r in
  if rl >= rr then
    let (o1: int) = rr + 1 in
    Node (o1, l, x, r)
  else
    let (o2: int) = rl + 1 in
    Node (o2, r, x, l)

let rec merge (t1: elt tree) (t2: elt tree) : elt tree =
  match (t1: elt tree), (t2: elt tree) with
  | Empty, _ -> t2
  | _, Empty -> t1
  | (Node (_, l1, x1, r1), Node (_, l2, x2, r2))
     [@gospel "requires leftist_heap t1 && leftist_heap t2
               ensures size result = size t1 + size t2
               ensures forall x. occ x result = occ x t1 + occ x t2
               ensures leftist_heap result"]
     -> if x1 <= x2 then
        let (o1: elt tree) = merge r1 t2 in
        make_n x1 l1 o1
      else
        let (o2: elt tree) = merge t1 r2 in
        make_n x2 l2 o2

let insert (x: elt) (t: elt tree) : elt tree =
  merge (Node (1, Empty, x, Empty)) t

let find_min (t: elt tree) : elt =
  match (t: elt tree) with
  | Empty -> assert false
  | Node (_, _, x, _)
      [@gospel "requires leftist_heap t
                ensures result = minimum t"]
    -> x

let delete_min (t: elt tree) : elt tree =
  match (t: elt tree) with
  | Empty -> assert false
  | Node (_, l, _, r) ->
      merge l r

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

(* let [@lemma] rec root_is_minimum (t: elt tree) : unit =
  match (t: elt tree) with
  | Empty -> assert false
  | Node ((_: int), (l: elt tree), (x: elt), (r: elt tree)) ->
      match (l: elt tree) with 
      | Empty -> ()
      | (_: elt tree) -> root_is_minimum l;
      match (r: elt tree) with
      | Empty -> ()
      | (_: elt tree) -> root_is_minimum r;  *)
(* @ root_is_minimum t
    requires is_heap t && size t > 0
    variant t
    ensures is_minimum (minimum t) t *)

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
(*@ r = empty
      ensures leftist_heap r
      ensures size r = 0
      ensures forall x. occ x r = 0 *)

(* let[@logic] is_empty (t: elt tree) : bool =
  match (t: elt tree) with
  | Empty -> true
  | (_: elt tree) -> false *)
(* @ r = is_empty t
      ensures r <-> size t = 0 *)

let rank (t: elt tree) : int =
  match (t: elt tree) with
  | Empty -> 0
  | Node ((r: int), (_: elt tree), (_: elt), (_: elt tree)) -> r
(*@ r = rank t
      requires leftist t
      ensures r = rank t *)

let make_n (x: elt) (l: elt tree) (r: elt tree) : elt tree =
  let (rl: int) = rank l in
  let (rr: int) = rank r in
  if rl >= rr then
    let (o1: int) = rr + 1 in
    Node (o1, l, x, r)
  else 
    let (o2: int) = rl + 1 in
    Node (o2, r, x, l)
(*@ res = make_n x l r
      requires leftist_heap l && leftist_heap r
      requires le_root x l && le_root x r
      ensures leftist_heap res
      ensures minimum res = x
      ensures size res = 1 + size l + size r
      ensures occ x res = 1 + (occ x l) + (occ x r)
      ensures forall y. x <> y -> occ y res = (occ y l) + (occ y r) *)

let rec merge (t1: elt tree) (t2: elt tree) : elt tree =
  match (t1: elt tree), (t2: elt tree) with
  | (Empty, (_: elt tree)) -> t2
  | (_: elt tree), Empty -> t1
  | (Node ((_: int), (l1: elt tree), (x1: elt), (r1: elt tree)), 
     Node ((_: int), (l2: elt tree), (x2: elt), (r2: elt tree))) ->
      if x1 <= x2 then 
        let (o1: elt tree) = merge r1 t2 in
        make_n x1 l1 o1
      else 
        let (o2: elt tree) = merge t1 r2 in
        make_n x2 l2 o2
(*@ r = merge t1 t2
      requires leftist_heap t1 && leftist_heap t2
      variant size t1 + size t2
      ensures size r = size t1 + size t2
      ensures forall x. occ x r = occ x t1 + occ x t2
      ensures leftist_heap r *)

let insert (x: elt) (t: elt tree) : elt tree =
  merge (Node (1, Empty, x, Empty)) t
(*@ r = insert x t
      requires leftist_heap t
      ensures leftist_heap r
      ensures size r = 1 + size t
      ensures occ x r = 1 + occ x t
      ensures forall y. x <> y -> occ y r = occ y t *)

let find_min (t: elt tree) : elt =
  match (t: elt tree) with
  | Empty -> assert false
  | Node ((_: int), (_: elt tree), (x: elt), (_: elt tree)) -> x
(*@ r = find_min t
      requires leftist_heap t
      requires size t > 0
      ensures r = minimum t *)

let delete_min (t: elt tree) : elt tree =
  match (t: elt tree) with
  | Empty -> assert false
  | Node ((_: int), (l: elt tree), (_: elt), (r: elt tree)) -> merge l r
(*@ r = delete_min t
      requires leftist_heap t
      requires size t > 0
      ensures leftist_heap r
      ensures occ (minimum t) r = occ (minimum t) t - 1
      ensures forall e. e <> minimum t -> occ e r = occ e t
      ensures size r = size t - 1 *)
      
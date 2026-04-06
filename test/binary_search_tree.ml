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
(*@ r = empty
      ensures forall x. occ x r = 0
      ensures bst r *)

let rec insert (x: elt) (t: elt tree): elt tree =
  match (t: elt tree) with
  | Empty -> Node (Empty, x, Empty)
  | Node (l, y, r) ->
      if x = y then Node (l, y, r)
      else if x < y then 
        let o1 = insert x l in Node (o1, y, r)
      else 
        let o2 = insert x r in Node (l, y, o2)
(*@ t = insert x t
      requires bst t
      variant  t
      ensures  forall y. y <> x -> occ y t = occ y t
      ensures  occ x t = occ x t || occ x t = 1 + occ x t
      ensures  bst t *)

let rec mem (x: elt) (t: elt tree) =
  match (t: elt tree) with
  | Empty -> false
  | Node (l, v, r) ->
      if x = v then true
      else if x < v then mem x l
      else mem x r
(*@ b = mem x t
      requires bst t
      variant  t
      ensures  b <-> mem x t *)
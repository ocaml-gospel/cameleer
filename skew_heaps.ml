type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

let empty: int tree = Empty

(* let le a b = true (* TODO *) *)

let is_empty (t: int tree) : bool =
  match t with
  | Empty -> true
  | Node ((l: int tree), (x: int), (r: int tree)) -> false
(*@ r = is_empty t
      ensures r <-> t = Empty *)

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
      ensures  occ (minimum t) r = occ (minimum t) r - 1
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

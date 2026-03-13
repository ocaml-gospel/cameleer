type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

let empty: 'a tree = Empty

let le a b = true (* TODO *)

let is_empty (t: 'a tree) : bool =
  match t with
  | Empty -> true
  | Node ((l: 'a tree), (x: 'a), (r: 'a tree)) -> false
(*@ r = is_empty t
      ensures r <-> t = Empty *)

let rec merge (t1: 'a tree) (t2: 'a tree) : 'a tree =
    match t1, t2 with
    | Empty, (_: 'a tree) -> t2
    | (_: 'a tree), Empty -> t1
    | Node ((l1: 'a tree), (x1: 'a), (r1: 'a tree)),
      Node ((l2: 'a tree), (x2: 'a), (r2: 'a tree)) ->
       if (le x1 x2 : bool) then
         let l = merge r1 t2 in
         Node (l, x1, l1)
       else
         let l = merge r2 t1 in
         Node (l, x2, l2)

let add (x: 'a) (t: 'a tree) : 'a tree =
  merge (Node (Empty, x, Empty)) t

let remove_min (t: 'a tree) : 'a tree =
  match t with
  | Empty      -> assert false
  | Node ((l: 'a tree), (_: 'a), (r: 'a tree)) -> merge l r

let get_min (t: 'a tree) : 'a =
  match t with
  | Empty      -> assert false
  | Node ((_: 'a tree), (x: 'a), (_: 'a tree)) -> x

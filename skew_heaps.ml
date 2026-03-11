type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

let empty = Empty

let le a b = true (* todo *)

let is_empty (t: 'a tree) =
  match t with
  | Empty -> true
  | Node ((l: 'a tree), (x: 'a), (r: 'a tree)) -> false
(*@ r = is_empty t
      ensures r <-> t = Emtpy *)

let rec merge (t1: 'a tree) (t2: 'a tree) : 'a tree =
    match t1, t2 with
    | Empty, _ -> t2
    | _, Empty -> t1
    | Node (l1, x1, r1), Node (l2, x2, r2) ->
       if le x1 x2 then
         let l = merge r1 t2 in
         Node (l, x1, l1)
       else
         let l = merge r2 t1 in
         Node (l, x2, l2)


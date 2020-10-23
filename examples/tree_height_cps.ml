type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

(*@ function height (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + max (height l) (height r) *)

let rec height_cps t k = match t with
  | Empty -> k 0
  | Node (l, _, r) ->
      height_cps l (fun hl ->
      height_cps r (fun hr -> k (1 + max hl hr)))
(*@ r = height_cps t k
      variant t
      ensures r = k (height t) *)

let height_tree t =
  height_cps t (fun x -> x)
(*@ r = height_tree t
      ensures r = height t *)

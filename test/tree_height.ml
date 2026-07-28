type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

(*@ function max (x: integer) (y: integer) : integer =
      if x >= y then x
      else y *)

(*@ function height (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + max (height l) (height r) *)

let max (x: int) (y: int) : int =
  if x >= y then x
  else y
(*@ r = max x y
      requires true
      ensures r = max x y *)

(* @ Comment test *)
let rec height (t: 'a tree) : int =
  match (t: 'a tree) with
  | Empty -> 0
  | Node ((l: 'a tree), (_: 'a), (r: 'a tree)) 
      [@ gospel {| requires t <> Empty |}]  -> 
      let (o1: int) = height l in
      let (o2: int) = height r in
      let (m: int) = max o1 o2 in
      1 + m
(* @ r = height t
      requires true
      variant t*)
      

let rec height2 (t: 'a tree) : int =
  match (t: 'a tree) with
  | Empty -> 0
  | Node ((l: 'a tree), (_: 'a), (r: 'a tree)) ->
      let (o1: int) = height2 l in
      let (o2: int) = height2 r in
      let (m: int) = max o1 o2 in
      1 + m
(* @ r = height t
      requires t <> Empty
      variant t
      ensures r > 0*)

let test =
      let t2 = Node (Empty, 1, Empty) in
      height t2



      

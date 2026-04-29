
type t = A of t | B | C | D of t

let is_empty (x: t) : bool =
  match (x: t) with
  | (x:t) -> true
  | (y:t) -> false

type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

let is_empty (ttttt: 'a tree) : bool =
  match (ttttt: 'a tree) with
  | Empty -> true
  | Node ((l: 'a tree), (x :'a), (r: 'a tree)) -> false

let get_int (t: 'a tree) : int =
  match (t: 'a tree) with
  | Empty -> 1
  | Node (Empty, (x: 'a), (r: 'a tree)) -> 2
  | Node ((_: 'a tree), (x: 'a), (r: 'a tree)) -> 3

(* bugs:
  - the order in the match is wrong
  [x] the actions are shuffled *)

let match_t (x: t) =
  match (x: t) with
  | A B -> 1
  | A C -> 10
  | A (_: t) -> 100
  | B      -> 2
  | (x: t) -> 3

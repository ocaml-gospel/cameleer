type t = A of t | B | C | D of t
type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

let is_empty (x: t) : bool =
  match (x: t) with
  | (x:t) -> true
  | (y:t) -> false

let is_empty2 (t: 'a tree) : bool =
  match (t: 'a tree) with
  | Empty -> true
  | Node (l, x, r) -> false

let get_int (t: 'a tree) : int =
  match (t: 'a tree) with
  | Empty -> 1
  | Node (Empty, x', r) -> 2
  | Node (_, x', r) -> 3

(* bugs:
  - the order in the match is wrong
  [x] the actions are shuffled *)

let match_t (x: t) : int =
  match (x: t) with
  | A B -> 1
  | A C -> 10
  | A _ -> 100
  | B      -> 2
  | x -> 3

exception Empty
exception H of int

type list = Nil | Cons of int * list

let rec hd (l : list) : int =
  match (l: list) with
  | Nil -> raise Empty
  | Cons (x, _) -> x
(*@ res = hd l
    raises Empty -> l = Nil *)

(*@ predicate non_neg (l: list) = match l with
    | Nil -> true
    | Cons x xs -> x >= 0 && non_neg xs
*)

let main (default: int) (l: list) : int =
  try  hd l
  with Empty -> default
(*@ res = main default l
    requires non_neg l && default >= 0
    ensures res >= 0 *)

let main2 (default: int) (l: list) : int =
  try 
    hd l
  with 
    | Empty [@gospel 
    {|requires non_neg l && default >= 0
    ensures result >= 0|}] -> default
    | H z [@gospel 
    {|requires non_neg l && default >= 0
    ensures result >= 0|}] -> 2

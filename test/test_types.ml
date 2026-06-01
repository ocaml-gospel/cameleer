type t = A of int | B | C

let f (x: t) (n: int) : int =
  match (x: t) with
  | A (i:int) -> i
  | B -> 10
  | C -> -1
(*@ requires true
    ensures  true *)

let g (a: t) (x: int) : int =
  (* let (a: t) = A 2 in *)
  f a x
(*@ requires true
    ensures  true *)

type t = A of int | B | C

let f (x: t) (n: int) : int =
  match (x: t) with
  | A (i:int)
        [@gospel {| requires 0 < i
                    requires i < n
                    ensures  result < n |}] -> n - i
  | B   [@gospel {| requires n <> 1
                    ensures  result = 10 |}] -> 10
  | C -> -1
(*@ r = f x y
      requires n > 0
      requires x <> C
      requires !!
      ensures  r > 0 *)

let g (a: t) (x: int) : int =
  f a x
(*@ r = g x
      ensures  r > 1 *)

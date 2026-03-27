type t = A of int | B | C

let o (x:int):int = 10
(*@ r = o x
        requires true
        ensures r = 10 *)

let f (x: t) (n: int) : int =
  match (x: t) with
  | A (i:int)
        [@gospel {| requires 0 < i
                    requires i < n
                    ensures  0 < result < n |}] -> n - i
  | B   [@gospel {| requires n <> 1
                    ensures  result >= 10 |}] -> o 1
  | C -> -1
(*@ r = f x y
      requires n > 0
      requires x <> C
      requires !!
      ensures  r > n *)

let g (a: t) (x: int) : int =
  f a x
(*@ r = g x
      ensures  r > -1 *)



let h (x:int): int =
  g (A x) (x+1)
(*@ r = h x
      requires x > 0
      requires !!
      ensures  r > -2 *)


let h2 (x:int): int =
  h x
(*@ r = h2 x
      requires x <> 1
      ensures  r > -2 *)

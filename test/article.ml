exception DbZ of int

(* let div (x: int) (y: int) = assert false
(*@ requires true
    ensures result = div x y *) *)

let mdiv (x : int) (y : int) : int =
  if y = 0 then raise (DbZ x)
  else div x y
(*@ ensures x >= result * y
    ensures x < (result+1) * y
    raises DbZ x -> y = 0 *)

(* let div (x: int) (y: int) (o (r : int) {r = div x y}) = any *)

let rem (x : int) (y: int) : int =
  let (q: int) = div x y in
  let (qy: int) = q * y in
  x - qy
(*@ requires y > 0 /\ x >= 0
    ensures x = y * (div x y) + result
    ensures 0 <= result < y
    *)

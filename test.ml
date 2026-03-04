(* dune exec bin_coma/cli.exe -- ./test.ml *)

let sum x y =
  if x then
    if y then 2 else 1
  else 0

type t = A | B | C

let sum_t x y =
  if sum true y = x then
    if y then A else B
  else C

let match_t x y =
  match x with
  | A -> sum true false
  | B -> sum false false
  | x ->
    (match y with
     | true -> sum true false
     | _ -> if y then 100 else 200)


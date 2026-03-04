(* dune exec bin_coma/cli.exe -- ./test.ml *)

let sum x y =
  if x then
    if y then 2 else 1
  else 0

type t = A | B | C

let sum_t x y =
  if x then
    if y then A else B
  else C

let match_t x y =
  match x with
  | A -> sum 1 2
  | B -> sum 2 1
  | x -> if y then 100 else 200
  | _ -> if y then 1 else 2

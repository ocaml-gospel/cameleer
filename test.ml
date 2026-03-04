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

let match_t x =
  match x with
  | A -> 1
  | B -> 2
  | x -> 3
  | _ -> 4

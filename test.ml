(* dune exec bin_coma/cli.exe -- ./test.ml *)

type 'a t = Empty | Node of 'a t * 'a * 'a t

let sum x y =
  if x then
    if y then 2 else 1
  else 0
(*@ requires x > 0
    requires y >= 0 *)

type t = A | B | C

let sum_t x y =
  (* if sum true y = x then *)
  if x then
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

let sum_t2 x y =
  (* if sum true y = x then *)
  if if y then true else false then
    if x then A else B
  else C

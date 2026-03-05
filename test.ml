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

(* TODO: do we have to do smth special for `+`, `-`, …
         in `Sexp_apply` case of the CPS translation ? *)
let f a b c =
  let x = a in
  let y = b in
  let z = c in
  let q = y + z in
  x + q

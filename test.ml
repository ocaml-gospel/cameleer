(* How to run this file:
   `dune exec bin_coma/cli.exe -- --coma ./test.ml` *)

(* ------------------------------------------------------------------------- *)
(*- Types -*)

type 'a t = Empty | Node of 'a t * 'a * 'a t

type t = A of t | B | C | D of t

(* ------------------------------------------------------------------------- *)
(* Simple functions (+optional toplevel specification) *)

let sum x y =
  if x then
    if y then 21 else 13
  else 8
(*@ r = sum x y
    requires x > 0
    requires y >= 0
    ensures r >= 0 *)

let c = C
let b = B

let sum_t x y =
  let a = sum true y in      (* ANF requirement *)
  if a = 34 then
  if x then
    if y then A c else A B
  else A c
  else D c

let match_t x y =
  match x with
  | A _ -> sum true false
  | B   -> sum false false
  | x   ->
    (match y with
     | true -> sum true false
     | _ -> if y then 55 else 89)

let f a b c =
  let x = a in
  let y = b in
  let z = c in
  let q = y + z in
  x + q


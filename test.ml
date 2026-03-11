(* How to run this file:
   `dune exec bin_coma/cli.exe -- --coma ./test.ml` *)

(* ------------------------------------------------------------------------- *)
(*- Types -*)

type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

type t = A of t | B | C | D of t

(* ------------------------------------------------------------------------- *)
(* Simple functions (+optional toplevel specification) *)
let is_empty (t: 'a tree) =
  match t with
  | Empty -> true
  | Node ((l: 'a tree), (x: 'a), (r: 'a tree)) -> false
(*@ r = is_empty t
      ensures r <-> t = Emtpy *)

let sum (x: bool) (y: bool) =
  if x then
    if y then 21 else 13
  else 8
(*@ r = sum x y
    requires x > 0
    requires y >= 0
    ensures r >= 0 *)

let (c: t) = C
let (b: t) = B

let void (x: bool) = if x then ()

let sum_t (x: bool) (y: bool) =
  let (a: int) = sum true y in      (* ANF requirement *)
  if a = 34 then
  if x then
    if y then A c else A B
  else A c
  else D c

let match_t (x: t) (y: bool) =
  match x with
  | A _ -> sum true false
  | B   -> sum false false
  | x   ->
    (match y with
     | true -> sum true false
     | _ -> if y then 55 else 89)

let f (a: int) (b: int) (c: int) =
  let x = a in
  let y = b in
  let z = c in
  let q = y + z in
  x + q


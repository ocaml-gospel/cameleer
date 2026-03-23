(* How to run this file:
   `dune exec bin/cli_coma.exe -- --coma ./test.ml`

   + to compile pattern-matchings simply add `--pat`
 *)

(* ------------------------------------------------------------------------- *)
(*- Types -*)

type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

type t = A of t | B | C | D of t

(* ------------------------------------------------------------------------- *)
(* Simple functions (+optional toplevel specification) *)
let is_empty (t: 'a tree) : bool =
  match (t: 'a tree) with
  | Empty -> true
  | Node ((l: 'a tree), (x: 'a), (r: 'a tree)) -> false
(*@ r = is_empty t
      ensures r <-> t = Empty *)

let sum (x: bool) (y: bool) : int =
  if x then
    if y then 21 else 13
  else 8
(*@ r = sum x y
    requires x -> 0 > 0
    requires y -> 10 >= 0
    ensures r >= 0 *)

let c: t = C
let b: t = B

let void (x: bool) : unit = if x then ()

(* let void2 (x: bool) : unit = if x then (void x; void x) *)

(* let void3 (x: bool) (y: bool) : unit =
  let x = sum x y in
  while (x = 1 : bool) do
    void y
  done *)

let sum_t (x: bool) (y: bool) : t =
  let (a: int) = sum true y in      (* ANF requirement *)
  let (c: t) = C in
  if a = 34 then
  if x then
    if y then A c else A B
  else A c
  else D c

type mbool = MTrue | MFalse

(* let match_t (x: t) (y: mbool): int =
  match (x: t) with
  | A (_:t) -> sum true false
  | B       -> sum false false
  | (x:t)  ->
    (match (y: mbool) with
     | MTrue -> sum true false
     | (_: mbool) -> if y = MTrue then 55 else 89) *)

let f (a: int) (b: int) (c: int) : int =
  let (x: int) = a in
  let (y: int) = b in
  let (z: int) = c in
  let (q: int) = y + z in
  x + q



let g (x: int): int =
  let (k:int->int) = fun (j:int) -> j + 1 in
  k x

exception Exit of int

type re =
  | Empty
  | Epsilon
  | Char   of int
  | Alt    of re * re
   (*| Concat of re * re
  | Star   of re *)

(*
let nth (s: list int) (x: int)  (k (result: int)  )
= k {x}
*)

let nth (s: int list) (idx: int): int = assert false
let len (s: int list): int = assert false

let rec a (s: int list) (r: re) (i: int) (k: int -> unit): unit =
  match (r: re) with
  | Empty -> ()

  | Epsilon -> k i

  | Char c ->
      let (n: int) = len s in
      if i < n then let (si: int) = nth s i in if si = c then k (i + 1)

  | Alt (r1, r2) ->
      a s r1 i k;
      a s r2 i k

 (*  | Concat ((r1: re), (r2: re)) ->
      let (k: int -> unit): int -> unit  = fun (j:int) -> a s r2 j k in
      a s r1 i k
  | Star (r12: re) ->
      let (k2: int -> unit): int -> unit = fun (j:int) -> if i < j then a s r j k in
      k i; a s r12 i k2 *)

(* let accept (r: re) (s: string): bool =
  let (n: int) = String.length s in
  let (useless: int) = 0 in
  try
    let (k: int -> unit) = fun (j: int) -> if j = n then raise (Exit useless) in
    a s r 0 k;
    false
  with Exit (useless : int) -> true *)

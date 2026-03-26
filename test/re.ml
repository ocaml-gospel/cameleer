exception Exit of int

let o: int = 1

type re =
  | Empty
  | Epsilon
  | Char   of int
  | Alt    of re * re
  | Concat of re * re
  | Star   of re

let rec aa (s: string) (r: re) (i: int) (k: int -> unit): unit =
  match (r: re) with
  | Empty -> ()
  | Epsilon -> k i
  | Char (c: int) ->
      if i < 10(* n *) then let (si: int) = nth s i in if si = c then k (i + 1)
  | Alt    ((r1: re), (r2: re)) -> aa s r1 i k; aa s r2 i k
  | Concat ((r1: re), (r2: re)) ->
      let (k: int -> unit): int -> unit  = fun (j:int) -> aa s r2 j k in
      aa s r1 i k
  | Star (r12: re) ->
      let (k2: int -> unit): int -> unit = fun (j:int) -> if i < j then aa s r j k in
      k i; aa s r12 i k2

let accept (r: re) (s: string): bool =
  let (n: int) = length s in
  try
    let (k: int -> unit): int -> unit = fun (j: int) -> if j = n then raise (Exit o) in
    aa s r 0 k;
    false
  with Exit (o : int) -> true

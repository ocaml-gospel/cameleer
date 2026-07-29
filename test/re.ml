exception Exit of int

type re =
  | Empty
  | Epsilon
  | Char   of int
  | Alt    of re * re
  | Concat of re * re
  | Star   of re

let rec a (s: string) (r: re) (i: int) (k: int -> unit): unit =
  match (r: re) with
  | Empty -> ()
  | Epsilon -> k i
  | Char c ->
      if i < 10(* n *) then let (si: int) = nth s i in if si = c then k (i + 1)
  | Alt    (r1, r2) -> a s r1 i k; a s r2 i k
  | Concat (r1, r2) ->
      let (k: int -> unit): int -> unit  = fun (j:int) -> a s r2 j k in
      a s r1 i k
  | Star r12 ->
      let (k2: int -> unit): int -> unit = fun (j:int) -> if i < j then a s r j k in
      k i; a s r12 i k2

let accept (r: re) (s: string): bool =
  let (n: int) = String.length s in
  let (useless: int) = 0 in
  try
    let (k: int -> unit) = fun (j: int) -> if j = n then raise (Exit useless) in
    a s r 0 k;
    false
  with Exit (useless : int) -> true


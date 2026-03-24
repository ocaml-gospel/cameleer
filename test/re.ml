exception Exit of int

let (o : int) = 1

type re =
  | Empty
  | Char of char
  | Alt of re * re
  | Epsilon
  | Star of re
  | Concat of re * re

let accept (r: re) (s: string): bool =
  let (n : int) = String.length s in
  let rec a (r: re) (i: int) (k: int -> unit): unit = match r with
  | Empty -> ()
  | Epsilon -> k i
  | Char (c: char) -> if i < n then let si = s.[i] in if si = c then k (i + 1)
  | Alt ((r1: re), (r2: re)) -> a r1 i k; a r2 i k
  | Concat ((r1: re), (r2: re)) -> let k2 j = a r2 j k in a r1 i k2
  | Star (r1: re) -> let k2 j = if i < j then a r j k in k i; a r1 i k2 in
  try
    a r 0 (fun (j: int) -> if j = n then raise (Exit o));
    false
  with Exit (o : int) -> true

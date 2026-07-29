exception Exit of int

type re =
  | Empty
  | Epsilon
  | Char   of int
  | Alt    of re * re
  | Concat of re * re
  | Star   of re

type char = int

(*@ predicate mem (w: int sequence) (r: re) *)

(*@ axiom mem_eps:
      mem Sequence.empty Empty *)
(*@ axiom mem_char:
      forall c: char. mem (Sequence.singleton c) (Char c) *)
(*@ axiom mem_altl:
      forall w: int sequence, r1 r2: re. mem w r1 -> mem w (Alt r1 r2) *)
(*@ axiom mem_altr:
      forall w: int sequence, r1 r2: re. mem w r2 -> mem w (Alt r1 r2) *)
(*@ axiom mem_concat:
      forall w1 w2: int sequence, r1 r2: re.
      mem w1 r1 -> mem w2 r2 -> mem (w1 ++ w2) (Concat r1 r2) *)
(*@ axiom mems1:
      forall r: re. mem Sequence.empty (Star r) *)
(*@ axiom mems2:
      forall w1 w2: int sequence, r: re.
      mem w1 r -> mem w2 (Star r) -> mem (w1 ++ w2) (Star r) *)

(*@ lemma mem_star_nonempty:
  forall w: int sequence. forall r: re.
    mem w (Star r) ->
    w <> Sequence.empty ->
      exists k: int.
        0 < k <= Sequence.length w /\
        mem w[..k] r /\
        mem w[k..] (Star r) *)

(*@ lemma split_concat:
  forall w: int sequence. forall r1 r2: re.
    mem w (Concat r1 r2) ->
      exists k: int.
        0 <= k <= Sequence.length w /\
        mem w[..k] r1 /\ mem w[k..] r2 *)

(*@ lemma concat_split:
  forall w: int sequence. forall r1 r2: re. forall i j k: int.
    0 <= i <= k <= j <= Sequence.length w ->
      mem w[i..k] r1 ->
      mem w[k..j] r2 ->
      mem w[i..j] (Concat r1 r2) *)

(*@ lemma extseq:
  forall w: int sequence.
    let z: int = 0 in
    let n: int = Sequence.length w in
    w[z..n] = w *)

(*@
  predicate cons (w: int sequence) (r: re) (ck: int -> bool) (i: int) =
    [@inline:trivial]
    exists j. i <= j <= Sequence.length w /\ mem w[i..j] r /\ ck j *)

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
  | Concat (r1, r2) ->
      let (k: int -> unit) = fun (j:int) -> a s r2 j k in
      a s r1 i k
  | Star r ->
      let (k2: int -> unit) = fun (j:int) -> if i < j then a s r j k in
      k i; a s r i k2
(* WIP
  @ requires 0 <= i <= Sequence.length s
    ensures  result = ()
    raises   Exit _ -> not cons w r ck i
 *)


let accept (r: re) (s: int list): bool =
  let (n: int) = len s in
  let (useless: int) = 0 in
  try
    let (k: int -> unit) = fun (j: int) -> if j = n then raise (Exit useless) in
    a s r 0 k;
    false
  with Exit (useless : int) -> true
(*@ requires true
    ensures  result <-> mem r s *)

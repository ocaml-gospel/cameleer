type re =
  | Empty
  | Epsilon
  | Char   of int
  | Alt    of re * re
  | Concat of re * re
  | Star   of re

(*
let nth (s: list int) (x: int)  (k (result: int)  )
= k {x}
*)

(*@ predicate mem (w: int sequence) (r: re) *)

(*@ axiom mem_eps:
      mem Sequence.empty Empty *)
(*@ axiom mem_char:
      forall c: int. mem (Sequence.singleton c) (Char c) *)
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

let nth (s: int list) (idx: int): int = List.nth s idx
let len (s: int list): int = List.length s

let rec a (s: int list) (r: re) (i: int) (k: int -> bool): bool =
  match (r: re) with
  | Empty -> false
  | Epsilon -> k i
  | Char c ->
      let (n: int) = len s in
      i < n && let (si: int) = nth s i in
               si = c && k (i + 1)
  | Alt (r1, r2) ->
      let (test: bool) = a s r1 i k in
      test || a s r2 i k
  | Concat (r1, r2) ->
      let (k: int -> bool) = fun (j:int) -> a s r2 j k in
      a s r1 i k
  | Star r1 ->
      let (k2: int -> bool) = fun (j:int) -> i < j && a s r j k in
      let (ki: bool) = k i in
      ki || a s r1 i k2
(*@ requires 0 <= i <= Sequence.length s
    ensures  true
 *)


let accept (r: re) (s: int list): bool =
  let (n: int) = len s in
  let (k: int -> bool) = fun (j: int) -> j = n in
  a s r 0 k
(*@ requires true
    ensures  result <-> mem r s *)

(*
let w1 = []
let w2 = [1;1;1;1;1]
let w3 = [1;2;1]
let w4 = [2;2;2;1]

let r1 = Star (Char 1)
let r2 = Star (Alt (Alt (Char 1, Char 2), Char 3))
let r3 = Alt (Empty, Empty)

let () =
  assert (accept r1 w1);
  assert (accept r1 w2);
  assert (accept r2 w1);
  assert (accept r2 w2);
  assert (accept r2 w3);
  assert (not @@ accept r3 w1);
  assert (not @@ accept r3 w2);
  assert (not @@ accept r1 w3);
  assert (not @@ accept r1 w4) *)

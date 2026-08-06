type char

type word [@@coma "seq char"]

type re =
  | Empty
  | Epsilon
  | Char   of char
  | Alt    of re * re
  | Concat of re * re
  | Star   of re

(*@ predicate mem (w: char seq) (r: re) *)

(*@ axiom mem_eps:
      mem empty Epsilon *)
(*@ axiom mem_char:
      forall c: char. mem (singleton c) (Char c) *)
(*@ axiom mem_altl:
      forall w: char seq, r1 r2: re.
      mem w r1 -> mem w (Alt r1 r2) *)
(*@ axiom mem_altr:
      forall w: char seq, r1 r2: re.
      mem w r2 -> mem w (Alt r1 r2) *)
(*@ axiom mem_concat:
      forall w1 w2: char seq, r1 r2: re.
      mem w1 r1 -> mem w2 r2 -> mem (w1 ++ w2) (Concat r1 r2) *)
(*@ axiom mems1:
      forall r: re.
      mem empty (Star r) *)
(*@ axiom mems2:
      forall w1 w2: char seq, r: re.
      mem w1 r -> mem w2 (Star r) -> mem (w1 ++ w2) (Star r) *)

(*@ axiom mem_inversion :
    forall z:char seq. forall z1:re.
     mem z z1 ->
     (z = (empty: char seq) /\ z1 = Epsilon) \/
     (exists c:char. z = singleton c /\ z1 = Char c) \/
     (exists r1:re, r2:re. mem z r1 /\ z1 = Alt r1 r2) \/
     (exists r1:re, r2:re. mem z r2 /\ z1 = Alt r1 r2) \/
     (exists w1:char seq, w2:char seq, r1:re, r2:re.
         mem w1 r1 /\ mem w2 r2 /\ z = (w1 ++ w2) /\ z1 = Concat r1 r2) \/
     (exists r1:re. z = (empty: char seq) /\ z1 = Star r1) \/
     (exists w1:char seq, w2:char seq, r1:re.
       mem w1 r1 /\ mem w2 (Star r1) /\ z = (w1 ++ w2) /\ z1 = Star r1)
 *)

(*@ lemma mem_star_nonempty:
  forall w: char seq. forall r: re.
    mem w (Star r) ->
    w <> empty ->
      exists k: int.
        0 < k <= length w /\
        mem w[..k] r /\
        mem w[k..] (Star r) *)

(*@ lemma split_concat:
  forall w: char seq. forall r1 r2: re.
    mem w (Concat r1 r2) ->
      exists k: int.
        0 <= k <= length w /\
        mem w[..k] r1 /\ mem w[k..] r2 *)

(*@ lemma concat_split:
  forall w: char seq. forall r1 r2: re. forall i j k: int.
    0 <= i <= k <= j <= length w ->
      mem w[i..k] r1 ->
      mem w[k..j] r2 ->
      mem w[i..j] (Concat r1 r2) *)

(*@ lemma extseq:
  forall w: char seq.
    let z: int = 0 in
    let n: int = length w in
    w[z..n] = w *)


let nth (s: word) (idx: int): char = assert false
(*@ requires 0 <= idx < length s
    ensures  result = s[idx] *)

let len (s: word): int = assert false
(*@ requires true
    ensures  result = length s *)

type ckt =
  | CInit of int
  | CCat  of re * ckt
  | CStar of int * re * ckt

(*@ predicate exec_ck (ck: ckt) (w: char seq) (j: int) =
      match (ck: ckt) with
      | CInit n         -> j = n
      | CCat  r ck   ->
          exists i. j <= i <= length w /\ mem w[j..i] r /\ exec_ck ck w i
      | CStar i r ck -> i < j &&
          exists i. j <= i <= length w /\ mem w[j..i] r /\ exec_ck ck w i *)

(*@ predicate cons (w: char seq) (r: re) (ck: ckt) (i: int) =
      exists j. i <= j <= length w /\ mem w[i..j] r /\ exec_ck ck w j *)

let rec a (s: word) (r: re) (i: int)
          (ck: ckt)
          (k: int -> bool): bool =
           (* [@gospel "b = k j
                     requires mem[i..j] r
                     requires i <= j <= len s
                     ensures  b <-> ck j"]) = *)
    (* (k (result: int) { mem s[i..result] r } { i <= result <= length s }  (_k (result2: bool) { result2 <-> exec_ck ck w result } )) *)
  match (r: re) with
  | Empty -> false
  | Epsilon -> k i
  | Char c ->
      let (n: int) = len s in
      i < n && let (si: char) = nth s i in
               si = c && k (i + 1)
  | Alt (r1, r2) ->
      let (test: bool) = a s r1 i ck k in
      test || a s r2 i ck k
  | Concat (r1, r2) ->
      let (ck2 : ckt) = CCat (r2, ck) in
      let (k2: int -> bool) = fun (j:int) -> a s r2 j ck k in
      a s r1 i ck2 k2
  | Star r1 ->
      let (ck2 : ckt) = CStar (i, r, ck) in
      let (k2: int -> bool) = fun (j:int) -> i < j && a s r j ck k in
      let (ki: bool) = k i in
      ki || a s r1 i ck2 k2
(*@ requires 0 <= i <= length s
    ensures  result <-> cons s r ck i *)

let accept (r: re) (s: word): bool =
  let (n: int) = len s in
  let (k: int -> bool) = fun (j: int) -> j = n in
  let (ck: ckt) = CInit n in
  a s r 0 ck k
(*@ requires true
    ensures  result <-> mem s r *)


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

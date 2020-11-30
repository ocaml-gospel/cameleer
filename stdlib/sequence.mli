type 'a sequence

(*@ function length (s: 'a sequence): integer *)
(*@ axiom length_nonnegative: forall s: 'a sequence. length s >= 0 *)

(*@ function ([_]) (s: 'a sequence) (i:integer): 'a *)

(*@ predicate (==) (s1 s2: 'a sequence) =
      length s1 = length s2 &&
      forall i. 0 <= i < length s1 -> s1[i] = s2[i] *)

(*@ axiom ext_eq: forall s1 s2: 'a sequence. s1 == s2 -> s1 = s2 *)

(*@ function ([_.._]) (s: 'a sequence) (i1: integer) (i2: integer): 'a sequence *)
(*@ function ([_..]) (s: 'a sequence) (i: integer): 'a sequence *)
(*@ function ([.._]) (s: 'a sequence) (i: integer): 'a sequence *)

(*@ function empty: 'a sequence *)
(*@ axiom lenght_empty: length (empty: 'a sequence) = 0 *)

(*@ function create (x: integer) (f: integer -> 'a): 'a sequence *)
(*@ axiom create_len : forall n, f: (integer -> 'a). n >= 0 ->
      length (create n f) = n *)
(*@ axiom create_def : forall n, f: (integer -> 'a). n >= 0 ->
      forall i. 0 <= i < n -> (create n f)[i] = f i *)

(*@ function cons (x: 'a) (s: 'a sequence) : 'a sequence =
      create (length s + 1) (fun i -> if i = 0 then x else s[i - 1]) *)

(*@ function snoc (s: 'a sequence) (x: 'a) : 'a sequence =
      create (length s + 1) (fun i -> if i = length s then x else s[i]) *)

(*@ function (++) (s1: 'a sequence) (s2: 'a sequence): 'a sequence =
      let l = length s1 in
      create (l + length s2) (fun i -> if i < l then s1[i] else s2[i-l]) *)

(* @ axiom append_length: forall s1 s2: 'a sequence.
      length (s1 ++ s2) = length s1 + length s2 *)
(* @ axiom append_left: forall i, s1 s2: 'a sequence.
      0 <= i < length s1 -> (s1 ++ s2)[i] = s1[i] *)
(* @ axiom append_right: forall i, s1 s2: 'a sequence.
      length s1 <= i < length (s1 ++ s2) -> (s1 ++ s2)[i] = s2[i - length s1] *)

(*@ lemma append_empty_right: forall s: 'a sequence. s ++ empty == s*)
(*@ lemma append_empty_left : forall s: 'a sequence. empty ++ s == s *)

(*@ lemma append_assoc: forall s1 s2 s3: 'a sequence.
      s1 ++ (s2 ++ s3) == (s1 ++ s2) ++ s3 *)

(*@ lemma snoc_empty: forall s: 'a sequence, x: 'a.
      s ++ (cons x (empty: 'a sequence)) == snoc s x *)

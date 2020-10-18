type 'a seq

(*@ function length (s: 'a seq): integer *)
(*@ axiom length_nonnegative: forall s: 'a seq. length s >= 0 *)

(*@ function ([_]) (s: 'a seq) (i:integer): 'a *)

(*@ predicate (==) (s1 s2: 'a seq) =
      length s1 = length s2 &&
      forall i. 0 <= i < length s1 -> s1[i] = s2[i] *)

(*@ axiom ext_eq: forall s1 s2: 'a seq. s1 == s2 -> s1 = s2 *)

(*@ function ([_.._]) (s: 'a seq) (i1: integer) (i2: integer): 'a seq *)
(*@ function ([_..]) (s: 'a seq) (i: integer): 'a seq *)
(*@ function ([.._]) (s: 'a seq) (i: integer): 'a seq *)

(*@ function empty: 'a seq *)
(*@ axiom lenght_empty: length (empty: 'a seq) = 0 *)

(*@ function create (x: integer) (f: integer -> 'a): 'a seq *)
(*@ axiom create_len : forall n, f: (integer -> 'a). n >= 0 ->
      length (create n f) = n *)
(*@ axiom create_def : forall n, f: (integer -> 'a). n >= 0 ->
      forall i. 0 <= i < n -> (create n f)[i] = f i *)

(*@ function cons (x: 'a) (s: 'a seq) : 'a seq =
      create (length s + 1) (fun i -> if i = 0 then x else s[i - 1]) *)

(*@ function snoc (s: 'a seq) (x: 'a) : 'a seq =
      create (length s + 1) (fun i -> if i = length s then x else s[i]) *)

(*@ function (++) (s1: 'a seq) (s2: 'a seq): 'a seq =
      let l = length s1 in
      create (l + length s2) (fun i -> if i < l then s1[i] else s2[i-l]) *)

(* @ axiom append_length: forall s1 s2: 'a seq.
      length (s1 ++ s2) = length s1 + length s2 *)
(* @ axiom append_left: forall i, s1 s2: 'a seq.
      0 <= i < length s1 -> (s1 ++ s2)[i] = s1[i] *)
(* @ axiom append_right: forall i, s1 s2: 'a seq.
      length s1 <= i < length (s1 ++ s2) -> (s1 ++ s2)[i] = s2[i - length s1] *)

(*@ lemma append_empty_right: forall s: 'a seq. s ++ empty == s*)
(*@ lemma append_empty_left : forall s: 'a seq. empty ++ s == s *)

(*@ lemma append_assoc: forall s1 s2 s3: 'a seq.
      s1 ++ (s2 ++ s3) == (s1 ++ s2) ++ s3 *)

(*@ lemma snoc_empty: forall s: 'a seq, x: 'a.
      s ++ (cons x empty) == snoc s x *)

(*@ function seq_of_list (l: 'a list): 'a seq = match l with
      | [] -> empty
      | x :: r -> cons x (seq_of_list r)
    coercion *)

(*@ lemma seq_of_list_append: forall l1 l2: 'a list.
      seq_of_list (List.append l1 l2) == seq_of_list l1 ++ seq_of_list l2 *)

(*@ predicate permitted (v: 'a seq) (s: 'a seq) =
      length v <= length s &&
      forall i. 0 <= i < length v -> v[i] = s[i] *)

(*@ predicate complete (l: 'a seq) (v: 'a seq) =
      length v = length l *)

let rec fold_left ((v: 'a list) [@ghost]) ((inv: 'b -> 'a seq -> bool) [@ghost])
    ((l0: 'a list) [@ghost]) f (acc: 'b) = function
  | []     -> acc
  | x :: l -> fold_left (v @ [x]) inv l0 f (f acc x) l
(*@ r = fold_left v inv l0 f acc param
      requires permitted v l0
      requires l0 == v ++ param
      requires inv acc v
      requires forall v acc x.
                 inv acc v -> permitted (snoc v x) l0 -> not (complete v l0) ->
                 inv (f acc x) (snoc v x)
      variant  param
      ensures  exists vres: 'a list. permitted vres l0 && vres == v ++ param
      ensures  exists vres: 'a list. inv r vres *)

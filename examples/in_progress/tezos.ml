(* Compute imperatively the sum of the first elements of an array, until we meet
 * a negative number *)

(*@ function bool_to_int (b: bool) : integer =
      if b then 1 else 0
    coercion *)

type iterator = {mutable i : int ; mutable sum : int}

let sum_until_negative a =
  let iter = { i = 0 ; sum = 0} in
  let finished = ref false in
  while !finished do
    (*@ invariant 0 <= iter.i < Array.length a *)
    let element = a.(iter.i) in
    if element < 0 then
      finished := true
    else
      (iter.i <- iter.i + 1 ; iter.sum <- iter.sum + element)
  done ;
  iter.sum

let sum_until_negative2 a =
  let iter = { i = 0 ; sum = 0} in
  let finished = ref false in
  while !finished do
    (*@ variant   Array.length a - iter.i - !finished *)
    (*@ invariant exists j. 0 <= j < Array.length a && a.(j) < 0 && iter.i <= j *)
    (*@ invariant 0 <= iter.i < Array.length a *)
    let element = a.(iter.i) in
    if element < 0 then
      finished := true
    else
      (iter.i <- iter.i + 1 ; iter.sum <- iter.sum + element)
  done ;
  iter.sum
(*@ r = sum_until_negative_2 a
      requires exists i. 0 <= i < Array.length a && a.(i) < 0 *)

(*@ function logic_sum (f: int -> int) (l: int) (u: int) : integer *)

(*@ axiom logic_sum_0: forall f l u. u <= l -> logic_sum f l u = 0 *)
(*@ axiom logic_sum_n: forall f l u. u > l ->
      logic_sum f l u = logic_sum f l (u-1) + f (u-1) *)

(*@ lemma logic_sum_left:
      forall f: (int -> int), a b: int.
      a < b -> logic_sum f a b = f a + logic_sum f (a + 1) b *)

(*@ lemma logic_sum_ext:
      forall f g: (int -> int), a b: int.
      (forall i. a <= i < b -> f i = g i) ->
      logic_sum f a b = logic_sum g a b *)

(*@ lemma logic_sum_le:
      forall f g: (int -> int), a b: int.
      (forall i. a <= i < b -> f i <= g i) ->
      logic_sum f a b <= logic_sum g a b *)

(*@ lemma logic_sum_zero:
      forall f: (int -> int), a b: int.
      (forall i. a <= i < b -> f i = 0) ->
      logic_sum f a b = 0 *)

(*@ lemma logic_sum_nonneg:
      forall f: (int -> int), a b: int.
      (forall i. a <= i < b -> 0 <= f i) ->
      0 <= logic_sum f a b *)

(*@ lemma logic_sum_decomp:
      forall f: (int -> int), a b c: int. a <= b <= c ->
      logic_sum f a c = logic_sum f a b + logic_sum f b c *)

let [@lemma] rec shift_left (f: int -> int) (g: int -> int) a b c (d: int) =
  if a < b then shift_left f g (a+1) b (c+1) d
(*@ requires b - a = d - c
    requires forall i. a <= i < b -> f i  = g (c + i - a)
    variant  b - a
    ensures  logic_sum f a b = logic_sum g c d *)

(*@ predicate negative_array (a: int array) =
      (forall i. 0 <= i < Array.length a -> a.(i) >= 0) \/
      (exists i. 0 <= i < Array.length a &&
        (forall j. 0 <= j < i -> a.(j) >= 0) &&
        (forall j. i <= j < Array.length a -> a.(j) < 0)) *)

let sum_until_negative3 a =
  let iter = { i = 0 ; sum = 0} in
  let exception Finish of int in
  try while iter.i < Array.length a  do
      (*@ variant   Array.length a - iter.i *)
      (*@ invariant 0 <= iter.i <= Array.length a *)
      (*@ invariant forall j. 0 <= j < iter.i -> a.(j) >= 0 *)
      (*@ invariant iter.sum =
            logic_sum (fun i -> if a.(i) < 0 then 0 else a.(i)) 0 iter.i *)
      let element = a.(iter.i) in
      if element < 0 then
        raise (Finish iter.sum)
      else
        (iter.i <- iter.i + 1 ; iter.sum <- iter.sum + element)
    done;
    iter.sum
  with Finish i -> i
(*@ r = sum_until_negative_3 a
      requires negative_array a
      ensures  r =
       logic_sum (fun i -> if a.(i) < 0 then 0 else a.(i)) 0 (Array.length a) *)

let main () =
  sum_until_negative3 [| 1 ; 2 ; 3 ; 4 ; -5 ; -6; -7; -8; |]
(*@ r = main ()
      ensures r = 10 *)

(* Compute imperatively the sum of the first elements of an array, until we meet
 * a negative number *)

type iterator = {mutable i : int ; mutable sum : int}

(** Trying to prove the following function, with no specification attached,
    generates two verification conditions (VC): termination and index in array
    bounds. Proving such VCs ensures the program is *safe* to execute. So, the
    first thing to do is to add a *loop invariant* to state the cursor index is
    within bounds of the array. *)
let sum_until_negative_0 a =
  let iter = { i = 0 ; sum = 0} in
  let finished = ref false in
  while !finished do
    let element = a.(iter.i) in
    if element < 0 then
      finished := true
    else
      (iter.i <- iter.i + 1 ; iter.sum <- iter.sum + element)
  done ;
  iter.sum

(** With the following invariant, we can indeed prove the value of `iter.i`
    stays within bounds. However, a new proof challenge arises: to prove the
    invariant holds for every iteration of the loop. Well, the truth is the loop
    never actually executes. For proof purposes, our specification must be
    strong enough to handle both scenarios of loop execution. The fact is one
    cannot prove the loop invariant preservation. If the array `a` contains
    only non-negative values, `iter.i` would reach `Array.length a`, causing an
    out of bounds access. Let us refine our specification to prove this
    invariant, while also trying to prove the loop always terminates. *)
let sum_until_negative_1 a =
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

(*@ function bool_to_int (b: bool) : integer =
      if b then 1 else 0
    coercion *)

(** For this version of `sum_until_negative`, we attach a *pre-condition*
    to the function stating there is at least one negative element in the
    array. The loop invariant is changed accordingly, namely the value of
    `iter.i` is no greater than the index of the first negative element. We are
    now able to prove the invariant holds for any iteration of the loop. The
    new challenge now is to also prove the loop halts. To do so, we provide a
    *variant*, i.e., a measure that must strictly decreases after each
    iteration. An obvious such measure is the difference between the length of
    `a` and the value of `iter.i`. However, in order to account for the `then`
    case (when `iter.i` is not changed), we must be a little more creative. We
    use the above logical function `bool_to_int` to be able to use the value of
    `finished` as an integer. We come up with `Array.length a - iter.i +
    !finished` as our decreasing measure (since we declare `bool_to_int` as a
    coercion, we do not need to explicititly write it in the specification),
    which would work when the value of `finished` flips from `false` to
    `true`. The problem is, since the variant must decrease within a loop
    iteration, the generated VC features as premise `finished = true`. So, it
    never really flips. The next version of `sum_until_negative` fixes the
    specification and the code, providing a provably correct implementation. *)
let sum_until_negative2 a =
  let iter = { i = 0 ; sum = 0} in
  let finished = ref false in
  while !finished do
    (*@ variant   Array.length a - iter.i + !finished *)
    (*@ invariant exists j. 0 <= j < Array.length a && a.(j) < 0 && iter.i <= j *)
    (*@ invariant 0 <= iter.i *)
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

(** As it is very frequently the case, while proving the `sum_until_negative`
    function correct, we came up with a small optimization with respect to the
    original code. Instead of using the `finished` flag, we use a much more
    OCaml idiomatic style and raise an exception. We immediately catch `Finish`
    and take its argument as the function return value. *)
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

(** Exercise: Let us relax the property that the array must contain a suffix of
    only negative values. For instance, `[| 1; 2; -3; 4; 5; |]`. What would be
    correct specification for this case? Namely, how would we change the logical
    function `logic_sum` to cope with this scenario? Do we also need to change
    the code? *)

(*@ function sqr (x: integer) : integer = x * x *)

(*@ lemma sqr_non_neg: forall x: integer. sqr x >= 0 *)

(*@ lemma sqr_increasing:
      forall x y:integer. 0 <= x <= y -> sqr x <= sqr y *)

(*@ lemma sqr_sum :
      forall x y : integer. sqr(x+y) = sqr x + 2*x*y + sqr y *)

(*@ predicate int_sqrt_spec (x res:integer) =
      res >= 0 /\ sqr res <= x < sqr (res + 1) *)

let int_sqrt x =
  let count = ref 0 in
  let sum = ref 1 in
  while !sum <= x do
    (*@ invariant !count >= 0
        invariant x >= sqr !count
        invariant !sum = sqr (!count + 1)
        variant   x - !count *)
    count := !count + 1;
    sum := !sum + ((2 * !count) + 1)
  done;
  !count
(*@ r = int_sqrt x
      requires x >= 0
      ensures  int_sqrt_spec x r *)

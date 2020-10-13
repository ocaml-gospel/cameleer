(** Two implementations of factorial. *)

(*@ function fact (n: integer) : integer *)

(*@ axiom fact_0: fact 0 = 1 *)
(*@ axiom fact_n: forall n. n > 0 -> fact n = n * fact (n - 1) *)

let rec fact_rec x =
  if x = 0 then 1 else x * fact_rec (x - 1)
(*@ r = fact_rec x
      requires x >= 0
      variant  x
      ensures  r = fact x *)

let fact_imp x =
  let y = ref 0 in
  let r = ref 1 in
  while !y < x do
    (*@ invariant 0 <= !y <= x *)
    (*@ invariant !r = fact !y *)
    (*@ variant   x - !y *)
    y := !y + 1;
    r := !r * !y
  done;
  !r
(*@ r = fact_imp x
      requires x >= 0
      ensures  r = fact x *)

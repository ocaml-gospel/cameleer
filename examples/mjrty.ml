
(*@ function rec numof (p: integer -> bool) (a b: integer) : integer =
      if b <= a then 0 else
      if p (b - 1) then 1 + numof p a (b - 1)
                   else     numof p a (b - 1) *)
(*@ variant b - a *)

(*@ lemma numof_bounds :
      forall p : (integer -> bool), a b : int.
      a < b -> 0 <= numof p a b <= b - a *)

(*@ lemma numof_append:
      forall p: (integer -> bool), a b c: integer.
      a <= b <= c -> numof p a c = numof p a b + numof p b c *)

(*@ lemma numof_left_no_add:
      forall p : (integer -> bool), a b : integer.
      a < b -> not p a -> numof p a b = numof p (a+1) b *)

(*@ lemma numof_left_add :
      forall p : (integer -> bool), a b : integer.
      a < b -> p a -> numof p a b = 1 + numof p (a+1) b *)

(*@ function numof_eq (a: 'a array) (v: 'a) (l u: integer) : integer =
      numof (fun i -> a.(i) = v) l u *)

module type EQUAL = sig
  type t

  val eq : t -> t -> bool
  (*@ b = eq x y
        ensures b <-> x = y *)
end

module Mjrty (Eq : EQUAL) = struct
  type candidate = Eq.t

  let mjrty a =
    let exception Found of candidate in
    let n = Array.length a in
    let cand = ref a.(0) in
    let k = ref 0 in
    try
      for i = 0 to n - 1 do
        (*@ invariant 0 <= !k <= numof_eq a !cand 0 i
            invariant 2 * (numof_eq a !cand 0 i - !k) <= i - !k
            invariant forall c. c <> !cand -> 2 * numof_eq a c 0 i <= i - !k *)
        if !k = 0 then begin
          cand := a.(i);
          k := 1 end
        else if Eq.eq !cand a.(i) then incr k
        else decr k
      done;
      if !k = 0 then raise Not_found;
      if 2 * !k > n then raise (Found !cand);
      k := 0;
      for i = 0 to n - 1 do
        (*@ invariant !k = numof_eq a !cand 0 i /\ 2 * !k <= n *)
        if Eq.eq a.(i) !cand then (
          incr k;
          if 2 * !k > n then raise (Found !cand))
      done;
      raise Not_found
    with Found c -> c
  (*@ c = mjrty a
        requires 1 <= Array.length a
        ensures  2 * numof_eq a c 0 (Array.length a) > Array.length a
        raises   Not_found ->
                   forall x. 2 * numof_eq a x 0 (Array.length a) <= Array.length a *)
end

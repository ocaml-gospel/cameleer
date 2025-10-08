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

(*@ lemma empty :
      forall p : (int -> bool), a b : integer.
      (forall n : int. a <= n < b -> not p n) -> numof p a b = 0 *)

(*@ function numof_eq (a: 'a array) (v: 'a) (l u: integer) : integer =
      numof (fun i -> a.(i) = v) l u *)

let most_frequent (a: int array) : int
= let r = ref a.(0) in
  let c = ref 1 in
  let m = ref 1 in
  for i = 1 to Array.length a - 1 do
    (*@ invariant !c = numof_eq a a.(i-1) 0 i
        invariant !m = numof_eq a !r 0 i
        invariant forall x. numof_eq a x 0 i <= !m *)
    if a.(i) = a.(i-1) then begin
      incr c;
      if !c > !m then begin m := !c; r := a.(i) end
    end else
      c := 1
  done;
  !r
(*@ r = most_frequent a
    requires Array.length a > 0
    requires forall i j. 0 <= i <= j < Array.length a -> a[i] <= a[j]
    ensures  numof_eq a r 0 (Array.length a) > 0
    ensures  forall x. numof_eq a x 0 (Array.length a) <= numof_eq a r 0 (Array.length a)
*)

(*@ function gcd (x:int) (y:int) : int*)

(*@ axiom gcd_nonneg: forall a b: int. 0 <= gcd a b*)
(*@ axiom gcd_def1: forall a b: int. mod (gcd a b) a =0*)
(*@ axiom gcd_def2: forall a b: int. mod (gcd b a) b =0*)
(*@ axiom gcd_def3:
  forall a b x: int. mod x a = 0 -> mod x b = 0 -> mod (gcd a b) x = 0*)
(*@ axiom gcd_uniq: forall a b d: int.
  0 <= d -> mod a d = 0 -> mod b d = 0 ->
  (forall x: int. mod a x = 0 -> mod b x = 0 -> mod d x = 0) -> d = gcd a b*)
(*@ axiom gcd_assoc: forall x y z: int. gcd (gcd x y) z = gcd x (gcd y z)*)
(*@ axiom gcd_comm: forall u v: int. gcd u v = gcd v u *)

(*@ lemma gcd_0_pos: forall a: int. 0 <= a -> gcd a 0 = a *)
(*@ lemma gcd_computer_mod:
    forall a b: int[gcd b (mod a b)]. (b > 0) -> gcd b (mod a b) = gcd a b*)
(*@ lemma gcd_sub: forall u v: int. 0 <= u <= v -> gcd u (v-u) = gcd u v*)

(*@ predicate consistent (x:int) (y:int)=
      x>0 && y>0*)

let gcdd (x : int) (y : int) : int =
  let x0 = ref x in
  let y0 = ref y in
  while not (!x0 = !y0) do
    (*@ variant !x0 + !y0*)
    (*@ invariant consistent !x0 !y0*)
    (*@ invariant gcd !x0 !y0 = gcd x y *)
    if !x0 < !y0 then y0 := !y0 - !x0 else x0 := !x0 - !y0
  done;
  !x0

(*@ r = gcdd x y
      requires consistent x y
      ensures r = gcd x y*)

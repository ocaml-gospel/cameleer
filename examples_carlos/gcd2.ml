(*@ function gcd (x:int) (y:int) : int*)

(*@ axiom gcd_nonneg: forall a b: int. 0 <= gcd a b*)
<<<<<<< Updated upstream
(*@ axiom gcd_def1: forall a b: int. (gcd a b) mod a =0*)
(*@ axiom gcd_def2: forall a b: int. (gcd b a) mod b =0*)
(*@ axiom gcd_def3:
  forall a b x: int. x mod a = 0 -> x mod b = 0 -> (gcd a b) mod x = 0*)
(*@ axiom gcd_uniq: forall a b d: int.
=======
<<<<<<< HEAD
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
(*@ lemma gcd_euclid: forall a b q: int. gcd a b = gcd a (b - q * a) *)
(*@ lemma gcd_computer_mod:
    forall a b: int[gcd b (mod a b)]. (b > 0) -> gcd b (mod a b) = gcd a b*)
(*@ lemma gcd_sub: forall u v: int. 0 <= u <= v -> gcd u (v-u) = gcd u v*)

(*@ predicate consistent (x:int) (y:int)=
      x>0 && y>0*)
=======
(*@ axiom gcd_def1: forall a b: int. (gcd a b) mod a =0*)
(*@ axiom gcd_def2: forall a b: int. (gcd b a) mod b =0*)
(*@ axiom gcd_def3:
  forall a b x: int. x mod a = 0 -> x mod b = 0 -> (gcd a b) mod x = 0*)
(*@ axiom gcd_uniq: forall a b d: int.
>>>>>>> Stashed changes
  0 <= d -> a mod d = 0 -> b mod d = 0 ->
  (forall x: int. a mod x = 0 -> b mod x = 0 -> d mod x = 0) -> d = gcd a b*)
(*@ lemma gcd_sub: forall u v: int. 0 <= u <= v ->
    gcd u (v-u) = gcd u v*)
(*@ lemma gcd_sub2: forall u v: int. 0 <= v <= u ->
    gcd (u-v) v = gcd u v*)
(*lemma gcd_assoc: forall u v: int. gcd u v = gcd v u*)
(*@ lemma gcd_computer_mod:
    forall a b: int. (b > 0) -> gcd b (a mod b) = gcd a b*)

(*@ predicate consistent (x:int) (y:int)=
      x>0 && y>0*)
<<<<<<< Updated upstream

(*@ lemma gcd_comm: forall u v: int. gcd u v = gcd v u *)

(*@ lemma gcd_euclid: forall a b q: int. gcd a b = gcd a (b - q * a) *)

(*@ lemma gcd_0_pos: forall a: int. 0 <= a -> gcd a 0 = a *)
=======
>>>>>>> Stashed changes

(*@ lemma gcd_comm: forall u v: int. gcd u v = gcd v u *)

(*@ lemma gcd_euclid: forall a b q: int. gcd a b = gcd a (b - q * a) *)

(*@ lemma gcd_0_pos: forall a: int. 0 <= a -> gcd a 0 = a *)
>>>>>>> d2f754e145ac460c7ca81d17d9fc0fb16305f805

let gcdd (x : int) (y : int) : int =
  let x0 = ref x in
  let y0 = ref y in
  while not (!x0 = !y0) do
    (*@ variant !x0, !y0*)
    (*@ invariant consistent !x0 !y0*)
    (*@ invariant gcd !x0 !y0 = gcd x y *)
    if !x0 < !y0 then y0 := !y0 - !x0 else x0 := !x0 - !y0
  done;
  !x0

(*@ r = gcdd x y
      requires x > 0
      requires y > 0
      ensures r = gcd x y*)

(*@ function gcd (x:int) (y:int) : int*)
(*@ axiom gcd_nonneg: forall a b: int. 0 <= gcd a b*)
(*@ axiom gcd_def1: forall a b: int. mod (gcd a b) a =0*)
(*@ axiom gcd_def2: forall a b: int. mod (gcd b a) b =0*)
(*@ axiom gcd_def3: 
  forall a b x: int. mod a x = 0 -> mod b x = 0 -> mod (gcd a b) x = 0*)
(*@ axiom gcd_uniq: forall a b d: int.
  0 <= d -> mod a d = 0 -> mod b d = 0 ->
  (forall x: int. mod a x = 0 -> mod b x = 0 -> mod d x = 0) -> d = gcd a b*)

(*@ predicate consistent (x:int) (y:int)=
      x>0 && y>0*)
      

let gcdd (x: int) (y:int): int=
  let x0 = ref x in
  let y0 = ref y in
  while not (!x0 = !y0) do
    (*@ variant !x0, !y0*)
    (*@ invariant consistent !x0 !y0*)
    if !x0 < !y0 then y0 := !y0 - !x0 else x0 := !x0 - !y0
  done;
  !(x0)
(*@ r = gcdd x y
      requires x > 0
      requires y > 0
      ensures r = gcd x y*)
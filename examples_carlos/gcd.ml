(*@ predicate consistent (x:int) (y:int)=
      x>0 && y>0*)
let gcdd (x: int) (y:int): int=
  let x0 = ref x in
  let y0 = ref y in
  while not (!x0 = !y0) do
    (*@ variant !x0, !y0*)
    (*@ invariant consistent x y*)
    if !x0 < !y0 then y0 := !y0 - !x0 else x0 := !x0 - !y0
  done;
  !(x0)
(*@ r = gcdd x y
      requires x > 0
      requires y > 0
      ensures if x > y then
              (forall j. r < j < x -> (mod x j <> 0) \/ mod y j <> 0)
                else (forall j. r < j < y -> mod y j <> 0 \/ mod x j <> 0) *)
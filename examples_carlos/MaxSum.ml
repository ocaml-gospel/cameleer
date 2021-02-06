let max (x: int array) (n:int): int =
  let max = ref 0 in
  for i = 0 to n-1 do
    (*@ invariant  forall j. 0 <= j < i -> x.(j) <= !max *)
    if !max < x.(i) then max := x.(i)
  done; 
    !(max)
    (*@ r = max x n
    requires n = Array.length x
    requires forall i. 0 <= i < n -> x.(i) >= 0
    ensures forall j. 0 <= j < n -> x.(j) <= r 
  *)
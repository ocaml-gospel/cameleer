let max_sum a n =
  let sum = ref 0 in
  let max = ref 0 in
  for i = 0 to n - 1 do
    (*@ invariant !sum <= i * !max *)
    if !max < a.(i) then max := a.(i);
    sum := !sum + a.(i)
  done;
  !sum, !max
(*@ (sum, max) = max_sum a n
      requires n = Array.length a
      requires forall i. 0 <= i < n -> a[i] >= 0
      ensures  sum <= n * max *)

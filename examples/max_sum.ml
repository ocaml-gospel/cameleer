let max_sum a n =
  let sum = ref 0 in
  let max = ref 0 in
  if Array.length a = 0 then !sum, !max
  else begin
    for i = 0 to n - 1 do
      (*@ invariant !sum <= i * !max *)
      (*@ invariant forall j. 0 <= j < i -> a.(j) <= !max *)
      (*@ invariant exists j. 0 <= !j < i /\ !max = a[!j] *)
      if !max < a.(i) then max := a.(i);
      sum := !sum + a.(i)
    done;
    !sum, !max end
(*@ (sum, max) = max_sum a n
      requires n = Array.length a
      requires forall i. 0 <= i < n -> a[i] >= 0
      ensures  sum <= n * max
      ensures  (forall i. 0 <= i < n -> a[i] <= max) &&
               (exists j. 0 <= j < n /\ a[j] = max) *)

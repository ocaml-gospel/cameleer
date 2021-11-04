let all_distinct a m =
  let exception Duplicate in
  let dejavu = Array.make m false in
  try
    for k = 0 to Array.length a - 1 do
      (*@ invariant forall i j. 0 <= i < k -> 0 <= j < k -> i <> j ->
                    a.(i) <> a.(j)
          invariant forall x. 0 <= x < m -> dejavu.(x) <->
                    exists i. 0 <= i < k && a.(i) = x *)
      let v = a.(k) in
      if dejavu.(v) then raise Duplicate;
      dejavu.(v) <- true
    done;
    true
  with Duplicate -> false
(*@ b = all_distinct a m
      requires 0 <= m
      requires forall i. 0 <= i < Array.length a -> 0 <= a.(i) < m
      ensures  b <-> forall i j. 0 <= i < Array.length a ->
                     0 <= j < Array.length a -> i <> j -> a.(i) <> a.(j) *)

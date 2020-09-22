let binary_mult a b =
  let x = ref a in
  let y = ref b in
  let z = ref 0 in
  while not (!y = 0) do
    (*@ variant   !y *)
    (*@ invariant 0 <= !y *)
    (*@ invariant !z + !x * !y = a * b *)
    if !y mod 2 = 1 then z := !z + !x;
    x := 2 * !x;
    y := !y / 2
  done;
  !z
(*@ r = binary_mult a b
      requires b >= 0
      ensures  r = a * b *)

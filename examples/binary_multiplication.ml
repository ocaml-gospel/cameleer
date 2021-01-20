let binary_mult a b =
  let x = ref a in
  let y = ref b in
  let r = ref 0 in
  while not (!y = 0) do
    (*@ variant   !y *)
    (*@ invariant 0 <= !y *)
    (*@ invariant !r + !x * !y = a * b *)
    if !y mod 2 = 1 then r := !r + !x;
    x := 2 * !x;
    y := !y / 2
  done;
  !r
(*@ r = binary_mult a b
      requires b >= 0
      ensures  r = a * b *)

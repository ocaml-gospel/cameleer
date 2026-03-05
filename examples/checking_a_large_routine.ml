let[@logic] rec fact x = if x = 0 then 1 else x * fact (x - 1)
(*@ r = fact x
      requires x >= 0
      variant  x *)

let routine n =
  let r = ref 0 in
  let u = ref 1 in
  while !r < n do
    (*@ invariant 0 <= !r <= n /\ !u = fact !r
        variant   n - !r *)
    let s = ref 1 in
    let v = !u in
    while !s <= !r do
      (*@ invariant 1 <= !s <= !r + 1 /\ !u = !s * fact !r
          variant   !r - !s *)
      u := !u + v;
      s := !s + 1
    done;
    r := !r + 1
  done;
  !u
(*@ r = routine n
      requires n >= 0
      ensures  r = fact n *)

let routine2 n =
  let u = ref 1 in
  let[@ghost] c1 = ref 0 in
  for r = 0 to n - 1 do
    (*@ invariant !u = fact r
        invariant !c1 = r *)
    incr c1;
    let v = !u in
    for s = 1 to r do
      (*@ invariant !u = s * fact r *)
      u := !u + v
    done
  done;
  assert (!c1 = n);
  !u
(*@ r = routine2 n
      requires n >= 0
      ensures  r = fact n *)

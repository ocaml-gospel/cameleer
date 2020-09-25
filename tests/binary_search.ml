
exception Found of int

(*@ predicate is_sorted (a: int array) =
      forall i1 i2. 0 <= i1 <= i2 < Array.length a -> a[i1] <= a[i2] *)

let binary_search a v =
  let l = ref 0 in
  let u = ref (Array.length a - 1) in
  while !l <= !u do
    (*@ invariant 0 <= !l /\ !u < Array.length a *)
    (*@ invariant forall i : int. 0 <= i < Array.length a -> a[i] = v ->
          !l <= i <= !u *)
    (*@ variant !u - !l *)
    let m = !l + (!u - !l) / 2 in
    if a.(m) < v then
      l := m + 1
    else if a.(m) > v then
      u := m - 1
    else
      raise (Found m)
  done;
  raise Not_found
(*@ r = binary_search a v
      requires is_sorted a
      raises Not_found -> forall i. 0 <= i < Array.length a -> a[i] <> v
      raises Found i -> 0 <= i < Array.length a && a[i] = v *)

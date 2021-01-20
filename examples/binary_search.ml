
(*@ predicate is_sorted (a: int array) =
      forall i1 i2. 0 <= i1 <= i2 < Array.length a -> a.(i1) <= a.(i2) *)

let binary_search a v =
  let l = ref 0 in
  let u = ref (Array.length a - 1) in
  let exception Found of int in
  try while !l <= !u do
      (*@ variant   !u - !l *)
      (*@ invariant 0 <= !l && !u < Array.length a *)
      (*@ invariant forall i. 0 <= i < Array.length a -> a.(i) = v ->
            !l <= i <= !u *)
      let m = !l + (!u - !l) / 2 in
      if a.(m) < v then
        l := m + 1
      else if a.(m) > v then
        u := m - 1
      else
        raise (Found m)
    done;
    raise Not_found
  with Found i -> i
(*@ i = binary_search a v
      requires is_sorted a
      raises   Not_found -> forall i. 0 <= i < Array.length a -> a.(i) <> v
      ensures  0 <= i < Array.length a && a.(i) = v *)

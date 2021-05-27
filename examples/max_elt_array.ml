let max a =
  let x = ref 0 in
  let y = ref (Array.length a - 1) in
  while not (!x = !y) do
  (*@ variant   !y - !x
      invariant 0 <= !x <= !y < Array.length a
      invariant forall i. (0 <= i < !x \/ !y < i < Array.length a) ->
                          (a.(i) <= a.(!y) \/ a.(i) <= a.(!x)) *)
    if a.(!x) <= a.(!y) then incr x else decr y
  done;
  !x
(*@ r = max a
      requires Array.length a > 0
      ensures  0 <= r < Array.length a
      ensures  forall i. 0 <= i < Array.length a -> a.(i) <= a.(r) *)

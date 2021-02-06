exception Duplicate

  let elinarray (a: int array) (m: int) : bool=
   try
     for k = 0 to Array.length a - 1 do
     (*@ invariant forall i. 0 <= i < k -> not (a.(i) = m) *)
       if (a.(k) = m) then raise Duplicate;
     done;
     False
   with Duplicate ->
     True
  (*@ r = elinarray a m
  requires m >= 0
  requires forall i. 0 <= i < Array.length a -> 0 <= a.(i)
  ensures if r then exists i. 0 <= i < Array.length a && a.(i)= m 
  else forall i. 0 <= i < Array.length a -> not (a.(i) = m)*)
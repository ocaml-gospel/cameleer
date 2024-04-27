module type EQUAL = sig
  type t

  val eq : t -> t -> bool
  (*@ b = eq x y
        ensures b <-> x = y *)
end

module Make (E : EQUAL) = struct
  type elt = E.t

  let find x a =
    let exception E of int in
    try
      for i = 0 to Array.length a - 1 do
        (*@ invariant forall j. 0 <= j < i -> a.(j) <> x *)
        if E.eq a.(i) x then raise (E i)
      done;
      raise Not_found
    with E i -> i
  (*@ i = find x a
        ensures a.(i) = x
        raises Not_found -> forall i. 0 <= i < Array.length a -> a.(i) <> x *)
end

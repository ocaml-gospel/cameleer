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
      None
    with E i -> Some i
  (*@ r = find x a
        ensures match r with
                | None -> forall i. 0 <= i < Array.length a -> a.(i) <> x
                | Some i -> a.(i) = x *)
end

module MakeList (E: EQUAL) = struct
  type elt = E.t

  let rec mem x l =
    match l with
    | [] -> false
    | y :: r ->
        E.eq x y || mem x r

end

module type EQUAL = sig
  type elt

  val eq : elt -> elt -> bool
  (*@ b = eq x y
        ensures b <-> x = y *)
end

module Make (Eq : EQUAL) = struct
  type tree = Empty | Node of tree * Eq.elt * tree

  (*@ function elements (t: tree) : Eq.elt list = match t with
        | Empty -> []
        | Node l x r -> (elements l) @ (x :: elements r) *)

  type enum = (Eq.elt * tree) list

  (*@ function enum_elements (e : enum) : Eq.elt list = match e with
        | [] -> []
        | (x, r) :: e -> x :: (elements r @ enum_elements e) *)

  let rec mk_zipper (t : tree) (e : enum) =
    match t with Empty -> e | Node (l, x, r) -> mk_zipper l ((x, r) :: e)
  (*@ r = mk_zipper t e
        variant t
        ensures enum_elements r = elements t @ enum_elements e *)

  let rec eq_enum (e1 : enum) (e2 : enum) =
    match (e1, e2) with
    | [], [] -> true
    | (x1, r1) :: e1, (x2, r2) :: e2 ->
        Eq.eq x1 x2 && eq_enum (mk_zipper r1 e1) (mk_zipper r2 e2)
    | _ -> false
  (*@ b = eq_num e1 e2
        variant List.length (enum_elements e1)
        ensures b <-> enum_elements e1 = enum_elements e2 *)

  let same_fringe (t1 : tree) (t2 : tree) =
    eq_enum (mk_zipper t1 []) (mk_zipper t2 [])
  (*@ b = same_fringe t1 t2
        ensures b <-> elements t1 = elements t2 *)
end

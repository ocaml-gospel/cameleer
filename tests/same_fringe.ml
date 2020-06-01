module Make (Eq: sig
    type elt

    val eq : elt -> elt -> bool
    (*@ b = eq x y
          ensures b <-> x = y *)
  end)
= struct

  type tree = Empty | Node of tree * Eq.elt * tree

  [@@@gospel {| function elements (t: tree) : elt list = match t with
                | Empty -> []
                | Node l x r -> (elements l) @ (x :: elements r) |}]

  type enum = Done | Next of Eq.elt * tree * enum

  [@@@gospel {| function enum_elements (e : enum) : elt list = match e with
                | Done -> Nil
                | Next x r e -> Cons x (elements r @ enum_elements e) |}]

  let rec enum (t: tree) (e: enum) =
    match t with
    | Empty -> e
    | Node (l, x, r) -> enum l (Next (x, r, e))
  (*@ r = enum t e
        variant t
        ensures enum_elements r = elements t @ enum_elements e *)

  let rec eq_enum (e1: enum) (e2: enum) =
    match e1, e2 with
    | Done, Done ->
        true
    | Next (x1, r1, e1), Next (x2, r2, e2) ->
        Eq.eq x1 x2 && eq_enum (enum r1 e1) (enum r2 e2)
    | _ ->
        false
  (*@ b = eq_num e1 e2
        variant length (enum_elements e1)
        ensures b <-> enum_elements e1 = enum_elements e2 *)

  let same_fringe (t1: tree) (t2: tree) =
    eq_enum (enum t1 Done) (enum t2 Done)
    (*@ b = same_fringe t1 t2
          ensures b <-> elements t1 = elements t2 *)

end

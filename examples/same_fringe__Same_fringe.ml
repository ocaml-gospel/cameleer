module Make(Eq: sig type elt
  val eq : elt -> elt -> bool end) =
struct
  type tree =
    | Empty
    | Node of tree * Eq.elt * tree
  
  type enum =
    | Done
    | Next of Eq.elt * tree * enum
  
  let rec enum (t: tree) (e: enum) : enum =
    match t with
    | Empty -> e
    | Node (l, x, r) -> enum l (Next (x, r, e))
  
  let rec eq_enum (e1: enum) (e2: enum) : bool =
    match (e1, e2) with
    | (Done, Done) -> true
    | (Next (x1,
      r1,
      e11),
      Next (x2,
      r2,
      e21)) ->
      Eq.eq x1 x2 && eq_enum (enum r1 e11) (enum r2 e21)
    | _ -> false
  
  let same_fringe (t1: tree) (t2: tree) : bool =
    eq_enum (enum t1 Done) (enum t2 Done)
end


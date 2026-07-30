type 'a tree = Empty | Node of 'a tree * 'a * 'a tree
type elt = int
type enum = Done | Next of elt * elt tree * enum

(*@ function elements (t: 'a tree) : 'a sequence = match t with
      | Empty -> Nil
      | Node l x r ->  (elements l) @ (Sequence.cons x (elements r)) *)

(*@ function enum_elements (e : enum) : elt sequence = match e with
      | Done -> Nil
      | Next x r e -> Sequence.cons x (elements r @ enum_elements e) *)

let rec mk_zipper (t : elt tree) (e : enum) : enum =
  match (t : elt tree) with
  | Empty -> e
  | Node (l, x, r) ->
      mk_zipper l (Next (x, r, e))
(*@ requires true
    ensures enum_elements result = elements t @ enum_elements e *)

let rec eq_enum (e1 : enum) (e2 : enum) : bool =
  match ((e1 : enum), (e2 : enum)) with
  | Done, Done -> true
  | (Next (x1, r1, e11), Next (x2, r2, e22))
    [@gospel "requires true
              ensures result <-> Sequence.(==) (enum_elements e1) (enum_elements e2)"] ->
      x1 = x2 &&
        let (e13: enum) = mk_zipper r1 e11 in
        let (e23: enum) = mk_zipper r2 e22 in
        eq_enum e13 e23
  | _ -> false

let same_fringe (t1 : elt tree) (t2 : elt tree) : bool =
  let (e1: enum) = mk_zipper t1 Done in
  let (e2: enum) = mk_zipper t2 Done in
  eq_enum e1 e2
(*@ requires true
    ensures result <-> Sequence.(==) (elements t1) (elements t2) *)

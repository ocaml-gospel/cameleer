type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

(*@ function elements (t: 'a tree) : 'a list = match t with
      | Empty -> Nil
      | Node l x r ->  (elements l) @ (Cons x (elements r)) *)

type elt = int

type enum = Done | Next of elt * elt tree * enum

(*@ function enum_elements (e : enum) : elt list = match e with
      | Done -> Nil
      | Next x r e -> Cons x (elements r ++ enum_elements e) *)

let rec mk_zipper (t : elt tree) (e : enum) : enum =
  match (t : elt tree) with
  | Empty -> e
  | Node ((l: elt tree), (x: elt), (r: elt tree)) 
 [@gospel {| ensures enum_elements result = elements t @ enum_elements e |}]
  -> mk_zipper l (Next (x, r, e))
(*@ r = mk_zipper t e
      variant t
*)

let rec eq_enum (e1 : enum) (e2 : enum) : bool =
  match ((e1 : enum), (e2 : enum)) with
  | Done, Done -> true
  | (Next ((x1: elt), (r1:elt tree), (e11: enum)), Next ((x2:elt), (r2: elt tree),(e22: enum))) 
  [@gospel {| ensures result <-> (enum_elements e1 = enum_elements e2) |}]
  ->
      if x1 = x2 then
        let (e13: enum) = mk_zipper r1 e11 in
        let (e23: enum) = mk_zipper r2 e22 in
        eq_enum e13 e23
      else false
  (* TODO: if we remove the 2nd _ the patterns compilation fails *)
  | (_: enum), (_: enum) -> false
(*@ b = eq_enum e1 e2
      variant List.length (enum_elements e1)
     *)


let same_fringe (t1 : elt tree) (t2 : elt tree) : bool =
  let (e1: enum) = mk_zipper t1 Done in
  let (e2: enum) = mk_zipper t2 Done in
  eq_enum e1 e2
(*@ b = same_fringe t1 t2
      ensures b <-> elements t1 = elements t2 *)

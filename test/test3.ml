type tree = E | N of tree * tree

let f (t: tree) : int =
  match (t: tree) with
  | N (E, r)
    [@gospel {| requires p1
                ensures  q1 |}]   -> 1
  | E [@gospel {| requires p2
                  ensures  q2 |}] -> 2
  | N (_, _) -> 3
  | _ -> 30
(*@ r = f t
      requires pre
      ensures  post *)

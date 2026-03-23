type tree = E | N of tree * tree

let f (t: tree) : int =
  match (t: tree) with
  | (N (E, (r: tree)))
    [@gospel {| requires P1
                ensures  Q1 |}]   -> 1
  | E [@gospel {| requires P2
                  ensures  Q2 |}] -> 2
  | N (_, _) -> 3
  | (_: tree) -> 30
(*@ r = f t
      requires Pre
      ensures  Post *)

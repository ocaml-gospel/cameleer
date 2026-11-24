type tree = E | N of tree * tree

(*@ predicate post (x: int) = x = 42 *)
(*@ predicate pre  (x: int) = x = 42 *)
(*@ predicate p1   (x: int) = x = 42 *)
(*@ predicate q1   (x: int) = x = 42 *)
(*@ predicate p2   (x: int) = x = 42 *)
(*@ predicate q2   (x: int) = x = 42 *)

let f (t: tree) : int =
  match (t: tree) with
  | N (E, r)
    [@gospel {| requires p1 1
                ensures  q1 2 |}]   -> 1
  | E [@gospel {| requires p2 3
                  ensures  q2 4 |}] -> 2
  | N (_, _) -> 3
  | _ -> 30
(*@ r = f t
      requires pre 5
      ensures  post 6 *)

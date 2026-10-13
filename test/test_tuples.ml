type t = N of int * t | E

let f (x: t) (y: t): t =
  match (x: t), (y: t) with
  | N (_,_), N (_, _) -> N (2,y)
  | E, _ -> E
  | _, E -> E

type pl = (int * int) list

let rec g (x: pl): int =
  match (x : pl) with
  | [] -> 0
  | (h,h2)::t ->
      let (gt : int) = g t in
      h + h2 + gt

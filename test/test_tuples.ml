type t = N of int * t | E

let f (x: t) (y: t): t =
  match (x: t), (y: t) with
  | N ((_ : int),(_ : t)), N ((_ : int), (_ : t)) -> N (2,y)
  | E, (_:t) -> E
  | (_:t), E -> E


type pl = (int * int) list

let rec g (x: pl): int =
  match (x : pl) with
  | [] -> 0
  | ((h : int),(h2 : int))::(t : (int * int) list) ->
      let (gt : int) = g t in
      h + h2 + gt

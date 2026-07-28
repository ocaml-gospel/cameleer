let rec fact (a:int) : int =
  if a <= 0 then 1
  else 
    let (o1:int) = fact (a - 1) in
    a * o1
(*@ r = fact a
    requires a >= 0
    ensures r > 0
    variant a*)


let rec fact2 (a:int) : int =
  if a <= 0 then 1
  else 
    (let (o1:int) = fact2 (a - 1) in
    a * o1)
    [@gospel {| requires a > 0
                ensures result > 0|}]
(*@ r = fact a
    variant a*)

let test (a:int): int = 
  if a <= 0 then -1
    [@gospel {| requires a >= 0
                ensures result < 0|}]
  else 
    2
    [@gospel {| requires a >= 0
                ensures result > 0|}]

let main (x: int) : int =
  fact x
(*@ r = main x 
    requires x >= 0
    ensures r > 0 *)

let main2 (x: int) : int =
  fact2 x
(*@ r = main2 x 
    requires x >= 0
    ensures r > 0 *)


(* let is_positive (x: int) : bool = x > 0

let rec test (a: int) : int =
  if (is_positive a)
  then
    test (a - 1)
      [@gospel {| requires a > 0
                  ensures result >= 0 |}]
  else a *)

(* let rec test2 (a: int) : int =
  let is_pos (x:int) : bool = x > 0 in
  if (is_pos a)
  then
    test2 (a - 1)
      [@gospel {| requires a > 0
                  ensures result >= 0 |}]
  else a *)
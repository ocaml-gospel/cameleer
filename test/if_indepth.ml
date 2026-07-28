let rec fact (a : int) : int =
  if a <= 0 then 1
  else
    let (o1:int) = fact (a - 1) in
    a * o1
(*@ r = fact a
    requires a > 0
    ensures  r > 0 *)


let rec fact2 (a : int) : int =
  if a <= 0 then 1
  else
    (let (o1:int) = fact2 (a - 1) in
    a * o1) [@gospel {| requires a > 0
                        ensures result > 0|}]

let is_positive (x : int) : bool = x > 0

let rec test (a : int) : int =
  if is_positive a
  then
    test (a - 1)
      [@gospel {| requires a > 0
                  ensures result >= 0 |}]
  else a

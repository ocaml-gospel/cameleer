(*@ open Power *)

let rec power_2_above x n =
  if x >= n then x
  else power_2_above (x * 2) n
(*@ r = power_2_above x n
      requires x > 0
      requires exists k. k >= 0 && x = 2 ^ k
      variant  n - x
      ensures  exists k. k >= 0 && r = 2 ^ k && r >= n *)

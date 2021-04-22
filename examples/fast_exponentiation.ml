(*@ open Power *)

let rec fast_exp x n =
  if n = 0 then 1
  else let r = fast_exp x (n / 2) in
    if n mod 2 = 0 then r * r else r * r * x
(*@ r = fast_exp x n
      requires 0 <= n
      variant  n
      ensures  r = x ^ n *)

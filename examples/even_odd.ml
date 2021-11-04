let rec even x =
  if x = 0 then true
  else odd (x-1)
(*@ b = even x
    requires x >= 0
    variant  x
    ensures  b <-> mod x 2 = 0 *)
and odd y =
  if y = 0 then false
  else even (y-1)
(*@ b = odd y
    requires y >= 0
    variant  y
    ensures  b <-> mod y 2 = 1 *)

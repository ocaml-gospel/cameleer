
let g (x: int): int =
  let (k:int->int) = fun (j:int) -> j + 1 in
  k x

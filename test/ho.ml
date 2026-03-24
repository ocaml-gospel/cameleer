
let f (x: int): int =
  (fun (y:int) -> y + 1) x

let g (x: int): int =
  let c = fun (y:int) -> y + 1 in
  c x

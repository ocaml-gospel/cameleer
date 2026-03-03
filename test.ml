(* dune exec bin_coma/cli.exe -- ./test.ml *)

let band x y =
  if x then
    if y then 1 else 0
  else 0

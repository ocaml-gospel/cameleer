
let test (n: int) : int =
  let (res: int ref) = ref 0 in
  for i = 0 to n - 1 do
    res := !res + 1
  done;
  !res

let test2 (n: int) : int =
  let (res: int ref) = ref 0 in
  let (i: int ref) = ref 0 in
  while !i < n do
    res := !res + 1;
    i := !i + 1
  done;
  !res

let power (x: int) (n: int) : int =
  let (res: int ref) = ref 1 in
  let (i: int ref) = ref 0 in
  while !i < n do
    res := !res * x;
    i := !i + 1
  done;
  !res

(* let fact (n: int) : int =
  let (res: int ref) = ref 1 in
  let (k: int) = n - 1 in
  for i = 0 to k do
    let (aux: int) = i + 1 in
    res := !res * aux
  done;
  !res *)

(* @ function fib (n: int) : integer = if n <= 1 then n else fib (n - 1) + fib (n - 2)  *)
(*@ function fib (t: int) : integer *)

let fibonacci (n: int) : int =
  let (y: int ref) = ref 0 in
  let (x: int ref) = ref 1 in
  for i = 0 to (n - 1) do
    let (aux: int) = !y in
    y := !x;
    x := !x + aux
  done;
  !y
(*@ r = fibonacci n
      requires n >= 0
      ensures  r = fib n *)

let test : int =
  let (x: int) = 2 in
  x + 1

let test3 (n: int): int =
  for i = 0 to n - 1 do
    let (aux: int) = test in
    aux + 1
  done;
  1

let [@logic] [@ghost] rec fib n =
  if n <= 1 then n else fib (n-1) + fib (n-2)
(*@ r = fib n
      requires n >= 0
      variant  n *)

let fibonacci n =
  let y = ref 0 in
  let x = ref 1 in
  for i = 0 to n - 1 do
    (*@ invariant !y = fib i && !x = fib (i+1) *)
    let aux = !y in
    y := !x;
    x := !x + aux
  done;
  !y
(*@ r = fibonacci n
      requires n >= 0
      ensures  r = fib n *)

let fib_main k =
  let rec fib_rec_aux (n [@ghost]) a b k =
    if k = 0 then a else fib_rec_aux (n + 1) b (a + b) (k - 1)
  (*@ r = fib_rec_aux n a b k
        requires k >= 0
        requires 0 <= n && a = fib n && b = fib (n+1)
        variant  k
        ensures  r = fib (n+k) *) in
  fib_rec_aux 0 0 1 k
(*@ r = fib_main k
      requires k >= 0
      ensures  r = fib k *)

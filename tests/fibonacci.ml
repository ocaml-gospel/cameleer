let [@logic] [@ghost] rec fib n =
  if n = 0 then 0 else
  if n = 1 then 1 else
  fib (n-1) + fib (n-2)
(*@ r = fib n
      requires n >= 0
      variant  n *)

let fibonnaci n =
  let y = ref 0 in
  let x = ref 1 in
  for i = 0 to n - 1 do
    (*@ invariant 0 <= i <= n *)
    (*@ invariant fib (i+1) = !x /\ fib i = !y *)
    let aux = !y in
    y := !x;
    x := !x + aux
  done;
  !y
(*@ r = fibonnaci n
      requires n >= 0
      ensures  fib n = r *)

let rec fib_rec_aux (n [@ghost]) a b k =
  if k = 0 then a else fib_rec_aux (n + 1) b (a + b) (k - 1)
(*@ r = fib_rec_aux n a b k
      requires k >= 0
      requires 0 <= n && a = fib n && b = fib (n+1)
      variant  k
      ensures  r = fib (n+k) *)

let fib_main k =
  fib_rec_aux 0 0 1 k
(*@ r = fib_main k
      requires k >= 0
      ensures  r = fib k *)

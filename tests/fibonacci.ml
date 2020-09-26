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

(*@ type t = { a11: int; a12: int; a21: int; a22: int } *)

(*@ function m1110 : t = { a11 = 1; a12 = 1; a21 = 1; a22 = 0 } *)

module type Monoid = sig
  type elt

  (*@ function op (x y: elt) : elt *)
  (*@ axiom assoc: forall x y z. op (op x y) z = op x (op y z) *)

  (*@ function unit : elt *)

  (*@ axiom unit_def_l: forall x: elt. op unit x = x *)
  (*@ axiom unit_def_r: forall x: elt. op x unit = x *)
end

module type Exponentiation = sig
  type t

  (*@ function one: t *)

  (*@ function ( * ) (x y: t) : t *)

  include Monoid with type elt := t
end

module LogFib (E: Exponentiation) = struct

  let rec logfib n =
    if n = 0 then
      1, 0
    else
      (* assert { 0 <= div n 2 }; *)
      let a, b = logfib (n / 2) in
      let c = a + b in
      if n mod 2 = 0 then
        (* assert { 2 * (div n 2) = (div n 2) + (div n 2) }; *)
        a*a+ b*b, b*(a + c)
      else
        (* assert { 2 * (div n 2) + 1 = (div n 2) + (div n 2) + 1 }; *)
        b*(a + c), c*c + b*b
  (*@ r = logfib n
        requires n >= 0
        variant  n *)
end

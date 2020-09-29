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

module type Monoid = sig
  type t

  (*@ function op (x y: t) : t *)
  (*@ axiom assoc: forall x y z. op (op x y) z = op x (op y z) *)

  (*@ function unit : t *)

  (*@ axiom unit_def_l: forall x: t. op unit x = x *)
  (*@ axiom unit_def_r: forall x: t. op x unit = x *)
end

module type Exponentiation = sig
  type t

  (*@ function one: t *)

  (*@ function ( * ) (x y: t) : t *)

  include Monoid
    with type t := t (* For now, this only works for types with the same name *)
(*@ with function unit = one and function op := ( * ) *)

  (*@ function power (t: t) (x: integer) : t *)

  (*@ axiom power_0 : forall x: t. power x 0 = one *)

  (*@ axiom power_s :
        forall x: t, n: integer. n >= 0 -> power x (n+1) = x * power x n *)

  (*@ lemma power_s_alt:
        forall x: t, n: int. n > 0 -> power x n = x * power x (n-1) *)

  (*@ lemma power_1 : forall x : t. power x 1 = x *)

  (*@ lemma power_sum : forall x: t, n m: int. 0 <= n -> 0 <= m ->
        power x (n+m) = power x n * power x m *)

  (*@ lemma power_mult : forall x:t, n m : int. 0 <= n -> 0 <= m ->
        power x (Int.( * ) n m) = power (power x n) m *)

  (*@ lemma power_comm1 : forall x y: t. x * y = y * x ->
        forall n:int. 0 <= n ->
        power x n * y = y * power x n *)

  (*@ lemma power_comm2 : forall x y: t. x * y = y * x ->
        forall n:int. 0 <= n ->
        power (x * y) n = power x n * power y n *)
end

module type Mat22 = sig

  (* TODO: this does not need to be a "real" type *)
  type t = { a11: int; a12: int; a21: int; a22: int }

  (*@ function id : t = { a11 = 1; a12 = 0; a21 = 0; a22 = 1 } *)

  (*@ function mult (x: t) (y: t) : t = {
        a11 = x.a11 * y.a11 + x.a12 * y.a21;
        a12 = x.a11 * y.a12 + x.a12 * y.a22;
        a21 = x.a21 * y.a11 + x.a22 * y.a21;
        a22 = x.a21 * y.a12 + x.a22 * y.a22;
      } *)

  include Exponentiation
    with type t := t
(*@ with function one = id and function ( * ) := mult *)

end

module LogFib (M: Mat22) = struct

  let [@ghost] [@logic] m1110 : M.t = {
    a11 = 1; a12 = 1; a21 = 1; a22 = 0;
  }

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
        variant  n
        ensures  let a, b = r in
          power m1110 n = { a11 = a + b; a12 = b; a21 = b; a22 = a } *)
end

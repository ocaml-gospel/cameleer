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

module type Power = sig
  val [@logic] power : int -> int -> int

  (*@ function one : int = 1 *)

  include Exponentiation
    with type t = int
(*@ with function one   := one   and
         function ( * ) := ( * ) and
         function power := power and
         goal     assoc          and
         goal     unit_def_l     and
         goal     unit_def_r     and
         axiom    power_0        and
         axiom    power_s *)

  (*@ lemma power_non_neg:
        forall x y. x >= 0 /\ y >= 0 -> power x y >= 0 *)

  (*@ lemma power_pos:
        forall x y. x > 0 /\ y >= 0 -> power x y > 0 *)

  (*@ lemma power_monotonic:
        forall x n m:int. 0 < x /\ 0 <= n <= m -> power x n <= power x m *)
end

module FastExp (P: Power) = struct

  let rec fast_exp x n =
    if n = 0 then 1
    else let r = fast_exp x (n / 2) in
      if n mod 2 = 0 then r * r else r * r * x
  (*@ r = fast_exp x n
        requires 0 <= n
        variant  n
        ensures  r = P.power x n *)
end

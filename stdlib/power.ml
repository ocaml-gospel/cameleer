module type Exponentiation = sig
  type t

  (*@ function one: t *)

  (*@ function mul (x y: t) : t *)

  (*@ axiom assoc: forall x y z. mul (mul x y) z = mul x (mul y z) *)

  (*@ axiom unit_def_l: forall x: t. mul one x = x *)
  (*@ axiom unit_def_r: forall x: t. mul x one = x *)

  (*@ function power (t: t) (x: integer) : t *)

  (*@ axiom power_0 : forall x: t. power x 0 = one *)

  (*@ axiom power_s : forall x: t, n: integer. n >= 0 ->
        power x (n+1) = mul x (power x n) *)

  (*@ lemma power_s_alt: forall x: t, n: int. n > 0 ->
        power x n = mul x (power x (n-1)) *)

  (*@ lemma power_1 : forall x : t. power x 1 = x *)

  (*@ lemma power_sum : forall x: t, n m: int. 0 <= n -> 0 <= m ->
        power x (n+m) = mul (power x n) (power x m) *)

  (*@ lemma power_mult : forall x:t, n m : int. 0 <= n -> 0 <= m ->
        power x (n * m) = power (power x n) m *)

  (*@ lemma power_comm1 : forall x y: t. mul x y = mul y x ->
        forall n:int. 0 <= n ->
        mul (power x n) y = mul y (power x n) *)

  (*@ lemma power_comm2 : forall x y: t. mul x y = mul y x ->
        forall n:int. 0 <= n ->
        power (mul x y) n = mul (power x n) (power y n) *)
end

module type Power = sig
  type t = int

  val power : int -> int -> int [@@logic]

  (*@ function one : int = 1 *)

  (*@ function mul (x y: t) : t = x * y *)

  (*@ axiom assoc: forall x y z. mul (mul x y) z = mul x (mul y z) *)

  (*@ axiom unit_def_l: forall x: t. mul one x = x *)
  (*@ axiom unit_def_r: forall x: t. mul x one = x *)

  (*@ axiom power_0 : forall x: t. power x 0 = one *)

  (*@ axiom power_s : forall x: t, n: integer. n >= 0 ->
        power x (n+1) = mul x (power x n) *)

  (*@ lemma power_s_alt: forall x: t, n: int. n > 0 ->
        power x n = mul x (power x (n-1)) *)

  (*@ lemma power_1 : forall x : t. power x 1 = x *)

  (*@ lemma power_sum : forall x: t, n m: int. 0 <= n -> 0 <= m ->
        power x (n+m) = mul (power x n) (power x m) *)

  (*@ lemma power_mult : forall x:t, n m : int. 0 <= n -> 0 <= m ->
        power x (n * m) = power (power x n) m *)

  (*@ lemma power_comm1 : forall x y: t. mul x y = mul y x ->
        forall n:int. 0 <= n ->
        mul (power x n) y = mul y (power x n) *)

  (*@ lemma power_comm2 : forall x y: t. mul x y = mul y x ->
        forall n:int. 0 <= n ->
        power (mul x y) n = mul (power x n) (power y n) *)

  (*@ lemma power_non_neg:
        forall x y. x >= 0 /\ y >= 0 -> power x y >= 0 *)

  (*@ lemma power_pos:
        forall x y. x > 0 /\ y >= 0 -> power x y > 0 *)

  (*@ lemma aux: forall x y z. x > 0 -> 0 <= y <= z ->
      x * y <= x * z *)

  (*@ lemma power_monotonic:
        forall x n m:int. 0 < x /\ 0 <= n <= m -> power x n <= power x m *)
end

(*@ function logic_sum (f: int -> int) (l: int) (u: int) : integer *)

(*@ axiom logic_sum_0: forall f l u. u <= l -> logic_sum f l u = 0 *)
(*@ axiom logic_sum_n: forall f l u. u > l ->
      logic_sum f l u = logic_sum f l (u-1) + f (u-1) *)

(*@ lemma logic_sum_left:
      forall f: (int -> int), a b: int.
      a < b -> logic_sum f a b = f a + logic_sum f (a + 1) b *)

(*@ lemma logic_sum_ext:
      forall f g: (int -> int), a b: int.
      (forall i. a <= i < b -> f i = g i) ->
      logic_sum f a b = logic_sum g a b *)

(*@ lemma logic_sum_le:
      forall f g: (int -> int), a b: int.
      (forall i. a <= i < b -> f i <= g i) ->
      logic_sum f a b <= logic_sum g a b *)

(*@ lemma logic_sum_zero:
      forall f: (int -> int), a b: int.
      (forall i. a <= i < b -> f i = 0) ->
      logic_sum f a b = 0 *)

(*@ lemma logic_sum_nonneg:
      forall f: (int -> int), a b: int.
      (forall i. a <= i < b -> 0 <= f i) ->
      0 <= logic_sum f a b *)

(*@ lemma logic_sum_decomp:
      forall f: (int -> int), a b c: int. a <= b <= c ->
      logic_sum f a c = logic_sum f a b + logic_sum f b c *)

let[@lemma] rec shift_left (f : int -> int) (g : int -> int) a b c (d : int) =
  if a < b then shift_left f g (a + 1) b (c + 1) d
(*@ shift_left f g a b c d
    requires b - a = d - c
    requires forall i. a <= i < b -> f i  = g (c + i - a)
    variant  b - a
    ensures  logic_sum f a b = logic_sum g c d *)

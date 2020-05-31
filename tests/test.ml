let f (x: int) : int = x
(*@ r = f x
      requires x >= 0
      ensures  r >= 0 *)

type 'a t = E | N of 'a t * 'a * 'a t

[@@@gospel {|function size_logic (t: 'a t) : integer =
      match t with
      | E -> 0
      | N l _ r -> 1 + size_logic l + size_logic r |}]

let rec size (t: 'a t) : int =
  match t with
  | E -> 0
  | N (l, _, r) -> 1 + size l + size r
(*@ r = size t
      variant t *)

let head (t: 'a t) =
  match t with
  | E -> assert false
  | N (_, x, _) -> x
(*@ r = head t
      requires t <> E *)

type a = {
  mutable b: int;
  c: bool
} (*@ invariant c -> b > 0 *)

let rec dup_size t : int =
  match t with
  | E -> 0
  | N (l, _, r) -> 1 + dup_size l + dup_size r
(*@ r = size t
      variant t
      ensures r = size_logic t *)

let ff () : int = 42

let mk_a (b: int) : a =
  { b = b; c = true }
(*@ r = mk_a b
      requires b > 0 *)

[@@@gospel "function fact_logic (x: integer) : integer"]
[@@@gospel "axiom fact_0: fact_logic 0 = 1"]
[@@@gospel {|axiom fact_n: forall n. n > 0 ->
              fact_logic n = n * fact_logic (n-1)|}]

let rec fact (x: int) : int =
  if x = 0 then 1
  else x * fact (x - 1)
(*@ r = fact x
      variant x *)

let rec fact_2 (x: int) (acc: int) : int =
  if x = 0 then acc
  else fact_2 (x - 1) (acc * x)
(*@ r = fact_2 x
      requires x >= 0
      variant  x
      ensures  r >= acc * fact_logic x *)

type nat = { v: int }
(*@ invariant v >= 0 *)

let rec sum (x: nat) (y: nat) : int =
  if y.v = 0 then x.v
  else sum {v = x.v + 1} {v = y.v - 1}
(*@ r = sum x y
      requires in_bounds (x.v + y.v)
      variant  y.v
      ensures  r = x.v + y.v *)

[@@@gospel {| function power (x y: integer) : integer |}]
[@@@gospel {| axiom power_0: forall x. power x 0 = 1  |}]
[@@@gospel {| axiom power_s : forall x n. n >= 0 ->
                power x (n+1) = x * power x n |}]

let rec fast_exp (x: int) (n: int) =
  if n = 0 then 1
  else
    let r = fast_exp x (n / 2) in
    if n mod 2 = 0 then r * r else r * r * x
(*@ r = fast_expr x n
      requires 0 <= n
      variant  n
      ensures  r = power x n *)

let rec length (l: 'a list) : int =
  match l with
  | [] -> 0
  | _ :: r -> 1 + length r
(*@ r = length l
      variant l *)

type elt = int

type tree = Empty | Node of tree * elt * tree

[@@@gospel {| function elements (t: tree) : elt list =
                match t with
                | Empty -> []
                | Node l x r -> (elements l) @ (x :: elements r) |}]

type enum = Done | Next of elt * tree * enum

[@@@gospel {| function enum_elements (e : enum) : elt list = match e with
              | Done -> Nil
              | Next x r e -> Cons x (elements r ++ enum_elements e) |}]

let rec enum (t: tree) (e: enum) =
  match t with
  | Empty -> e
  | Node (l, x, r) -> enum l (Next (x, r, e))
(*@ r = enum t e
      variant t
      ensures enum_elements r = elements t ++ enum_elements e *)

let rec eq_enum (e1: enum) (e2: enum) =
  match e1, e2 with
  | Done, Done ->
      true
  | Next (x1, r1, e1), Next (x2, r2, e2) ->
      x1 = x2 && eq_enum (enum r1 e1) (enum r2 e2)
  | _ ->
      false
(*@ b = eq_num e1 e2
      variant length (enum_elements e1)
      ensures b <-> enum_elements e1 = enum_elements e2 *)

let same_fringe (t1: tree) (t2: tree) =
  eq_enum (enum t1 Done) (enum t2 Done)
(*@ b = same_fringe t1 t2
      ensures b <-> elements t1 = elements t2 *)

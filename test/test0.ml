type t = E | N of t
(* type l = Nil | Cons of t * l

let compare (a : l) (b : l) = match (a : l), (b : l) with
  | Nil, Nil                             -> 0
  | Cons (E, (a : l)), Cons (E, (b : l)) -> 0
  | (_ : l), Nil                         -> 1
  | Cons (N (_ : t), (_ : l)), (_ : l)    -> 1
  | Nil, (_ : l)                         -> -1
  | (_ : l), Cons(N (_ : t),(_ : l))     -> -1
 *)

type l0 = t list

(* let compare (a : l) (b : l) = match (a : l), (b : l) with
  | [], []                        -> 0
  | E :: (_ : l), E :: (_ : l)    -> 0 *)

type l = Nil | Cons of t * l0

(* À résoudre *)
let f1 (a : l): int = match (a : l) with
  | Cons ((_ : t), (_ : l)) -> 0

(* À résoudre *)
let f2 (a : l): int = match (a : l) with
  | Cons ((E : t), (_ : l)) -> 0
  | (_ : l) -> 0

(* let compare (a : l) = match (a: l) with
  | Cons (E, (b : l)) -> 0 *)

(* type t = E
let f (a: t): int = match (a: t) with E -> 0 *)

(*
let f2 (a : l) = match (a: l) with
  | Cons (N (_ : t), (b : l)) -> 0
  | Cons (E, (b : l)) -> 0
 *)

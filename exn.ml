(* ------------------------------------------------------------------------- *)
(*- Exceptions -*)

(** TODO: discuss this
    Is the following function a limitation?
    -> We can't (easily) get the name of the exception. *)
(*
    let g a =
      let r = E 42 in
      raise r
 *)

exception H of int
exception E of int
exception G of int

(* Some questions *)

(* Here CPS[g1] must take additional continuation to handle the [raise]. *)
let g1 a = if a then raise (E 42) else raise (G 34)

(* Here only one for [G]. *)
let g2 a =
  try raise (E 42)
  with E x -> x

(* [f1] uses [g1] without handler,
   does [f1] requires an additional continuation? yes *)
let f1 a =
  g1 a

(* one additional continuation *)
let f2 a =
  try
    g1 a
  with E x -> x

(* no additional continuation *)
let f2 a =
  try
    g1 a
  with E x -> x
     | G y -> y

(* catches exceptions from [g] but may raise [H] *)
let f3 a b =
  try
    if b then g1 a else raise (H 13)
  with E x -> x
     | G y -> y

(* catches exceptions from [g]+[H] but may raise [G] *)
let f3 a b =
  try
    if b then g1 a else raise (H 13)
  with E x -> x
     | G y -> y
     | H z -> raise (G z)

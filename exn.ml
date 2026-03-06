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

exception E of int

(* Some questions *)

(* Here CPS[g1] must take additional continuation to handle the [raise]. *)
let g1 a = raise (E 42)

(* Here not. *)
let g2 a =
  try raise (E 42)
  with E x -> x

(* [f1] uses [g1] without handler,
   does [f1] requires an additional continuation? yes *)
let f1 a =
  g1 a

(* no additional continuation *)
let f1 a =
  try
    g1 a
  with E x -> x

(* no additional continuation *)

let g1 a return raise_E = raise_E 42

let f1cps a return =
  let onE x = x in
  g1 a return (onE)

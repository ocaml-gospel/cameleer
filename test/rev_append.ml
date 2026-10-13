(* OCAML *)

(* use int.Int
use list.List
use list.Append
use list.Reverse *)

(* use list.List *)
(* use list.Reverse *)

(* type 'a list = Nil | Cons of 'a * 'a list *)

let rev_append (l0 : int list) (r0 : int list) : int list =
  let (r: int list ref) = ref r0 in
  let (l: int list ref) = ref l0 in

  let rec loop =
    let (aux: int list) = !l in
    match (aux: int list) with
    | [] -> !r
    | (h: int):: (t: int list) ->
        r := h :: !r;
        l := t;
        loop
  in
  loop
(*@ requires true
    ensures result = (reverse l0) ++ r0 *)

(* ------------------------------------- *)
(* COMA *)

(*
let rev_append (l0: list 'a) (r0: list 'a) {}
      (out (r: list 'a) { r = reverse l0 ++ r0 })
= loop
  [ loop
    = unList {l}
        (fun (h: 'a) (t: list 'a) ->
          [ &r <- Cons h r | &l <- t ] loop)
        (-> out {r}) ]
  [ &r: list 'a = r0 | &l: list 'a = l0 ] *)

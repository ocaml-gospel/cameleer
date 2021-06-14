type t = {
  mutable left : int;
         right : int;
}

let foo t =
  t.left <- t.right + t.left
(*@ foo t
      modifies t.left
      ensures  t.left = old (t.left) + t.right *)

(* type t = E | T of { value : int; mutable next : t }
 *
 * field value: Int
 * field next: Ref
 *
 * predicate t_repr (t: t) =
 *   case T => acc(t.value, 1/2) && acc(t.next) && t_repr(t.next *)

(* let swap t =
 *   let tmp = t.left in
 *   t.left <- t.right;
 *   t.right <- tmp *)
(* @ swap t
      ensures t.left  = (old t).right
      ensures t.right = (old t).left *)

let incr r =
  r := !r + 1
(*@ incr r
      ensures  r.contents = old(r.contents) + 1
      modifies r *)

(* let is_zero r =
 *   !r = 0
 * (\*@ b = is_zero r
 *       ensures b <-> r.contents = 0 *\) *)

let swap r1 r2 =
  r1.contents <- r2.contents

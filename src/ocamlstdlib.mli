val invalid_arg : string -> 'a
(*@ raises  Invalid_argument
    ensures false *)

(*@ predicate same_location (x y: 'a) *)

(*@ axiom same_location_eq: forall x y: 'a.
      same_location x y -> x = y *)

val ( == ) : 'a -> 'a -> bool
(* @ r = (==) x0 x1
      ensures r <-> same_location x0 x1 *)

val ignore : 'a -> unit
(*@ ignore x
      ensures true *)

val fst : 'a * 'b -> 'a
(*@ r = fst p
      ensures r = fst p
      ensures let (x, y) = p in r = x *)

val snd : 'a * 'b -> 'b
(*@ r = snd p
      ensures r = snd p *)

type ('a, 'b) result = Ok of 'a | Error of 'b

module List : sig
  val length : 'a list -> int
  (* @ r = length l
        ensures r = List.length l *)

  val rev : 'a list -> 'a list
  (* @ r = rev l
        ensures r = List.rev l *)

  val init : int -> (int -> 'a) -> 'a list
  (*@ r = init len f
        requires len >= 0
        ensures  forall i: int. 0 <= i < len -> r[i] = f i
        ensures  List.length r = len *)

  val rev_append : 'a list -> 'a list -> 'a list
  (*@ r = rev_append l1 l2
        ensures r = Seq.rev l1 ++ l2 *)

  val mem : 'a -> 'a list -> bool
  (*@ b = mem x l
        ensures b <-> List.mem x l *)
end

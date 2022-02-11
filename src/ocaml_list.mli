val length : 'a list -> int
(*@ r = length l
      ensures r = List.length l *)

val rev : 'a list -> 'a list
(*@ r = rev l
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

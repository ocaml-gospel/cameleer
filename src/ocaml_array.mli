val length : 'a array -> int
(*@ r = length a
      ensures r = Array.length a *)

val get : 'a array -> int -> 'a
(*@ r = get a i
      requires 0 <= i < Array.length a
      ensures r = Array.get a i *)

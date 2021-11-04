(*@ open Sequence *)

type 'a t = {
  dummy : 'a;
  mutable size : int;
  mutable data : 'a array;
  (* 0 <= size <= Array.length data *)
  mutable view : 'a sequence; [@ghost]
}

let make ?dummy n d =
  if n < 0 || n > Sys.max_array_length then invalid_arg "Vector.make";
  let dummy = match dummy with None -> d | Some x -> x in
  { dummy; size = n; data = Array.make n dummy; view = empty }
(*@ t = make ?dummy n d
      requires 0 <= n <= Sys.max_array_length
      raises   Invalid_argument _ -> not (0 <= n < Sys.max_array_length)
      ensures  t.size = n *)

(* let create ?(capacity=0) ~dummy =
 *   if capacity < 0 || capacity > Sys.max_array_length then
 *     invalid_arg "Vector.create";
 *   { dummy = dummy; size = 0; data = Array.make capacity dummy; }
 * (\*@ t = create ?capacity ~dummy
 *       requires let capacity = match capacity with
 *                  | None -> 0 | Some c -> c in
 *                0 <= capacity <= Sys.max_array_length
 *       raises   Invalid_argument _ -> false *\) *)

let init n ~dummy f =
  if n < 0 || n > Sys.max_array_length then invalid_arg "Vector.init";
  { dummy; size = n; data = Array.init n f; view = empty }
(*@ t = init n ~dummy f
      raises Invalid_argument _ -> not (0 <= n < Sys.max_array_length) *)

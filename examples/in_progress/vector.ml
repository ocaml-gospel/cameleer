type 'a t = {
          dummy: 'a;
  mutable size:  int;
  mutable data:  'a array; (* 0 <= size <= Array.length data *)
}

let make n ~dummy =
  if n < 0 || n > Sys.max_array_length then invalid_arg "Vector.make";
  { dummy = dummy; size = n; data = Array.make n dummy; }
(*@ t = make n ~dummy
      raises Invalid_argument _ -> not (0 <= n < Sys.max_array_length) *)

let create ~dummy =
  make 0 ~dummy
(*@ t = create ~dummy
      raises Invalid_argument _ -> false *)

let init n ~dummy f =
  if n < 0 || n > Sys.max_array_length then invalid_arg "Vector.init";
  { dummy = dummy; size = n; data = Array.init n f; }
(*@ t = init n ~dummy f
      raises Invalid_argument _ -> not (0 <= n < Sys.max_array_length) *)

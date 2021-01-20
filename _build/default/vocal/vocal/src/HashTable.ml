(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

module type HashedType = sig
  type t
  val equal: t -> t -> bool
  val hash: t -> int
end

(* A note on array bounds checks. In OCaml, a call [Array.get a i] is always
   checked, a call [Array.unsafe_get a i] is never checked, and an array access
   expression [a.(i)] is checked if and only if the compile-time flag [-unsafe]
   is not passed. In the code that follows, we use the latter form. When
   processed by CFML, without [-unsafe], this form is translated to
   [Array.get a i], and we prove that the array index is within bounds. When
   compiled with OCaml, we pass [-unsafe], so the check is not performed. *)

(* In this code, array indices are always within bounds, even if the client is
   unverified. This claim is informal, though; at present, we cannot explicitly
   reason about an unverified client in CFML. *)

module Make (K : HashedType) = struct

  type key = K.t

  (* A bucket is is a list of (unboxed) pairs of a key and a value. *)

  type 'a bucket =
    Void
  | More of key * 'a * 'a bucket

  (* The [data] field holds an array of buckets. The length of this array is
     always a power of two. Information about the key [k] is stored at index
     [index h k] in this array. The [population] field records how many
     bindings (i.e. key-data pairs) are present in the table. The [init] field
     records the table's initial capacity; it is used only by [reset]. *)

  type 'a table = {
    mutable data: 'a bucket array;
    mutable population: int;
    init: int;
  }

  type 'a t = 'a table

  (* [power_2_above x n] requires [x] to be a power of two, and ensures that
     its result [y] is a power of two and satisfies [x <= y]. *)

  (* It does NOT guarantee [n <= y]. In reality, this will be the case unless
     [max_array_length] is reached. We do not exceed [max_array_length],
     because we know that this will cause a failure when attempting to
     allocate the array. Also, this guarantees that the function terminates
     before an overflow can occur. These aspects are outside of the scope of
     the formal proof. *)

  let rec power_2_above x n =
    if x >= n then x
    else if x * 2 > Sys.max_array_length then x
    else power_2_above (x * 2) n

  let create init =
    let init = power_2_above 16 init in
    { data = Array.make init Void; population = 0; init }

  let clear h =
    h.population <- 0;
    Array.fill h.data 0 (Array.length h.data) Void

  let reset h =
    h.population <- 0;
    h.data <- Array.make h.init Void

  let copy h = {
    data = Array.copy h.data;
    population = h.population;
    init = h.init
  }

  let population h =
    h.population

  let length =
    population

  let index h k =
    (K.hash k) land (Array.length h.data - 1)

  (* [resize_aux h b] inserts the key-data pairs in [b], back-to-front,
     into the hash table [h], without updating [h.population] and without
     resizing the hash table (which is in the process of being resized).
     Working back-to-front is important because this preserves the original
     order of the values, when there are several values for a single key. *)

  let rec resize_aux h = function
    | Void ->
        ()
    | More (k, x, b) ->
        resize_aux h b; (* work back-to-front *)
        let i = index h k in
        h.data.(i) <- More (k, x, h.data.(i))

  let resize h =
    let odata = h.data in
    let nsize = Array.length odata * 2 in
    if nsize < Sys.max_array_length then begin
      h.data <- Array.make nsize Void;
      (* We could use [Array.iter] and rely on the OCaml compiler to inline
         it. The flambda compiler can do it. Still, it seems preferable to
         use an explicit loop. *)
      for i = 0 to Array.length odata - 1 do
        resize_aux h odata.(i)
      done
    end

  let increment_population h =
    h.population <- h.population + 1;
    if h.population > 2 * Array.length h.data then resize h

  let add h k x =
    let i = index h k in
    h.data.(i) <- More (k, x, h.data.(i));
    increment_population h

  let rec remove_aux h k b =
    match b with
    | Void ->
        Void
    | More (k', x', b') ->
        if K.equal k' k
        then begin
          h.population <- h.population - 1;
          b'
        end
        else
          let b'' = remove_aux h k b' in
          if b'' == b' then
          (* Avoid allocating when the new cell would be identical to the old
             one (which means the key was not found). Thus, we avoid not only
             allocating new cells, but also promoting them. This should help
             reduce GC activity. *)
            b
          else
            More (k', x', b'')

  let remove h k =
    let i = index h k in
    h.data.(i) <- remove_aux h k h.data.(i)
      (* This write could also be avoided if the new bucket is physically
         equal to the old one. Not sure if that would be worthwhile. *)

  let rec find_aux k = function
    | Void ->
        None
    | More (k', x', b) ->
        if K.equal k' k then Some x' else find_aux k b

  let find h k =
    find_aux k h.data.(index h k)

  let rec find_all_aux k = function
  | Void ->
      []
  | More (k', x', b) ->
      if K.equal k' k
      then x' :: find_all_aux k b
      else find_all_aux k b

  let find_all h k =
    find_all_aux k h.data.(index h k)

  let replace h k x =
    let i = index h k in
    let b = remove_aux h k h.data.(i) in
    h.data.(i) <- More (k, x, b);
    increment_population h

  let mem h k =
    match find h k with None -> false | Some _ -> true

  let rec fold_aux f b accu =
    match b with
    | Void ->
        accu
    | More(k, x, b) ->
        let accu = f k x accu in
        fold_aux f b accu

  (* Perhaps surprisingly, using a [for] loop and a reference seems to
     yield slightly faster code than using a tail-recursive function
     and an accumulator. OCaml 4.03+flambda, -O3. *)

  let fold f h accu =
    let data = h.data in
    let state = ref accu in
    for i = 0 to Array.length data - 1 do
      state := fold_aux f data.(i) !state
    done;
    !state

  (* Perhaps surprisingly, defining [iter] in terms of [fold] is just as fast
     as giving a direct definition of [iter]. OCaml 4.03+flambda, -O3. *)

  let iter f h =
    fold (fun k x () -> f k x) h ()

  let rec to_seq_aux data i b =
    match b with
    | More (k, x, b) ->
        Seq.Cons ((k, x), fun () -> to_seq_aux data i b)
    | Void ->
        let i = i + 1 in
        if i < Array.length data then
          to_seq_aux data i data.(i)
        else
          Seq.Nil

  let to_seq h =
    let data = h.data in
    let b = data.(0) in
    fun () ->
      to_seq_aux data 0 b

  (* The following code is unverified. *)

  (* [histogram f a] produces a histogram of the function [f] over the array
     [t]. That is, it produces a new array [h] such that, for every [y] in the
     range of [f], [h.(y)] is the number of indices [i] such that [f(t.(i))] is
     [y]. The function [f] should be pure; it is invoked twice per index [i]. *)

  let histogram (f : 'a -> int) (t : 'a array) : int array =
    (* Compute the maximum value taken by [f] over the array [t]. *)
    let m : int = Array.fold_left (fun m x -> max m (f x)) 0 t in
    (* Allocate a new array of domain [0..m]. *)
    let h : int array = Array.make (m + 1) 0 in
    (* Compute how many times each value in the image of [f] is taken. *)
    Array.iter (fun x ->
      let y = f x in
      h.(y) <- h.(y) + 1
    ) t;
    (* Done. *)
    h

  type statistics = {
    num_bindings: int;
    num_buckets: int;
    max_bucket_length: int;
    bucket_histogram: int array
  }

  let rec bucket_length accu = function
    | Void -> accu
    | More(_, _, rest) -> bucket_length (accu + 1) rest

  let stats h =
    let num_bindings = h.population in
    let num_buckets = Array.length h.data in
    let bucket_histogram = histogram (bucket_length 0) h.data in
    let max_bucket_length = Array.length bucket_histogram - 1 in
    { num_bindings; num_buckets; max_bucket_length; bucket_histogram }

end

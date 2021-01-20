(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

type 'a buffer = {
  dummy: 'a;
  data: ('a array);
  mutable first: int;
  mutable len: int;
  }

let create : type a. (int) -> a ->  (a buffer) =
  fun n dummy -> { dummy = dummy; data = Array.make n dummy; first = 0; len =
                   0 }

let length : type a. (a buffer) ->  (int) = fun b -> b.len

let clear : type a. (a buffer) ->  unit =
  fun b -> Array.fill b.data 0 (Array.length b.data) b.dummy; b.len <- 0

let push : type a. (a buffer) -> a ->  unit =
  fun b x -> let n = Array.length b.data in
             let i =
               if b.first >= n - b.len
               then b.first + (b.len - n)
               else b.first + b.len in
             (b.data).(i) <- x; b.len <- b.len + 1

let peek : type a. (a buffer) ->  a = fun b -> (b.data).(b.first)

let pop : type a. (a buffer) ->  a =
  fun b -> let r = (b.data).(b.first) in
           b.len <- b.len - 1;
           (b.data).(b.first) <- b.dummy;
           let n = Array.length b.data in
           b.first <- b.first + 1; if b.first = n then b.first <- 0; r

let get : type a. (a buffer) -> (int) ->  a =
  fun b i -> let n = Array.length b.data in
             let i1 =
               if b.first >= n - i then b.first + (i - n) else b.first + i in
             (b.data).(i1)

let copy : type a. (a buffer) ->  (a buffer) =
  fun b -> { dummy = b.dummy; data = Array.copy b.data; first = b.first;
             len = b.len }


(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)


let mjrty (a: ((string) array)) : string =
  let exception QtReturn of (string) in
  try
    let n = Array.length a in
    let cand = ref a.(0) in
    let k = ref 1 in
    (let o = n - 1 in let o1 = 1 in
     for i = o1 to o do
       if !k = 0
       then begin cand := a.(i); k := 1 end
       else begin if !cand = a.(i) then incr k else decr k end
       done);
    if !k = 0 then raise (Not_found);
    if !k > n / 2 then raise (QtReturn !cand);
    k := 0;
    (let o = n - 1 in let o1 = 0 in
     for i1 = o1 to o do
       if a.(i1) = !cand
       then begin incr k; if !k > n / 2 then raise (QtReturn !cand) end
       done);
    raise (Not_found)
  with
  | QtReturn r -> r


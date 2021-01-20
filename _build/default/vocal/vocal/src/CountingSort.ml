(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

let counting_sort (k: int) (a: ((int) array)) (b: ((int) array)) : unit =
  let c = Array.make k 0 in
  (let o = Array.length a - 1 in let o1 = 0 in
   for i = o1 to o do let v = a.(i) in c.(v) <- c.(v) + 1 done);
  let j = ref 0 in
  let o = k - 1 in
  let o1 = 0 in
  for v = o1 to o do
    let o2 = c.(v) in
    let o3 = 1 in
    for _i = o3 to o2 do b.(!j) <- v; j := !j + 1 done
    done

let in_place_counting_sort (k: int) (a: ((int) array)) : unit =
  let c = Array.make k 0 in
  (let o = Array.length a - 1 in let o1 = 0 in
   for i1 = o1 to o do let v1 = a.(i1) in c.(v1) <- c.(v1) + 1 done);
  let j = ref 0 in
  let o = k - 1 in
  let o1 = 0 in
  for v1 = o1 to o do
    let o2 = c.(v1) in
    let o3 = 1 in
    for _i1 = o3 to o2 do a.(!j) <- v1; j := !j + 1 done
    done


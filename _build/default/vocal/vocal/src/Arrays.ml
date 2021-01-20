(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

let rec binary_search :
  type a. (a -> (a -> (int))) -> ((a array)) -> (int) -> (int) -> a ->  (int) =
  fun cmp a fromi toi v -> if fromi >= toi
                           then raise (Not_found)
                           else
                             begin
                               let mid = fromi + (toi - fromi) / 2 in
                               let c = cmp a.(mid) v in
                               if c < 0 
                               then binary_search cmp a (mid + 1 ) toi v
                               else
                                 begin
                                   if c > 0 
                                   then binary_search cmp a fromi mid v
                                   else mid end end

let rec binary_search_left :
  type a. (a -> (a -> (int))) -> ((a array)) -> (int) -> (int) -> a ->  (int) =
  fun cmp a fromi toi v -> if fromi >= toi
                           then toi
                           else
                             begin
                               let mid = fromi + (toi - fromi) / 2 in
                               let c = cmp a.(mid) v in
                               if c < 0 
                               then binary_search_left cmp a (mid + 1 ) toi v
                               else binary_search_left cmp a fromi mid v end

let rec unsafe_binary_search_right :
  type a. (a -> (a -> (int))) -> ((a array)) -> (int) -> (int) -> a ->  (int) =
  fun cmp a fromi toi v -> if fromi >= toi
                           then toi
                           else
                             begin
                               let mid = fromi + (toi - fromi) / 2 in
                               let c = cmp a.(mid) v in
                               if c <= 0 
                               then
                                 unsafe_binary_search_right cmp
                                 a
                                 (mid + 1 )
                                 toi
                                 v
                               else
                                 unsafe_binary_search_right cmp a fromi mid v end

let binary_search_right :
  type a. (a -> (a -> (int))) -> ((a array)) -> (int) -> (int) -> a ->  (int) =
  fun cmp a fromi toi v -> if
                             not (0  <= fromi && fromi <= toi && toi <= Array.length a)
                           then raise (Invalid_argument "binary_search_right");
                           unsafe_binary_search_right cmp a fromi toi v

let binary_sort :
  type a. (a -> (a -> (int))) -> ((a array)) -> (int) -> (int) ->  unit =
  fun cmp a fromi toi -> if fromi < toi - 1
                         then begin
                           let o = toi - 1 in let o1 = fromi + 1 in
                           for k = o1 to o do
                             let v = a.(k) in
                             let mid =
                               unsafe_binary_search_right cmp a fromi k v in
                             Array.blit a mid a (mid + 1 ) (k - mid);
                             a.(mid) <- v
                             done end

let swap : type a. ((a array)) -> (int) -> (int) ->  unit =
  fun a i j -> let v = a.(i) in a.(i) <- a.(j); a.(j) <- v

let knuth_shuffle : type a. ((a array)) ->  unit =
  fun a -> let i = ref (0 ) in
           while !i < Array.length a do
             let j = Random.int (!i + 1 ) in swap a !i j; incr i
           done


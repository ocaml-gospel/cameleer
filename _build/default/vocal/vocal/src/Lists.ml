(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

(** val map : ('a1 -> 'a2) -> 'a1 list -> 'a2 list **)

let map f l =
  match let rec split chunks l0 = match l0 with
        | [] -> l0 :: chunks
        | _ :: l'' ->
          (match l'' with
           | [] -> l0 :: chunks
           | _ :: l''0 ->
             (match l''0 with
              | [] -> l0 :: chunks
              | _ :: l''1 ->
                (match l''1 with
                 | [] -> l0 :: chunks
                 | _ :: l''2 -> split (l0 :: chunks) l''2)))
        in split [] l with
  | [] -> []
  | first :: rest ->
    let rec map_all_tail_chunks suffix = function
    | [] -> suffix
    | chunk :: chunks0 ->
      map_all_tail_chunks
        (match chunk with
         | [] -> []
         | x :: chunk0 ->
           (f x) :: (match chunk0 with
                     | [] -> []
                     | x0 :: chunk1 ->
                       (f x0) :: (match chunk1 with
                                  | [] -> []
                                  | x1 :: chunk2 ->
                                    (f x1) :: (match chunk2 with
                                               | [] -> []
                                               | x2 :: _ -> (f x2) :: suffix))))
        chunks0
    in map_all_tail_chunks
         (match first with
          | [] -> []
          | x :: chunk ->
            (f x) :: (match chunk with
                      | [] -> []
                      | x0 :: chunk0 ->
                        (f x0) :: (match chunk0 with
                                   | [] -> []
                                   | x1 :: chunk1 ->
                                     (f x1) :: (match chunk1 with
                                                | [] -> []
                                                | x2 :: _ -> (f x2) :: []))))
         rest

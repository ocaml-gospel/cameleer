(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

type 'a cell = Nil | Cons of { mutable content: 'a; mutable next: 'a cell; }

let get_content = function
  | Nil -> invalid_arg "get_content"
  | Cons { content; _ } -> content

let set_content l v = match l with
  | Nil -> invalid_arg "set_content"
  | Cons c -> c.content <- v

let get_next = function
  | Nil -> invalid_arg "get_next"
  | Cons { next; _ } -> next

let set_next l1 l2 = match l1 with
  | Nil -> invalid_arg "set_next"
  | Cons c -> c.next <- l2

open Format
let rec pp_l pp_elt fmt = function
  | Nil -> ()
  | Cons { content; next } ->
      fprintf fmt "%a " pp_elt content; pp_l pp_elt fmt next

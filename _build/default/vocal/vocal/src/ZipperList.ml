(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

type 'a t = {
  left: 'a list;
  right: 'a list;
  len: int;
  }

let empty : type a. unit ->  (a t) =
  fun _ -> { left = [] ; right = [] ; len = 0  }

let is_empty : type a. (a t) ->  (bool) =
  fun z -> match (z.left, z.right) with
    | ([], []) -> true
    | _ -> false

let to_list : type a. (a t) ->  (a list) =
  fun z -> List.rev_append z.left z.right

let rec peano_length : type a. (a list) ->  (int) =
  fun l -> match l with
    | [] -> 0 
    | _ :: s -> peano_length s + 1

let make : type a. (a list) ->  (a t) =
  fun l -> { left = [] ; right = l; len = peano_length l }

let length : type a. (a t) ->  (int) = fun z -> z.len

let move_right : type a. (a t) ->  (a t) =
  fun z -> match z.right with
    | [] -> assert false (* absurd *)
    | x :: r -> { left = x :: z.left; right = r; len = z.len }

let insert_right : type a. a -> (a t) ->  (a t) =
  fun x z -> { left = z.left; right = x :: z.right; len = z.len + 1 }

let remove_right : type a. (a t) ->  (a t) =
  fun z -> match z.right with
    | [] -> assert false (* absurd *)
    | _ :: r -> { left = z.left; right = r; len = z.len - 1 }

let move_all_right : type a. (a t) ->  (a t) =
  fun z -> let l = List.rev_append z.right z.left in
           { left = l; right = [] ; len = z.len }

let move_left : type a. (a t) ->  (a t) =
  fun z -> match z.left with
    | [] -> assert false (* absurd *)
    | x :: l -> { left = l; right = x :: z.right; len = z.len }

let insert_left : type a. a -> (a t) ->  (a t) =
  fun x z -> { left = x :: z.left; right = z.right; len = z.len + 1 }

let remove_left : type a. (a t) ->  (a t) =
  fun z -> match z.left with
    | [] -> assert false (* absurd *)
    | _ :: r -> { left = r; right = z.right; len = z.len - 1 }

let move_all_left : type a. (a t) ->  (a t) =
  fun z -> let l = List.rev_append z.left z.right in make l

let is_focused : type a. (a t) ->  (bool) =
  fun z -> match z.right with
    | [] -> false
    | _ :: _ -> true

let focused : type a. (a t) ->  (a option) =
  fun z -> match z.right with
    | [] -> None 
    | x :: _ -> Some x


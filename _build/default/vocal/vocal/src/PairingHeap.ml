(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

module Make(X: sig type t
  val compare : t -> t -> int end) =
struct
  type elt = X.t
  
  type tree =
    | E
    | T of X.t * tree list
  
  type heap = tree
  
  let empty (_: unit) : heap = E
  
  let is_empty (t: heap) : bool = match t with
                                  | E -> true
                                  | T (_, _) -> false
  
  let find_min (t: heap) : X.t =
    match t with
    | E -> assert false (* absurd *)
    | T (x, _) -> x
  
  let merge_heap (h1: tree) (h2: tree) : tree =
    match (h1, h2) with
    | ((E, h) | (h, E)) -> h
    | (T (x1,
      l1),
      T (x2,
      l2)) ->
      if X.compare x1 x2 <= 0  then T (x1, h2 :: l1) else T (x2, h1 :: l2)
  
  let merge (t1: heap) (t2: heap) : heap = merge_heap t1 t2
  
  let insert (x: X.t) (t: heap) : heap = let h_x = T (x, [] ) in merge h_x t
  
  let rec merge_pairs_heap (l: tree list) : tree =
    match l with
    | [] -> E
    | h :: ([]) -> h
    | h1 :: (h2 :: r) -> merge_heap (merge_heap h1 h2) (merge_pairs_heap r)
  
  let delete_min (t: heap) : heap =
    match t with
    | E -> assert false (* absurd *)
    | T (_, l) -> merge_pairs_heap l
end


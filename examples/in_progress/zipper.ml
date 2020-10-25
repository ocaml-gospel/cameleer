(*@ open Sequence *)

(*@ function seq_of_list (l: 'a list): 'a sequence = match l with
      | [] -> empty
      | x :: r -> cons x (seq_of_list r)
    coercion *)

type 'a t = {
  self: 'a list * 'a list;
  seq : 'a sequence [@ghost];
  idx : int         [@ghost];
} (*@ invariant let (l, r) = self in seq == List.rev_append l r *)
  (*@ invariant let (l, _) = self in idx = length l *)

let [@logic] empty : 'a t = { self = [], []; idx = 0; seq = empty }
(*@ r = empty
      ensures r.seq == empty *)

let is_empty (t: 'a t) = match t.self with
  | [], [] -> true
  | _ -> false
(*@ b = is_empty t
      ensures b <-> t.seq == Sequence.empty *)

let to_list (t: 'a t) =
  let l, r = t.self in List.rev_append l r
(*@ r = to_list t
      ensures r == t.seq *)

let to_rev_list (t: 'a t) =
  let l, r = t.self in List.rev_append r l
(* @ r = to_rev_list t
      ensures r = List.rev t.seq *)

let make (l: 'a list) : 'a t =
  { self = [], l; idx = 0; seq = Sequence.empty }
(*@ r = make l
      ensures r.seq == l *)

let left = function
  | x::l, r -> l, x::r
  | [], r -> [], r
(* @ r = left param *)

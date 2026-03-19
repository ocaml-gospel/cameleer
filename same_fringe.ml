type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

(*@ function elements (t: 'a tree) : 'a list = match t with
      | Empty -> []
      | Node l x r -> (elements l) @ (x :: elements r) *)

type elt = int

type enum = (elt * elt tree) list

(*@ function enum_elements (e : enum) : elt list = match e with
      | [] -> []
      | (x, r) :: e -> x :: (elements r @ enum_elements e) *)

let rec mk_zipper (t : elt tree) (e : enum) =
  match t with Empty -> e | Node (l, x, r) -> mk_zipper l ((x, r) :: e)
(*@ r = mk_zipper t e
      variant t
      ensures enum_elements r = elements t @ enum_elements e *)

let rec eq_enum (e1 : enum) (e2 : enum) =
  match (e1, e2) with
  | [], [] -> true
  | (x1, r1) :: e1, (x2, r2) :: e2 ->
      x1 = x2 &&
      let e1 = mk_zipper r1 e1 in
      let e2 = mk_zipper r2 e2 in
      eq_enum e1 e2
  | _ -> false
(*@ b = eq_num e1 e2
      variant List.length (enum_elements e1)
      ensures b <-> enum_elements e1 = enum_elements e2 *)

let same_fringe (t1 : elt tree) (t2 : elt tree) =
  let e1 = mk_zipper t1 [] in
  let e2 = mk_zipper t2 [] in
  eq_enum e1 e2
(*@ b = same_fringe t1 t2
      ensures b <-> elements t1 = elements t2 *)


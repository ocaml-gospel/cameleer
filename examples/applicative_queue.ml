
type 'a t = {
  self : 'a list * 'a list;
  view : 'a list [@ghost]
} (*@ invariant let (prefix, xiffus) = self in
                (prefix=[] -> xiffus=[]) && view = prefix @ List.rev xiffus *)

let empty = { self = [], []; view = [] }
(*@ t = empty
      ensures t.view = [] *)

let [@logic] is_empty (q: 'a t) = match q.self with
  | [], _ -> true
  | _ -> false
(*@ b = is_empty q
      ensures b <-> q.view = [] *)

let add queue elt = match queue.self with
  | [], [] ->
      { self = [elt], []; view = [elt] }
  | prefix, xiffus ->
      { self = prefix, elt :: xiffus; view = queue.view @ [elt] }
(*@ r = add queue elt
      ensures r.view = queue.view @ (elt :: []) *)

let head (param: 'a t) = match param.self with
  | head :: _, _-> head
  | [], _ -> raise Not_found
(*@ x = head param
      raises  Not_found -> is_empty param
      ensures match param.view with [] -> false | y :: _ -> x = y *)

let [@logic] [@ghost] tail_list = function
  | [] -> assert false
  | _ :: l -> l
(*@ r = tail_list param
      requires param <> []
      ensures  match param with [] -> false | _ :: l -> r = l *)

let tail t = match t.self with
  | [_], xiffus ->
      { self = List.rev xiffus, []; view = tail_list t.view }
  | _ :: prefix, xiffus ->
      { self = prefix, xiffus; view = tail_list t.view }
  | [], _ -> raise Not_found
(*@ r = tail t
      raises  Not_found -> is_empty t
      ensures r.view = tail_list t.view *)

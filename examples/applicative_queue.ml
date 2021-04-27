
type 'a t = {
  self : 'a list * 'a list;
  view : 'a list [@ghost];
} (*@ invariant let (prefix, xiffus) = self in
                (prefix=[] -> xiffus=[]) && view = prefix @ List.rev xiffus *)

let empty = { self = [], []; view = [] }
(*@ t = empty
      ensures t.view = [] *)

let [@logic] is_empty {self; _} = match self with
  | [], _ -> true
  | _ -> false
(*@ b = is_empty q
      ensures b <-> q.view = [] *)

let add elt {self; view} = match self with
  | [], [] ->
      { self = [elt], []; view = [elt] }
  | prefix, xiffus ->
      { self = prefix, elt :: xiffus; view = view @ [elt] }
(*@ r = add elt queue
      ensures r.view = queue.view @ (elt :: []) *)

let head {self; _} = match self with
  | head :: _, _-> head
  | [], _ -> raise Not_found
(*@ x = head param
      raises  Not_found -> is_empty param
      ensures match param.view with [] -> false | y :: _ -> x = y *)

let [@ghost] [@logic] tail_list = function
  | [] -> assert false
  | _ :: l -> l
(*@ r = tail_list q
      requires q <> []
      ensures  match q with [] -> false | _ :: l -> r = l *)

let tail {self; view} = match self with
  | [_], xiffus ->
      { self = List.rev xiffus, []; view = tail_list view }
  | _ :: prefix, xiffus ->
      { self = prefix, xiffus; view = tail_list view }
  | [], _ -> raise Not_found
(*@ r = tail t
      raises  Not_found -> is_empty t
      ensures r.view = tail_list t.view *)

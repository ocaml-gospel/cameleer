type 'a t = 'a list * 'a list
  (** a queue is a pair (prefix, xiffus), with elements popped from prefix
      and inserted into xiffus
      invariant: prefix=[] -> xiffus=[] *)

(*@ function view (t: 'a t) : 'a list = match t with
      | (prefix, xiffus) -> prefix @ rev xiffus *)

(*@ predicate invariant_t (t: 'a t) (l: 'a list) = match t with
      | (prefix, xiffus) -> (prefix = [] -> xiffus = []) &&
                            view t = l *)

let [@logic] empty () : 'a t = [], []
(*@ t = empty ()
      ensures invariant_t t [] *)

let is_empty (* (prefix, _) *) = function
  | [], _ -> true
  | _ -> false
(*@ b = is_empty param
      ensures b <-> *)

let add queue elt = match queue with
  | [], [] -> [elt], []
  | prefix, xiffus -> prefix, elt :: xiffus

let head = function
  | head :: _, _-> head
  | [], _ -> raise Not_found
(*@ x = head param
      raises Not_found *)

let tail = function
  | [_], xiffus -> rev xiffus, []
  | _ :: prefix, xiffus -> prefix, xiffus
  | [], _ -> raise Not_found
(*@ t = tail param
      raises Not_found *)

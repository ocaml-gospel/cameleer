type 'a t = 'a list * 'a list
  (** a queue is a pair (prefix, xiffus), with elements popped from prefix
      and inserted into xiffus
      invariant: prefix=[] -> xiffus=[] *)

(*@ function view (t: 'a t) : 'a list = match t with
      | (prefix, xiffus) -> prefix @ rev xiffus *)

(*@ predicate invariant_t (t: 'a t) (l: 'a list) = match t with
      | (prefix, xiffus) -> (prefix = [] -> xiffus = []) && view t = l *)

let empty = [], []
(*@ t = empty
      ensures invariant_t t [] *)

let [@logic] is_empty (q: 'a t) = match q with
  | [], _ -> true
  | _ -> false
(*@ b = is_empty q
      requires exists l. invariant_t q l
      ensures  b <-> invariant_t q []*)

let add queue elt = match queue with
  | [], [] -> [elt], []
  | prefix, xiffus -> prefix, elt :: xiffus
(*@ r = add queue elt
      requires exists l. invariant_t queue l
      ensures  exists l. invariant_t r (l ++ (elt :: []))*)

let head (param: 'a t) = match param with
  | head :: _, _-> head
  | [], _ -> raise Not_found
(*@ x = head param
      requires exists l. invariant_t param l
      raises   Not_found -> is_empty param
      ensures  exists l. invariant_t param (x :: l) *)

let tail = function
  | [_], xiffus -> rev xiffus, []
  | _ :: prefix, xiffus -> prefix, xiffus
  | [], _ -> raise Not_found
(*@ t = tail param
      requires exists l. invariant_t param l
      raises   Not_found -> is_empty param
      ensures  exists l. invariant_t param l &&
                 match l with
                 | [] -> false
                 | _ :: ll -> invariant_t t ll *)

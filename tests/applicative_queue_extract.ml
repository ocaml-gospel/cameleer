type 'a t = ('a list) * ('a list)

let empty : type xi xi1.  ((xi list) * (xi1 list)) = ([] , [] )

let is_empty : type a. (a t) ->  (bool) =
  fun q -> match q with
    | ([], _) -> true
    | _ -> false

let add : type xi2. (xi2 t) -> xi2 ->  (xi2 t) =
  fun queue elt -> match queue with
    | ([], []) -> (elt :: [] , [] )
    | (prefix, xiffus) -> (prefix, elt :: xiffus)

let head : type a. (a t) ->  a =
  fun param -> match param with
    | (head1 :: _, _) -> head1
    | ([], _) -> raise (Not_found)

let tail : type xi3. (xi3 t) ->  (xi3 t) =
  fun t1 -> match t1 with
    | (_ :: ([]), xiffus) -> (List.rev xiffus, [] )
    | (_ :: prefix, xiffus) -> (prefix, xiffus)
    | ([], _) -> raise (Not_found)


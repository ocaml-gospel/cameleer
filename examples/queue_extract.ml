type 'a t = {
  mutable front: 'a list;
  mutable rear: 'a list;
  mutable size: Z.t;
  }

let create : type xi. unit ->  (xi t) =
  fun _ -> { front = [] ; rear = [] ; size = Z.zero }

let push : type xi1. xi1 -> (xi1 t) ->  unit =
  fun x q -> q.rear <- x :: q.rear; q.size <- Z.add q.size Z.one

let is_empty_list : type xi2. (xi2 list) ->  (bool) =
  fun param -> match param with
    | [] -> true
    | _ -> false

let pop : type xi3. (xi3 t) ->  xi3 =
  fun q -> if is_empty_list q.front
           then begin q.front <- rev q.rear; q.rear <- []  end;
           match q.front with
           | [] -> raise (Not_found)
           | x :: f -> q.front <- f; q.size <- Z.sub q.size Z.one; x

let is_empty : type xi4. (xi4 t) ->  (bool) = fun q -> Z.equal q.size Z.zero

let transfer : type xi5. (xi5 t) -> (xi5 t) ->  unit =
  fun q1 q2 -> while not (is_empty q1) do
                 let o = pop q1 in push o q2 done


type 'a t = {
  mutable front: 'a list;
  mutable rear : 'a list;
  mutable size : int;
  mutable view : 'a list [@ghost];
} (*@ invariant size = length view *)
  (*@ invariant (front = [] -> rear = []) && view = front ++ List.rev rear *)

let create () = {
  front = [];
  rear  = [];
  size  = 0;
  view  = [];
} (*@ q = create ()
        ensures q.view = [] *)

let [@logic] is_empty q = q.size = 0
(*@ b = is_empty q
      ensures b <-> q.view = [] *)

let push x q =
  if is_empty q then q.front <- [x] else q.rear <- x :: q.rear;
  q.size <- q.size + 1;
  q.view <- q.view @ [x]
(*@ push x q
      ensures q.view = (old q.view) @ (x :: []) *)

let [@ghost] head_list = function
  | [] -> assert false
  | x :: _ -> x
(*@ r = head_list param
      requires param <> []
      ensures  match param with [] -> false | y :: _ -> r = y *)

let [@ghost] tail_list = function
  | [] -> assert false
  | _ :: l -> l
(*@ r = tail_list param
      requires param <> []
      ensures  match param with [] -> false | _ :: l -> r = l *)

let pop q =
  let x = match q.front with
    | [] -> raise Not_found
    | [x] ->
        q.front <- List.rev q.rear;
        q.rear  <- [];
        x
    | x :: f ->
        q.front <- f;
        x in
  q.view <- tail_list q.view;
  q.size <- q.size - 1;
  x
(*@ x = pop q
      raises  Not_found -> is_empty (old q) (* SUPER IMPORTANT ! *)
      ensures x :: q.view = (old q).view *)

let transfer q1 q2 =
  while not (is_empty q1) do
    (*@ variant   List.length q1.view *)
    (*@ invariant q1.size = List.length q1.view &&
                  q2.size = List.length q2.view *)
    (*@ invariant (q1.front = [] -> q1.rear = []) &&
                  (q2.front = [] -> q2.rear = []) *)
    (*@ invariant q1.view = q1.front @ List.rev q1.rear &&
                  q2.view = q2.front @ List.rev q2.rear *)
    (*@ invariant q2.view @ q1.view = (old q2).view @ (old q1).view *)
    push (pop q1) q2
  done
(*@ transfer q1 q2
      raises   Not_found -> false
      ensures  q1.view = []
      ensures  q2.view = (old q2.view) @ (old q1.view) *)

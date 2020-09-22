type 'a t = {
  mutable front: 'a list;
  mutable rear : 'a list;
  mutable size : int;
  mutable view : 'a list [@ghost]
} (*@ invariant size = length view *)
  (*@ invariant view = front ++ List.rev rear *)

let create () = {
  front = [];
  rear  = [];
  size  = 0;
  view  = [];
}
(*@ q = create ()
      ensures q.view = [] *)

let push x q =
  q.rear <- x :: q.rear;
  q.size <- q.size + 1;
  q.view <- q.view @ (x :: [])
(*@ push x q
      ensures q.size = (old q.size) + 1
      ensures q.view = (old q.view) @ (x :: []) *)

let [@logic] is_empty_list = function
  | [] -> true
  | _ -> false

let [@ghost] head_list = function
  | [] -> assert false
  | x :: _ -> x
(*@ r = head_list param
      requires param <> []
      ensures  match param with [] -> false | y :: _ -> r = y *)

let pop q =
  if is_empty_list q.front then begin
    q.front <- List.rev q.rear;
    q.rear  <- [] end;
  match q.front with
  | [] -> raise Not_found
  | x :: f ->
      q.front <- f;
      q.size  <- q.size - 1;
      q.view  <- (match q.view with [] -> assert false | _ :: ff -> ff);
      x
(*@ x = pop q
      raises  Not_found -> is_empty_list (old q).view (* SUPER IMPORTANT ! *)
      ensures q.size + 1 = (old q).size
      ensures x :: q.view = (old q).view *)

let is_empty q =
  q.size = 0
(*@ b = is_empty q
      ensures b <-> is_empty_list q.view *)

let transfer q1 q2 =
  let [@ghost] todo_view = ref [] in
  while not (is_empty q1) do
    (*@ variant   q1.size *)
    (*@ invariant length q1.view = q1.size /\ length q2.view = q2.size *)
    (*@ invariant q1.view = q1.front @ List.rev q1.rear /\
                  q2.view = q2.front @ List.rev q2.rear *)
    (*@ invariant old q1.view = !todo_view @ q1.view *)
    (*@ invariant q2.view = (old q2.view) @ !todo_view *)
    todo_view := !todo_view @ (head_list q1.view :: []);
    push (pop q1) q2
  done
(*@ transfer q1 q2
      raises  Not_found -> false
      ensures q1.view = []
      ensures q2.view = (old q2.view) @ (old q1.view) *)

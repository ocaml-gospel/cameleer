type 'a t = {
  mutable front: 'a list;
  mutable rear : 'a list;
  mutable size : int;
} (*@ mutable model view: 'a list *)
  (*@ invariant size = length front + length rear *)
  (*@ invariant view = front ++ rev rear *)

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
      ensures q.size = (old q.size) + 1 *)

let [@logic] is_empty_list = function
  | [] -> true
  | _ -> false

let pop q =
  if is_empty_list q.front then begin
    q.front <- rev q.rear;
    q.rear  <- [] end;
  match q.front with
  | [] -> raise Not_found
  | x :: f ->
      q.front <- f;
      q.size  <- q.size - 1;
      q.view  <- (match q.view with [] -> assert false | _ :: ff -> ff);
      x
(*@ x = pop q
      raises  Not_found -> is_empty_list q.view
      ensures q.size + 1 = (old q).size
      ensures x :: q.view = (old q).view *)

let is_empty q =
  q.size = 0
(*@ b = is_empty q
      ensures b <-> q.view = [] *)

let transfer q1 q2 =
  while [@gospel "invariantt true"] not (is_empty q1) do
    push (pop q1) q2
  done
(*@ transfer q1 q2
      raises Not_found -> false *)

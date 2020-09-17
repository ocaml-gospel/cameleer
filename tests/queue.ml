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

let push x q =
  q.rear <- x :: q.rear;
  q.size <- q.size + 1;
  q.view <- q.view @ (x :: [])
(*@ push x q
      ensures q.size = (old q.size) + 1 *)

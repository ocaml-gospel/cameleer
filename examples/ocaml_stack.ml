type 'a t = {
  mutable c : 'a list;
  mutable len : int;
  mutable view : 'a list; [@ghost]
}
(*@ with a invariant List.length a.view = a.len /\ a.c = a.view *)

exception Empty

let create () = { c = []; len = 0; view = [] }
(*@ r = create ()
      ensures r.view = [] *)

let clear s =
  s.c <- [];
  s.len <- 0;
  s.view <- []
(*@ clear s
      ensures s.view = [] *)

let copy s = { c = s.c; len = s.len; view = s.view }
(*@ r = copy s
      ensures r.view = s.view *)

let push x s =
  s.c <- x :: s.c;
  s.len <- s.len + 1;
  s.view <- x :: s.view
(*@ push x s
      ensures s.view = x :: (old s.view) *)

let pop s =
  match s.c with
  | hd :: tl ->
      s.c <- tl;
      s.len <- s.len - 1;
      s.view <- tl;
      hd
  | [] -> raise Empty
(*@ r = pop s
      raises  Empty -> (old s.view) = []
      ensures match (old s.view) with
              | [] -> false
              | hd :: tl -> r = hd && s.view = tl *)

let pop_opt s =
  match s.c with
  | hd :: tl ->
      s.c <- tl;
      s.len <- s.len - 1;
      s.view <- tl;
      Some hd
  | [] -> None

(*@ r = pop_opt s
      ensures match (old s.view) with
              | [] -> r = None
              | hd :: tl -> r = Some hd && s.view = tl *)
let top s = match s.c with hd :: _ -> hd | [] -> raise Empty
(*@ r = top s
      raises  Empty -> s.view = []
      ensures match s.view with [] -> false | hd::_ -> r = hd *)

let top_opt s = match s.c with hd :: _ -> Some hd | [] -> None
(*@ r = top s
      ensures match s.view with [] -> r = None | hd::_ -> r = r = Some hd *)

let is_empty s = match s.c with [] -> true | _ -> false
(*@ b = is_empty s
      ensures b <-> s.view = [] *)

let length s = s.len
(*@ r = length s
      ensures r = List.length s.view *)

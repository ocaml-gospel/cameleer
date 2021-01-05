type expr = Cte of int | Sub of expr * expr | Add of expr * expr

type prog = expr

let [@logic] rec eval_0 = function
  | Cte n -> n
  | Sub (e1, e2) -> eval_0 e1 - eval_0 e2
  | Add (e1, e2) -> eval_0 e1 + eval_0 e2
(*@ eval_0 e
      variant e *)

let [@logic] interpret_0 p = eval_0 p

module Stack = struct
  type opcode = OPush of int | OSub | OAdd

  type program = opcode list
  type stack = int list

  type state = {
    sstack : stack;
    scode  : program;
  }

  type result = Error | Res of stack

  let [@logic] step stack = function
    | OPush x -> Res (x :: stack)
    | OSub -> begin match stack with
      | x :: y :: r -> Res ((x - y) :: r)
      | _ -> Error end
    | OAdd -> match stack with
      | x :: y :: r -> Res ((x + y) :: r)
      | _ -> Error

  let [@logic] rec star (s: stack) = function
    | [] -> Res s
    | o :: r -> match step s o with
      | Res sr -> star sr r
      | Error -> Error

  (* @ lemma star_append: forall p1 p2 s1 s2.
        let s' = star s1 p1 in
        star (s1 @ s2) (p1 @ p2) = star (s' @ s2) p2 *)

  let [@lemma] rec star_append
      (p1: program) (p2: program) (s1: stack) (s2: stack) (s: stack) =
    match p1 with
    | [] -> ()
    | OPush n :: r -> star_append r p2 (n :: s1) s2 s
    | OSub    :: r -> begin match s1 with
        | [] | [_] -> assert false (* to reinforce this cannot happen *)
        | x :: y :: sr -> star_append r p2 ((x - y) :: sr) s2 s end
    | OAdd    :: r ->
        match s1 with
        | [] | [_] -> assert false (* to reinforce this cannot happen *)
        | x :: y :: sr -> star_append r p2 ((x + y) :: sr) s2 s
  (*@ star_append p1 p2 s1 s2 s
        requires Res s = star s1 p1
        variant  p1
        ensures  star (s1 @ s2) (p1 @ p2) = star (s @ s2) p2 *)

  let prog p = star [] p

end

module Compile = struct

  let rec compile = function
    | Cte n -> [Stack.OPush n]
    | Sub (e1, e2) ->
        let a2 = compile e2 in
        let a1 = compile e1 in
        Stack.star_append a2 (a1 @ [OSub]) [] [] [eval_0 e2];
        Stack.star_append a1 [OSub] [] [eval_0 e1] [eval_0 e1];
        a2 @ a1 @ [OSub]
    | Add (e1, e2) -> compile e2 @ compile e1 @ [OAdd]
  (*@ r = compile e
        variant e
        ensures star [] r = Res ((eval_0 e) :: []) *)
end

let rec eval_1 e k =
  match e with
  | Cte n -> k n
  | Sub (e1, e2) ->
      eval_1 e1 (fun v1 -> eval_1 e2 (fun v2 -> k (v1 - v2)))
  | Add (e1, e2) ->
      eval_1 e1 (fun v1 -> eval_1 e2 (fun v2 -> k (v1 + v2)))
(*@ r = eval_1 e k
      variant e
      ensures r = k (eval_0 e) *)

let interpret_1 p =
  eval_1 p (fun n -> n)
(*@ r = interpret_1 p
      ensures r = eval_0 p *)

module Error = struct
  type value = Vnum of int | Underflow

  let [@logic] rec eval_0 = function
    | Cte n -> if n >= 0 then Vnum n else Underflow
    | Sub (e1, e2) -> begin match eval_0 e1 with
      | Underflow -> Underflow
      | Vnum v1 -> begin match eval_0 e2 with
        | Underflow -> Underflow
        | Vnum v2 -> if v1 >= v2 then Vnum (v1 - v2) else Underflow end end
    | Add (e1, e2) -> match eval_0 e1 with
      | Underflow -> Underflow
      | Vnum v1 -> match eval_0 e2 with
        | Underflow -> Underflow
        | Vnum v2 -> if v1 >= v2 then Vnum (v1 - v2) else Underflow

end

module Typing = struct
  type typ = TyInt
end

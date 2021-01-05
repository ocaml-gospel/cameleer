type expr = Cte of int | Sub of expr * expr

type prog = expr

let [@logic] rec eval_0 = function
  | Cte n -> n
  | Sub (e1, e2) -> eval_0 e1 - eval_0 e2
(*@ eval_0 e
      variant e *)

let [@logic] interpret_0 p = eval_0 p

module Stack = struct
  type opcode = OPush of int | OSub

  type program = opcode list
  type stack = int list

  type state = {
    sstack : stack;
    scode  : program;
  }

  exception Error

  (*@ predicate will_typed (stack: stack) (o: opcode) = match o with
        | OSub -> (match stack with [] | _ :: [] -> true | _ -> false)
        | _ -> true *)

  (*@ function step (s: stack) (o: opcode) : stack *)
  (*@ axiom step_push: forall x s. step s (OPush x) = x :: s *)
  (*@ axiom step_sub : forall x y s. step (x :: y :: s) OSub = (x - y) :: s *)

  let step stack = function
    | OPush x -> x :: stack
    | OSub -> match stack with
      | x :: y :: r -> (x - y) :: r
      | _ -> raise Error
  (*@ r = step stack o
        raises  Error -> will_typed stack o
        ensures r = step stack o *)

  (*@ function star (s: stack) (p: program) : stack = match p with
        | [] -> s
        | o :: r -> let sr = step s o in
            star sr r *)

  (* @ lemma star_append: forall p1 p2 s1 s2.
        let s' = star s1 p1 in
        star (s1 @ s2) (p1 @ p2) = star (s' @ s2) p2 *)

  let [@lemma] rec star_append
      (p1: program) (p2: program) (s1: stack) (s2: stack) (s: stack) =
    match p1 with
    | [] -> ()
    | OPush n :: r -> star_append r p2 (n :: s1) s2 s
    | OSub    :: r ->
        match s1 with
        | [] | [_] -> assert false
        | x :: y :: sr -> star_append r p2 ((x - y) :: sr) s2 s
  (*@ star_append p1 p2 s1 s2 s
        requires s = star s1 p1
        variant  p1
        ensures  star (s1 @ s2) (p1 @ p2) = star (s @ s2) p2 *)

  let rec star stack = function
    | [] -> stack
    | o :: r -> let s = step stack o in
        star s r
  (*@ r = star stack p
        variant p
        raises  Error
        ensures r = star stack p *)

  let prog p = star [] p
  (*@ prog p
        raises Error *)

end

module Compile = struct

  let rec compile = function
    | Cte n -> [Stack.OPush n]
    | Sub (e1, e2) -> compile e2 @ compile e1 @ [OSub]
  (*@ r = compile e
        variant e
        ensures star [] r = (eval_0 e) :: [] *)
end

let rec eval_1 e k =
  match e with
  | Cte n -> k n
  | Sub (e1, e2) ->
      eval_1 e1 (fun v1 -> eval_1 e2 (fun v2 -> k (v1 - v2)))
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
    | Sub (e1, e2) -> match eval_0 e1 with
      | Underflow -> Underflow
      | Vnum v1 -> match eval_0 e2 with
        | Underflow -> Underflow
        | Vnum v2 -> if v1 >= v2 then Vnum (v1 - v2) else Underflow

end

module Typing = struct
  type typ = TyInt
end

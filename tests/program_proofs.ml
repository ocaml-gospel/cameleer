module Mult = struct

  let [@logic] rec mult (x: int) (y: int) : int =
    if y = 0 then 0 else x + mult x (y - 1)
  (*@ r = mult x y
        requires y >= 0
        variant  y *)

  let rec mult_commutative (x: int) (y: int) =
    if x = y then ()
    else if x = 0 then mult_commutative x (y-1)
    else if y < x then mult_commutative y x
    else begin
      mult_commutative x (y-1);
      mult_commutative (x-1) (y-1);
      mult_commutative (x-1) y
    end
  (*@ mult_commutative x y
        requires x >= 0
        requires y >= 0
        variant  (x, y)
        ensures  mult x y = mult y x *)

end

module Mirror = struct

  type 'a tree = Empty | Node of 'a tree * 'a * 'a tree

  let[@logic] rec mirror (t: 'a tree) : 'a tree =
    match t with
    | Empty -> Empty
    | Node (l, x, r) -> Node (mirror r, x, mirror l)

  let[@lemma] rec mirror_involutive (t: 'a tree) =
    match t with
    | Empty -> () | Node (l, _, r) -> mirror_involutive l; mirror_involutive r
  (*@ mirror_involutive t
        variant t
        ensures mirror (mirror t) = t *)

  [@@@gospel {|function size (t: 'a tree) : integer =
        match t with
        | Empty -> 0
        | Node l _ r -> 1 + size l + size r |} ]

  let[@lemma] rec mirror_size (t: 'a tree) =
    match t with
    | Empty -> ()
    | Node (l, _, r) -> mirror_size l; mirror_size r
  (*@ mirror_size t
        variant t
        ensures size (mirror t) = size t *)

end

module AST = struct

  type op = Add | Mul

  type expr =
    | Const of int
    | Var of string
    | Node of op * (expr list)

  type env = string -> int option

  let[@logic] unit (op: op) : int =
    match op with
    | Add -> 0
    | Mul -> 1

  let [@logic] rec eval (e: expr) (env: env) : int =
    match e with
    | Const n -> n
    | Var s -> begin match env s with Some v -> v | None -> 0 end
    | Node (op, args) -> eval_list op args env
  (*@ r = eval e env
        variant e *)

  and [@logic] eval_list (op: op) (args: expr list) (env: env) : int =
    match args with
    | [] -> unit op
    | e :: l ->
        let v0 = eval e env in
        let v1 = eval_list op l env in
        match op with
        | Add -> v0 + v1
        | Mul -> v0 * v1
  (*@ r = eval_list op args env
        variant args *)

  let[@logic] shorten (op: op) (args: expr list) : expr =
    match args with
    | [] -> Const (unit op)
    | [e] -> e
    | _ -> Node (op, args)
  (*@ r = shorten op args
        ensures forall env. eval r env = eval (Node op args) env *)

  let[@logic] rec optimize (e: expr) : expr =
    match e with
    | Const _ | Var _ -> e
    | Node (op, args) -> shorten op (optimize_and_filter args (unit op))
  (*@ r = optimize e
        variant e
        ensures forall env. eval r env = eval e env *)

  and[@logic] optimize_and_filter (args: expr list) (u: int) : expr list
  = match args with
    | [] -> []
    | e :: l ->
        let e = optimize e in
        let l = optimize_and_filter l u in
        match e with Const n -> if n = u then l else e :: l | _ -> e :: l
  (*@ r = optimize_and_filter args u
        variant args
        ensures forall op env. u = unit op ->
                eval (Node op r) env = eval (Node op args) env *)

end

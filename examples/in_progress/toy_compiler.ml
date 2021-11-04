type expr =
  | Ecte of int
  | Eplus of expr * expr
  | Eminus of expr * expr
  | Emult of expr * expr

(*@ function eval_expr (e: expr) : integer =
      match e with
      | Ecte   n     -> n
      | Eplus  e1 e2 -> eval_expr e1 + eval_expr e2
      | Eminus e1 e2 -> eval_expr e1 - eval_expr e2
      | Emult  e1 e2 -> eval_expr e1 * eval_expr e2 *)

type asm = Apush of int | Aadd | Asub | Amul

(*@ function compute (s: int list) (a: asm list) : integer list =
    match a with
    | [] -> s
    | a :: r ->
      match a, s with
      | Apush n, _              -> compute (n :: s) r
      | Aadd, (n1 :: (n2 :: s)) -> compute ((n2+n1) :: s) r
      | Asub, (n1 :: (n2 :: s)) -> compute ((n2-n1) :: s) r
      | Amul, (n1 :: (n2 :: s)) -> compute ((n2*n1) :: s) r
      | _ -> s *)

let rec compile = function
  | Ecte n -> [ Apush n ]
  | Eplus (e1, e2) -> compile e1 @ compile e2 @ [ Aadd ]
  | Eminus (e1, e2) -> compile e1 @ compile e2 @ [ Asub ]
  | Emult (e1, e2) -> compile e1 @ compile e2 @ [ Amul ]
(*@ r = compile param
      variant param
      ensures let r_eval = eval_expr param in
              compute (r_eval :: []) [] = compute [] r*)

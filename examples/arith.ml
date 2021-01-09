type expr =
  | ECte of int
  | EVar of int
  | ESub of expr * expr
  | EAdd of expr * expr
  | EMul of expr * expr
  | EIf  of ebool * expr * expr
and ebool =
  | EAnd of ebool * ebool
  | ETrue
  | EFalse

type prog = expr

type store = int -> int

let [@logic] rec eval_b (st: store) = function
  | ETrue -> true
  | EFalse -> false
  | EAnd (b1, b2) -> eval_b st b1 && eval_b st b2

let [@logic] rec eval_0 store = function
  | ECte n -> n
  | EVar x -> store x
  | ESub (e1, e2) -> eval_0 store e1 - eval_0 store e2
  | EAdd (e1, e2) -> eval_0 store e1 + eval_0 store e2
  | EMul (e1, e2) -> eval_0 store e1 * eval_0 store e2
  | EIf (b, e1, e2) ->
      if eval_b store b then eval_0 store e1 else eval_0 store e2
(*@ eval_0 store e
      variant e *)

let interpret_0 p = eval_0 p

type opcode =
  | OTrue
  | OFalse
  | OPush   of int
  | OFetch  of int
  | OBranch of code * code
  | OSub
  | OAdd
  | OMul
  | OAnd
and code = opcode list

type value = VInt of int | VBool of bool

type stack = value list

type state = stack * code * store

type res = Error | Res of state

let [@logic] [@ghost] rec star (s: stack) (c: code) (st: store) : res =
  match c with
  | []            -> Res (s, [], st)
  | OTrue    :: r -> star (VBool true  :: s) r st
  | OFalse   :: r -> star (VBool false :: s) r st
  | OPush n  :: r -> star (VInt n :: s) r st
  | OFetch x :: r -> star (VInt (st x) :: s) r st
  | OSub     :: r -> (match s with
      | VInt x :: VInt y :: sr -> star (VInt (x - y) :: sr) r st
      | _ -> Error)
  | OAdd     :: r -> (match s with
      | VInt x :: VInt y :: sr -> star (VInt (x + y) :: sr) r st
      | _ -> Error)
  | OMul     :: r -> (match s with
      | VInt x :: VInt y :: sr -> star (VInt (x * y) :: sr) r st
      | _ -> Error)
  | OAnd      :: r -> (match s with
      | VBool x :: VBool y :: sr -> star (VBool (x && y) :: sr) r st
      | _ -> Error)
  | OBranch (p1, p2) :: r -> (match s with
      | VBool b :: sr ->
          if b then star sr (p1 @ r) st else star sr (p2 @ r) st
      | _ -> Error)
(*@ star s c st
      variant List.length c *)

(** small hint lemmas *)
let [@ghost] star_nil (n: int) (st: store) =
  ()
(*@ star_nil n st
      ensures star (VInt n :: []) [] st = Res (VInt n :: [], [], st) *)

let [@ghost] star_nil_bool (b: bool) (st: store) =
  ()
(*@ star_nil_bool b st
      ensures star (VBool b :: []) [] st = Res (VBool b :: [], [], st) *)

let [@ghost] star_sub (c1: code) (c2: code) (st: store) (x1: int) (x2: int) =
  ()
(*@ star_sub c1 c2 st x1 x2
      requires star [] (c1 @ (c2 @ (OSub :: []))) st
             = star (VInt x1 :: []) (c2 @ (OSub :: [])) st
      requires star (VInt x1 :: []) (c2 @ (OSub :: [])) st
             = star (VInt x2 :: (VInt x1 :: [])) (OSub :: []) st
      ensures  star [] (c1 @ (c2 @ (OSub :: []))) st
             = star (VInt (x2 - x1) :: []) [] st  *)

let [@ghost] star_add (c1: code) (c2: code) (st: store) (x1: int) (x2: int) =
  ()
(*@ star_add c1 c2 st x1 x2
      requires star [] (c1 @ (c2 @ (OAdd :: []))) st
             = star (VInt x1 :: []) (c2 @ (OAdd :: [])) st
      requires star (VInt x1 :: []) (c2 @ (OAdd :: [])) st
             = star (VInt x2 :: (VInt x1 :: [])) (OAdd :: []) st
      ensures  star [] (c1 @ (c2 @ (OAdd :: []))) st
             = star (VInt (x2 + x1) :: []) [] st  *)

let [@ghost] star_mul (c1: code) (c2: code) (st: store) (x1: int) (x2: int) =
  ()
(*@ star_add c1 c2 st x1 x2
      requires star [] (c1 @ (c2 @ (OMul :: []))) st
             = star (VInt x1 :: []) (c2 @ (OMul :: [])) st
      requires star (VInt x1 :: []) (c2 @ (OMul :: [])) st
             = star (VInt x2 :: (VInt x1 :: [])) (OMul :: []) st
      ensures  star [] (c1 @ (c2 @ (OMul :: []))) st
             = star (VInt (x2 * x1) :: []) [] st  *)

let [@ghost] star_and (c1: code) (c2: code) (st: store) (x1: bool) (x2: bool) =
  ()
(*@ star_sub c1 c2 st x1 x2
      requires star [] (c1 @ (c2 @ (OAnd :: []))) st
             = star (VBool x1 :: []) (c2 @ (OAnd :: [])) st
      requires star (VBool x1 :: []) (c2 @ (OAnd :: [])) st
             = star (VBool x2 :: (VBool x1 :: [])) (OAnd :: []) st
      ensures  star [] (c1 @ (c2 @ (OAnd :: []))) st
             = star (VBool (x2 && x1) :: []) [] st  *)

let [@lemma] rec star_append (store: store)
    (p1: code) (p2: code) (s1: stack) (s2: stack) (s: state) =
  match p1 with
  | [] -> ()
  | OTrue    :: r -> star_append store r p2 (VBool true  :: s1) s2 s
  | OFalse   :: r -> star_append store r p2 (VBool false :: s1) s2 s
  | OPush  n :: r -> star_append store r p2 (VInt n :: s1) s2 s
  | OFetch x :: r -> star_append store r p2 (VInt (store x) :: s1) s2 s
  | OSub     :: r -> begin match s1 with
      | VInt x :: VInt y :: sr ->
          star_append store r p2 (VInt (x - y) :: sr) s2 s
      | _ -> assert false (* to reinforce this cannot happen *) end
  | OAdd     :: r -> begin match s1 with
      | VInt x :: VInt y :: sr ->
          star_append store r p2 (VInt (x + y) :: sr) s2 s
      | _ -> assert false (* to reinforce this cannot happen *) end
  | OMul     :: r -> begin match s1 with
      | VInt x :: VInt y :: sr ->
          star_append store r p2 (VInt (x * y) :: sr) s2 s
      | _ -> assert false (* to reinforce this cannot happen *) end
  | OAnd     :: r -> begin match s1 with
      | VBool x :: VBool y :: sr ->
          star_append store r p2 (VBool (x && y) :: sr) s2 s
      | _ -> assert false end
  | OBranch (c1, c2) :: r -> begin match s1 with
      | VBool b :: sr ->
          if b then star_append store (c1 @ r) p2 sr s2 s
          else star_append store (c2 @ r) p2 sr s2 s
      | _ -> assert false end
(*@ star_append store p1 p2 s1 s2 res
      requires Res res = star s1 p1 store
      requires let _, _, st = res in st = store
      variant  p1
      ensures  let stack, code, store = res in
               star (s1    @ s2) (p1   @ p2) store
             = star (stack @ s2) (code @ p2) store *)

let rec compile_bool (st: store) = function
  | ETrue  -> [OTrue]
  | EFalse -> [OFalse]
  | EAnd (b1, b2) ->
      let a1 = compile_bool st b1 in
      let a2 = compile_bool st b2 in
      star_append st a2 (a1 @ [OAnd]) [] [] ([VBool (eval_b st b2)], [], st);
      star_append st a1 [OAnd] [] [VBool (eval_b st b2)]
        ([VBool (eval_b st b1)], [], st);
      (* assert (star ([VBool (eval_b st b1 && eval_b st b2)]) [] st
       *        = Res ([VBool (eval_b st b1 && eval_b st b2)], [], st));
       * assert (star [] (a2 @ (a1 @ ([OAnd]))) st
       *       = star ([VBool (eval_b st b1 && eval_b st b2)]) [] st); *)
      star_nil_bool (eval_b st b1 && eval_b st b2) st;
      star_and a2 a1 st (eval_b st b2) (eval_b st b1);
      a2 @ a1 @ [OAnd]
(*@ r = compile_bool st b
      variant b
      ensures match star [] r st with
              | Error -> false
              | Res (stack, code, store) ->
                  stack = (VBool (eval_b st b)) :: [] && code = [] &&
                  st = store *)

let rec compile (st [@ghost]) = function
  | ECte n -> [OPush n]
  | EVar n -> [OFetch n]
  | ESub (e1, e2) ->
      let a2 = compile st e2 in
      let a1 = compile st e1 in
      star_append st a2 (a1 @ [OSub]) [] []
        ([VInt (eval_0 st e2)], [], st);
      star_append st a1 [OSub] [] [VInt (eval_0 st e2)]
        ([VInt (eval_0 st e1)], [], st);
      assert (star ([VInt (eval_0 st e1 - eval_0 st e2)]) [] st
             = Res ([VInt (eval_0 st e1 - eval_0 st e2)], [], st));
      assert (star [] (a2 @ (a1 @ ([OSub]))) st
            = star ([VInt (eval_0 st e1 - eval_0 st e2)]) [] st);
      a2 @ a1 @ [OSub]
  | EAdd (e1, e2) ->
      let a2 = compile st e2 in
      let a1 = compile st e1 in
      star_append st a2 (a1 @ [OAdd]) [] []
        ([VInt (eval_0 st e2)], [], st);
      star_append st a1 [OAdd] [] [VInt (eval_0 st e2)]
        ([VInt (eval_0 st e1)], [], st);
      star_nil (eval_0 st e1 + eval_0 st e2) st;
      star_add a2 a1 st (eval_0 st e2) (eval_0 st e1);
      a2 @ a1 @ [OAdd]
  | EMul (e1, e2) ->
      let a2 = compile st e2 in
      let a1 = compile st e1 in
      star_append st a2 (a1 @ [OMul]) [] []
        ([VInt (eval_0 st e2)], [], st);
      star_append st a1 [OMul] [] [VInt (eval_0 st e2)]
        ([VInt (eval_0 st e1)], [], st);
      star_nil (eval_0 st e1 * eval_0 st e2) st;
      star_mul a2 a1 st (eval_0 st e2) (eval_0 st e1);
      a2 @ a1 @ [OMul]
  | EIf (b, e1, e2) ->
      let ba = compile_bool st b in
      let a1 = compile st e1 in
      let a2 = compile st e2 in
      star_append st ba [OBranch (a1, a2)] [] []
        ([VBool (eval_b st b)], [], st);
      ba @ [OBranch (a1, a2)]
(*@ r = compile store e
      variant e
      ensures match star [] r store with
              | Error -> false
              | Res (stack, code, st) ->
                  stack = (VInt (eval_0 store e) :: []) /\ code = [] /\
                  st = store *)

module type EqType = sig
  type t

  val eq : t -> t -> bool
end

module Make (E : EqType) = struct
  type ident = E.t

  type aexpr =
    | ECte of int
    | EVar of ident
    | ESub of aexpr * aexpr
    | EAdd of aexpr * aexpr
    | EMul of aexpr * aexpr

  and ebool =
    | ETrue
    | EFalse
    | EAnd of ebool * ebool
    | EEq of aexpr * aexpr
    | ELeq of aexpr * aexpr
    | ENeg of ebool

  type stmt =
    | SSkip
    (* | SAssign of ident * aexpr *)
    | SSeq of stmt * stmt
    | SIf of ebool * stmt * stmt
  (* | SWhile of ebool * stmt *)

  type prog = aexpr
  type store = ident -> int

  let[@logic] update s x v y = if E.eq x y then v else s x

  let[@logic] rec eval_b (st : store) = function
    | ETrue -> true
    | EFalse -> false
    | EAnd (b1, b2) -> eval_b st b1 && eval_b st b2
    | ENeg b -> not (eval_b st b)
    | EEq (a1, a2) -> eval_0 st a1 = eval_0 st a2
    | ELeq (a1, a2) -> eval_0 st a1 <= eval_0 st a2

  (*@ eval_b st b
        variant b *)
  and[@logic] eval_0 store = function
    | ECte n -> n
    | EVar x -> store x
    | ESub (e1, e2) -> eval_0 store e1 - eval_0 store e2
    | EAdd (e1, e2) -> eval_0 store e1 + eval_0 store e2
    | EMul (e1, e2) -> eval_0 store e1 * eval_0 store e2
  (*@ eval_0 store e
        variant e *)

  let interpret_0 p = eval_0 p

  type sem_result = RVal of store | ROutOfFuel

  let[@logic] rec stmt_eval c s stmt =
    if c = 0 then ROutOfFuel
    else
      match stmt with
      | SSkip -> RVal s
      (* | SAssign (x, a) ->
       *     let v = eval_0 s a in
       *     let s' = update s x v in
       *     RVal s' *)
      | SSeq (s1, s2) -> (
          match stmt_eval c s s1 with
          | ROutOfFuel -> ROutOfFuel
          | RVal _ -> stmt_eval c s s2 (* FIXME: give good store *))
      | SIf (b, s1, s2) ->
          if eval_b s b then stmt_eval c s s1 else stmt_eval c s s2
  (* | SWhile (b, stmt) -> (
   *     if not (bexp_eval s b) then RVal s
   *     else
   *       match stmt_eval c s stmt with
   *       | ROutOfFuel -> ROutOfFuel
   *       | RVal s' -> stmt_eval (c - 1) s' (SWhile (b, stmt))) *)
  (*@ stmt_eval c s stmt
        requires c >= 0
        variant  c, stmt *)

  let[@lemma] rec stmt_semantics_more_fuel (c1 : int) (c2 : int) (st : store)
      (stmt : stmt) =
    match stmt with
    | SSkip -> ()
    | SSeq (s1, s2) ->
        stmt_semantics_more_fuel c1 c2 st s1;
        stmt_semantics_more_fuel c1 c2 st s2
    | SIf (b, s1, s2) ->
        if eval_b st b then stmt_semantics_more_fuel c1 c2 st s1
        else stmt_semantics_more_fuel c1 c2 st s2
  (*@ variant  stmt
      requires 0 <= c2 <= c1
      ensures  forall st'. stmt_eval c2 st stmt = RVal st' ->
                           stmt_eval c1 st stmt = RVal st' *)

  type stmt_sem = Terminates | Diverges

  (*@ function stmt_semantics (stmt: stmt) (st: store) : stmt_sem =
        if exists c s. c > 0 /\ stmt_eval c st stmt = RVal s then Terminates
        else Diverges *)

  (** Hint lemmas *)
  (*@ lemma stmt_eval_skip : forall c s.
        c >= 1 -> stmt_eval c s SSkip = RVal s *)

  (*@ lemma stmt_semantics_skip : forall st.
        stmt_semantics SSkip st = Terminates *)

  (*@ lemma stmt_semantics_if : forall st stmt1 stmt2 b.
        stmt_semantics stmt1 st = Terminates ->
        stmt_semantics stmt2 st = Terminates ->
        stmt_semantics (SIf b stmt1 stmt2) st = Terminates *)

  (*@ lemma stmt_semantics_seq : forall st stmt1 stmt2.
      stmt_semantics stmt1 st = Terminates ->
      stmt_semantics stmt2 st = Terminates ->
      stmt_semantics (SSeq stmt1 stmt2) st = Terminates *)

  type opcode =
    | ONoop
    | OTrue
    | OFalse
    | OPush of int
    | OFetch of ident
    | OBranch of code * code
    | OSub
    | OAdd
    | OMul
    | OAnd
    | ONeg
    | OEq
    | OLeq

  and code = opcode list

  type value = VInt of int | VBool of bool
  type stack = value list
  type state = stack * code * store
  type res = Error | Res of state

  let[@ghost] [@logic] rec opcode_size = function
    | ONoop | OTrue | OFalse | OPush _ | OFetch _ | OSub | OAdd | OMul | OAnd
    | ONeg | OEq | OLeq ->
        1
    | OBranch (c1, c2) -> 1 + code_size c1 + code_size c2

  and[@ghost] [@logic] code_size = function
    | [] -> 0
    | o :: r -> opcode_size o + code_size r

  let[@lemma] rec opcode_size_nonneg = function
    | OTrue | OFalse | OPush _ | OFetch _ | OSub | OAdd | OMul | OAnd | ONeg
    | OEq | OLeq | ONoop ->
        ()
    | OBranch (c1, c2) ->
        code_size_nonneg c1;
        code_size_nonneg c2

  (*@ opcode_size_nonneg o
        ensures opcode_size o >= 0 *)
  and[@lemma] code_size_nonneg = function
    | [] -> ()
    | o :: r ->
        opcode_size_nonneg o;
        code_size_nonneg r
  (*@ code_size_nonneg p
        ensures code_size p >= 0 *)

  let[@lemma] rec code_size_append (c1 : code) (c2 : code) =
    match c1 with [] -> () | _ :: r -> code_size_append r c2
  (*@ code_size_append c1 c2
        ensures code_size (c1 @ c2) = code_size c1 + code_size c2 *)

  (* Big-step semantics for the stack language *)
  let[@ghost] [@logic] rec star (s : stack) (c : code) (st : store) : res =
    match c with
    | [] -> Res (s, [], st)
    | ONoop :: r -> star s r st
    | OTrue :: r -> star (VBool true :: s) r st
    | OFalse :: r -> star (VBool false :: s) r st
    | OPush n :: r -> star (VInt n :: s) r st
    | OFetch x :: r -> star (VInt (st x) :: s) r st
    | OSub :: r -> (
        match s with
        | VInt x :: VInt y :: sr -> star (VInt (x - y) :: sr) r st
        | _ -> Error)
    | OAdd :: r -> (
        match s with
        | VInt x :: VInt y :: sr -> star (VInt (x + y) :: sr) r st
        | _ -> Error)
    | OMul :: r -> (
        match s with
        | VInt x :: VInt y :: sr -> star (VInt (x * y) :: sr) r st
        | _ -> Error)
    | OAnd :: r -> (
        match s with
        | VBool x :: VBool y :: sr -> star (VBool (x && y) :: sr) r st
        | _ -> Error)
    | OEq :: r -> (
        match s with
        | VInt x :: VInt y :: sr -> star (VBool (x = y) :: sr) r st
        | _ -> Error)
    | OLeq :: r -> (
        match s with
        | VInt x :: VInt y :: sr -> star (VBool (x <= y) :: sr) r st
        | _ -> Error)
    | ONeg :: r -> (
        match s with
        | VBool x :: sr -> star (VBool (not x) :: sr) r st
        | _ -> Error)
    | OBranch (p1, p2) :: r -> (
        match s with
        | VBool b :: sr ->
            let c = if b then p1 else p2 in
            star sr (c @ r) st
        | _ -> Error)
  (*@ star s c st
        variant code_size c *)

  (* @ lemma star_app_error : forall c1 s c2 st.
        star s c1 st = Error -> star s (c1 @ c2) st = Error *)

  (*@ lemma star_determ : forall c s st.
        star s c st = Error \/ (exists s' c' st'. star s c st = Res (s', c', st')) *)

  (** small hint lemmas *)
  let[@ghost] star_nil (n : int) (st : store) = ()
  (*@ star_nil n st
        ensures star (VInt n :: []) [] st = Res (VInt n :: [], [], st) *)

  let[@ghost] star_nil_bool (b : bool) (st : store) = ()
  (*@ star_nil_bool b st
        ensures star (VBool b :: []) [] st = Res (VBool b :: [], [], st) *)

  let[@ghost] star_mul (c1 : code) (c2 : code) (st : store) (x1 : int)
      (x2 : int) =
    ()
  (*@ star_mul c1 c2 st x1 x2
        requires star [] (c1 @ (c2 @ (OMul :: []))) st
               = star (VInt x1 :: []) (c2 @ (OMul :: [])) st
        requires star (VInt x1 :: []) (c2 @ (OMul :: [])) st
               = star (VInt x2 :: (VInt x1 :: [])) (OMul :: []) st
        ensures  star [] (c1 @ (c2 @ (OMul :: []))) st
               = star (VInt (x2 * x1) :: []) [] st *)

  let[@lemma] rec star_append (store : store) (p1 : code) (p2 : code)
      (s1 : stack) (s2 : stack) (s : state) =
    match p1 with
    | [] -> ()
    | ONoop :: r -> star_append store r p2 s1 s2 s
    | OTrue :: r -> star_append store r p2 (VBool true :: s1) s2 s
    | OFalse :: r -> star_append store r p2 (VBool false :: s1) s2 s
    | OPush n :: r -> star_append store r p2 (VInt n :: s1) s2 s
    | OFetch x :: r -> star_append store r p2 (VInt (store x) :: s1) s2 s
    | OSub :: r -> (
        match s1 with
        | VInt x :: VInt y :: sr ->
            star_append store r p2 (VInt (x - y) :: sr) s2 s
        | _ -> assert false)
    | OAdd :: r -> (
        match s1 with
        | VInt x :: VInt y :: sr ->
            star_append store r p2 (VInt (x + y) :: sr) s2 s
        | _ -> assert false)
    | OMul :: r -> (
        match s1 with
        | VInt x :: VInt y :: sr ->
            star_append store r p2 (VInt (x * y) :: sr) s2 s
        | _ -> assert false)
    | OAnd :: r -> (
        match s1 with
        | VBool x :: VBool y :: sr ->
            star_append store r p2 (VBool (x && y) :: sr) s2 s
        | _ -> assert false)
    | OEq :: r -> (
        match s1 with
        | VInt x :: VInt y :: sr ->
            star_append store r p2 (VBool (x = y) :: sr) s2 s
        | _ -> assert false)
    | OLeq :: r -> (
        match s1 with
        | VInt x :: VInt y :: sr ->
            star_append store r p2 (VBool (x <= y) :: sr) s2 s
        | _ -> assert false)
    | ONeg :: r -> (
        match s1 with
        | VBool x :: sr -> star_append store r p2 (VBool (not x) :: sr) s2 s
        | _ -> assert false)
    | OBranch (c1, c2) :: r -> (
        match s1 with
        | VBool b :: sr ->
            if b then star_append store (c1 @ r) p2 sr s2 s
            else star_append store (c2 @ r) p2 sr s2 s
        | _ -> assert false)
  (*@ star_append store p1 p2 s1 s2 res
        requires Res res = star s1 p1 store
        requires let _, _, st = res in st = store
        variant  code_size p1
        ensures  let stack, code, store = res in
                 star (s1    @ s2) (p1   @ p2) store
               = star (stack @ s2) (code @ p2) store *)

  let rec compile_bool ((st : store) [@ghost]) = function
    | ETrue -> [ OTrue ]
    | EFalse -> [ OFalse ]
    | EAnd (b1, b2) ->
        let a1 = compile_bool st b1 in
        let a2 = compile_bool st b2 in
        star_append st a2 (a1 @ [ OAnd ]) [] []
          ([ VBool (eval_b st b2) ], [], st);
        star_append st a1 [ OAnd ] []
          [ VBool (eval_b st b2) ]
          ([ VBool (eval_b st b1) ], [], st);
        star_nil_bool (eval_b st b1 && eval_b st b2) st;
        a2 @ a1 @ [ OAnd ]
    | EEq (e1, e2) ->
        let a1 = compile st e1 in
        let a2 = compile st e2 in
        star_append st a2 (a1 @ [ OEq ]) [] [] ([ VInt (eval_0 st e2) ], [], st);
        star_append st a1 [ OEq ] []
          [ VInt (eval_0 st e2) ]
          ([ VInt (eval_0 st e1) ], [], st);
        star_nil_bool (eval_0 st e1 = eval_0 st e2) st;
        a2 @ a1 @ [ OEq ]
    | ELeq (e1, e2) ->
        let a1 = compile st e1 in
        let a2 = compile st e2 in
        star_append st a2 (a1 @ [ OLeq ]) [] [] ([ VInt (eval_0 st e2) ], [], st);
        star_append st a1 [ OLeq ] []
          [ VInt (eval_0 st e2) ]
          ([ VInt (eval_0 st e1) ], [], st);
        star_nil_bool (eval_0 st e1 <= eval_0 st e2) st;
        a2 @ a1 @ [ OLeq ]
    | ENeg b ->
        let a = compile_bool st b in
        star_append st a [ ONeg ] [] [] ([ VBool (eval_b st b) ], [], st);
        star_nil_bool (not (eval_b st b)) st;
        a @ [ ONeg ]

  (*@ r = compile_bool st b
        variant b
        ensures match star [] r st with
                | Error -> false
                | Res s ->
                    let (stack, code, st') = s  in
                    stack = (VBool (eval_b st b)) :: [] && code = [] &&
                    st = store *)
  and compile ((st : store) [@ghost]) = function
    | ECte n -> [ OPush n ]
    | EVar n -> [ OFetch n ]
    | ESub (e1, e2) ->
        let a2 = compile st e2 in
        let a1 = compile st e1 in
        star_append st a2 (a1 @ [ OSub ]) [] [] ([ VInt (eval_0 st e2) ], [], st);
        star_append st a1 [ OSub ] []
          [ VInt (eval_0 st e2) ]
          ([ VInt (eval_0 st e1) ], [], st);
        star_nil (eval_0 st e1 - eval_0 st e2) st;
        a2 @ a1 @ [ OSub ]
    | EAdd (e1, e2) ->
        let a2 = compile st e2 in
        let a1 = compile st e1 in
        star_append st a2 (a1 @ [ OAdd ]) [] [] ([ VInt (eval_0 st e2) ], [], st);
        star_append st a1 [ OAdd ] []
          [ VInt (eval_0 st e2) ]
          ([ VInt (eval_0 st e1) ], [], st);
        star_nil (eval_0 st e1 + eval_0 st e2) st;
        a2 @ a1 @ [ OAdd ]
    | EMul (e1, e2) ->
        let a2 = compile st e2 in
        let a1 = compile st e1 in
        star_append st a2 (a1 @ [ OMul ]) [] [] ([ VInt (eval_0 st e2) ], [], st);
        star_append st a1 [ OMul ] []
          [ VInt (eval_0 st e2) ]
          ([ VInt (eval_0 st e1) ], [], st);
        star_nil (eval_0 st e1 * eval_0 st e2) st;
        star_mul a2 a1 st (eval_0 st e2) (eval_0 st e1);
        a2 @ a1 @ [ OMul ]
  (*@ r = compile store e
        variant e
        ensures match star [] r store with
                | Error -> false
                | Res s ->
                    let (stack, code, st') = s  in
                    stack = (VInt (eval_0 store e) :: []) /\ code = [] &&
                    st = store *)

  let rec compile_stmt ((st : store) [@ghost]) = function
    | SSkip -> [ ONoop ]
    | SIf (b, stmt1, stmt2) ->
        let ba = compile_bool st b in
        let a1 = compile_stmt st stmt1 in
        let a2 = compile_stmt st stmt2 in
        star_append st ba
          [ OBranch (a1, a2) ]
          [] []
          ([ VBool (eval_b st b) ], [], st);
        ba @ [ OBranch (a1, a2) ]
    | SSeq (stmt1, stmt2) ->
        let a1 = compile_stmt st stmt1 in
        let a2 = compile_stmt st stmt2 in
        star_append st a1 a2 [] [] ([], [], st);
        a1 @ a2
  (*@ r = compile_stmt st stmt
        variant stmt
        ensures match star [] r st with
                | Error -> false
                | Res s ->
                    let (stack, code, st') = s  in
                    st' = st &&
                    stack = [] && code = [] &&
                    stmt_semantics stmt st = Terminates *)
end

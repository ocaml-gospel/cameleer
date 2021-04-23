type ident = string

type literal =
  | FVar   of ident
  | FConst of bool

type formula =
  | L     of literal
  | FAnd  of formula * formula
  | FOr   of formula * formula
  | FImpl of formula * formula
  | FNeg  of formula

type formula_wi =
  | L_wi    of literal
  | FAnd_wi of formula_wi * formula_wi
  | FOr_wi  of formula_wi * formula_wi
  | FNeg_wi of formula_wi

type formula_nnf =
  | FAnd_nnf of formula_nnf * formula_nnf
  | FOr_nnf  of formula_nnf * formula_nnf
  | FNeg_nnf of literal
  | L_nnf    of literal

type disj =
  | FOr_cnf  of disj * disj
  | FNeg_cnf of literal
  | L_cnf    of literal

type formula_cnf =
  | FAnd_cnf of formula_cnf * formula_cnf
  | D        of disj

type valuation = ident -> bool

let [@logic] eval_literal (v: valuation) (f: literal) : bool
  = match f with
  | FVar x   -> v x
  | FConst b -> b

let [@logic] rec eval (v: valuation) (f: formula) : bool
  = match f with
  | L     phi1     -> eval_literal v phi1
  | FAnd  (f1, f2) -> eval v f1 && eval v f2
  | FOr   (f1, f2) -> eval v f1 || eval v f2
  | FImpl (f1, f2) -> not (eval v f1) || eval v f2
  | FNeg  f        -> not (eval v f)
(*@ r = eval v f
      variant f *)

let [@logic] rec eval_wi (v: valuation) (f: formula_wi) : bool
  = match f with
  | L_wi    phi1     -> eval_literal v phi1
  | FAnd_wi (f1, f2) -> eval_wi v f1 && eval_wi v f2
  | FOr_wi  (f1, f2) -> eval_wi v f1 || eval_wi v f2
  | FNeg_wi f        -> not (eval_wi v f)
(*@ r = eval_wi v f
      variant f *)

let [@logic] rec eval_nnf (v: valuation) (f: formula_nnf) : bool
  = match f with
  | FAnd_nnf (f1, f2) -> eval_nnf v f1 && eval_nnf v f2
  | FOr_nnf  (f1, f2) -> eval_nnf v f1 || eval_nnf v f2
  | FNeg_nnf literal  -> not (eval_literal v literal)
  | L_nnf    literal  -> eval_literal v literal
(*@ r = eval_nnf v f
      variant f *)

let [@logic] rec eval_disj (v: valuation) (f: disj) : bool
  = match f with
  | FOr_cnf  (f1, f2) -> eval_disj v f1 || eval_disj v f2
  | FNeg_cnf literal  -> not (eval_literal v literal)
  | L_cnf    literal  -> eval_literal v literal
(*@ r = eval_disj v f
      variant f *)

let [@logic] rec eval_cnf (v: valuation) (f: formula_cnf) : bool
  = match f with
  | FAnd_cnf (f1, f2) -> eval_cnf v f1 && eval_cnf v f2
  | D        disj     -> eval_disj v disj
(*@ r = eval_cnf v f
      variant f *)

(*@ function size (phi: formula_wi) : integer
    = match phi with
      | L_wi _ -> 1
      | FNeg_wi phi -> 1 + size phi
      | FAnd_wi phi1 phi2 | FOr_wi phi1 phi2 -> 1 + size phi1 + size phi2 *)

(*@ function size_disj (phi: disj) : integer
    = match phi with
      | FOr_cnf phi1 phi2 -> 1 + size_disj phi1 + size_disj phi2
      | FNeg_cnf _ -> 2
      | L_cnf _ -> 1 *)

(*@ function size_cnf (phi: formula_cnf) : integer
    = match phi with
      | FAnd_cnf phi1 phi2 -> 1 + size_cnf phi1 + size_cnf phi2
      | D phi1 -> size_disj phi1 *)

let [@lemma] rec size_nonneg (phi: formula_wi)
  = match phi with
  | L_wi _      -> ()
  | FNeg_wi phi -> size_nonneg phi
  | FAnd_wi (phi1, phi2) | FOr_wi (phi1, phi2) ->
      size_nonneg phi1; size_nonneg phi2
(*@ size_nonneg phi
      variant phi
      ensures size phi >= 0 *)

let [@lemma] rec size_nonneg_disj (phi: disj)
  = match phi with
  | FNeg_cnf _ | L_cnf _ -> ()
  | FOr_cnf (phi1, phi2) -> size_nonneg_disj phi1; size_nonneg_disj phi2
(*@ size_nonneg_disj phi
      variant phi
      ensures size_disj phi >= 0 *)

let [@lemma] rec size_nonneg_cnf (phi: formula_cnf)
  = match phi with
  | FAnd_cnf (phi1, phi2) -> size_nonneg_cnf phi1; size_nonneg_cnf phi2
  | D phi1                -> size_nonneg_disj phi1
(*@ size_nonneg_cnf phi
      variant phi
      ensures size_cnf phi >= 0 *)

let [@logic] rec impl_free (phi: formula) : formula_wi
  = match phi with
  | FNeg   phi1        -> FNeg_wi (impl_free phi1)
  | FOr   (phi1, phi2) -> FOr_wi (impl_free phi1, impl_free phi2)
  | FAnd  (phi1, phi2) -> FAnd_wi (impl_free phi1, impl_free phi2)
  | FImpl (phi1, phi2) -> FOr_wi (FNeg_wi (impl_free phi1), impl_free phi2)
  | L  phi             -> L_wi phi
(*@ r = impl_free phi
      variant phi
      ensures forall v. eval v phi = eval_wi v r *)

let [@logic] rec nnfc (phi: formula_wi)
  = match phi with
  | FNeg_wi (FNeg_wi phi1) ->
      nnfc phi1
  | FNeg_wi (FAnd_wi (phi1, phi2)) ->
      FOr_nnf (nnfc (FNeg_wi phi1), nnfc (FNeg_wi phi2))
  | FNeg_wi (FOr_wi (phi1, phi2)) ->
      FAnd_nnf (nnfc (FNeg_wi phi1), nnfc (FNeg_wi phi2))
  | FNeg_wi (L_wi phi1) ->
      FNeg_nnf (phi1)
  | FOr_wi (phi1, phi2) ->
      FOr_nnf (nnfc phi1, nnfc phi2)
  | FAnd_wi (phi1, phi2) ->
      FAnd_nnf (nnfc phi1, nnfc phi2)
  | L_wi phi1 ->
      L_nnf phi1
(*@ r = nnfc phi
      variant size phi
      ensures forall v. eval_wi v phi = eval_nnf v r *)

let [@logic] rec distr (phi1: formula_cnf) (phi2: formula_cnf)
  = match phi1, phi2 with
  | FAnd_cnf (phi11, phi12), phi2 ->
      FAnd_cnf (distr phi11 phi2, distr phi12 phi2)
  | phi1, FAnd_cnf (phi21, phi22) ->
      FAnd_cnf (distr phi1 phi21, distr phi1 phi22)
  | D phi1, D phi2 ->
      D (FOr_cnf (phi1, phi2))
(*@ r = distr phi1 phi2
      variant size_cnf phi1 + size_cnf phi2
      ensures forall v. (eval_cnf v phi1 || eval_cnf v phi2) = eval_cnf v r *)

let [@logic] rec cnfc (phi: formula_nnf)
  = match phi with
  | FOr_nnf  (phi1, phi2) -> distr (cnfc phi1) (cnfc phi2)
  | FAnd_nnf (phi1, phi2) -> FAnd_cnf (cnfc phi1, cnfc phi2)
  | FNeg_nnf literal      -> D (FNeg_cnf literal)
  | L_nnf    literal      -> D (L_cnf literal)
(*@ r = cnf phi
      variant phi
      ensures forall v. eval_nnf v phi = eval_cnf v r *)

let t (phi: formula) : formula_cnf
  = cnfc (nnfc (impl_free phi))
(*@ r = t phi
      ensures forall v. eval v phi = eval_cnf v r *)

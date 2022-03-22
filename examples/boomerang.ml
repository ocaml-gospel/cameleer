type 'a const = 'a

type ocaml_int = int

type nat = Nat of ocaml_int const
type tz = Tz of int const

module Option = struct
  type 'a t = 'a option

  let value o a = match o with
    | Some a -> a
    | None -> a

  let [@logic] get x = match x with
    | Some a -> a
    | None -> invalid_arg "Option.get"
  (*@   requires  match x with
                  | Some _ -> true
                  | None -> false
        raises    Invalid_argument _ -> false *)
end

type address = Address of string const
module Address = struct
  type t = address
end

type rep =
  | RepInt
  | RepUnit
  | RepPair of rep * rep

let rec any_rep (n:int) =
  if n < 0 then
    RepInt
  else if Random.bool () then
    RepUnit
  else
    RepPair(any_rep (n-1), any_rep (n-1))
  (*@ variant  n *)

type param =
  | ParamInt of int
  | ParamUnit
  | ParamPair of param * param

let rec typecheck r p =
  match r, p with
  | RepInt, ParamInt _
  | RepUnit, ParamUnit -> true
  | RepPair(t1,t2), ParamPair(p1,p2) ->
    typecheck t1 p1 && typecheck t2 p2
  | RepInt, ParamUnit
  | RepInt, ParamPair (_, _)
  | RepUnit, ParamInt _
  | RepUnit, ParamPair (_, _)
  | RepPair (_, _), ParamInt _
  | RepPair (_, _), ParamUnit -> false
  (*@ variant  r *)

type contract = Contract of address * rep

(*
type 'a contract =
  | Of_address : address -> 'a contract
*)

type operation = Transfer_tokens of param * tz * contract

let of_address (addr : address) (p : param) : contract option =
  let r = any_rep (Random.int ()) in
  if typecheck r p then
    Some (Contract (addr, r))
  else
    None

(*
type operation =
  | Transfer_tokens : unit * tz * unit contract -> operation
*)

type operations = operation list

module Contract = struct
  type t = contract
  let [@logic] contract (addr : address) (p : param) : t option =
    of_address addr p
  (* always succeeds *)
end

module Operation = struct
  type 'a t = operation
  let [@logic] transfer_tokens a tz c =
    Transfer_tokens (a, tz, c)
end

module Env = struct
  type t =
    { env_amount : tz
    ; env_source : address
    }

  let env = (None : t option)
  let get env = Option.get env
  (*@   requires  match env with
                  | Some _ -> true
                  | None -> false
        raises    Invalid_argument _ -> false *)

  let amount env = env.env_amount
  let source env = env.env_source
end

module Global = struct
  let [@logic] get_amount env = (Env.get env).Env.env_amount
  (*@   requires  match env with
                  | Some _ -> true
                  | None -> false
        raises    Invalid_argument _ -> false *)
  let [@logic] get_source env = (Env.get env).Env.env_source
  (*@   requires  match env with
                  | Some _ -> true
                  | None -> false
        raises    Invalid_argument _ -> false *)
end

let [@logic] eq_tz tz1 tz2 =
    match (tz1,tz2) with Tz n1, Tz n2 -> n1 = n2

let [@entry] main env (param : unit) (storage : unit) =
  let amount = Global.get_amount env in
  let ops =
    if eq_tz amount (Tz 0) then []
    else
(*
      let source_contract = Option.get (Contract.contract (Global.get_source env)) in
      [ Operation.transfer_tokens () amount source_contract ]
  in
  ops, ()
*)
      let source = Global.get_source env in
      let source_contract_option = Contract.contract source ParamUnit in
      let op =
        match source_contract_option with
        | Some source_contract -> Operation.transfer_tokens ParamUnit amount source_contract
        | None -> assert false
      in [ op ]
    in
    ops, ()
(*@ ops, stg = main env param storage
      requires  match env with
                | Some _ -> true
                | None -> false
      requires  match (Contract.contract (Global.get_source env) ParamUnit) with
                | Some _ -> true
                | None -> false
      ensures   if eq_tz (Global.get_amount env) (Tz 0) then ops = [] else ops = match Contract.contract (Global.get_source env) ParamUnit with
        | Some source_contract -> (Operation.transfer_tokens ParamUnit (Global.get_amount env) source_contract) :: []
        | None -> []
      raises    Invalid_argument _ -> false *)

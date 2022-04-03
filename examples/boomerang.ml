
let [@entry] main env (param : unit) (storage : unit) =
  let amount = Global.get_amount env in
  let ops =
    if eq_tz amount (Tz 0) then []
    else
      let source = Global.get_source env in
      let source_contract = Option.get (Contract.contract source ParamUnit) in
      [ Operation.transfer_tokens ParamUnit amount source_contract ]
    in
    ops, ()
(*@ ops, stg = main env param storage
      requires  match env with None -> false | Some _ -> true
      requires  match (Contract.contract (Global.get_source env) ParamUnit) with None -> false | Some _ -> true
      ensures   ops =
                  if eq_tz (Global.get_amount env) (Tz 0) then []
                  else let sc = Option.get (Contract.contract (Global.get_source env) ParamUnit) in (Operation.transfer_tokens ParamUnit (Global.get_amount env) sc) :: []
      raises    Invalid_argument _ -> false *)

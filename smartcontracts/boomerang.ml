
let [@entry] main env (param : unit) (storage : unit) =
  let amount = Global.get_amount env in
  let ops =
    if amount == (Tz 0) then []
    else
      let source = Global.get_source env in
      let source_contract = Option.get (Contract.contract source ParamUnit) in
      [ Operation.transfer_tokens ParamUnit amount source_contract ]
    in
    ops, ()
(*@ ops, stg = main env param storage
      requires  match env with None -> false | Some _ -> true
      ensures   let f = fun env ->
                  match (Contract.contract (Global.get_source env) ParamUnit) with None -> false | Some _ -> true
                in f env ->
                if (Global.get_amount env) == (Tz 0) then ops = []
                else
                  let sco = Contract.contract (Global.get_source env) ParamUnit in
                  match sco with
                  | Some sc -> ops = (Operation.transfer_tokens ParamUnit (Global.get_amount env) sc) :: []
                  | None -> false
      raises    Invalid_argument _ -> match (Contract.contract (Global.get_source env) ParamUnit) with None -> true | Some _ -> false *)

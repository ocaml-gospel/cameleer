
let [@entry] main env (param : unit) (storage : unit) =
  let amount = Global.get_amount env in
  let ops =
    if Tz.eq amount (Tz 0) then []
    else
      let source_contract = Option.get (Contract.contract (Global.get_source env) ParamUnit) in
      [ Operation.transfer_tokens ParamUnit amount source_contract ]
    in
    ops, ()
(*@ ops, stg = main env param storage
      requires  match env with None -> false | Some _ -> true
      ensures   if Tz.eq (Global.get_amount env) (Tz 0) then ops = []
                else
                  match Contract.contract (Global.get_source env) ParamUnit with
                  | Some sc -> ops = (Operation.transfer_tokens ParamUnit (Global.get_amount env) sc) :: []
                  | None -> true
      raises Invalid_argument _ -> 
        match (Contract.contract (Global.get_source env) ParamUnit) with None -> true | Some _ -> false *)
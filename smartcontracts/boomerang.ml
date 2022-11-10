
let main env () () =
  let amount = Global.get_amount env in
  let ops =
    if Tz.eq amount (Tz 0) then []
    else
      let source_contract = Option.get (Contract.contract RepUnit (Global.get_source env)) in
      [ Operation.transfer_tokens (ParamUnit ()) amount source_contract ]
    in
    ops, ()
(*@ ops, stg = main env param storage
      ensures   if Tz.eq (Global.get_amount env) (Tz 0) then ops = []
                else
                  match Contract.contract RepUnit (Global.get_source env) with
                  | Some sc -> ops = Operation.transfer_tokens (ParamUnit ()) (Global.get_amount env) sc :: []
                  | None -> true
                && stg = ()
      raises Invalid_argument _ ->
        match (Contract.contract RepUnit (Global.get_source env)) with None -> true | Some _ -> false *)


type parameter =
  | Left of tz
  | Right of tz

let [@entry] main env parameter storage =
  let ops =
    match parameter with
    | Left _ -> []
    | Right amount ->
      let sender = Global.get_sender env in
      if (eq_addr sender storage) then
        let source_contract = Option.get (Contract.contract sender ParamUnit) in
        [ Operation.transfer_tokens ParamUnit amount source_contract ]
      else failwith ()
  in
  ops, storage
(*@ ops, stg = main env param storage
      requires  match env with None -> false | Some _ -> true
      requires  match (Contract.contract (Global.get_sender env) ParamUnit) with None -> false | Some _ -> true
      requires  match param with Left _ -> true | Right _ -> eq_addr (Global.get_sender env) storage
      ensures   match param with
                | Left _ ->  ops = []
                | Right amount ->
                  let sc = Option.get (Contract.contract (Global.get_sender env) ParamUnit) in ops = (Operation.transfer_tokens ParamUnit amount sc) :: []
      raises    Invalid_argument _ -> false
      raises    Fail -> false *)

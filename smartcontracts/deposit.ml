
type parameter =
  | Left of tz
  | Right of tz

let [@entry] main env parameter storage =
  let ops =
    match parameter with
    | Left _ -> []
    | Right amount ->
      let sender = Global.get_sender env in
      if sender == storage then
        let source_contract = Option.get (Contract.contract sender ParamUnit) in
        [ Operation.transfer_tokens ParamUnit amount source_contract ]
      else failwith ()
  in
  ops, storage
(*@ ops, stg = main env param storage
      requires  match env with None -> false | Some _ -> true
      ensures   let f = fun param env storage ->
                  match param with
                  | Left _ -> true
                  | Right _ -> (Global.get_sender env) == storage
                in
                let g = fun env ->
                  match (Contract.contract (Global.get_sender env) ParamUnit) with
                  | None -> false
                  | Some _ -> true
                in
                f param env storage && g env ->
                match param with
                | Left _ ->  ops = []
                | Right amount ->
                  let sco = Contract.contract (Global.get_sender env) ParamUnit in
                  match sco with Some sc -> ops = (Operation.transfer_tokens ParamUnit amount sc) :: [] | None -> false
      raises    Invalid_argument _ -> match (Contract.contract (Global.get_sender env) ParamUnit) with None -> true | Some _ -> false
      raises    Fail -> match param with Left _ -> false | Right _ -> (Global.get_sender env) != storage *)

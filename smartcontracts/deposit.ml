
type parameter =
  | Left of tz
  | Right of tz

let [@entry] main env parameter storage =
  let ops =
    match parameter with
    | Left _ -> []
    | Right amount ->
      let sender = Global.get_sender env in
      if Address.eq sender storage then
        let source_contract = Option.get (Contract.contract RepUnit sender) in
        [ Operation.transfer_tokens (ParamUnit ()) amount source_contract ]
      else failwith ()
  in
  ops, storage

(*@ ops, stg = main env param storage
      ensures
          let sco = Contract.contract RepUnit (Global.get_sender env) in
          match param, sco with
          | Left _, _ ->  ops = []
          | Right amount, Some sc ->
              Address.eq (Global.get_sender env) storage -> ops = (Operation.transfer_tokens (ParamUnit ()) amount sc) :: []
          | Right _, None -> false
      raises
          Invalid_argument _ ->
            match (Contract.contract RepUnit (Global.get_sender env)) with
            | None -> true
            | Some _ -> false
      raises
          Fail ->
            match param with
            | Left _ -> false
            | Right _ -> not (Address.eq (Global.get_sender env) storage) *)

open SCaml

type parameter =
  | Left of tz
  | Right of tz

let [@entry] main parameter storage =
  let sender = Global.get_sender () in
  let ops =
    match parameter with
    | Left _ -> []
    | Right amount ->
      if (storage = sender) then
        let source_contract = Option.get @@ Contract.contract @@ storage in
        [ Operation.transfer_tokens () amount source_contract ]
      else failwith ()
  in
  ops, storage
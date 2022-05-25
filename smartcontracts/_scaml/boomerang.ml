open SCaml

let [@entry] main () () =
  let amount = Global.get_amount () in
  let ops =
    if amount = Tz 0. then []
    else
      let source_contract = Option.get @@ Contract.contract @@ Global.get_source () in
      [ Operation.transfer_tokens () amount source_contract ]
  in
  ops, ()
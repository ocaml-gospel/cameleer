
let main x =
  let t = Contract.contract (Address " ") ParamUnit in
  let o = Operation.transfer_tokens ParamUnit (Tz 100) (Option.get t) in
  Option.get x
(*@ n = main x
    requires match x with None -> false | Some _ -> true
    requires match Contract.contract (Address " ") ParamUnit with None -> false | Some _ -> true
    raises Invalid_argument _ -> false *)

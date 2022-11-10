let main () () =
  let ctr = Contract.self RepUnit in
  Operation.transfer_tokens (ParamUnit ()) (Tz 0) ctr :: [], ()
(*@ ops, stg = main p s
    ensures
      ops = Operation.transfer_tokens (ParamUnit ()) (Tz 0) (Contract.self RepUnit) :: []
        && stg = () *)

let main () =
  let a =
    Contract.address
      (Contract.self
        (RepPair [
          RepPair [
            RepNat;
            RepOr [
              RepPair [
                RepMutez;
                RepContract
              ];
              RepOr [
                RepOption RepKeyHash;
                RepPair [
                  RepNat;
                  RepList RepKey
                ]
              ]
            ]
          ];
          RepList (RepOption RepSignature)
        ]))
  in ()

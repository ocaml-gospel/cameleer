
type storage =
  { stored_counter : nat
  ; threshold : nat
  ; keys : key list
  }

type parameter =
  { payload : payload
  ; sigs : signature option list
  }

and payload =
  { counter : nat
  ; action : action
  }

and action =
  | Transfer of transfer
  | Delegate of key_hash option
  | Change_keys of change_keys

and transfer =
  { amount : tz
  ; dest : contract
  }

and change_keys =
  { threshold' : nat
  ; keys' : key list
  }

  let[@entry] main parameter storage =
  (* pair the payload with the current contract address, to ensure signatures
     can't be replayed accross different contracts if a key is reused. *)
  let signature_target =
    Obj.pack
      ( parameter.payload,
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
            ]) : contract)
        (* This is always KT1BEqzn5Wx8uJrZNvuS9DVHmLvG9td3fDLi in the test *),
        Chain_id "NetXdQprcVkpaWU" )
  in
  (* Check that the counters *)
  myassert (Nat.eq storage.stored_counter parameter.payload.counter) ;
  (* Compute the number of valid signatures *)
  let nsigs =
    Loop.left
      (fun (nsigs, keys, sigs) ->
        match keys, sigs with
        | [], [] -> Right nsigs
        | key :: keys, None :: sigs -> Left (nsigs, keys, sigs)
        | _ ->
            (* There were fewer signatures in the list
               than keys. Not all signatures must be present, but
               they should be marked as absent using the option type.
            *)
            raise Fail)
      (Nat 0, storage.keys, parameter.sigs)
  in ()
  (*(* Assert that the threshold is less than or equal to the
     number of valid signatures.
  *)
  assert (storage.threshold <= nsigs) ;

  (* Increment counter and place in storage *)
  (* XXX temp state is stored as a tuple.  Inefficient *)
  let storage =
    {storage with stored_counter = storage.stored_counter +^ Nat 1}
  in

  (* We have now handled the signature verification part,
     produce the operation requested by the signers.
  *)
  match parameter.payload.action with
  | Transfer {amount; dest} ->
      (* Transfer tokens *)
      ( [Operation.transfer_tokens () amount (Contract.implicit_account dest)],
        storage )
  | Delegate key_hash_opt ->
      (* Change delegate *)
      [Operation.set_delegate key_hash_opt], storage
  | Change_keys {threshold; keys} ->
      (* Change set of signatures *)
      [], {storage with threshold; keys}*)

(*let parameter =
  { payload= { counter= Nat 42
             ; action= Transfer { amount= Tz 1.0
                                ; dest= Contract.implicit_account (Key_hash "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx")
                                }
             }

  ; sigs= [ Some (Signature "edsigtteMcYkviZ3rTaM6N7DWvgsyoTmEHGo91Q63qNJNYXFhTwWzmytanUj8G44aEZ8QDJt3myyxjuVwvRMikSJauZ96AvshWJ"); None ]
  }

let storage =
  { stored_counter= Nat 42
  ; threshold= Nat 1
  ; keys= [ Key "edpkuBknW28nW72KG6RoHtYW7p12T6GKc7nAbwYX5m8Wd9sDVC9yav" (* bootstrap1 *)
          ; Key "edpktzNbDAUjUk697W7gYg2CRuBQjyPxbEg8dLccYYwKSKvkPvjtV9" (* bootstrap2 *)
          ]
  }

let [@entry] test () () =
  let ops, _ = main parameter storage in
  ops, ()*)

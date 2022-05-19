
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
  { threshold : nat
  ; keys : key list
  }

(*let main parameter storage =

  let signature_target =
    Obj.pack ( parameter.payload
             , Contract.address Contract.self
             , (match (Obj.unpack (Obj.pack (Chain_id "NetXdQprcVkpaWU")) : SCaml.chain_id option) with None -> failwith "failed" | Some x -> x)
             )

  assert (storage.stored_counter = parameter.payload.counter);

  let nsigs = Loop.left (fun (nsigs, keys, sigs) ->
      match keys, sigs with
      | [], [] -> Right nsigs
      | key::keys, Some sig_::sigs ->
          assert (Crypto.check_signature key sig_ signature_target);
          Left (nsigs +^ Nat 1, keys, sigs)
      | key::keys, None::sigs ->
          Left (nsigs, keys, sigs)
      | _ ->
          assert false
    )
      (Nat 0, storage.keys, parameter.sigs)
  in

  assert (storage.threshold <= nsigs);

  let storage = { storage with stored_counter = storage.stored_counter +^ Nat 1 } in

  match parameter.payload.action with
  | Transfer { amount ; dest } ->
      [ Operation.transfer_tokens () amount dest ], storage
  | Delegate key_hash_opt ->
      [ Operation.set_delegate key_hash_opt], storage
  | Change_keys { threshold ; keys } ->
      [], { storage with threshold; keys }
;;

let parameter =
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

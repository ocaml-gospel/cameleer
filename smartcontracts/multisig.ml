[@@@SCaml iml_optimization=true]
open SCaml

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
  ; dest : unit contract
  }

and change_keys =
  { threshold : nat
  ; keys : key list
  }

let main parameter storage =

  (* pair the payload with the current contract address, to ensure signatures
     can't be replayed accross different contracts if a key is reused. *)
  let signature_target =
    Obj.pack ( parameter.payload
             , Contract.address Contract.self
             , (match (Obj.unpack (Obj.pack (Chain_id "NetXdQprcVkpaWU")) : SCaml.chain_id option) with None -> failwith "failed" | Some x -> x)
               (* Global.get_chain_id () varies in different networks *)
             )
  in
  (* Check that the counters *)
  assert (storage.stored_counter = parameter.payload.counter);
  (* Compute the number of valid signatures
  *)
  let nsigs = Loop.left (fun (nsigs, keys, sigs) ->
      match keys, sigs with
      | [], [] -> Right nsigs
      | key::keys, Some sig_::sigs ->
          (* Checks signatures, fails if invalid *)
          assert (Crypto.check_signature key sig_ signature_target);
          Left (nsigs +^ Nat 1, keys, sigs)
      | key::keys, None::sigs ->
          Left (nsigs, keys, sigs)
      | _ ->
          (* There were fewer signatures in the list
             than keys. Not all signatures must be present, but
             they should be marked as absent using the option type.
          *)
          assert false
    )
      (Nat 0, storage.keys, parameter.sigs)
  in
  (* Assert that the threshold is less than or equal to the
     number of valid signatures.
  *)
  assert (storage.threshold <= nsigs);

  (* Increment counter and place in storage *)
  (* XXX temp state is stored as a tuple.  Inefficient *)
  let storage = { storage with stored_counter = storage.stored_counter +^ Nat 1 } in

  (* We have now handled the signature verification part,
     produce the operation requested by the signers.
  *)
  match parameter.payload.action with
  | Transfer { amount ; dest } ->
      (* Transfer tokens *)
      [ Operation.transfer_tokens () amount dest ], storage
  | Delegate key_hash_opt ->
      (* Change delegate *)
      [ Operation.set_delegate key_hash_opt], storage
  | Change_keys { threshold ; keys } ->
      (* Change set of signatures *)
      [], { storage with threshold; keys }
;;

(*
parameter (pair
             (pair :payload
                (nat %counter) # counter, used to prevent replay attacks
                (or :action    # payload to sign, represents the requested action
                   (pair :transfer    # transfer tokens
                      (mutez %amount) # amount to transfer
                      (contract %dest unit)) # destination to transfer to
                   (or
                      (option %delegate key_hash) # change the delegate to this address
                      (pair %change_keys          # change the keys controlling the multisig
                         (nat %threshold)         # new threshold
                         (list %keys key)))))     # new list of keys
             (list %sigs (option signature)));    # signatures

storage (pair (nat %stored_counter) (pair (nat %threshold) (list %keys key))) ;

code
  {
    UNPAIR ; SWAP ; DUP ; DIP { SWAP } ;
    DIP
      {
        UNPAIR ;
        # pair the payload with the current contract address, to ensure signatures
        # can't be replayed accross different contracts if a key is reused.
        DUP ; SELF ; ADDRESS ; CHAIN_ID ; PAIR ; PAIR ;
        PACK ; # form the binary payload that we expect to be signed
        DIP { UNPAIR @counter ; DIP { SWAP } } ; SWAP
      } ;

    # Check that the counters match
    UNPAIR @stored_counter; DIP { SWAP };
    ASSERT_CMPEQ ;

    # Compute the number of valid signatures
    DIP { SWAP } ; UNPAIR @threshold @keys;
    DIP
      {
        # Running count of valid signatures
        PUSH @valid nat 0; SWAP ;
        ITER
          {
            DIP { SWAP } ; SWAP ;
            IF_CONS
              {
                IF_SOME
                  { SWAP ;
                    DIP
                      {
                        SWAP ; DIIP { DIP { DUP } ; SWAP } ;
                        # Checks signatures, fails if invalid
                        CHECK_SIGNATURE ; ASSERT ;
                        PUSH nat 1 ; ADD @valid } }
                  { SWAP ; DROP }
              }
              {
                # There were fewer signatures in the list
                # than keys. Not all signatures must be present, but
                # they should be marked as absent using the option type.
                FAIL
              } ;
            SWAP
          }
      } ;
    # Assert that the threshold is less than or equal to the
    # number of valid signatures.
    ASSERT_CMPLE ;
    DROP ; DROP ;

    # Increment counter and place in storage
    DIP { UNPAIR ; PUSH nat 1 ; ADD @new_counter ; PAIR} ;

    # We have now handled the signature verification part,
    # produce the operation requested by the signers.
    NIL operation ; SWAP ;
    IF_LEFT
      { # Transfer tokens
        UNPAIR ; UNIT ; TRANSFER_TOKENS ; CONS }
      { IF_LEFT {
                  # Change delegate
                  SET_DELEGATE ; CONS }
                {
                  # Change set of signatures
                  DIP { SWAP ; CAR } ; SWAP ; PAIR ; SWAP }} ;
    PAIR }
*)

let parameter =
  { payload= { counter= Nat 42
             ; action= Transfer { amount= Tz 1.0
                                ; dest= Contract.implicit_account (Key_hash "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx")
                                }
             }
  (* signature is obtained by

     tezos-client sign bytes 0x0507070707002a050507070080897a0a00000016000002298c03ed7d454a101eb7022bc95f7e5f41ac7807070a00000016011d23c1d3d2f8a4ea5e8784b8f7ecf2ad304c0fe6000a000000047a06a770 for bootstrap1

     The binary is obtained by app_multisig_target.ml
  *)
  ; sigs= [ Some (Signature "edsigtteMcYkviZ3rTaM6N7DWvgsyoTmEHGo91Q63qNJNYXFhTwWzmytanUj8G44aEZ8QDJt3myyxjuVwvRMikSJauZ96AvshWJ"); None ]
  }

let storage =
  { stored_counter= Nat 42
  ; threshold= Nat 1
    (* keys are obtained from public_keys of sandboxed node *)
  ; keys= [ Key "edpkuBknW28nW72KG6RoHtYW7p12T6GKc7nAbwYX5m8Wd9sDVC9yav" (* bootstrap1 *)
          ; Key "edpktzNbDAUjUk697W7gYg2CRuBQjyPxbEg8dLccYYwKSKvkPvjtV9" (* bootstrap2 *)
          ]
  }

let [@entry] test () () =
  let ops, _ = main parameter storage in
  ops, ()

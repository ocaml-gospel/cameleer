let main () = eq (Address "true") (Address "false")
(*@ b = main ()
    ensures b = false *)

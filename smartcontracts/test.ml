let main () = lt (Timestamp "true") (Timestamp "false")
(*@ b = main ()
    ensures b = false *)

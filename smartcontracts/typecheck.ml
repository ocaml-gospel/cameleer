let main () =
  if typecheck (RepList RepInt) (ParamList [ParamInt 0]) then 0 else 1
(*@ n = main ()
    ensures n = 0 *)

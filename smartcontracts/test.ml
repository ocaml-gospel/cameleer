let main () = 
  let l = Map ((1, "d") :: (2, "b") :: (3, "c") :: []) in
  Map.update (=) (<) 1 (Some "a") l
(*@ l = main ()
    ensures let vo = Map.get (=) 1 ul in match vo with Some _ -> false | None -> true *)


let main b = if b then 1 else failwith ()
(*@ n = main b
    ensures b = true -> n = 1
    raises Fail -> b = false *)

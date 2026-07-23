let f (x: int) : int =
  let (r: int) = ref x in
  let (v: int) = !r in
  r := v + 1;
  !r

let g (x: int) : int =
  let (r: int) = ref x in
  r := !r + 1;
  !r

let alloc_twice : int =
  let (r: int) = ref 0 in
  let (l: int) = ref 1 in
  r := !l;
  !r
(*@ res = alloc_twice
    requires true
    ensures res > 0 *)

let incr_twice (r: int ref) : int =
  r := !r + 1;
  r := !r + 1;
  !r
(*@ requires true
    ensures !r = !(old r) + 2 *)

let incr_twice2 (r: int ref) (t: int ref) : int  =
  r := !r + 1;
  r := !r + 1;
  t := !t + 2;
  !r
(*@ requires true
    ensures !r = !(old r) + 2 && !t = !(old t) + 2 *)

(* let postIncrPro (r: int ref) : int =
  let (v: int) = !r in
  r := v + 1;
  v
(*@ ensures !r = ! (old r) + 1 *)

let postIncrPro (&r: int) [v: int = r] {} (return (p: int) {r = v + 1} {p = v})
= [ &r <- r+1 ] return {v} *)

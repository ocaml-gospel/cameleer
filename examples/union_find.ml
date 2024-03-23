(*@ open Array *)

(** The following is used to prove validity of the [uf] type invariant. *)
let[@ghost] [@logic] init () = Array.init 0 (fun x -> x)
(*@ a = init ()
      ensures length a = 0 *)

(*@ predicate mem (i: int) (a: int array) =
      0 <= i < length a *)

type uf = {
  link : int array;
  rank : int array;
  mutable rep : int -> int; [@ghost]
  mutable dst : int -> int; [@ghost]
  mutable maxd : int; [@ghost]
}
(*@ with uf invariant 0 <= uf.maxd
    invariant length uf.rank = length uf.link
    invariant forall i. mem i uf.link -> 0 <= uf.link.(i) < length uf.link
    invariant forall i. mem i uf.link -> uf.rep (uf.rep i) = uf.rep i
    invariant forall i. mem i uf.link -> 0 <= uf.rep i < length uf.link
    invariant forall i. mem i uf.link -> uf.link.(i) <> i -> uf.rep i = uf.rep uf.link.(i)
    invariant forall i. mem i uf.link -> (uf.link.(i) = i <-> uf.rep i = i)
    invariant forall i. mem i uf.link -> 0 <= uf.dst i <= uf.maxd
    invariant forall i. mem i uf.link -> uf.link.(i) <> i -> uf.dst i < uf.dst uf.link.(i) *)

let rec find i uf =
  let p = uf.link.(i) in
  if p = i then i
  else
    let rep = find p uf in
    uf.link.(i) <- rep;
    rep
(*@ r = find i uf
      requires 0 <= i < Array.length uf.link
      variant  uf.maxd - uf.dst i
      ensures  0 <= r < Array.length uf.link
      ensures  r = uf.rep i
      ensures  uf.dst r >= uf.dst i *)

(*@ predicate equiv (i j: int) (uf: uf) =
      mem i uf.link -> mem j uf.link -> uf.rep i = uf.rep j *)

let[@ghost] set (f : 'a -> 'b) (x : 'a) (v : 'b) : 'a -> 'b =
 fun y -> if (y = x) [@pure] then v else f y

let union i j uf =
  let rep_i = find i uf in
  let rep_j = find j uf in
  if not (rep_i = rep_j) then
    if uf.rank.(rep_i) > uf.rank.(rep_j) then (
      uf.link.(rep_j) <- rep_i;
      uf.rep <-
        (fun [@pure] k -> if uf.rep k = uf.rep rep_j then rep_i else uf.rep k);
      uf.maxd <- uf.maxd + 1;
      uf.dst <- set uf.dst rep_i (1 + max (uf.dst rep_i) (uf.dst rep_j)))
    else (
      uf.link.(rep_i) <- rep_j;
      uf.rep <-
        (fun [@pure] k -> if uf.rep k = uf.rep rep_i then rep_j else uf.rep k);
      uf.maxd <- uf.maxd + 1;
      uf.dst <- set uf.dst rep_j (1 + max (uf.dst rep_i) (uf.dst rep_j));
      if uf.rank.(rep_i) = uf.rank.(rep_j) then
        uf.rank.(rep_i) <- uf.rank.(rep_i) + 1)
(*@ union i j uf
      requires 0 <= i < Array.length uf.link
      requires 0 <= j < Array.length uf.link
      ensures  exists r. (r = (old uf).rep i || r = (old uf).rep j) &&
               forall k. 0 <= k < Array.length uf.link ->
                 uf.rep k = if old (equiv k i uf || equiv k j uf) then r
                            else old (uf.rep k) *)

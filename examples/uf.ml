let [@ghost] [@logic] set (f: 'a -> 'b) (x: 'a) (v: 'b) : 'a -> 'b =
  fun y -> if (y = x) [@pure] then v else f y

(*@ open Array *)

(** The following is used to prove validity of the [uf] type invariant. *)
let [@logic] [@ghost] init () =
  Array.init 0 (fun _ -> 0)
(*@ a = init ()
      ensures length a = 0 *)

(*@ predicate mem (i: int) (a: int array) =
      0 <= i < length a *)

type uf = {
          link: int array;
          rank: int array;
  mutable rep : (int -> int) [@ghost];
  mutable dst : (int -> int) [@ghost];
  mutable maxd: int          [@ghost];
} (*@ invariant 0 <= maxd *)
  (*@ invariant length rank = length link *)
  (*@ invariant forall i. mem i link -> 0 <= link.(i) < length link *)
  (*@ invariant forall i. mem i link -> rep (rep i) = rep i *)
  (*@ invariant forall i. mem i link -> 0 <= rep i < length link *)
  (*@ invariant forall i. mem i link -> link.(i) <> i -> rep i = rep link.(i) *)
  (*@ invariant forall i. mem i link -> (link.(i) = i <-> rep i = i) *)
  (*@ invariant forall i. mem i link -> 0 <= dst i <= maxd *)
  (*@ invariant forall i. mem i link -> link.(i) <> i -> dst i < dst link.(i) *)

let rec find i uf =
  let p = uf.link.(i) in
  if p = i then i
  else begin let rep = find p uf in
    uf.link.(i) <- rep;
    rep end
(*@ r = find i uf
      requires 0 <= i < Array.length uf.link
      variant  uf.maxd - uf.dst i
      ensures  0 <= r < Array.length uf.link
      ensures  r = uf.rep i
      ensures  uf.dst r >= uf.dst i *)

(*@ predicate equiv (i j: int) (uf: uf) =
      0 <= i < Array.length uf.link -> 0 <= j < Array.length uf.link ->
      uf.rep i = uf.rep j *)

let union i j uf =
  let rep_i = find i uf in
  let rep_j = find j uf in
  if not (rep_i = rep_j) then
    if uf.rank.(rep_i) > uf.rank.(rep_j) then begin
      uf.link.(rep_j) <- rep_i;
      uf.rep  <-
        (fun k -> if uf.rep k = uf.rep rep_j then rep_i else uf.rep k) [@pure];
      uf.maxd <- uf.maxd + 1;
      uf.dst  <- set uf.dst rep_i (1 + max (uf.dst rep_i) (uf.dst rep_j)) end
    else begin
      uf.link.(rep_i) <- rep_j;
      uf.rep  <-
        (fun k -> if uf.rep k = uf.rep rep_i then rep_j else uf.rep k) [@pure];
      uf.maxd <- uf.maxd + 1;
      uf.dst  <- set uf.dst rep_j (1 + max (uf.dst rep_i) (uf.dst rep_j));
      if uf.rank.(rep_i) = uf.rank.(rep_j) then
        uf.rank.(rep_i) <- uf.rank.(rep_i) + 1
    end
(*@ union i j uf
      requires 0 <= i < Array.length uf.link
      requires 0 <= j < Array.length uf.link
      ensures  exists r. (r = (old uf).rep i || r = (old uf).rep j) &&
               forall k. 0 <= k < Array.length uf.link ->
                 uf.rep k = if old (equiv k i uf || equiv k j uf) then r
                            else old (uf.rep k) *)

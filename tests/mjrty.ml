let [@logic] [@ghost] rec numof_int p a b =
  if b <= a then 0 else
  if p (b - 1) then 1 + numof_int p a (b - 1)
               else     numof_int p a (b - 1)
(*@ x = numof_int p a b
      variant b - a *)

let [@lemma] rec numof_bounds (p: int -> bool) (a: int) (b: int) =
  if a < b - 1 then numof_bounds p a (b - 1)
(*@ numof_bounds p a b
      requires a < b
      variant  b - a
      ensures  0 <= numof_int p a b <= b - a *)

let [@lemma] rec numof_append (p : int -> bool) (a: int) (b: int) (c : int) =
  if b >= c then ()
  else numof_append p a b (c - 1)
(*@ numof_append p a b c
      requires a <= b <= c
      variant  c - b
      ensures  numof_int p a c = numof_int p a b + numof_int p b c *)

let [@lemma] numof_left_no_add (p : int -> bool) (a: int) (b : int) =
  ()
(*@ numof_left_no_add p a b
      requires a < b
      requires not p a
      ensures  numof_int p a b = numof_int p (a+1) b *)

let [@lemma] numof_left_add (p : int -> bool) (a: int) (b : int) =
  ()
(*@ numof_left_add p a b
      requires a < b
      requires p a
      ensures  numof_int p a b = 1 + numof_int p (a+1) b *)

(*@ function numof (a: 'a array) (v: 'a) (l u: integer) : integer =
  numof_int (fun i -> a[i] = v) l u *)

module type EQUAL = sig
  type t

  val eq : t -> t -> bool
  (*@ b = eq x y
        ensures b <-> x = y *)

end

module Mjrty (Eq: EQUAL) = struct

  exception Not_found

  type candidate = Eq.t

  exception Found of candidate

  let mjrty a
  = let n = Array.length a in
    let cand = ref a.(0) in
    let k = ref 0 in
    for i = 0 to n - 1 do (* could start at 1 with k initialized to 1 *)
      (*@ invariant 0 <= !k <= numof a !cand 0 i
          invariant 2 * (numof a !cand 0 i - !k) <= i - !k
          invariant forall c. c <> !cand -> 2 * numof a c 0 i <= i - !k *)
      if !k = 0 then begin
        cand := a.(i);
        k := 1
      end else if Eq.eq !cand a.(i) then
        incr k
      else
        decr k
    done;
    if !k = 0 then raise Not_found;
    if 2 * !k > n then raise (Found !cand);
    k := 0;
    for i = 0 to n - 1 do
      (*@ invariant !k = numof a !cand 0 i /\ 2 * !k <= n *)
      if Eq.eq a.(i) !cand then begin
        incr k;
        if 2 * !k > n then raise (Found !cand)
      end
    done;
    raise Not_found
(*@ mjrty a
      requires 1 <= Array.length a
      raises   Found c -> 2 * numof a c 0 (Array.length a) > Array.length a
      raises   Not_found ->
                 forall x. 2 * numof a x 0 (Array.length a) <= Array.length a *)

end

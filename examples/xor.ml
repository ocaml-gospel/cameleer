(*@ open Seq       *)
(*@ open SeqOfList *)

(*@ predicate map (f: 'a -> 'a -> 'b) (a1 a2: 'a seq) (r: 'b seq) =
      length a1 = length a2 = length r &&
      forall i. 0 <= i < length a1 -> r[i] = f a1[i] a2[i] *)

module type XOR = sig
  type t

  val xor : t -> t -> t [@@logic]

  (*@ axiom com_xor: forall x y. xor x y = xor y x   *)
  (*@ axiom inv_xor: forall x y. xor (xor x y) y = x *)
end

module type CIPHER = sig
  type elt
  (*@ function xor (x y: elt) : elt *)

  type t
  (*@ function to_seq (t: t) : elt seq *)

  val cipher : t -> t -> t
  (*@ r = cipher k m
        requires length (to_seq k) = length (to_seq m)
        ensures  map (fun x y -> xor x y) (to_seq m) (to_seq k) (to_seq r) *)
end

module Make (X : XOR) : CIPHER with type elt = X.t = struct
  type elt = X.t
  type t = elt list

  (*@ function xor (x y: elt) : elt = X.xor x y *)

  (*@ function to_seq (t: t) : elt seq = of_list t *)

  let rec cipher key msg =
    match (key, msg) with
    | [], [] -> []
    | x :: xs, y :: ys -> X.xor x y :: cipher xs ys
    | _ -> assert false
  (*@ r = cipher m k
        requires List.length m = List.length k
        ensures  map (fun x y -> X.xor x y) k m r
        variant  m *)

  let correct msg key =
    let r = cipher key msg in
    cipher r key
  (*@ res = correct msg key
        requires length msg = length key
        ensures  res == msg *)
end

module XBool : XOR with type t = bool = struct
  type t = bool

  let[@logic] xor t1 t2 = ((not t1) && t2) || (t1 && not t2)
end

module XBool2 : XOR with type t = bool = struct
  type t = bool

  let[@logic] xor t1 t2 = if t1 then not t2 else t2
end

module XBit : XOR = struct
  type t = Zero | One

  let[@logic] xor t1 t2 =
    match (t1, t2) with Zero, Zero | One, One -> Zero | _ -> One
end

module CBool = Make (XBool)
module CBool2 = Make (XBool2)
module CBit = Make (XBit)

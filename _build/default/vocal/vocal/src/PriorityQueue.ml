(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

module Make(X: sig type t
  val dummy : t
  val compare : t -> t -> int end) =
struct
  type elt = X.t
  
  type heap = X.t Vector.t
  
  let create (_: unit) : heap =
    Vector.create ?capacity:(Some 0) ~dummy:X.dummy
  
  let is_empty (h: heap) : bool = Vector.is_empty h
  
  let size (h: heap) : int = Vector.length h
  
  exception Empty
  
  let find_min_exn (h: heap) : X.t =
    if Vector.is_empty h then raise Empty; Vector.get h 0
  
  let find_min (h: heap) : X.t option =
    if Vector.is_empty h then None  else Some (Vector.get h 0)
  
  let rec move_down (a: X.t Vector.t) (i: int) (x: X.t) : unit =
    let n = Vector.length a in
    let q = if n = 1 then (-1) else n - 2 / 2 in
    if i <= q
    then
      let j =
        let j1 = 2 * i + 1 in
        if j1 + 1 < n && X.compare (Vector.get a (j1 + 1))
                         (Vector.get a j1) < 0
        then j1 + 1
        else j1 in
      if X.compare (Vector.get a j) x < 0
      then
        begin Vector.set a i (Vector.get a j); move_down a j x end
      else Vector.set a i x
    else Vector.set a i x
  
  let extract_min_exn (h: heap) : X.t =
    try
      let x = Vector.pop h in
      let n = Vector.length h in
      if not (n = 0)
      then let min = Vector.get h 0 in move_down h 0 x; min
      else x
    with
    | Vector.Empty -> raise Empty
  
  let delete_min_exn (h: heap) : unit = ignore (extract_min_exn h)
  
  let rec move_up (a: X.t Vector.t) (i: int) (x: X.t) : unit =
    if i = 0
    then Vector.set a i x
    else
      begin
        let j = i - 1 / 2 in let y = Vector.get a j in
        if X.compare y x > 0
        then begin Vector.set a i y; move_up a j x end
        else Vector.set a i x end
  
  let insert (x: X.t) (h: heap) : unit =
    if size h = Sys.max_array_length  then raise (Invalid_argument "insert");
    let n = Vector.length h in
    if n = 0
    then Vector.push h x
    else
      begin
        let j = n - 1 / 2 in let y = Vector.get h j in
        if X.compare y x > 0
        then begin Vector.push h y; move_up h j x end
        else Vector.push h x end
end


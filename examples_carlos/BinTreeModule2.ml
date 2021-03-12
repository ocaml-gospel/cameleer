module type OrderedType = sig
  type t

  val[@logic] compare : t -> t -> int
  (*@ axiom is_pre_order: is_pre_order compare *)
end

module type S =
sig
  type elt
  type t

  val find: t -> elt -> bool
  val insert: t -> elt -> t
  val delete: t -> elt -> t
end


module BinTree (Ord: OrderedType) = struct
  type elt = Ord.t
  type t = Empty | Node of {l:t; v:elt; r:t; h:int}

  (*@ function occ (x: elt) (t: t) : int = match t with
        | Empty -> 0
        | Node (l, v, r, h) -> (if x = v then 1 else 0) + occ x l + occ x r*)

  let [@lemma] rec occ_nonneg (x: elt) (t: t) =
    match t with
    | Empty -> ()
    | Node {l; r} -> occ_nonneg x l; occ_nonneg x r
  (*@ occ_nonneg x t
        ensures 0 <= occ x t *)

  (*@ predicate mem2 (x: elt) (t: t) = occ x t > 0 *)

  (*@ predicate bst (t: t) = match t with
        | Empty -> true
        | Node (l, v, r, h) ->
          (forall x. mem2 x l -> Ord.compare x v < 0) &&
          (forall y. mem2 y r -> Ord.compare y v > 0) &&
           bst l && bst r *)

  (*@ function specif_height (t: t) : int = match t with
        | Empty -> 0
        | Node (l, v, r, h) -> 1 + max (specif_height l) (specif_height r)*)
        
  let [@lemma] rec height_nonneg (t:t) = 
    match t with
    | Empty -> ()
    | Node {l; r} -> height_nonneg l ; height_nonneg r
  (*@ height_nonneg t
        ensures 0 <= specif_height t*)
  
  
  let [@logic] rec height = function
    Empty -> 0
    | Node {h} -> h
  (*@ r = height param
      ensures r = specif_height param*)


  (*@ predicate baltree (t: t) = bst t && match t with
    | Empty -> true
    | Node (l, v, r, h) -> let a = (specif_height l) in
                      let b = (specif_height r) in 
                      abs (a - b) <= 2 && (baltree l) && (baltree r)*)
                      

  let [@lemma] rec occ_uniq2 (x: elt) (t: t)=
    match t with
    | Empty -> ()
    | Node {l = Empty;r = Empty} -> ()
    | Node {l = ll; v = a; r = rr; _} -> let z = Ord.compare x a in
        if z = 0 then assert (x=a)
        else occ_uniq2 x (if z < 0 then ll else rr)
  (*@ occ_uniq2 x t
        variant t
        requires bst t
        ensures  occ x t <= 1 *)
        
  (*@ predicate is_minimum (x: elt) (tree: t) =
    mem2 x tree /\ forall e: elt. mem2 e tree -> Ord.compare x e < 0 \/ e = x *)

  (*@ predicate is_maximum (x:elt) (tree: t) =
    mem2 x tree /\ forall e: elt. mem2 e tree -> Ord.compare x e > 0 \/ e = x*)

  let [@logic] rec min_tree (tree: t) : elt =
    match tree with
    | Empty -> assert false
    | Node {l = Empty; v = a} -> a
    | Node {l} -> min_tree l
  (*@ r = min_tree t
    variant t
    requires t <> Empty && bst t
    ensures is_minimum r t*)

  let [@logic] rec max_tree (tree: t) : elt =
    match tree with
    | Empty -> assert false
    | Node {v = a; r = Empty} -> a
    | Node {r = rr} -> max_tree rr
  (*@ r = max_tree t
    variant t
    requires t <> Empty && bst t
    ensures is_maximum r t*)

  let [@lemma] rec is_minimum_min (t: t) =
    match t with
    |Empty -> assert false
    |Node {l = Empty} -> ()
    |Node {l = ll} -> is_minimum_min ll
  (*@ is_minimum_min t
    requires t <> Empty
    requires bst t
    variant t
    ensures is_minimum (min_tree t) t*)

  let [@lemma] rec is_maximum_max (t: t) =
    match t with
    |Empty -> assert false
    |Node {r = Empty} -> ()
    |Node {r = rr} -> is_maximum_max rr
  (*@ is_maximum_max t
    requires t <> Empty
    requires bst t
    variant t
    ensures is_maximum (max_tree t) t*)
  


  let create l v r =
    let hl = height l (*match l with Empty -> 0 | Node (_,_,_,h) -> h*) in
    let hr = height r (*match r with Empty -> 0 | Node (_,_,_,h) -> h*) in
    Node{l; v; r; h=(if hl >= hr then hl + 1 else hr + 1)}
  (*@ res = create l v r
      requires baltree l
      requires baltree r
      requires abs ((height l) - (height r)) <= 2
      requires not (mem2 v l || mem2 v r)
      requires forall j:elt. (mem2 j l -> not mem2 j r) && (mem2 j r -> not mem2 j l)
      requires forall y: elt. mem2 y l -> Ord.compare y v < 0
      requires forall x: elt. mem2 x r -> Ord.compare x v > 0
      ensures baltree res
      ensures forall z: elt. mem2 z l || mem2 z r || Ord.compare z v = 0 -> mem2 z res
      ensures forall w: elt. if w <> v then occ w res = occ w l + occ w r else mem2 v res*)
      

  let bal l v r = 
    let hl = height l(*match l with Empty -> 0 |Node (_,_,_,h) -> h*) in
    let hr = height r (*match r with Empty -> 0 |Node (_,_,_,h) -> h*) in
    if hl > hr + 2 then begin 
      match l with
        Empty -> assert false
        |Node {l = ll; v = lv; r = lr; _} ->
          if height ll <= height lr then
            create ll lv (create lr v r)
          else begin
            match lr with
              Empty -> assert false
              |Node {l = lrl; v = lrv; r = lrr; _} ->
                create (create ll lv lrl) lrv (create lrr v r)
          end
    end else if hr > hl +2 then begin 
      match r with
        Empty -> assert false
        |Node {l = rl; v = rv; r = rr; _} ->
          if height rr <= height rl then
            create (create l v rl) rv rr
          else begin
            match rl with
              Empty -> assert false 
              |Node {l = rll; v = rlv; r = rlr; _} ->
                create (create l v rll) rlv (create rlr rv rr)
          end
    end else
      Node {l; v; r; h=(if hl >= hr then hl +1 else hr + 1)}
  (*@ res = bal l v r
      requires baltree l && baltree r
      requires abs ((height l) - (height r)) <= 3
      requires not (l = Empty) /\ not (r = Empty)
      requires not (mem2 v l || mem2 v r)
      requires forall j:elt. (mem2 j l -> not mem2 j r) && (mem2 j r -> not mem2 j l)
      requires forall y: elt. mem2 y l -> Ord.compare y v < 0
      requires forall x: elt. mem2 x r -> Ord.compare x v > 0
      ensures baltree res
      ensures forall z: elt. mem2 z l || mem2 z r || Ord.compare z v = 0 -> mem2 z res
      ensures forall w: elt. if w <> v then occ w res = occ w l + occ w r else mem2 v res*)
      
  let rec remove_min_elt = function
      Empty -> assert false
    | Node {l = Empty ; r = rr} -> rr
    | Node {l=ll; v=vv; r=rr} -> bal (remove_min_elt ll) vv rr
  (*@ r = remove_min_elt param
      variant param
      requires baltree param
      requires param <> Empty
      ensures baltree r
      ensures forall j: elt. Ord.compare j (min_tree param) <> 0 -> occ j param = occ j r
      ensures not mem2 (min_tree param) r*)

  let merge t1 t2 =
    match (t1, t2) with
    | (Empty, t) -> t
    | (t, Empty) -> t
    | (_, _) -> bal t1 (min_tree t2) (remove_min_elt t2)
  (*@ r = merge t1 t2
      requires t1 <> Empty 
      requires t2 <> Empty
      requires baltree t1 && baltree t2
      requires abs ((height t1) - (height t2)) <= 2 
      requires forall j: elt. mem2 j t1 -> (forall y: elt. mem2 y t2 -> Ord.compare j y < 0)
      requires forall j:elt. (mem2 j t1 -> not mem2 j t2) && (mem2 j t2 -> not mem2 j t1)
      ensures forall z: elt. mem2 z t1 || mem2 z t2 -> mem2 z r
      ensures forall j: elt. occ j t1 + occ j t2 = occ j r
      ensures baltree r*)

  let rec mem x tree =
    match tree with
    | Node {l;v;r; _} -> let z = Ord.compare x v in
        z = 0 || mem x (if z < 0 then l else r)
    | Empty -> false
  (*@ r = find x t
      requires bst t
      variant  t
      ensures  r <-> mem2 x t *)


  let rec add tree x =
    match tree with
    |Empty -> Node {l=Empty; v=x; r=Empty; h=1}
    |Node {l;v;r; _} as t -> 
      let z = Ord.compare x v in
      if z = 0 then t else 
      if z < 0 then 
        let ll = add l x in
        if l == ll then t else bal ll v r
      else
        let rr = add r x in 
        if r == rr then t else bal l v rr
  (*@r = add t x
      requires bst t
      variant t
      ensures forall j: elt. j <> x -> occ j r = occ j t
      ensures occ x r = occ x t || occ x r = 1 + occ x t
      ensures bst r *)

  let rec remove x = function
    | Empty -> Empty
    | Node {l;v;r; _} as t -> 
        let z = Ord.compare x v in
        if z = 0 then merge l r 
        else
          if z < 0 then 
            let ll = remove x l in 
            if l == ll then t 
            else bal ll v r 
          else 
            let rr = remove x r in
            if r == rr then t 
            else bal l v rr
  (*@ r = remove x t
      requires baltree t
      variant t
      ensures forall j: elt. (x<>j) -> occ j t = occ j r
      ensures occ x r = if (occ x t > 0) then ((occ x t) - 1) else occ x t
      ensures baltree r*)
end
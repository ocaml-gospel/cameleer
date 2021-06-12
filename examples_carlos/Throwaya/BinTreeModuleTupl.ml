module type OrderedType = sig
  type t

  val[@logic] compare : t -> t -> int
  (*@ axiom is_pre_order: is_pre_order compare *)
end

module type S =
sig
  type elt
  type t

  val mem: t -> elt -> bool
  val add: elt -> t -> t
  val remove: t -> elt -> t
end


module BinTree (Ord: OrderedType) = struct
  type elt = Ord.t
  type t = Empty | Node of t * elt * t * int

  (*@ function occ (x: elt) (t: t) : int = match t with
        | Empty -> 0
        | Node l v r _ -> (if x = v then 1 else 0) + occ x l + occ x r*)

  let [@lemma] rec occ_nonneg (x: elt) (t: t) =
    match t with
    | Empty -> ()
    | Node (l,_,r,_) -> occ_nonneg x l; occ_nonneg x r
  (*@ occ_nonneg x t
        ensures 0 <= occ x t *)

  (*@ predicate mem2 (x: elt) (t: t) = occ x t > 0 *)

  (*@ function height (t: t) : int = match t with
        | Empty -> 0
        | Node l _ r _ -> 1 + max (height l) (height r) *)

  (*@ lemma height_nonneg: forall t: t. height t >= 0 *)

  (*@ predicate avl (t: t) = match t with
        | Empty -> true
        | Node l v r h ->
            h = height t &&
            (forall lv. mem2 lv l -> Ord.compare lv v < 0) &&
            (forall rv. mem2 rv r -> Ord.compare v rv < 0) &&
            abs (height l - height r) <= 2 &&
            avl l && avl r*)
            
  (*@ predicate bst (t:t) = match t with
        |Empty -> true
        | Node l v r _ -> 
            (forall lv. mem2 lv l -> Ord.compare lv v < 0) &&
            (forall rv. mem2 rv r -> Ord.compare v rv < 0) &&
            bst l && bst r*)


  let rec height = function
      Empty -> 0
    | Node (_,_,_,h) -> h
  (*@ r = height param
      requires avl param
      ensures r = height param*)

  let [@lemma] rec occ_uniq2 (x: elt) (t: t)=
    match t with
    | Empty -> ()
    | Node (Empty,_, Empty,_) -> ()
    | Node (l, a, r,_) -> let z = Ord.compare x a in
        if z = 0 then assert (x=a)
        else occ_uniq2 x (if z < 0 then l else r)
  (*@ occ_uniq2 x t
        variant t
        requires avl t || bst t
        ensures  occ x t <= 1 *)

  let [@logic] create l v r =
    let hl = match l with Empty -> 0 | Node (_,_,_,h) -> h in
    let hr = match r with Empty -> 0 | Node (_,_,_,h) -> h in
    Node(l, v, r, (if hl >= hr then hl + 1 else hr + 1))
  (*@ res = create l v r
      requires avl l
      requires avl r
      requires abs ((height l) - (height r)) <= 2
      requires forall y: elt. mem2 y l -> Ord.compare y v < 0
      requires forall x: elt. mem2 x r -> Ord.compare v x < 0
      ensures avl res
      ensures forall w: elt. w <> v -> occ w res = occ w l + occ w r
      ensures occ v res = 1
      ensures height res = 1 + max (height l) (height r) *)


  let bal l v r =
    let hl = match l with Empty -> 0 |Node (_,_,_,h) -> h in
    let hr = match r with Empty -> 0 |Node (_,_,_,h) -> h in
    if hl > hr + 2 then begin
      match l with
        Empty -> assert false
      | Node (ll, lv, lr, _) ->
          if height ll >= height lr then
            create ll lv (create lr v r)
          else begin
            match lr with
              Empty -> assert false
            |Node (lrl, lrv, lrr,_) ->
                create (create ll lv lrl) lrv (create lrr v r)
          end
    end else if hr > hl +2 then begin
      match r with
        Empty -> assert false
      | Node (rl, rv, rr, _) ->
          if height rr >= height rl then
            create (create l v rl) rv rr
          else begin
            match rl with
              Empty -> assert false
            |Node (rll, rlv, rlr, _) ->
                create (create l v rll) rlv (create rlr rv rr)
          end
    end else
      Node (l, v, r, (if hl >= hr then hl +1 else hr + 1))
  (*@ res = bal l v r
      requires avl l && avl r
      requires abs ((height l) - (height r)) <= 3
      requires forall y: elt. mem2 y l -> Ord.compare y v < 0
      requires forall x: elt. mem2 x r -> Ord.compare v x < 0
      ensures avl res
      ensures forall w: elt. w <> v -> occ w res = occ w l + occ w r
      ensures occ v res = 1
      ensures max (height l) (height r) <= height res <= 1 + max (height l) (height r)
      ensures abs ((height l) - (height r)) <= 2 -> res = create l v r*)



  (*@ predicate is_minimum (x: elt) (tree: t) =
    mem2 x tree /\ forall e: elt. mem2 e tree -> Ord.compare x e < 0 \/ e = x *)

  (*@ predicate is_maximum (x:elt) (tree: t) =
     mem2 x tree /\ forall e: elt. mem2 e tree -> Ord.compare x e > 0 \/ e = x*)
     

  let [@logic] rec min_tree (tree: t) : elt =
    match tree with
    | Empty -> assert false
    | Node (Empty,a,_,_) -> a
    | Node (l,_,_,_) -> min_tree l
  (*@ r = min_tree t
    variant t
    requires t <> Empty && avl t
    ensures is_minimum r t*)
    
  let [@logic] rec max_tree (tree: t) : elt =
    match tree with
    | Empty -> assert false
    | Node (_,a,Empty,_) -> a
    | Node (_,_,r,_) -> max_tree r
  (*@ r = max_tree t
    variant t
    requires t <> Empty && avl t
    ensures is_maximum r t*)

  let [@lemma] rec is_minimum_min (t: t) =
    match t with
    |Empty -> assert false
    |Node (Empty,_,_,_) -> ()
    |Node (l,_,_,_) -> is_minimum_min l
  (*@ is_minimum_min t
    requires t <> Empty
    requires avl t
    variant t
    ensures is_minimum (min_tree t) t*)

   let [@lemma] rec is_maximum_max (t: t) =
    match t with
    |Empty -> assert false
    |Node (_,_,Empty,_) -> ()
    |Node (_,_,r,_) -> is_maximum_max r
  (*@ is_maximum_max t
    requires t <> Empty
    requires avl t
    variant t
    ensures is_maximum (max_tree t) t*)
    
   let rec remove_min_elt = function
      Empty -> assert false
    | Node (Empty,_, r,_) as x -> assert (height r - height x = - 1); r
    | Node (l, v, r,_) -> bal (remove_min_elt l) v r
  (*@ r = remove_min_elt param
      variant param
      requires avl param
      requires param <> Empty
      ensures avl r
      ensures forall j: elt. j <> (min_tree param) -> occ j r = occ j param
      ensures not mem2 (min_tree param) r
      ensures height param - 1 <= height r <= height param*)
      
  let rec remove_max_elt = function
      Empty -> assert false
    | Node (l,_, Empty,_) as x -> assert (height l - height x = - 1); l
    | Node (l, v, r,_) -> bal l v (remove_max_elt r)
  (*@ r = remove_max_elt param
      variant param
      requires avl param
      requires param <> Empty
      ensures avl r
      ensures forall j: elt. j <> (max_tree param) -> occ j r = occ j param
      ensures not mem2 (max_tree param) r
      ensures height param - 1 <= height r <= height param*)
      
  let rec add_min_element x = function
      | Empty -> create Empty x Empty
      | Node (l, v, r, _) -> bal (add_min_element x l) v r
  (*@ r = add_min_element x param
      variant param
      requires avl param
      requires forall j: elt. mem2 j param -> Ord.compare x j < 0
      ensures avl r 
      ensures forall j: elt. j <> x -> occ j param = occ j r
      ensures occ x r = 1
      ensures height param <= height r <= height param + 1*)
      
  let rec add_max_element x = function
      | Empty -> create Empty x Empty
      | Node (l, v, r, _) -> bal l v (add_max_element x r)
  (*@ r = add_max_element x param
      variant param
      requires avl param
      requires forall j: elt. mem2 j param -> Ord.compare x j > 0
      ensures avl r 
      ensures forall j: elt. j <> x -> occ j param = occ j r
      ensures occ x r = 1
      ensures height param <= height r <= height param + 1*)
         
  let rec join l v r =
    match (l,r) with
    (Empty, _) -> add_min_element v r
    |(_, Empty) -> add_max_element v l
    |(Node(ll, lv, lr, lh), Node(rl, rv, rr, rh)) ->
      if lh > rh +2 then bal ll lv (join lr v r) else
      if rh > lh + 2 then bal (join l v rl) rv rr else
      create l v r
  (*@ res = join l v r
      variant l,r
      requires avl l && avl r
      requires forall y: elt. mem2 y l -> Ord.compare y v < 0
      requires forall x: elt. mem2 x r -> Ord.compare v x < 0
      ensures avl res
      ensures forall w: elt. w <> v -> occ w res = occ w l + occ w r
      ensures occ v res = 1
      ensures max (height l) (height r) <= height res <= 1 + max (height l) (height r)*)

  let merge t1 t2 =
    match (t1, t2) with
    | (Empty, t) -> t
    | (t, Empty) -> t
    | (_, _) -> bal t1 (min_tree t2) (remove_min_elt t2)
  (*@ r = merge t1 t2
      requires avl t1 && avl t2
      requires abs ((height t1) - (height t2)) <= 2
      requires forall j: elt. mem2 j t1 -> (forall y: elt. mem2 y t2 -> Ord.compare j y < 0)
      requires forall j:elt. (mem2 j t1 -> not mem2 j t2) && (mem2 j t2 -> not mem2 j t1)
      ensures forall j: elt. occ j t1 + occ j t2 = occ j r
      ensures avl r
      ensures max (height t1) (height t2) <= height r <= 1 + max (height t1) (height t2)*)
    
      
  let concat t1 t2 =
      match (t1, t2) with
        (Empty, t) -> t
      | (t, Empty) -> t
      | (_, _) -> join t1 (min_tree t2) (remove_min_elt t2)
  (*@ r = concat t1 t2
      requires avl t1 && avl t2
      requires forall j: elt. mem2 j t1 -> (forall y: elt. mem2 y t2 -> Ord.compare j y < 0)
      requires forall j:elt. (mem2 j t1 -> not mem2 j t2) && (mem2 j t2 -> not mem2 j t1)
      ensures forall j: elt. occ j t1 + occ j t2 = occ j r
      ensures avl r
      ensures max (height t1) (height t2) <= height r <= 1 + max (height t1) (height t2)*)
      
  let rec split x = function
        Empty ->
          (Empty, false, Empty)
      | Node(l, v, r, _) ->
          let c = Ord.compare x v in
          if c = 0 then (l, true, r)
          else if c < 0 then
            let (ll, pres, rl) = split x l in (ll, pres, join rl v r)
          else
            let (lr, pres, rr) = split x r in (join l v lr, pres, rr)
  (*@ (l,pres,r) = split x t
      variant t
      requires avl t
      ensures avl l && avl r
      ensures forall j:elt. Ord.compare j x < 0 -> occ j l = occ j t
      ensures forall y:elt. Ord.compare y x > 0 -> occ y r = occ y t
      ensures pres <-> mem2 x t *)    

  let rec mem x tree =
    match tree with
    | Node (l, v, r, _) -> let z = Ord.compare x v in
        z = 0 || mem x (if z < 0 then l else r)
    | Empty -> false
  (*@ r = mem x t
      requires avl t
      variant  t
      ensures  r <-> mem2 x t *)

  let rec add x = function
    Empty -> Node (Empty, x, Empty, 1)
    |Node (l,v,r, _) as t ->
        let z = Ord.compare x v in
        if z = 0 then t else
        if z < 0 then
          let ll = add x l in
          if l == ll then t else bal ll v r
        else
          let rr = add x r in
          if r == rr then t else bal l v rr
  (*@ r = add x t
      requires avl t
      variant t
      ensures forall j: elt. j <> x -> occ j r = occ j t
      ensures occ x r = occ x t || occ x r = 1 + occ x t
      ensures avl r 
      ensures 1 >= height r - height t >= 0*)

  let rec remove x = function
    | Empty -> Empty
    | Node (l,v,r, _) as t ->
        let z = Ord.compare x v in
        if z = 0 then  merge l r
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
      requires avl t
      variant t
      ensures forall j: elt. (x<>j) -> occ j t = occ j r
      ensures occ x r = if (occ x t > 0) then ((occ x t) - 1) else occ x t
      ensures avl r
      ensures height t - 1 <= height r <= height t*)
      
  let rec union s1 s2 =
      match (s1, s2) with
        (Empty, t2) -> t2
      | (t1, Empty) -> t1
      | (Node(l1, v1, r1, h1), Node(l2, v2, r2, h2)) ->
          if h1 >= h2 then
            if h2 = 1 then add v2 s1 else begin
              let (l2, _, r2) = split v1 s2 in
              join (union l1 l2) v1 (union r1 r2)
            end
          else
            if h1 = 1 then add v1 s2 else begin
              let (l1, _, r1) = split v2 s1 in
              join (union l1 l2) v2 (union r1 r2)
            end
  (* *)
              
              
  (*@ predicate subset (s1 s2: t) = forall x : elt. mem2 x s1 -> mem2 x s2*)
 
  let rec subset s1 s2 =
      match (s1, s2) with
        Empty, _ ->
          true
      | _, Empty ->
          false
      | Node (l1, v1, r1, _), (Node (l2, v2, r2, _) as t2) ->
          let c = Ord.compare v1 v2 in
          if c = 0 then
            subset l1 l2 && subset r1 r2
          else if c < 0 then
            subset (Node (l1, v1, Empty, 0)) l2 && subset r1 t2
          else
            subset (Node (Empty, v1, r1, 0)) r2 && subset l1 t2
  (*@ r = subset t1 t2
    requires bst t1 && bst t2
    variant t1, t2
    ensures r <-> subset t1 t2*)
end

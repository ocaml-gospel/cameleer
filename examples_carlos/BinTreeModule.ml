module type Comparable = sig
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


module BinTree (TreeNode : Comparable) = 
  struct
    type elt = TreeNode.t
    type t = |Node of t * elt * t
            |Empty
            
 
  (*@ function occ (x: elt) (t: t) : int = 
      match t with
        | Empty -> 0
        | Node l v r -> (if x = v then 1 else 0) + occ x l + occ x r*)
        
  let [@lemma] rec occ_nonneg (x: elt) (t: t) =
    match t with
      |Empty -> ()
      |Node (Empty, _, Empty) -> ()
      |Node (l, _, r) -> occ_nonneg x l; occ_nonneg x r
    (*@ occ_nonneg x t
      ensures 0 <= (occ x t) *)
    
    (*@ predicate mem (x: elt) (t: t) = occ x t > 0 *)
    
    
    (*@ predicate binsearchtree (t: t) = match t with
      | Empty -> true
      | Node l v r ->
        (forall x. mem x l -> TreeNode.compare x v < 0) &&
        (forall y. mem y r -> TreeNode.compare y v > 0) &&
         binsearchtree l && binsearchtree r *)
    

    let [@lemma] rec occ_uniq2 (x: elt) (t: t)=
      match t with
      |Empty -> ()
      |Node (Empty, _,Empty) -> ()
      |Node (l, a, r) -> let z = TreeNode.compare x a in
                         if z = 0 then (assert (x=a)) else 
                         (occ_uniq2 x (if z < 0 then l else r))
      (*@ occ_uniq2 x t 
        variant t
        requires binsearchtree t
        ensures (occ x t) <= 1*)
        

    let rec find tree x =
      match tree with 
        |Node (l,a,r) -> let z = TreeNode.compare x a in
                      if (z=0) then true else
                      find (if z < 0 then (l) else (r)) x
        |Empty -> false
        (*@ r = find t x
        requires binsearchtree t
        variant t
        ensures r <-> mem x t*)


    let rec insert tree x =
      match tree with
        |Empty -> Node (Empty,x,Empty)
        |Node (l,y,r)-> let z = TreeNode.compare x y in
                        if z < 0 then Node ((insert l x),y,r) else
                        if z > 0 then Node (l, y, (insert r x))
                        else Node (l,y,r)
    (*@r = insert t x
      requires binsearchtree t
      variant t
      ensures forall j: elt. j <> x -> occ j r = occ j t 
      ensures occ x r = occ x t || occ x r = 1 + occ x t 
      ensures binsearchtree r *)
    
    (*@ predicate is_minimum (x: elt) (tree: t) =
      mem x tree /\ forall e: elt. mem e tree -> TreeNode.compare x e < 0 \/ e = x *)
    
    let [@logic] rec min_tree (tree: t) : elt =
      match tree with
        | Empty -> assert false
        | Node (Empty, a, _) -> a
        | Node (l, _, _) -> min_tree l
    (*@ r = min t
      variant t
      requires t <> Empty && binsearchtree t
      ensures is_minimum r t*)


    let [@lemma] rec is_minimum_min (t: t) =
      match t with
        |Empty -> assert false
        |Node (Empty, _, _) -> ()
        |Node (l, _, _) -> is_minimum_min l
    (*@ is_minimum_min t 
      requires t <> Empty
      requires binsearchtree t
      variant t
      ensures is_minimum (min_tree t) t*)



    let rec find_min tree =
      match tree with
        | Empty -> assert false
        | Node (Empty, x, r) -> (x, r)
        | Node (l,a,b) -> let x,y = find_min l in (x, (Node (y,a, b)))
    (*@ (r, x) = find_min t
      variant t
      requires binsearchtree t
      requires t <> Empty
      ensures binsearchtree x
      ensures forall j: elt. j <> r -> occ j t = occ j x
      ensures occ r x = (occ r t) - 1
      ensures r = min_tree t*)
    
    
    let rec delete tree x =
      match tree with
        |Empty -> Empty
        |Node (l,a,r) -> let z = TreeNode.compare x a in
                        if z < 0 then Node ((delete l x), a, r) else
                        if z > 0 then Node (l, a, (delete r x)) else 
                        match l, r with
                          |Empty, _ -> r
                          |_, Empty -> l
                          |l', r' -> let (min, x') = find_min r' in Node (l', min, (x'))
    (*@ r = delete t x
      requires binsearchtree t
      variant t
      ensures forall j: elt. (x<>j) -> occ j t = occ j r
      ensures occ x r = if (occ x t > 0) then ((occ x t) - 1) else occ x t
      ensures binsearchtree r*)


  end
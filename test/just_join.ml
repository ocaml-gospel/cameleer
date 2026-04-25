type 'a tree = Empty | Node of int * 'a tree * 'a * 'a tree
type elt = int

(*@ predicate lt (x y: elt) = x < y *)

(** Ver se são precisas ou não*)
(* @ function min (x y: int) : int = if x <= y then x else y *)
(* @ function max (x y: int) : int = if x <= y then y else x *)

(*TODO: rever*)
(* @ function ht (t: elt tree) : integer = match t with
      | Empty -> 0
      | Node h _ _ _ -> h *)

(*TODO: rever*)
(* @ function node (l: elt tree) (x: elt) (r: elt tree) : elt tree = Node (1 + max (ht l) (ht r)) l x r *)

(** VER COMO ESCREVER ISTO  PQ É GHOST *)
let[@ghost] [@logic] rec height (t: elt tree) : int = 
  match (t: elt tree) with
      | Empty -> 0
      | Node ((_: int), (l: elt tree), (_: elt), (r: elt tree)) -> 1 + max (height l) (height r)
(*@ result = height t 
    ensures result >= 0 *)

(*@ predicate wf (t: elt tree) = match t with
      | Empty -> true
      | Node h l _ r -> h = height t && wf l && wf r *)

(*@ predicate mem (y: elt) (t: elt tree) = match t with
      | Empty -> false
      | Node _ l x r -> mem y l || y = x || mem y r *)

(*@ predicate tree_lt (t: elt tree) (y: elt) =  forall x. mem x t -> lt x y *)

(*@ predicate lt_tree (y: elt) (t: elt tree) = forall x. mem x t -> lt y x *)

(*@ predicate bst (t: elt tree) = match t with
      | Empty -> true
      | Node _ l x r -> bst l && bst r && tree_lt l x && lt_tree x r *)

(*@ predicate avl (t: elt tree) = match t with
      | Empty -> true
      | Node _ l _ r -> avl l && avl r && -1 <= height l - height r <= 1 *)

(* TODO: rever*)
let ht (t: elt tree) : int = 
  match (t: elt tree) with
      | Empty -> 0
      | Node ((h: int), (_: elt tree), (_: elt), (_: elt tree)) -> h

(* TODO: rever*)
let node (l: elt tree) (x: elt) (r: elt tree) : elt tree = 
  let (o1: int) = 1 + max (ht l) (ht r) in
  Node (o1, l, x, r)

let rotate_left (t: elt tree) : elt tree = 
  match (t: elt tree) with
  | Node ((_: int), (a: elt tree), (x: elt), (r: elt tree)) -> 
    match (r: elt tree) with
      | Node ((_: int), (b: elt tree), (y: elt), (c: elt tree)) -> 
        let (o1: elt tree) = node a x b in
        node o1 y c
      | (_: elt tree)  -> assert false    
  | (_: elt tree)  -> assert false
(*@ result = rotate_left t
    requires wf t && bst t
    requires match t with 
            | Node _ _ _ (Node _ _ _ _) -> true 
            | _ -> false
    ensures wf result && bst result
    ensures match t with 
              | Node _ a x (Node _ b y c) ->
                (match result with 
                | Node _ (Node _ ra rx rb) ry rc -> ra=a && rx=x && rb=b && ry=y && rc=c
                | _ -> false)
              | _ -> false *)

let rotate_right (t: elt tree) : elt tree = 
  match (t: elt tree) with
  | Node ((_: int), (l: elt tree), (y: elt), (c: elt tree)) -> 
    match (l: elt tree) with
      | Node ((_: int), (a: elt tree), (x: elt), (b: elt tree)) -> 
        let (o1: elt tree) = node b y c in
        node a x o1
      | (_: elt tree)  -> assert false    
  | (_: elt tree)  -> assert false
(*@ result = rotate_right t
    requires wf t && bst t
    requires match t with 
              | Node _ _ _ (Node _ _ _ _) -> true 
              | _ -> false
    ensures  wf result && bst result
    ensures  match t with 
              | Node _ (Node _ a x b) y c ->
                (match result with 
                | Node _ ra rx (Node _ rb ry rc) -> ra=a && rx=x && rb=b && ry=y && rc=c
                | _ -> false)
              | _ -> false *)

let rec join_right (l: elt tree) (x: elt) (r: elt tree) : elt tree = 
  match (l: elt tree) with
  | Empty -> assert false
  | Node ((_: int), (ll: elt tree), (lx: elt), (lr: elt tree)) ->
      let (ht_lr: int) = ht lr in
      let (ht_r: int) = ht r + 1 in
      if ht_lr <= ht_r then
        let (t: elt tree) = node lr x r in
        if ht t <= ht ll + 1 then node ll lx t
        else 
          let (o1: elt tree) = rotate_right t in
          let (node1: elt tree) = node ll lx o1 in
          rotate_left node1
      else
        let (t: elt tree) = join_right lr x r in
        let (t': elt tree) = node ll lx t in
        if ht t <= ht ll + 1 then t' else rotate_left t'
(*@ result = join_right l x r
  requires wf l && wf r
  requires bst l && tree_lt l x
  requires bst r && lt_tree x r
  requires height l >= height r + 2
  requires avl l && avl r
  variant height l
  ensures wf result && bst result
  ensures avl result
  ensures forall y. mem y result <-> (mem y l || y=x || mem y r) 
  ensures height result = height l ||
             height result = height l + 1 && 
             match result with
               | Node _ rl _ rr ->
                   height rl = height l - 1 && height rr = height l
               | _ -> false *)

let rec join_left (l: elt tree) (x: elt) (r: elt tree) : elt tree = 
  match (r: elt tree) with
  | Empty -> assert false
  | Node ((_: int), (rl: elt tree), (rx: elt), (rr: elt tree)) ->
      if ht rl <= ht l + 1 then
        let (t: elt tree) = node l x rl in
        if ht t <= ht rr + 1 then node t rx rr
        else 
          let (o1: elt tree) = rotate_left t in
          let (node1: elt tree) = node o1 rx rr in
          rotate_right node1
      else
        let (t: elt tree) = join_left l x rl in
        let (t': elt tree) = node t rx rr in
        if ht t <= ht rr + 1 then t' else rotate_right t'
(*@ result = join_left l x r
    requires wf l && wf r
    requires bst l && tree_lt l x
    requires bst r && lt_tree x r
    requires height r >= height l + 2
    requires avl l && avl r
    variant height r
    ensures wf result && bst result
    ensures forall y. mem y result <-> (mem y l || y=x || mem y r)
    ensures avl result
    ensures height result = height r ||
            height result = height r + 1 && 
            match result with
              | Node _ rl _ rr ->
                height rr = height r - 1 && height rl = height r
              | _ -> false *)

let join (l: elt tree) (x: elt) (r: elt tree) : elt tree =
  if ht l > ht r + 1 then join_right l x r
  else if ht r > ht l + 1 then join_left l x r
  else node l x r
(*@ result = join l x r
  requires wf l && wf r 
  requires bst l && tree_lt l x
  requires bst r && lt_tree x r
  requires avl l && avl r 
  ensures wf result
  ensures bst result
  ensures forall y. mem y result <-> (mem y l || y=x || mem y r)
  ensures avl result
  ensures height result <= 1 + max (height l) (height r) *)


let rec split (t: elt tree) (y: elt) : elt tree * bool * elt tree = 
  match (t: elt tree) with
  | Empty -> (Empty, false, Empty)
  | Node ((_: int), (l: elt tree), (x: elt), (r: elt tree)) ->
      if y = x then (l, true, r)
      else 
        if y < x then 
          let ((ll: elt tree), (b: bool), (lr: elt tree)) = split l y in 
          (ll, b, join lr x r)
        else     
          let ((rl: elt tree), (b: bool), (rr: elt tree)) = split r y in 
          (join l x rl, b, rr)
(*@ l, b, r = split t y
  requires wf t && bst t && avl t
  variant height t
  ensures wf l && bst l && avl l
  ensures tree_lt l y
  ensures wf r && bst r && avl r 
  ensures lt_tree y r
  ensures forall x. mem x t <-> (mem x l || mem x r || b && x=y) *)

let insert (x: elt) (t: elt tree) : (elt tree) =
  let ((l: elt tree), (_: bool), (r: elt tree)) = split t x in
  join l x r
(*@ r = insert x t
  requires wf t && bst t && avl t
  ensures  wf r && bst r && avl r
  ensures  forall y. mem y r <-> (mem y t || y=x) *)

let rec split_last (t: elt tree) : elt tree * elt = 
  match (t: elt tree) with
  | Node ((_: int), (l: elt tree), (x: elt), (r: elt tree)) -> 
    match (r: elt tree) with
    | Empty -> (l, x)
    | (_: elt tree) -> 
      let ((r': elt tree), (m: elt)) = split_last r in 
      (join l x r', m)
  | (_: elt tree) -> assert false
(*@ r, m = split_last t
  requires t <> Empty
  requires wf t && bst t && avl t
  variant height t
  ensures wf r && bst r && avl r
  ensures tree_lt r m
  ensures forall x. mem x t <-> (mem x r && lt x m || x=m) *)

let join2 (l:elt tree) (r: elt tree) : elt tree =
  match (l: elt tree) with
  | Empty -> r
  | (_: elt tree) -> 
    let ((l: elt tree), (k: elt)) = split_last l in 
    join l k r
(*@ result = join2 l r
  requires wf l && bst l && avl l
  requires wf r && bst r && avl r
  requires forall x y. mem x l -> mem y r -> lt x y
  ensures wf result && bst result && avl result
  ensures forall x. mem x result <-> (mem x l || mem x r) *)

let delete (x: elt) (t: elt tree) : elt tree = 
  let ((l: elt tree), (_: bool), (r: elt tree)) = split t x in
  join2 l r
(*@ result = delete x t
  requires wf t && bst t && avl t
  ensures  wf result && bst result && avl result
  ensures  forall y. mem y result <-> (mem y t && y<>x) *)



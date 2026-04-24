type 'a tree = Empty | Node of int * 'a tree * 'a * 'a tree
type elt = int

(*@ function ht (t: 'a tree) : integer = match t with
      | Empty -> 0
      | Node h _ _ _ -> h *)

(*@ function node (l: 'a tree) (v: 'a) (r: 'a tree) : 'a tree = Node (1 + max (ht l) (ht r)) l v r *)

(** VER COMO ESCREVER ISTO*)
(*@ function height (t: 'a tree) : integer = ht t *)

(*@ predicate wf (t: 'a tree) = match t with
      | Empty -> true
      | Node h l v r -> h = height t && wf l && wf r *)

(*@ predicate mem (y: 'a) (t: 'a tree) = match t with
      | Empty -> false
      | Node _ l x r -> mem y l || y = x || mem y r *)

(*@ predicate tree_lt (t: 'a tree) (y: 'a) : integer =  forall x. mem x t -> lt x y *)

(*@ predicate lt_tree (t: 'a tree) (y: 'a) = forall x. mem x t -> lt y x *)

(*@ predicate bst (t: 'a tree) = match t with
      | Empty -> true
      | Node _ l x r -> bst l && bst r && tree_lt l x && lt_tree x r *)

(*@ predicate avl (t: 'a tree) = match t with
      | Empty -> true
      | Node _ l _ r -> avl l && avl r && -1 <= height l - height r <= 1 *)

let rotate_left (t: 'a tree) : 'a tree = 
  match (t: 'a tree) with
  | Node ((_: int), (a: 'a tree), (x: 'a), (r: 'a tree)) -> 
    match (r: 'a tree) with
      | Node ((_: int), (b: 'a tree), (y: 'a), (c: 'a tree)) -> 
        let (o1: 'a tree) = node a x b in
        node o1 y c
      | (_: 'a tree)  -> assert false    
  | (_: 'a tree)  -> assert false
(*@ r = rotate_left t
    requires wf t && bst t
    requires match t with N _ _ _ (N _ _ _ _) -> true | _ -> false end
    ensures  wf r && bst r
    ensures  match t with 
              | N _ a x (N _ b y c) ->
                match r with 
                | N _ (N _ ra rx rb) ry rc -> ra=a && rx=x && rb=b && ry=y && rc=c
                | _ -> false 
              | _ -> false *)

let rotate_right (t: 'a tree) : (r: 'a tree) = 
  match (t: 'a tree) with
  | Node ((_: int), (l: 'a tree), (y: 'a), (c: 'a tree)) -> 
    match (l: 'a tree) with
      | Node ((_: int), (a: 'a tree), (x: 'a), (b: 'a tree)) -> 
        let (o1: 'a tree) = node b y c in
        node a x o1
      | (_: 'a tree)  -> assert false    
  | (_: 'a tree)  -> assert false
(*@ r = rotate_right t
    requires wf t && bst t
    requires match t with 
      | N _ _ _ (N _ _ _ _) -> true | _ -> false end
    ensures  wf r && bst r
    ensures  match t with 
              | N _ (N _ a x b) y c ->
                match r with 
                | N _ ra rx (N _ rb ry rc) -> ra=a && rx=x && rb=b && ry=y && rc=c
                | _ -> false 
              | _ -> false *)

let rec join_right (l: 'a tree) (x: 'a) (r: 'a tree) : 'a tree = 
  match (l: 'a tree) with
  | Empty -> assert false
  | Node ((_: int), (ll: 'a tree), (lx: 'a), (lr: 'a tree)) ->
      let (ht_lr: int) = ht lr in
      let (ht_r: int) = ht r + 1 in
      if ht_lr <= ht_r then
        let (t: 'a tree) = node lr x r in
        if ht t <= ht ll + 1 then node ll lx t
        else 
          let (o1: 'a tree) = rotate_right t in
          let (node1: 'a tree) = node ll lx o1 in
          rotate_left node1
      else
        let (t: 'a tree) = join_right lr x r in
        let (t': 'a tree) = node ll lx t in
        if ht t <= ht ll + 1 then t' else rotate_left t'
(*@ result = join_right l x r
  requires wf l && wf r
  requires bst l && tree_lt l x
  requires bst r && lt_tree x r
  requires height l >= height r + 2
  requires avl l && avl r
  variant height l
  ensures wf result && bst result
  ensures bst result && lt_tree x result
  ensures avl result
  ensures forall y. mem y result <-> (mem y l || y=x || mem y r) 
  ensures height result = height l ||
             height result = height l + 1 && 
             match result with
               | Node ((_: int), (rl: 'a tree), (rx: 'a), (rr: 'a tree)) ->
                   height rl = height l - 1 && height rr = height l
               | _ -> false *)


let rec join_left (l: 'a tree) (x: 'a) (r: 'a tree) : 'a tree = 
  match (r: 'a tree) with
  | Empty -> assert false
  | Node ((_: int), (rl: 'a tree), (rx: 'a), (rr: 'a tree)) ->
      if ht rl <= ht l + 1 then
        let (t: 'a tree) = node l x rl in
        if ht t <= ht rr + 1 then node t rx rr
        else 
          let (o1: 'a tree) = rotate_left t in
          let (node1: 'a tree) = node o1 rx rr in
          rotate_right node1
      else
        let (t: 'a tree) = join_left l x rl in
        let (t': 'a tree) = node t rx rr in
        if ht t <= ht rr + 1 then t' else rotate_right t'
(*@ result = join_left l x r
    requires wf l && wf r
    requires bst l && tree_lt l x
    requires bst r && lt_tree x r
    requires height r >= height l + 2
    requires avl l && avl r
    variant height r
    ensures wf result 
    ensures bst result
    ensures forall y. mem y result <-> (mem y l || y=x || mem y r)
    ensures avl result
    ensures height result = height r ||
            height result = height r + 1 && 
            match result with
              | Node ((_: int), (rl: 'a tree), (rx: 'a), (rr: 'a tree)) ->
                height rr = height r - 1 && height rl = height r
              | _ -> false *)

let join (l: 'a tree) (x: 'a) (r: 'a tree) : 'a tree =
  if ht l > ht r + 1 then join_right l x r
  else 
    if ht r > ht l + 1 then join_left l x r
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

let rec split (t: 'a tree) (y: 'a) : ('a tree, bool, 'a tree) = 
  match (t: 'a tree) with
  | Empty -> Empty, false, Empty
  | Node ((_: int), (l: 'a tree), (x: 'a), (r: 'a tree)) ->
      if y = x then l, true, r
      else 
        if lt y x then 
          let (ll: 'a tree), (b: bool), (lr: 'a tree) = split l y in 
          ll, b, join lr x r
        else     
          let (rl: 'a tree), (b: bool), (rr: 'a tree) = split r y in 
          join l x rl, b, rr
(*@ result = split t y
  requires wf t && bst t && avl t
  variant  height t
  ensures  wf l && bst l && avl l
  ensures tree_lt l y
  ensures wf r && bst r && avl r 
  ensures lt_tree y r
  ensures forall x. mem x t <-> (mem x l || mem x r || b && x=y) *)

let insert (x: 'a) (t: 'a tree) : ('a tree) =
  let (l: 'a tree), (_: bool), (r: 'a tree) = split t x in
  join l x r
(*@ r = insert x t
  requires wf t && bst t && avl t
  ensures  wf r && bst r && avl r
  ensures  forall y. mem y r <-> (mem y t || y=x) *)


let rec split_last (t: 'a tree) : (r: 'a tree, m: 'a) = 
  match (t: 'a tree) with
  | Node ((_: int), (l: 'a tree), (x: 'a), (r: 'a tree)) -> 
    match (r: 'a tree) with
    | Empty -> l, x
    | (_: 'a tree) -> 
      let r', m = split_last r in 
      join l x r', m
  | (_: 'a tree) -> assert false
(*@ result = split_last t
  requires t <> Empty
  requires wf t && bst t && avl t
  variant height t
  ensures wf r && bst r && avl r
  ensures tree_lt r m
  ensures forall x. mem x t <-> (mem x r && lt x m || x=m) *)

let join2 (l:'a tree) (r: 'a tree) : (t: 'a tree) =
  match (l: 'a tree) with
  | Empty -> r
  | (_: 'a tree) -> 
    let (l: 'a tree), (k: 'a) = split_last l in 
    join l k r
(*@ result = join2 l r
  requires wf l && bst l && avl l
  requires wf r && bst r && avl r
  requires forall x y. mem x l -> mem y r -> lt x y
  ensures  wf t && bst t && avl t
  ensures  forall x. mem x t <-> (mem x l || mem x r) *)


let delete (x: 'a) (t: 'a tree) : (r: 'a tree) = 
  let (l: 'a tree), (_: bool), (r: 'a tree) = split t x in
  join2 l r
(*@ result = delete x t
  requires wf t && bst t && avl t
  ensures  wf r && bst r && avl r
  ensures  forall y. mem y r <-> (mem y t && y<>x) *)

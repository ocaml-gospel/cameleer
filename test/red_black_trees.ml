type key = int
type value = int
type color = Red | Black
type tree = Leaf | Node of color * tree * key * value * tree

(*@ predicate memt (t: tree) (k: key) (v: value) =
  match t with
  | Leaf -> false
  | Node _ l k' v' r -> (k = k' /\ v = v') \/ memt l k v \/ memt r k v *)

(*@ lemma memt_color :
      forall l r : tree, k k' : key, v v' : value, c c' : color.
      memt (Node c l k v r) k' v' -> memt (Node c' l k v r) k' v' *)

(*@ predicate lt_tree (x : key) (t : tree) =
    forall k v. memt t k v -> k < x *)

(*@ predicate gt_tree (x : key) (t : tree) =
  forall k v. memt t k v -> x < k *)

(*@ lemma lt_leaf: forall x: key. lt_tree x Leaf *)

(*@ lemma gt_leaf: forall x: key. gt_tree x Leaf *)

(*@ lemma lt_tree_node:
    forall x y: key, v: value, l r: tree, c: color.
    lt_tree x l -> lt_tree x r -> y < x -> lt_tree x (Node c l y v r) *)

(*@ lemma gt_tree_node:
    forall x y: key, v: value, l r: tree, c: color.
    gt_tree x l -> gt_tree x r -> x < y -> gt_tree x (Node c l y v r) *)

(*@ lemma lt_node_lt:
    forall x y: key, v: value, l r: tree, c: color.
    lt_tree x (Node c l y v r) -> y < x *)

(*@ lemma gt_node_gt:
    forall x y: key, v: value, l r: tree, c: color.
    gt_tree x (Node c l y v r) -> x < y *)

(*@ lemma lt_left:
    forall x y: key, v: value, l r: tree, c : color.
    lt_tree x (Node c l y v r) -> lt_tree x l *)

(*@ lemma lt_right:
    forall x y: key, v: value,  l r: tree, c: color.
    lt_tree x (Node c l y v r) -> lt_tree x r *)

(*@ lemma gt_left:
    forall x y: key, v: value, l r: tree, c: color.
    gt_tree x (Node c l y v r) -> gt_tree x l *)

(*@ lemma gt_right:
    forall x y: key, v: value, l r: tree, c: color.
    gt_tree x (Node c l y v r) -> gt_tree x r *)

(*@ lemma lt_tree_not_in:
    forall x: key, t: tree. lt_tree x t -> forall v: value. not (memt t x v) *)

(*@ lemma lt_tree_trans:
    forall x y: key. x < y -> forall t: tree. lt_tree x t -> lt_tree y t *)

(*@ lemma gt_tree_not_in :
    forall x: key, t: tree. gt_tree x t -> forall v: value. not (memt t x v) *)

(*@ lemma gt_tree_trans :
    forall x y: key. y < x -> forall t: tree. gt_tree x t -> gt_tree y t *)

(*@ predicate bst (t : tree) =
    match t with
    | Leaf -> true
    | Node _ l k _ r -> bst l /\ bst r /\ lt_tree k l /\ gt_tree k r *)

(*@ lemma bst_Leaf : bst Leaf *)

(*@ lemma bst_left:
    forall k: key, v: value, l r: tree, c: color. bst (Node c l k v r) -> bst l *)

(*@ lemma bst_right:
    forall k: key, v: value, l r: tree, c: color. bst (Node c l k v r) -> bst r *)

(*@ lemma bst_color:
    forall c c': color, k: key, v: value, l r: tree.
    bst (Node c l k v r) -> bst (Node c' l k v r) *)

(*@ lemma rotate_left:
    forall kx ky: key, vx vy: value, a b c: tree, c1 c2 c3 c4: color.
    bst (Node c1 a kx vx (Node c2 b ky vy c)) ->
    bst (Node c3 (Node c4 a kx vx b) ky vy c) *)

(*@ lemma rotate_right:
    forall kx ky: key, vx vy: value, a b c: tree, c1 c2 c3 c4: color.
    bst (Node c3 (Node c4 a kx vx b) ky vy c) ->
    bst (Node c1 a kx vx (Node c2 b ky vy c)) *)

(*@ predicate is_not_red (t : tree) =
    match t with
    | Node Red _ _ _ _ -> false
    | Leaf | Node Black _ _ _ _ -> true *)

(*@ predicate rbtree (n : int) (t : tree) =
    match t with
    | Leaf -> n = 0
    | Node Red l _ _ r -> rbtree n l /\ rbtree n r /\ is_not_red l /\ is_not_red r
    | Node Black l _ _ r -> rbtree (n-1) l /\ rbtree (n-1) r *)

(*@ lemma rbtree_Leaf: rbtree 0 Leaf *)

(*@ lemma rbtree_Node1:
    forall k:key, v:value. rbtree 0 (Node Red Leaf k v Leaf) *)

(*@ lemma rbtree_left:
    forall x: key, v: value, l r: tree, c: color.
    (exists n: int. rbtree n (Node c l x v r)) -> exists n: int. rbtree n l *)

(*@ lemma rbtree_right:
    forall x: key, v: value, l r: tree, c: color.
    (exists n: int. rbtree n (Node c l x v r)) -> exists n: int. rbtree n r *)

let rec find (t : tree) (k : key) : value option = 
  match (t: tree) with
  (* | Leaf -> raise Not_found *)
  | Leaf -> None
  | Node ((_: color), (l: tree), (k': key), (v: value), (r: tree)) ->
      if k = k' then Some v
      else if k < k' then find l k
      else find r k
(*@ result = find t k
    requires bst t 
    variant t
    ensures match result with 
            | None -> forall v : value. not (memt t k v)
            | Some res -> memt t k res *)

(*@ predicate almost_rbtree (n : int) (t : tree) =
    match t with
    | Leaf -> n = 0
    | Node Red   l _ _ r -> rbtree n l /\ rbtree n r
    | Node Black l _ _ r -> rbtree (n-1) l /\ rbtree (n-1) r *)

(*@ lemma rbtree_almost_rbtree:
    forall n: int, t: tree. rbtree n t -> almost_rbtree n t *)

(*@ lemma rbtree_almost_rbtree_ex:
    forall s: tree.
    (exists n: int. rbtree n s) -> exists n: int. almost_rbtree n s *)

(*@ lemma almost_rbtree_rbtree_black:
    forall x: key, v: value, l r: tree, n: int.
    almost_rbtree n (Node Black l x v r) -> rbtree n (Node Black l x v r) *)

let lbalance (l : tree) (k : key) (v : value) (r : tree) : tree = 
    match (l: tree) with
    | Node ((col: color), (ll: tree), (ky: key), (vy: value), (c: tree)) -> 
        begin
            match ((col: color), (ll: tree), (c: tree)) with
            | (Black, (_: tree), (_: tree)) -> Node (Black, l, k, v, r)
            | (Red, Node ((col2: color), (a: tree), (kx: key), (vx: value), (b: tree)), (_: tree)) ->
                 begin 
                    match (col2: color) with
                    | Black -> Node (Black, l, k, v, r)
                    | Red -> 
                        let (bl_node1: tree) = Node (Black, a, kx, vx, b) in
                        let (bl_node2: tree) = Node (Black, c, k, v, r) in 
                        Node (Red, bl_node1, ky, vy, bl_node2)
                 end 
            | (Red, (_: tree), Node ((col3: color), (b: tree), (ky2: key), (vy2: value), (c2:tree))) ->
                begin
                    match (col3: color) with
                    | Black -> Node (Black, l, k, v, r)
                    | Red ->  
                        let (bl_node1: tree) = Node (Black, ll, ky, vy, b) in
                        let (bl_node2: tree) = Node (Black, c2, k, v, r) in 
                        Node (Red, bl_node1, ky2, vy2, bl_node2)
                end
            | ((_: color), (_: tree), (_: tree)) -> Node (Black, l, k, v, r)
        end
    | (_: tree) -> Node (Black, l, k, v, r)
(* @ result = lbalance l k v r
    requires lt_tree k l /\ gt_tree k r /\ bst l /\ bst r
    ensures bst result /\
      (forall n : int. almost_rbtree n l -> rbtree n r -> rbtree (n+1) result) /\
      forall k':key, v':value.
        memt result k' v' <->
        if k' = k then v' = v else (memt l k' v' \/ memt r k' v') *)

let rbalance (l : tree) (k : key) (v : value) (r : tree) : tree= 
    match (r: tree) with
    | Node ((col: color), (rl: tree), (kz: key), (vz: value), (d: tree)) -> 
        begin 
            match (col: color), (rl: tree), (d: tree) with
            | (Black, (_: tree), (_: tree)) -> Node (Black, l, k, v, r)
            | (Red, Node ((col2: color), (b: tree), (ky: key), (vy: value), (c: tree)), (_: tree)) ->
                 begin 
                    match (col2: color) with
                    | Black -> Node (Black, l, k, v, r)
                    | Red -> 
                        let (bl_node1: tree) = Node (Black, l, k, v, b) in
                        let (bl_node2: tree) = Node (Black, c, kz, vz, d) in 
                        Node (Red, bl_node1, ky, vy, bl_node2)
                 end 
            | (Red, (_: tree), Node ((col3: color), (c: tree), (kz2: key), (vz2: value), (d2:tree))) ->
                begin
                    match (col3: color) with
                    | Black -> Node (Black, l, k, v, r)
                    | Red ->  
                        let (bl_node1: tree) = Node (Black, l, k, v, rl) in
                        let (bl_node2: tree) = Node (Black, c, kz2, vz2, d2) in 
                        Node (Red, bl_node1, kz, vz, bl_node2)
                end
            | ((_: color), (_: tree), (_: tree)) -> Node (Black, l, k, v, r)
        end
    | (_: tree) -> Node (Black, l, k, v, r)
(* @ result = rbalance l k v r
    requires lt_tree k l /\ gt_tree k r /\ bst l /\ bst r
    ensures bst result /\
      (forall n : int. almost_rbtree n r -> rbtree n l -> rbtree (n+1) result)
      /\
      forall k':key, v':value.
        memt result k' v' <->
        if k' = k then v' = v else (memt l k' v' \/ memt r k' v') *)

let rec insert (t : tree) (k : key) (v : value) : tree = 
    match (t: tree) with
    | Leaf -> Node (Red, Leaf, k, v, Leaf)
    | Node ((cl: color), (l: tree), (k': key), (v':value), (r:tree)) 
        [@gospel {|
                requires bst t /\ exists n: int. rbtree n t
                ensures bst result /\
                    (forall n : int. rbtree n t -> almost_rbtree n result /\
                        (is_not_red t -> rbtree n result)) /\
                    memt result k v /\
                    forall k':key, v':value.
                        memt result k' v' <-> if k' = k then v' = v else memt t k' v'|}] ->
        begin 
            match (cl:color) with
            | Red -> 
                if k < k' then 
                    let (o1: tree) = insert l k v in
                    Node (Red, o1, k', v', r)
                else if k' < k then 
                    let (o2: tree) = insert r k v in
                    Node (Red, l, k, v', o2)
                else Node (Red, l, k', v, r)
            | Black ->
                if k < k' then 
                    let (o1: tree) = insert l k v in
                    lbalance o1 k' v' r
                else if k' < k then 
                    let (o2: tree) = insert r k v in
                    rbalance l k' v' o2
                else Node (Black, l, k', v, r)
        end 
(* @ result = insert t k v
    requires bst t /\ exists n: int. rbtree n t
    variant t
    ensures bst result /\
        (forall n : int. rbtree n t -> almost_rbtree n result /\
            (is_not_red t -> rbtree n result)) /\
        memt result k v /\
        forall k':key, v':value.
            memt result k' v' <-> if k' = k then v' = v else memt t k' v' *)

let add (t : tree) (k : key) (v : value) : tree = 
    let (o1: tree) = insert t k v in
    match (o1: tree) with
    | Leaf -> assert false
    | Node ((_: color), (l: tree), (k': key), (v': value), (r: tree)) -> Node (Black, l, k', v', r)  
(* @ result = add t k v
    requires bst t /\ exists n:int. rbtree n t
    ensures bst result /\ (exists n:int. rbtree n result) /\
        memt result k v /\
        forall k':key, v':value.
        memt result k' v' <-> if k' = k then v' = v else memt t k' v' *)
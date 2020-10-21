module type PRE_ORD = sig
  type t

  (*@ function le : t -> t -> bool *)

  (*@ axiom reflexive : forall x. le x x *)
  (*@ axiom total     : forall x y. le x y \/ le y x *)
  (*@ axiom transitive: forall x y z. le x y -> le y z -> le x z *)

  val leq : t -> t -> bool
  (*@ b = leq x y
        ensures b <-> le x y *)
end

module Make (E: PRE_ORD) = struct

  type elt = E.t

  type tree = T of E.t * tree list

  let [@logic] [@ghost] le_tree e = function T (x, _) -> E.leq e x

  let [@logic] [@ghost] rec le_tree_list e = function
    | [] -> true
    | t :: r -> le_tree e t && le_tree_list e r

  (*@ lemma le_roots_trans: forall x y l.
        E.le x y -> le_tree_list y l -> le_tree_list x l *)

  (*@ function occ_list (x: elt) (l: tree list) : integer *)

  (*@ function occ (x: elt) (t: tree) : integer = match t with
        | T y l -> occ_list x l + (if x = y then 1 else 0) *)

  (*@ axiom occ_list_def: forall x l. match l with
        | [] -> occ_list x l = 0
        | t :: r -> occ_list x l = occ x t + occ_list x r *)

  (* @ lemma occ_nonneg: forall x t. occ x t >= 0 *)

  (* @ lemma occ_list_nonneg: forall x l. occ_list x l >= 0 *)

  let [@lemma] rec occ_nonneg = function
    | T (_, l) -> occ_list_nonneg l
  (*@ occ_nonneg param
        variant param
        ensures forall x. occ x param >= 0 *)
  and occ_list_nonneg = function
    | [] -> ()
    | t :: r -> occ_nonneg t; occ_list_nonneg r
  (*@ occ_list_nonneg param
        variant param
        ensures forall x. occ_list x param >= 0 *)

  (*@ predicate mem_tree (x: elt) (t: tree) = occ x t > 0 *)

  (*@ predicate mem_tree_list (x: elt) (l: tree list) = occ_list x l > 0 *)

  (*@ predicate is_minimum_tree (x: elt) (t: tree) =
        mem_tree x t && forall e. mem_tree e t -> E.le x e *)

  (*@ function minimum_tree (t: tree) : elt = match t with T x _ -> x *)

  let [@logic] [@ghost] rec heap_tree = function
    | T (x, l) -> le_tree_list x l && heap_tree_list l
  and [@logic] [@ghost] heap_tree_list = function
    | [] -> true
    | t :: r -> heap_tree t && heap_tree_list r

  type t = E | N of tree

  let [@logic] rec size  = function E -> 0 | N t -> size_tree t
  and [@logic] size_tree = function T (_, l) -> 1 + size_list_tree l
  and [@logic] size_list_tree = function
    | [] -> 0
    | t :: r -> size_tree t + size_list_tree r

  let [@lemma] rec size_nonneg = function E -> () | N t -> size_tree_nonneg t
  (*@ size_nonneg param
        variant param
        ensures size param >= 0 *)
  and [@lemma] size_tree_nonneg = function T (_, l) -> size_tree_list_nonneg l
  (*@ size_tree_nonneg param
        variant param
        ensures size_tree param >= 0 *)
  and [@lemma] size_tree_list_nonneg = function
    | [] -> ()
    | t :: r -> size_tree_nonneg t; size_tree_list_nonneg r
  (*@ size_tree_list_nonneg param
        variant param
        ensures size_list_tree param >= 0 *)

  (*@ lemma size_empty: forall t. size t = 0 <-> t = E *)

  (*@ predicate le_root (e: elt) (t: t) = match t with
        | E -> true
        | N tree -> le_tree e tree *)

  (*@ lemma le_root_trans: forall x y t.
        E.le x y -> le_root y t -> le_root x t *)

  (*@ function occ_t (x: elt) (tree: t) : integer = match tree with
        | E -> 0
        | N t -> occ x t *)

  (*@ lemma occ_t_nonneg: forall x t. occ_t x t >= 0 *)

  (*@ predicate mem (x: elt) (t: t) = occ_t x t > 0 *)

  (*@ predicate is_minimum (x: elt) (t: t) =
        mem x t && forall e. mem e t -> E.le x e *)

  (*@ function minimum (t: t) : elt *)
  (*@ axiom minimum_def: forall t. minimum (N t) = minimum_tree t *)

  (*@ predicate heap (t: t) = match t with
        | E -> true
        | N t -> heap_tree t *)

  let [@lemma] rec heap_mem_le = function
    | E -> ()
    | N t -> tree_mem_le t
  (*@ heap_mem_le param
        requires heap param
        variant  param
        ensures  forall x. le_root x param -> forall y. mem y param ->
                   E.le x y *)
  and tree_mem_le = function T (_, l) -> tree_list_mem_le l
  (*@ tree_mem_le param
        requires heap_tree param
        variant  param
        ensures  forall x. le_tree x param -> forall y. mem_tree y param ->
                   E.le x y *)
  and tree_list_mem_le = function
    | [] -> ()
    | x :: r -> tree_mem_le x; tree_list_mem_le r
  (*@ tree_list_mem_le param
        requires heap_tree_list param
        variant  param
        ensures  forall x. le_tree_list x param ->
                   forall y. mem_tree_list y param -> E.le x y *)

  let [@lemma] root_is_minimum = function
    | E -> assert false
    | N _ -> ()
  (*@ root_is_minimum param
        requires param <> E
        requires heap param
        ensures  is_minimum (minimum param) param *)

  let [@logic] is_empty = function
    | E -> true
    | N _ -> false
  (*@ b = is_empty param
        ensures b <-> size param = 0 *)

  exception Empty

  let find_min_exn = function
    | E -> raise Empty
    | N (T (x, _)) -> x
  (*@ r = find_min_exn param
        requires heap param
        raises   Empty -> is_empty param
        ensures  r = minimum param *)

  let merge t1 t2 = match t1, t2 with
    | E, t | t, E -> t
    | N (T (x, l1)), N (T (y, l2)) ->
        if E.leq x y then N (T (x, (T (y, l2)) :: l1))
        else N (T (y, (T (x, l1) :: l2)))
  (*@ t = merge t1 t2
        requires heap t1 && heap t2
        ensures  heap t
        ensures  size t = size t1 + size t2
        ensures  forall x. occ_t x t = occ_t x t1 + occ_t x t2 *)

  let add x t =
    merge (N (T (x, []))) t
  (*@ h = add x t
        requires heap t
        ensures  heap h
        ensures  size h = size t + 1
        ensures  occ_t x h = occ_t x t + 1
        ensures  forall y. x <> y -> occ_t y h = occ_t y t *)

  let rec merge_list = function
    | [] -> E
    | [t] -> N t
    | t1 :: t2 :: r ->
        merge (merge (N t1) (N t2)) (merge_list r)
  (*@ t = merge_list param
        requires heap_tree_list param
        variant  List.length param
        ensures  heap t
        ensures  size t = size_list_tree param
        ensures  forall x. occ_t x t = occ_list x param *)

  let delete_min_exn = function
    | E -> raise Empty
    | N (T (_, l)) -> merge_list l
  (*@ t = delete_min_exn param
        requires heap param
        raises   Empty -> is_empty param
        ensures  heap t
        ensures  size t + 1 = size param
        ensures  occ_t (minimum param) t + 1 = occ_t (minimum param) param
        ensures  forall x. x <> minimum param -> occ_t x param = occ_t x t *)
end

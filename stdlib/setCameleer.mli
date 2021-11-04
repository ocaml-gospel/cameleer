module Set : sig
  (*@ type 'a fset *)

  (*@ predicate mem (x: 'a) (s: 'a fset) (* = s.to_map[x] *) *)

  (** equality *)
  (*@ predicate (==) (s1 s2: 'a fset) = forall x: 'a. mem x s1 <-> mem x s2 *)

  (*@ lemma extensionality:
        forall s1 s2: 'a fset. s1 == s2 -> s1 = s2 *)

  (** inclusion *)
  (*@ predicate subset (s1 s2: 'a fset) = forall x : 'a. mem x s1 -> mem x s2 *)

  (*@ lemma subset_refl:
        forall s: 'a fset. subset s s *)

  (*@ lemma subset_trans:
      forall s1 s2 s3: 'a fset. subset s1 s2 -> subset s2 s3 -> subset s1 s3 *)

  (** empty set *)
  (*@ predicate is_empty (s: 'a fset) = forall x: 'a. not (mem x s) *)

  (*@ function empty: 'a fset *)

  (*@  axiom is_empty_empty: is_empty (empty: 'a fset) *)

  (*@ lemma empty_is_empty:
        forall s: 'a fset. is_empty s -> s = empty *)

  (** addition *)
  (*@ function add (x: 'a) (s: 'a fset) : 'a fset *)

  (*@ axiom add_def: forall x: 'a, s: 'a fset, y: 'a.
        mem y (add x s) <-> (mem y s \/ y = x) *)

  (*@ lemma add_comm: forall x y: 'a, s: 'a fset.
        add x (add y s) = add y (add x s) *)

  (*@ function singleton (x: 'a): 'a fset = add x empty *)

  (*@ lemma mem_singleton:
        forall x, y: 'a. mem y (singleton x) -> y = x *)

  (** removal *)

  (*@ function remove (x: 'a) (s: 'a fset) : 'a fset *)
  (*@ axiom remove_def: forall x: 'a, s: 'a fset, y: 'a.
      mem y (remove x s) <-> (mem y s /\ y <> x) *)

  (*@ lemma add_remove:
        forall x: 'a, s: 'a fset. mem x s -> add x (remove x s) = s *)

  (*@ lemma remove_add:
        forall x: 'a, s: 'a fset. remove x (add x s) = remove x s *)

  (*@ lemma subset_remove:
        forall x: 'a, s: 'a fset. subset (remove x s) s *)

  (** union *)

  (*@ function union (s1 s2: 'a fset): 'a fset *)
  (*@ axiom union_def: forall s1 s2: 'a fset, x: 'a.
        mem x (union s1 s2) <-> mem x s1 \/ mem x s2 *)

  (*@ lemma subset_union_1:
        forall s1 s2: 'a fset. subset s1 (union s1 s2) *)
  (*@ lemma subset_union_2:
        forall s1 s2: 'a fset. subset s2 (union s1 s2) *)

  (*@ lemma union_add_comm1: forall x: 'a, s1 s2: 'a fset.
        add x (union s1 s2) = union (add x s1) s2 *)

  (*@ lemma union_add_comm2: forall x: 'a, s1 s2: 'a fset.
        add x (union s1 s2) = union s1 (add x s2) *)

  (** intersection *)

  (*@ function inter (s1 s2: 'a fset): 'a fset *)
  (*@ axiom inter_def: forall s1 s2: 'a fset, x: 'a.
        mem x (inter s1 s2) <-> mem x s1 /\ mem x s2 *)

  (*@ lemma subset_inter_1:
        forall s1 s2: 'a fset. subset (inter s1 s2) s1 *)
  (*@ lemma subset_inter_2:
        forall s1 s2: 'a fset. subset (inter s1 s2) s2 *)

  (** difference *)

  (*@ function diff (s1 s2: 'a fset): 'a fset *)
  (*@ axiom diff_def: forall s1 s2: 'a fset, x: 'a.
        mem x (diff s1 s2) <-> mem x s1 /\ not (mem x s2) *)

  (*@ lemma subset_diff:
        forall s1 s2: 'a fset. subset (diff s1 s2) s1 *)

  (** arbitrary element *)
  (*@ function pick (s: 'a fset): 'a *)

  (*@ axiom pick_def: forall s: 'a fset. not (is_empty s) -> mem (pick s) s *)

  (** disjoint sets *)
  (*@ predicate disjoint (s1 s2: 'a fset) =
        forall x. not (mem x s1) \/ not (mem x s2) *)

  (*@ lemma disjoint_inter_empty:
        forall s1 s2: 'a fset. disjoint s1 s2 <-> is_empty (inter s1 s2) *)

  (*@ lemma disjoint_diff_eq:
        forall s1 s2: 'a fset. disjoint s1 s2 <-> diff s1 s2 = s1 *)

  (*@ lemma disjoint_diff_s2:
        forall s1 s2: 'a fset. disjoint (diff s1 s2) s2 *)

  (** `{ x | x in s /\ p x }` *)

  (*@ function filter (s: 'a fset) (p: 'a -> bool) : 'a fset *)
  (*@ axiom filter_def: forall s: 'a fset, p: ('a -> bool), x: 'a.
        mem x (filter s p) <-> mem x s /\ p x *)

  (*@ lemma subset_filter:
        forall s: 'a fset, p: ('a -> bool). subset (filter s p) s *)

  (** `{ f x | x in U }` *)

  (*@ function map (f: 'a -> 'b) (u: 'a fset) : 'b fset *)
  (*@ axiom map_def:
        forall f: ('a -> 'b), u: 'a fset, y: 'b.
        mem y (map f u) <-> exists x: 'a. mem x u /\ y = f x *)

  (*@ lemma mem_map:
        forall f: ('a -> 'b), u: 'a fset.
        forall x: 'a. mem x u -> mem (f x) (map f u) *)

  (** cardinal *)
  (*@ function cardinal (s: 'a fset) : integer *)

  (*@ axiom cardinal_nonneg:
        forall s: 'a fset. cardinal s >= 0 *)

  (*@ axiom cardinal_empty:
        forall s: 'a fset. is_empty s <-> cardinal s = 0 *)

  (*@ axiom cardinal_add:
        forall x: 'a. forall s: 'a fset.
        if mem x s then cardinal (add x s) = cardinal s
                   else cardinal (add x s) = cardinal s + 1 *)

  (*@ axiom cardinal_remove:
        forall x: 'a. forall s: 'a fset.
        if mem x s then cardinal (remove x s) = cardinal s - 1
                   else cardinal (remove x s) = cardinal s *)

  (*@ axiom cardinal_subset:
        forall s1 s2: 'a fset.
        subset s1 s2 -> cardinal s1 <= cardinal s2 *)

  (*@ lemma subset_eq:
       forall s1 s2: 'a fset.
        subset s1 s2 -> cardinal s1 = cardinal s2 -> s1 = s2 *)

  (*@ lemma cardinal1:
        forall s: 'a fset. cardinal s = 1 ->
        forall x: 'a. mem x s -> x = pick s *)

  (*@ axiom cardinal_union:
        forall s1 s2: 'a fset.
        cardinal (union s1 s2)
      = cardinal s1 + cardinal s2 - cardinal (inter s1 s2) *)

  (*@ lemma cardinal_inter_disjoint:
        forall s1 s2: 'a fset. disjoint s1 s2 -> cardinal (inter s1 s2) = 0 *)

  (*@ axiom cardinal_diff:
        forall s1 s2: 'a fset.
        cardinal (diff s1 s2) = cardinal s1 - cardinal (inter s1 s2) *)

  (*@ lemma cardinal_filter:
        forall s: 'a fset, p: ('a -> bool).
        cardinal (filter s p) <= cardinal s *)

  (*@ lemma cardinal_map:
        forall f: ('a -> 'b), s: 'a fset.
        cardinal (map f s) <= cardinal s *)
end

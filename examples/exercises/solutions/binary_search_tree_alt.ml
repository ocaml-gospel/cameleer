module type OrderedType = sig
  type t

  val[@logic] compare : t -> t -> int
  (*@ axiom is_pre_order: is_pre_order compare *)
end


module Make (Ord: OrderedType) = struct
  type elt = Ord.t

  type t = E | T of t * elt * t

  (*@ function occ (x: elt) (t: t) : integer = match t with
        | E -> 0
        | T l v r ->
            occ x l + occ x r + (if Ord.compare x v = 0 then 1 else 0) *)

  (*@ lemma occ_nonneg: forall x: elt, t: t. occ x t >= 0 *)

  (*@ predicate mem (x: elt) (t: t) = occ x t > 0 *)

  (*@ predicate bst (t: t) = match t with
        | E -> true
        | T l v r ->
            (forall lv. mem lv l -> Ord.compare lv v < 0) &&
            (forall rv. mem rv r -> Ord.compare rv v > 0) &&
            bst l && bst r *)

  let empty = E
  (*@ r = empty
        ensures forall x. occ x r = 0
        ensures bst r *)

  let rec insert x = function
    | E -> T (E, x, E)
    | T (l, y, r) ->
        if Ord.compare x y = 0 then T (l, y, r)
        else if Ord.compare x y < 0 then T (insert x l, y, r)
        else T (l, y, insert x r)
  (*@ t = insert x param
        requires bst param
        variant  param
        ensures  forall y. y <> x -> occ y t = occ y param
        ensures  occ x t = occ x param || occ x t = 1 + occ x param
        ensures  bst t *)

  let rec mem x = function
    | E -> false
    | T (l, v, r) ->
        let c = Ord.compare x v in
        c = 0 || mem x (if c < 0 then l else r)
  (*@ b = mem x param
        requires bst param
        variant  param
        ensures  b <-> mem x param *)

  (*@ function min (t: t) : elt *)
  (*@ axiom is_min_empty: forall x r. min (T E x r) = x *)
  (*@ axiom is_min_left: forall l x r. l <> E -> min (T l x r) = min l *)

  let[@lemma] rec occ_min (t: t) = match t with
    | E -> assert false
    | T (E, _, _) -> ()
    | T (l, _, r) -> occ_min l
  (*@ occ_min t
        requires t <> E
        requires bst t
        variant  t
        ensures  occ (min t) t = 1 *)

  let rec remove_min = function
    | E -> assert false
    | T (E, v, r) -> v, r
    | T (l, v, r) -> let m, l = remove_min l in
        m, T (l, v, r)
  (*@ m, r = remove_min t
        requires t <> E
        requires bst t
        variant  t
        ensures  bst r
        ensures  forall x. x <> min t -> occ x t = occ x r
        ensures  occ (min t) r = 0
        ensures  m = min t *)

  let rec remove x = function
    | E -> E
    | T (l, v, r) ->
        if Ord.compare x v < 0 then T (remove x l, v, r)
        else if Ord.compare x v > 0 then T (l, v, remove x r)
        else
          match r with
          | E -> l
          | r -> let min_elt, new_r = remove_min r in
              T (l, min_elt, new_r)
   (*@ r = remove x t
         requires bst t
         variant  t
         ensures  bst t
         ensures  forall y. y <> x -> occ y r = occ y t
         ensures  occ x r = 0 *)

end

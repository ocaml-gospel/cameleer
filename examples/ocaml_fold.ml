(*@ open Seq *)

(*@ function seq_of_list (l: 'a list): 'a seq = match l with
      | [] -> empty
      | x :: r -> cons x (seq_of_list r) *)
(*@ coercion *)

(*@ lemma seq_of_list_append: forall l1 l2: 'a list.
      seq_of_list (List.append l1 l2) == seq_of_list l1 ++ seq_of_list l2 *)

(*@ predicate permitted (v: 'a seq) (s: 'a seq) =
      length v <= length s &&
      forall i. 0 <= i < length v -> v[i] = s[i] *)

(*@ predicate complete (l: 'a seq) (v: 'a seq) =
      length v = length l *)

let rec fold_left (v : 'a list) ((inv : 'b -> 'a seq -> bool) [@ghost])
    ((l0 : 'a list) [@ghost]) f (acc : 'b) = function
  | [] -> (acc, v)
  | x :: l -> fold_left (v @ [ x ]) inv l0 f (f acc x) l
(*@ r, vres = fold_left v inv l0 f acc param
      requires permitted v l0
      requires l0 == v ++ param
      requires inv acc v
      requires forall v acc x.
                 inv acc v -> permitted (snoc v x) l0 -> not (complete v l0) ->
                 inv (f acc x) (snoc v x)
      variant  param
      ensures  permitted vres l0 && vres == v ++ param && inv r vres *)

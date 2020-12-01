(*@ open Sum *)
(*@ open Sequence *)

module type Cursor = sig
  type 'a t
  (*@ mutable model visited: 'a sequence *)

  (*@ predicate permitted (t: 'a t) *)
  (*@ axiom permitted_empty: forall t: 'a t. t.visited = empty -> permitted t *)

  (*@ predicate complete (t: 'a t) *)

  val next : 'a t -> 'a
  (*@ r = next c
        requires permitted c && not (complete c)
        modifies c.visited
        ensures  c.visited = snoc (old c).visited r
        ensures  permitted c *)

  val has_next : 'a t -> bool
  (*@ b = has_next c
        requires permitted c
        ensures  b <-> not (complete c) *)
end

module CursorList : Cursor = struct
  (*@ function seq_of_list (l: 'a list): 'a sequence = match l with
      | [] -> empty
      | x :: r -> cons x (seq_of_list r) *)

  type 'a t = {
    mutable visited   : 'a sequence [@ghost];
            collection: 'a list     [@ghost];
    mutable to_visit  : 'a list;
  } (*@ invariant seq_of_list collection = visited ++ seq_of_list to_visit *)

  (*@ lemma seq_of_list_append: forall l1 l2: 'a list.
        seq_of_list (List.append l1 l2) == seq_of_list l1 ++ seq_of_list l2 *)

  (*@ lemma seq_of_list_length: forall l: 'a list.
        length (seq_of_list l) = List.length l *)

  (*@ predicate permitted (t: 'a t) =
        length t.visited <= length (seq_of_list t.collection) &&
        forall i. 0 <= i < length t.visited ->
          t.visited[i] = (seq_of_list t.collection)[i] *)

  (*@ predicate complete (t: 'a t) =
        length t.visited = length (seq_of_list t.collection) *)

  let next c = match c.to_visit with
    | [] -> assert false
    | x :: r ->
        c.visited <- snoc c.visited x; c.to_visit <- r;
        x
  (*@ r = next c
        requires permitted c && not (complete c)
        ensures  permitted c
        ensures  c.visited = snoc (old c).visited r *)

  let has_next c = match c.to_visit with
    | [] -> false
    | _ -> true
  (*@ b = has_next c
        requires permitted c
        ensures  b <-> not (complete c) *)

  let create l =
    { visited = empty; collection = l; to_visit = l }
  (*@ r = create l
        ensures r.visited = empty
        ensures r.collection = l *)
end

let sum_cursor l =
  let s = ref 0 in
  let c = CursorList.create l in
  while CursorList.has_next c do
    (*@ variant length (seq_of_list l) - length c.visited *)
    (*@ invariant permitted c *)
    (*@ invariant !s = logic_sum (fun i -> c.visited[i]) 0 (length c.visited) *)
    let x = CursorList.next c in
    s := !s + x
  done;
  !s
(*@ r = sum_cursor l
      ensures r = logic_sum (fun i -> (seq_of_list l)[i]) 0 (List.length l) *)
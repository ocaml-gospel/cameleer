(*@ open Sum *)
(*@ open Seq *)

module type Cursor = sig
  type 'a t
  (*@ mutable model visited: 'a seq *)

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

module CursorList (* : Cursor *) = struct
  (*@ function seq_of_list (l: 'a list): 'a seq = match l with
      | [] -> empty
      | x :: r -> cons x (seq_of_list r) *)

  type 'a t = {
    mutable visited : 'a seq; [@ghost]
    collection : 'a list; [@ghost]
    mutable to_visit : 'a list;
  }
  (*@ invariant seq_of_list collection = visited ++ seq_of_list to_visit *)

  (*@ lemma seq_of_list_append: forall l1 l2: 'a list.
        seq_of_list (List.append l1 l2) == seq_of_list l1 ++ seq_of_list l2 *)

  (*@ lemma seq_of_list_length: forall l: 'a list.
        length (seq_of_list l) = List.length l *)

  (*@ lemma seq_of_list_mem: forall l: 'a list, x: 'a.
        List.mem x l <-> Seq.mem x (seq_of_list l) *)

  (*@ predicate permitted (t: 'a t) =
        length t.visited <= length (seq_of_list t.collection) &&
        forall i. 0 <= i < length t.visited ->
          t.visited[i] = (seq_of_list t.collection)[i] *)

  (*@ predicate complete (t: 'a t) =
        length t.visited = length (seq_of_list t.collection) *)

  let next c =
    match c.to_visit with
    | [] -> assert false
    | x :: r ->
        c.visited <- snoc c.visited x;
        c.to_visit <- r;
        x
  (*@ r = next c
        requires permitted c && not (complete c)
        ensures  permitted c
        ensures  c.visited = snoc (old c).visited r *)

  let has_next c = match c.to_visit with [] -> false | _ -> true
  (*@ b = has_next c
        requires permitted c
        ensures  b <-> not (complete c) *)

  let create l = { visited = empty; collection = l; to_visit = l }
  (*@ r = create l
        ensures r.visited = empty
        ensures r.collection = l *)
end

let sum_cursor l =
  let s = ref 0 in
  let c = CursorList.create l in
  while CursorList.has_next c do
    (*@ variant length (seq_of_list l) - length c.visited
        invariant permitted c
        invariant !s = sum (fun i -> c.visited[i]) 0 (length c.visited) *)
    let x = CursorList.next c in
    s := !s + x
  done;
  !s
(*@ r = sum_cursor l
      ensures r = sum (fun i -> (seq_of_list l)[i]) 0 (List.length l) *)

module Mem (Eq : sig
  type elt

  val eq : elt -> elt -> bool
  (*@ b = eq x y
        ensures b <-> x = y *)
end) =
struct
  let mem_cursor l x =
    let c = CursorList.create l in
    let exception Found in
    try
      while CursorList.has_next c do
        (*@ variant length (seq_of_list l) - length c.visited
            invariant permitted c
            invariant forall i. 0 <= i < length c.visited -> c.visited[i] <> x *)
        if Eq.eq (CursorList.next c) x then raise Found
      done;
      false
    with Found -> true
  (*@ b = mem_cursor l x
        ensures b <-> List.mem x l *)
end

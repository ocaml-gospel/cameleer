(* Decomposition of the initial list in runs. *)

(*@ open Permut *)

type 'a run = Asc of 'a list | Desc of 'a list

(*@ function get_run (r: 'a run) : 'a list = match r with Asc l | Desc l -> l *)

let[@logic] rec sorted_list compare = function
  | [] | [ _ ] -> true
  | x :: y :: r -> compare x y <= 0 && sorted_list compare (y :: r)
(*@ sorted_list compare l
      requires is_pre_order compare
      variant  l *)

type 'a cmp = 'a -> 'a -> int

let[@lemma] rec sorted_mem (cmp : 'a cmp) (x : 'a) (l : 'a list) =
  match l with [] -> () | [ _ ] -> () | y1 :: ys -> sorted_mem cmp y1 ys
(*@ aux cmp x l
      requires is_pre_order cmp
      requires sorted_list cmp (x :: l)
      ensures  forall e: 'a. List.mem e l -> cmp x e <= 0 *)

(*@ lemma sorted_cons: forall x l, cmp: 'a cmp.
      is_pre_order cmp ->
      ((forall y. List.mem y l -> cmp x y <= 0) /\ sorted_list cmp l <->
      sorted_list cmp (x :: l)) *)

(*@ lemma sorted_append: forall l1 l2, cmp: 'a cmp.
      is_pre_order cmp ->
      ((sorted_list cmp l1 && sorted_list cmp l2 &&
        (forall x y. List.mem x l1 -> List.mem y l2 -> cmp x y <= 0)) <->
      sorted_list cmp (l1 ++ l2)) *)

let[@logic] rec sorted_list_rev compare = function
  | [] | [ _ ] -> true
  | x :: y :: r -> compare x y >= 0 && sorted_list_rev compare (y :: r)
(*@ sorted_list_rev compare l
      requires is_pre_order compare
      variant  l *)

let[@lemma] rec sorted_rev_mem (cmp : 'a cmp) (x : 'a) (l : 'a list) =
  match l with [] -> () | [ _ ] -> () | y1 :: ys -> sorted_rev_mem cmp y1 ys
(*@ aux cmp x l
      requires is_pre_order cmp
      requires sorted_list_rev cmp (x :: l)
      ensures  forall e: 'a. List.mem e l -> cmp x e >= 0 *)

(*@ lemma sorted_rev_sorted: forall l, cmp: 'a cmp.
      is_pre_order cmp ->
      (sorted_list cmp l <-> sorted_list_rev cmp (List.rev l)) *)

(*@ predicate wf_run (cmp: 'a -> 'a -> int) (r: 'a run) =
      is_pre_order cmp -> match r with
        | Asc l -> sorted_list cmp l      && l <> []
        | Desc l -> sorted_list_rev cmp l && l <> [] *)

(*@ predicate wf_run_len (cmp: 'a -> 'a -> int) (n: int) (r: 'a run) =
      wf_run cmp r && List.length (get_run r) = n *)

let rec next_asc_run_rev compare revrun last len = function
  | x :: xs ->
      if compare last x <= 0 then
        next_asc_run_rev compare (last :: revrun) x (len + 1) xs
      else
        let xs = x :: xs in
        (len, Desc (last :: revrun), xs)
  | xs -> (len, Desc (last :: revrun), xs)
(*@ next_asc_run_rev compare revrun last len l
      requires is_pre_order compare
      variant  l *)

let rec next_desc_run_rev compare (revrun : 'a list) last len = function
  | x :: xs ->
      if compare last x > 0 then
        next_desc_run_rev compare (last :: revrun) x (len + 1) xs
      else
        let xs = x :: xs in
        (len, Asc (last :: revrun), xs)
  | xs -> (len, Asc (last :: revrun), xs)
(*@ lenr, run, xs = next_desc_run_rev compare revrun last len l
      requires is_pre_order compare
      requires sorted_list compare revrun
      requires forall x. List.mem x revrun -> compare x last > 0
      requires exists l0. l0 = List.rev_append revrun (last :: l)
      requires 1 + List.length revrun = len
      ensures  wf_run compare run
      ensures  match run with
               | Desc _ -> false
               | Asc run -> List.length run = lenr &&
                            exists l0. l0 = List.rev_append run xs
      variant  l *)

let next_run compare xs =
  match xs with
  | [] -> None
  | [ _ ] -> Some (1, Asc xs, [])
  | x1 :: x2 :: xs ->
      if compare x1 x2 <= 0 then Some (next_asc_run_rev compare [ x1 ] x2 2 xs)
      else Some (next_desc_run_rev compare [ x1 ] x2 2 xs)
(*@ r = next_run compare xs
      requires is_pre_order compare
      ensures  xs = [] -> r = None
      ensures  match r with
               | None -> xs = []
               | Some (len, run, rem) ->
                   wf_run compare run &&
                   let l = get_run run in
                   List.length l = len &&
                   xs = l @ rem *)

(* Merge function (as in MergeSort) *)

let merge_asc_rev compare xs ys =
  let rec merge_asc_rev revacc xs ys =
    match (xs, ys) with
    | [], zs | zs, [] -> List.rev_append zs revacc
    | x :: xs', y :: ys' ->
        if compare x y <= 0 then merge_asc_rev (x :: revacc) xs' ys
        else merge_asc_rev (y :: revacc) xs ys'
    (*@ merge_asc_rev revacc xs ys
          requires is_pre_order compare
          requires sorted_list compare xs && sorted_list compare ys
          requires sorted_list compare (List.rev revacc)
          requires forall x y. List.mem x revacc -> List.mem y xs ->
            compare x y <= 0
          requires forall x y. List.mem x revacc -> List.mem y ys ->
            compare x y <= 0
          variant  xs, ys *)
  in
  merge_asc_rev [] xs ys
(*@ r = merge_asc_rev compare xs ys
      requires is_pre_order compare
      requires sorted_list compare xs && sorted_list compare ys
      ensures  sorted_list compare (List.rev r) *)

let merge_desc_rev compare =
  let rec merge_desc_rev revacc xs ys =
    match (xs, ys) with
    | [], zs | zs, [] -> List.rev_append zs revacc
    | x :: xs', y :: ys' ->
        if compare x y > 0 then merge_desc_rev (x :: revacc) xs' ys
        else merge_desc_rev (y :: revacc) xs ys'
    (*@ merge_desc_rev revacc xs ys
          variant  xs, ys *)
  in
  merge_desc_rev []

let merge compare n1 n2 r1 r2 =
  let run =
    match (r1, r2) with
    | Asc r1, Asc r2 -> Desc (merge_asc_rev compare r1 r2)
    | Desc r1, Desc r2 -> Asc (merge_desc_rev compare r1 r2)
    | Asc r1, Desc r2 ->
        if n1 < n2 then Asc (merge_desc_rev compare (List.rev r1) r2)
        else Desc (merge_asc_rev compare r1 (List.rev r2))
    | Desc r1, Asc r2 ->
        if n1 < n2 then Desc (merge_asc_rev compare (List.rev r1) r2)
        else Asc (merge_desc_rev compare r1 (List.rev r2))
  in
  (n1 + n2, run)
(*@ (n, r) = merge compare n1 n2 r1 r2
      requires is_pre_order compare
      requires wf_run_len compare n1 r1 && wf_run_len compare n2 r2
      ensures  wf_run_len compare n r *)

type 'a stack = (int * 'a run) list

(*@ predicate wf_stack (cmp: 'a -> 'a -> int) (s: 'a stack) = match s with
      | [] -> true
      | (n, r) :: xs -> wf_run_len cmp n r && wf_stack cmp xs *)

(* The TimSort algorithm. *)

let timsort compare l =
  let merge = merge compare in
  let next_run = next_run compare in

  let rec fetch_next_run remaining stack =
    match next_run remaining with
    | Some (n, r, rem) -> sort rem ((n, r) :: stack)
    | None -> stack
  (*@ r = fetch_next_run remaining stack
        requires wf_stack compare stack
        ensures  wf_stack compare r
        variant  List.length remaining, List.length stack *)
  and sort remaining stack =
    match stack with
    | ((n1, r1) as s1) :: (n2, r2) :: ((n3, r3) :: stack'' as stack') -> (
        if n3 < n1 then sort remaining (s1 :: merge n2 n3 r2 r3 :: stack'')
        else if n2 <= n1 then sort remaining (merge n1 n2 r1 r2 :: stack')
        else if n3 <= n1 + n2 then sort remaining (merge n1 n2 r1 r2 :: stack')
        else
          match stack with
          | (n4, _) :: _ ->
              if n4 <= n3 + n2 then sort remaining (merge n1 n2 r1 r2 :: stack')
              else fetch_next_run remaining stack
          | _ -> fetch_next_run remaining stack)
    | [ (n1, r1); (n2, r2) ] ->
        if n2 <= n1 then sort remaining [ merge n1 n2 r1 r2 ]
        else fetch_next_run remaining stack
    | _ -> fetch_next_run remaining stack
    (*@ r = sort remaining stack
          requires wf_stack compare stack
          ensures  wf_stack compare r
          variant  List.length remaining, List.length stack *)
  in

  let rec finish = function
    | (n1, r1) :: (n2, r2) :: stack -> finish (merge n1 n2 r1 r2 :: stack)
    | [ (_, Asc r) ] -> r
    | [ (_, Desc r) ] -> List.rev r
    | [] -> []
    (*@ r = finish stack
          requires wf_stack compare stack
          ensures  sorted_list compare r
          variant  l *)
  in

  finish (sort l [])
(*@ r = timsort compare l
      requires is_pre_order compare
      ensures  sorted_list compare r *)

type 'a tree = Empty | Tree of 'a tree * 'a  * 'a tree

(*@ function occ (x: int) (t: int tree) : int = 
  match t with
        | Empty -> 0
        | Tree l v r -> (if x = v then 1 else 0) + occ x l + occ x r *)

let [@lemma] rec occ_nonneg (x: int) (t: int tree) =
  match t with
  |Empty -> ()
  |Tree (Empty, _, Empty) -> ()
  |Tree (l, _, r) -> occ_nonneg x l; occ_nonneg x r
(*@ occ_nonneg x t
      ensures 0 <= (occ x t) *)
      
(*@ predicate mem (x: int) (t: int tree) = occ x t > 0 *)
  

(*@ predicate binsearchtree (t: int tree) = match t with
  | Empty -> true
  | Tree l v r ->
    (forall x: int. mem x l -> x < v) &&
    (forall y: int. mem y r -> y > v) &&
     binsearchtree l && binsearchtree r *)
            
            
let rec mem (x: int) (t:int tree): bool = 
  match t with
    |Empty -> false
    |Tree (l, v, r) ->
        if x = v then true else mem x (if x < v then l else r)
  (*@ r = mem x t
        requires binsearchtree t
        variant t
        ensures  r <-> mem x t*)
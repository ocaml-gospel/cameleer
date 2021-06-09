type 'a t = Empty | Node of 'a t * 'a * 'a t

(*@ function inorder (t: 'a t) : 'a list = match t with
      | Empty -> []
      | Node l x r -> (inorder l) @ (x :: (inorder r)) *)

(*@ function size (t: 'a t) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + size l + size r *)

(*@ function height (t: 'a t) : integer = match t with
      | Empty -> 0
      | Node l _ r -> 1 + max (height l) (height r) *)

let[@logic] rec to_list a l u =
  if u <= l then [] else a.(l) :: to_list a (l+1) u
(*@ to_list a l u
      requires l >= 0 /\ u <= Array.length a
      variant  u - l *)

let[@lemma] rec to_list_append (a: 'a array) (l: int) (m: int) (u: int) =
  if l < m then to_list_append a (l+1) m u
(*@ to_list_append a l m u
      requires 0 <= l <= m <= u <= Array.length a
      variant  m - l
      ensures  to_list a l m @ to_list a m u = to_list a l u *)

(*@ open Power *)

let rec tree_of_array_aux a lo hi =
  if lo = hi then
    Empty
  else
    let mid = lo + (hi - lo) / 2 in
    let left = tree_of_array_aux a lo mid in
    let right = tree_of_array_aux a (mid + 1) hi in
    Node (left, a.(mid), right)
(*@ r = tree_of_array_aux a lo hi
      requires 0 <= lo <= hi <= Array.length a
      variant  hi - lo
      ensures  inorder r = to_list a lo hi
      ensures  let n = hi - lo in n = size r &&
               (n > 0 ->
                  let h = height r in
                  2 ^ (h - 1) <= n < 2 ^ h) *)

let rec tree_of_array a =
  tree_of_array_aux a 0 (Array.length a)
(*@ r = tree_of_array a
      ensures inorder r = to_list a 0 (Array.length a)
      ensures size r = Array.length a *)

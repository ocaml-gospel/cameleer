(**************************************************************************)
(*                                                                        *)
(*  VOCaL -- A Verified OCaml Library                                     *)
(*                                                                        *)
(*  Copyright (c) 2020 The VOCaL Project                                  *)
(*                                                                        *)
(*  This software is free software, distributed under the MIT license     *)
(*  (as described in file LICENSE enclosed).                              *)
(**************************************************************************)

type 'a t = {
  dummy: 'a;
  mutable size: int;
  mutable data: ('a array);
  }

let create : type a. ?capacity:int -> dummy:a ->  (a t) =
  fun ?capacity:capacity ~dummy:dummy -> let capacity1 =
                                           match capacity with
                                           | None -> 0 
                                           | Some c -> c in
                                         { dummy = dummy; size = 0 ; data =
                                           Array.make capacity1 dummy }

let make : type a. ?dummy:a -> (int) -> a ->  (a t) =
  fun ?dummy:dummy n x -> let dummy1 =
                            match dummy with
                            | None -> x
                            | Some d -> d in
                          { dummy = dummy1; size = n; data = Array.make n x }

let init : type a. dummy:a -> (int) -> ((int) -> a) ->  (a t) =
  fun ~dummy:dummy n f -> let a = make  n dummy in
                          (let o = n - 1 in let o1 = 0 in
                           for i = o1 to o do (a.data).(i) <- f i done);
                          a

let length : type a. (a t) ->  (int) = fun a -> a.size

let get : type a. (a t) -> (int) ->  a = fun a i1 -> (a.data).(i1)

let set : type a. (a t) -> (int) -> a ->  unit =
  fun a n x -> (a.data).(n) <- x

let unsafe_resize : type a. (a t) -> (int) ->  unit =
  fun a n -> let n_old = Array.length a.data in
             if n <= a.size
             then
               if n < n_old / 4
               then a.data <- Array.sub a.data (0 ) n
               else Array.fill a.data n (a.size - n) a.dummy
             else
               begin
                 if n > n_old
                 then begin
                   let n_div2 = n / 2 in
                   let n' =
                     if n_div2 >= n_old
                     then
                       if Sys.max_array_length  / 2 >= n_div2
                       then n
                       else Sys.max_array_length 
                     else
                       begin
                         if Sys.max_array_length  / 2 >= n_old
                         then 2 * n_old
                         else Sys.max_array_length  end in
                   let a' = Array.make n' a.dummy in
                   Array.blit a.data (0 ) a' (0 ) a.size; a.data <- a' end end;
             a.size <- n

let resize : type a. (a t) -> (int) ->  unit =
  fun a n -> if not (0  <= n && n <= Sys.max_array_length )
             then raise (Invalid_argument "resize");
             unsafe_resize a n

let clear : type a. (a t) ->  unit = fun a -> unsafe_resize a (0 )

let is_empty : type a. (a t) ->  (bool) = fun a -> length a = 0 

let sub : type a. (a t) -> (int) -> (int) ->  (a t) =
  fun a ofs n -> { dummy = a.dummy; size = n; data = Array.sub a.data ofs n }

let fill : type a. (a t) -> (int) -> (int) -> a ->  unit =
  fun a ofs n x -> Array.fill a.data ofs n x

let blit : type a. (a t) -> (int) -> (a t) -> (int) -> (int) ->  unit =
  fun a1 ofs1 a2 ofs2 n -> Array.blit a1.data ofs1 a2.data ofs2 n

let append : type a. (a t) -> (a t) ->  (a t) =
  fun a1 a2 -> let n1 = length a1 in
               let n2 = length a2 in
               let a = make  (n1 + n2) a1.dummy in
               blit a1 (0 ) a (0 ) n1; blit a2 (0 ) a n1 n2; a

let merge_right : type a. (a t) -> (a t) ->  unit =
  fun a1 a2 -> let n1 = length a1 in
               let n2 = length a2 in
               let size = n1 + n2 in
               unsafe_resize a1 size; blit a2 (0 ) a1 n1 n2; clear a2

let copy : type a. (a t) ->  (a t) =
  fun a1 -> { dummy = a1.dummy; size = a1.size; data = Array.copy a1.data }

let push : type a. (a t) -> a ->  unit =
  fun a x -> let n = a.size in unsafe_resize a (n + 1 ); (a.data).(n) <- x

exception Empty

let pop : type a. (a t) ->  a =
  fun a -> let n = length a - 1  in
           if n < 0  then raise Empty;
           let r = (a.data).(n) in unsafe_resize a n; r

let pop_opt : type a. (a t) ->  (a option) =
  fun a -> let n = length a - 1  in
           if n < 0 
           then None 
           else begin let r = (a.data).(n) in unsafe_resize a n; Some r end

let top : type a. (a t) ->  a =
  fun a -> let n = length a in (a.data).(n - 1 )

let top_opt : type a. (a t) ->  (a option) =
  fun a -> let n = length a in
           if n = 0  then None  else Some (a.data).(n - 1 )

let fold_left : type a b. (a t) -> (b -> (a -> b)) -> b ->  b =
  fun a f acc -> let r = ref acc in
                 (let o = length a - 1 in let o1 = 0 in
                  for i1 = o1 to o do r := f !r (get a i1) done);
                 !r

let fold_right : type a b. (a t) -> (a -> (b -> b)) -> b ->  b =
  fun a f acc -> let n = length a in
                 let r = ref acc in
                 (let o = 0 in let o1 = n - 1 in
                  for i2 = o1 downto o do r := f (get a i2) !r done);
                 !r

let map : type a b. dummy:b -> (a t) -> (a -> b) ->  (b t) =
  fun ~dummy:dummy a f -> let n = length a in
                          let a_new = make  n dummy in
                          (let o = n - 1 in let o1 = 0 in
                           for i3 = o1 to o do
                             let x = get a i3 in (a_new.data).(i3) <- f x
                             done);
                          a_new

let mapi : type a b. dummy:b -> (a t) -> ((int) -> (a -> b)) ->  (b t) =
  fun ~dummy:dummy a f -> let n = length a in
                          let a_new = make  n dummy in
                          (let o = n - 1 in let o1 = 0 in
                           for i4 = o1 to o do
                             let x = get a i4 in (a_new.data).(i4) <- f i4 x
                             done);
                          a_new


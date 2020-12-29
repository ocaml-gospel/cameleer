module type System = sig
  type user
  val eq_user : user -> user -> bool
  (*@ b = eq_user x y
        ensures b <-> x = y *)

  type printer
  val eq_printer : printer -> printer -> bool
  (*@ b = eq_printer p1 p2
        ensures b <-> p1 = p2 *)
end

module Printers (S: System) = struct

  (*@ function occ (x: 'a) (l: 'a list) : integer = match l with
        | [] -> 0
        | y :: r -> occ x r + (if x = y then 1 else 0) *)

  (*@ lemma occ_nonneg: forall x: 'a, l: 'a list.
        0 <= occ x l *)

  (*@ lemma occ_sum: forall x: 'a, l1 l2: 'a list.
        occ x (l1 @ l2) = occ x l1 + occ x l2 *)

  (*@ predicate list_set (l: 'a list) =
        forall x. occ x l <= 1 *)

  type t = S.user -> S.printer list

  (*@ predicate single_printer (pp: S.printer list) =
        list_set pp *)

  (*@ predicate inv_single_printer (t: t) =
        forall x. single_printer (t x) *)

  (*@ predicate inv_system (t: t) =
        inv_single_printer t *)

  let rec check_access printer = function
    | [] -> false
    | p :: r -> S.eq_printer printer p || check_access printer r
  (*@ b = check_access printer printer_set
        requires single_printer printer_set
        variant  printer_set
        ensures  b <-> List.mem printer printer_set *)

  let rec check_acess_system user printer (t: t) =
    check_access printer (t user)
  (*@ b = check_acess_system user printer t
        requires inv_system t
        ensures  b <-> List.mem printer (t user) *)

  (*@ predicate user_in_system (u: user) (t: t) =
        not (t u = []) *)

  let rec remove_from_list p = function
    | [] -> []
    | p' :: r -> if S.eq_printer p p' then r else p' :: remove_from_list p r
  (*@ r = remove_from_list p pl
        variant pl
        ensures if not (List.mem p pl) then pl = r
                else exists pp ps. pp @ (p :: ps) = pl && pp @ ps = r *)

  let give_access user printer (t: t) =
    let rec insert_printer p = function
      | [] -> [p]
      | p' :: pp ->
          if S.eq_printer p p' then p' :: pp else p' :: (insert_printer p pp)
    (*@ pr = insert_printer p printer_list
           requires list_set printer_list
           variant  printer_list
           ensures  list_set pr
           ensures  if List.mem p printer_list then pr = printer_list
                    else pr = printer_list @ (p :: []) *)
    in
    fun u -> if S.eq_user u user then insert_printer printer (t user) else t u
  (*@ r = give_access user printer t
        requires inv_system t
        ensures  user_in_system user r
        ensures  inv_system r *)

end

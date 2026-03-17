
open Ml_lang
(* open Term *)

(* exception ConstructorExpected of lsymbol * ty
exception NonExhaustive of pattern list *)

val compile :
  get_constructors:(string -> string list) ->
  mk_case:(atom -> (pattern * 'a) list -> 'a) ->
  mk_let:(binder -> expr -> 'a -> 'a) ->
  atom -> (pattern list * 'a) list -> 'a
  (** [compile get_constructors mk_case mk_let terms branches]
      returns a composition of match- and let-terms equivalent
      to [match terms with branches], where every pattern is
      either a constructor applied to a list of variables, or
      a wildcard pattern.

      Raises [NonExhaustive patterns] where [patterns] is the
      list of non-covered patterns. The check is permissive:
      [match Cons t tl with Cons x xl -> ...] is accepted and
      compiled into [match t, tl with x, xl -> ...]. *)

val compile_pattern : declaration -> declaration

(** Temporary "driver" from GOSPEL symbols into WhyML.

    This is a very simple workaround, in order to support translation of
    existing examples of the VOCaL library. In the future, this should resemble
    the drivers technology of Why3, i.e., one should be able to provide a
    driver file mapping GOSPEL symbols into a corresponding counterpart from the
    Why3 standard library. The translation plugin should then consume such
    file, similarly to how Why3 extraction mechanism deals with drivers. *)

module I  = Gospel.Identifier
module Ty = Gospel.Ttypes
open Gospel.Utils

type syntax_map = string Hstr.t

let driver: syntax_map = Hstr.create 16
let () = List.iter (fun (x, y) -> Hstr.add driver x y)
    Ty.[
      ts_integer.ts_ident.I.id_str, "int";
      "int", "int63";
      "mixfix {}", "empty";
      "mixfix {:_:}", "singleton";
      "[]", "Nil";
      "infix ::", "Cons";
    ]

let query_syntax str =
  Hstr.find_opt driver str

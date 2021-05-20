(** Temporary "driver" from OCaml symbols into WhyML.

    This is a very simple workaround, in order to support translation of very
    simple OCaml programs. In the future, this should resemble the drivers
    technology of Why3, i.e., one should be able to provide a driver file
    mapping OCaml symbols into a corresponding counterpart from the Why3
    standard library. The translation plugin should then consume such file,
    similarly to how Why3 extraction mechanism deals with drivers. *)

open Gospel.Utils

type syntax_map = string Hstr.t

let driver : syntax_map = Hstr.create 16

let () =
  List.iter
    (fun (x, y) -> Hstr.add driver x y)
    [
      ("integer", "int");
      ("int", "int");
      ("+", "infix +");
      ("*", "infix *");
      ("-", "infix -");
      ("/", "infix /");
      ("infix mod", "infix %");
      ("<=", "infix <=");
      (">=", "infix >=");
      ("<", "infix <");
      (">", "infix >");
      ("<>", "infix <>");
      ("=", "infix =");
      (* FIXME: this is only true for integers *)
      ("==", "infix ==");
      (* FIXME: this is only true for integers *)
      ("mixfix {}", "empty");
      ("mixfix {:_:}", "singleton");
      ("mixfix [_]", "mixfix []");
      ("[]", "Nil");
      ("infix ::", "Cons");
      ("::", "Cons");
      (* FIXME: understand why this happens in program symbols *)
      ("infix @", "infix ++");
      ("@", "infix ++");
      ("!", "prefix !");
      (":=", "infix :=");
      ("|>", "infix |>");
      ("<>", "infix ~=");
      ("mixfix ([<-])", "mixfix ([<-])");
      ("~-", "prefix ~-");
    ]

let query_syntax str = Hstr.find_opt driver str

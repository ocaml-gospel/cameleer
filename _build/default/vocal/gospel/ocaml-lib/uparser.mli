
(* The type of tokens. *)

type token = 
  | WITH
  | VARIANT
  | VAL
  | UNDERSCORE
  | UIDENT of (string)
  | TYPE
  | TRUE
  | TILDA
  | THEN
  | STRING of (string)
  | STAR
  | SEMICOLON
  | RIGHTSQ
  | RIGHTPAR
  | RIGHTBRC
  | REQUIRES
  | REC
  | RAISES
  | QUOTE_LIDENT of (string)
  | QUESTION
  | PREDICATE
  | OR
  | OPPREF of (string)
  | OPEN
  | OP4 of (string)
  | OP3 of (string)
  | OP2 of (string)
  | OP1 of (string)
  | OLD
  | NOT
  | MUTABLE
  | MODIFIES
  | MODEL
  | MATCH
  | LTGT
  | LRARROW
  | LIDENT of (string)
  | LET
  | LEMMA
  | LEFTSQRIGHTSQ
  | LEFTSQ
  | LEFTPAR
  | LEFTBRCRIGHTBRC
  | LEFTBRCCOLON
  | LEFTBRC
  | LARROW
  | INVARIANT
  | INTEGER of (string)
  | IN
  | IF
  | GOAL
  | FUNCTION
  | FUN
  | FORALL
  | FLOAT of (string)
  | FALSE
  | EXISTS
  | EQUIVALENT
  | EQUAL
  | EPHEMERAL
  | EOF
  | ENSURES
  | ELSE
  | DOTDOT
  | DOT
  | DIVERGES
  | CONSUMES
  | COMMA
  | COLONRIGHTBRC
  | COLONEQUAL
  | COLONCOLON
  | COLON
  | COERCION
  | CHECKS
  | BARBAR
  | BAR
  | BACKQUOTE_LIDENT of (string)
  | AXIOM
  | ATTRIBUTE of (string)
  | AS
  | ARROW
  | ANDW
  | AND
  | AMPAMP

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val spec_init: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Uast.spec)

val loop_spec: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Uast.loop_spec)

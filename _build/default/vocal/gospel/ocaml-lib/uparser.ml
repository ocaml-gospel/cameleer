
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | WITH
    | VARIANT
    | VAL
    | UNDERSCORE
    | UIDENT of (
# 78 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 15 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | TYPE
    | TRUE
    | TILDA
    | THEN
    | STRING of (
# 84 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 24 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | STAR
    | SEMICOLON
    | RIGHTSQ
    | RIGHTPAR
    | RIGHTBRC
    | REQUIRES
    | REC
    | RAISES
    | QUOTE_LIDENT of (
# 82 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 37 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | QUESTION
    | PREDICATE
    | OR
    | OPPREF of (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 45 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | OPEN
    | OP4 of (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 51 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | OP3 of (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 56 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | OP2 of (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 61 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | OP1 of (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 66 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | OLD
    | NOT
    | MUTABLE
    | MODIFIES
    | MODEL
    | MATCH
    | LTGT
    | LRARROW
    | LIDENT of (
# 78 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 79 "vocal/gospel/ocaml-lib/uparser.ml"
  )
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
    | INTEGER of (
# 79 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 94 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | IN
    | IF
    | GOAL
    | FUNCTION
    | FUN
    | FORALL
    | FLOAT of (
# 81 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 105 "vocal/gospel/ocaml-lib/uparser.ml"
  )
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
    | BACKQUOTE_LIDENT of (
# 83 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 131 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | AXIOM
    | ATTRIBUTE of (
# 85 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 137 "vocal/gospel/ocaml-lib/uparser.ml"
  )
    | AS
    | ARROW
    | ANDW
    | AND
    | AMPAMP
  
end

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState514
  | MenhirState510
  | MenhirState504
  | MenhirState503
  | MenhirState501
  | MenhirState499
  | MenhirState497
  | MenhirState496
  | MenhirState495
  | MenhirState493
  | MenhirState492
  | MenhirState490
  | MenhirState484
  | MenhirState479
  | MenhirState476
  | MenhirState475
  | MenhirState473
  | MenhirState468
  | MenhirState464
  | MenhirState461
  | MenhirState460
  | MenhirState458
  | MenhirState457
  | MenhirState456
  | MenhirState455
  | MenhirState454
  | MenhirState451
  | MenhirState450
  | MenhirState449
  | MenhirState448
  | MenhirState447
  | MenhirState445
  | MenhirState442
  | MenhirState441
  | MenhirState440
  | MenhirState437
  | MenhirState436
  | MenhirState435
  | MenhirState434
  | MenhirState433
  | MenhirState427
  | MenhirState424
  | MenhirState423
  | MenhirState421
  | MenhirState420
  | MenhirState418
  | MenhirState417
  | MenhirState416
  | MenhirState414
  | MenhirState410
  | MenhirState404
  | MenhirState399
  | MenhirState398
  | MenhirState397
  | MenhirState396
  | MenhirState395
  | MenhirState394
  | MenhirState393
  | MenhirState392
  | MenhirState391
  | MenhirState390
  | MenhirState388
  | MenhirState386
  | MenhirState385
  | MenhirState383
  | MenhirState382
  | MenhirState374
  | MenhirState373
  | MenhirState371
  | MenhirState365
  | MenhirState362
  | MenhirState360
  | MenhirState358
  | MenhirState356
  | MenhirState354
  | MenhirState352
  | MenhirState350
  | MenhirState348
  | MenhirState347
  | MenhirState346
  | MenhirState345
  | MenhirState344
  | MenhirState338
  | MenhirState337
  | MenhirState336
  | MenhirState333
  | MenhirState329
  | MenhirState328
  | MenhirState327
  | MenhirState325
  | MenhirState322
  | MenhirState317
  | MenhirState316
  | MenhirState315
  | MenhirState312
  | MenhirState311
  | MenhirState310
  | MenhirState309
  | MenhirState308
  | MenhirState307
  | MenhirState306
  | MenhirState303
  | MenhirState302
  | MenhirState301
  | MenhirState300
  | MenhirState292
  | MenhirState291
  | MenhirState290
  | MenhirState289
  | MenhirState286
  | MenhirState282
  | MenhirState281
  | MenhirState280
  | MenhirState279
  | MenhirState278
  | MenhirState277
  | MenhirState276
  | MenhirState271
  | MenhirState270
  | MenhirState269
  | MenhirState266
  | MenhirState265
  | MenhirState263
  | MenhirState261
  | MenhirState259
  | MenhirState256
  | MenhirState254
  | MenhirState252
  | MenhirState251
  | MenhirState249
  | MenhirState247
  | MenhirState246
  | MenhirState243
  | MenhirState237
  | MenhirState236
  | MenhirState235
  | MenhirState234
  | MenhirState233
  | MenhirState232
  | MenhirState231
  | MenhirState230
  | MenhirState229
  | MenhirState228
  | MenhirState227
  | MenhirState226
  | MenhirState225
  | MenhirState224
  | MenhirState223
  | MenhirState222
  | MenhirState221
  | MenhirState220
  | MenhirState219
  | MenhirState218
  | MenhirState217
  | MenhirState216
  | MenhirState215
  | MenhirState206
  | MenhirState205
  | MenhirState203
  | MenhirState202
  | MenhirState201
  | MenhirState200
  | MenhirState199
  | MenhirState198
  | MenhirState194
  | MenhirState191
  | MenhirState189
  | MenhirState186
  | MenhirState184
  | MenhirState183
  | MenhirState182
  | MenhirState181
  | MenhirState180
  | MenhirState179
  | MenhirState178
  | MenhirState176
  | MenhirState175
  | MenhirState174
  | MenhirState171
  | MenhirState170
  | MenhirState158
  | MenhirState157
  | MenhirState154
  | MenhirState152
  | MenhirState151
  | MenhirState150
  | MenhirState149
  | MenhirState148
  | MenhirState144
  | MenhirState143
  | MenhirState125
  | MenhirState120
  | MenhirState119
  | MenhirState117
  | MenhirState114
  | MenhirState113
  | MenhirState112
  | MenhirState110
  | MenhirState109
  | MenhirState108
  | MenhirState106
  | MenhirState99
  | MenhirState98
  | MenhirState96
  | MenhirState95
  | MenhirState94
  | MenhirState93
  | MenhirState92
  | MenhirState91
  | MenhirState89
  | MenhirState87
  | MenhirState86
  | MenhirState84
  | MenhirState82
  | MenhirState81
  | MenhirState78
  | MenhirState77
  | MenhirState74
  | MenhirState64
  | MenhirState61
  | MenhirState58
  | MenhirState55
  | MenhirState54
  | MenhirState53
  | MenhirState52
  | MenhirState49
  | MenhirState43
  | MenhirState42
  | MenhirState41
  | MenhirState40
  | MenhirState28
  | MenhirState26
  | MenhirState24
  | MenhirState21
  | MenhirState20
  | MenhirState19
  | MenhirState18
  | MenhirState13
  | MenhirState10
  | MenhirState8
  | MenhirState5
  | MenhirState1
  | MenhirState0

# 11 "vocal/gospel/ocaml-lib/uparser.mly"
  
  open Identifier
  open Uast
  open Uast_utils

  let rev_fspec s = {
      fun_req     = List.rev s.fun_req;
      fun_ens     = List.rev s.fun_ens;
      fun_variant = List.rev s.fun_variant;
      fun_coer    = s.fun_coer;
    }

  let empty_fspec = {
      fun_req     = [];
      fun_ens     = [];
      fun_variant = [];
      fun_coer    = false;
    }

  let rev_vspec s = {
    sp_hd_ret  = s.sp_hd_ret;
    sp_hd_nm  = s.sp_hd_nm;
    sp_hd_args = s.sp_hd_args;
    sp_pre     = List.rev s.sp_pre;
    sp_post    = List.rev s.sp_post;
    sp_xpost   = List.rev s.sp_xpost;
    sp_reads   = List.rev s.sp_reads;
    sp_writes  = List.rev s.sp_writes;
    sp_consumes= List.rev s.sp_consumes;
    sp_alias   = List.rev s.sp_alias;
    sp_variant = List.rev s.sp_variant;
    sp_diverge = s.sp_diverge;
    sp_equiv   = List.rev s.sp_equiv;
  }

  let empty_vspec = {
    sp_hd_ret  = [];
    sp_hd_nm   = mk_pid "" Lexing.dummy_pos Lexing.dummy_pos;
    sp_hd_args = [];
    sp_pre     = [];
    sp_post    = [];
    sp_xpost   = [];
    sp_reads   = [];
    sp_writes  = [];
    sp_consumes= [];
    sp_alias   = [];
    sp_variant = [];
    sp_diverge = false;
    sp_equiv   = [];
  }

  let rev_tspec s = {
      ty_ephemeral = s.ty_ephemeral;
      ty_field     = List.rev s.ty_field;
      ty_invariant = List.rev s.ty_invariant;
    }

  let empty_tspec = {
      ty_ephemeral = false;
      ty_field     = [];
      ty_invariant = [];
    }


# 469 "vocal/gospel/ocaml-lib/uparser.ml"

let rec _menhir_goto_separated_nonempty_list_ANDW_single_constraint_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.constraint_spec list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState365 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (xs : (Uast.constraint_spec list)) = _v in
        let (_menhir_stack, _menhir_s, (x : (Uast.constraint_spec))) = _menhir_stack in
        let _2 = () in
        let _v : (Uast.constraint_spec list) = 
# 243 "<standard.mly>"
    ( x :: xs )
# 483 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_ANDW_single_constraint_ _menhir_env _menhir_stack _menhir_s _v
    | MenhirState345 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_1 : (Uast.constraint_spec list)) = _v in
        let _v : (Uast.constraint_spec list) = 
# 761 "vocal/gospel/ocaml-lib/uparser.mly"
                                    ( _1 )
# 493 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_2 : (Uast.constraint_spec list)) = _v in
        let (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _v : (Uast.constraint_spec list) = 
# 347 "vocal/gospel/ocaml-lib/uparser.mly"
                                   ( _2 )
# 504 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__2_ = _endpos in
            let (_menhir_stack, _menhir_s, (_1 : (Uast.constraint_spec list)), _startpos__1_) = _menhir_stack in
            let _2 = () in
            let _v : (Uast.spec) = let _endpos = _endpos__2_ in
            let _startpos = _startpos__1_ in
            
# 150 "vocal/gospel/ocaml-lib/uparser.mly"
     ( Sconstraint (_1, mk_loc _startpos _endpos) )
# 523 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_spec_init _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_bar_list1_raises_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> ((Uast.qualid * (Uast.pattern * Uast.term) option) list) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_r_ = _endpos in
    let (r : ((Uast.qualid * (Uast.pattern * Uast.term) option) list)) = _v in
    let _startpos_r_ = _startpos in
    let ((_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_), _) = _menhir_stack in
    let _2 = () in
    let _startpos = _startpos_bd_ in
    let _v : (Uast.val_spec) = 
# 279 "vocal/gospel/ocaml-lib/uparser.mly"
    ( let xp = mk_loc _startpos_r_ _endpos_r_, r in
      { bd with sp_xpost = xp :: bd.sp_xpost } )
# 549 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos

and _menhir_goto_func : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.function_) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | EOF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_menhir_stack, _menhir_s, (_1 : (Uast.function_)), _startpos__1_) = _menhir_stack in
        let _2 = () in
        let _v : (Uast.spec) = let _endpos = _endpos__2_ in
        let _startpos = _startpos__1_ in
        
# 148 "vocal/gospel/ocaml-lib/uparser.mly"
                    ( Sfunction (_1, mk_loc _startpos _endpos))
# 572 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_spec_init _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_single_constraint : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.constraint_spec) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ANDW ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run362 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FUNCTION ->
            _menhir_run356 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | GOAL ->
            _menhir_run354 _menhir_env (Obj.magic _menhir_stack) MenhirState365
        | PREDICATE ->
            _menhir_run346 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState365)
    | EOF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (x : (Uast.constraint_spec))) = _menhir_stack in
        let _v : (Uast.constraint_spec list) = 
# 241 "<standard.mly>"
    ( [ x ] )
# 612 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_ANDW_single_constraint_ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_triggers : _menhir_env -> 'ttv_tail -> (Uast.variant list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ATTRIBUTE _v ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EXISTS ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FALSE ->
            _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FLOAT _v ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FORALL ->
            _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FUN ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IF ->
            _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INTEGER _v ->
            _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRC ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRCCOLON ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRCRIGHTBRC ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQRIGHTSQ ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LET ->
            _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MATCH ->
            _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOT ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OLD ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OPPREF _v ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TRUE ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState246 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState246)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_separated_nonempty_list_BAR_raises_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> ((Uast.qualid * (Uast.pattern * Uast.term) option) list) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    match _menhir_s with
    | MenhirState455 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xl_ = _endpos in
        let (xl : ((Uast.qualid * (Uast.pattern * Uast.term) option) list)) = _v in
        let _startpos_xl_ = _startpos in
        let (_menhir_stack, _menhir_s, _startpos_x_) = _menhir_stack in
        let x = () in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_xl_ in
        let _v : ((Uast.qualid * (Uast.pattern * Uast.term) option) list) = let _1 = 
# 126 "<standard.mly>"
    ( Some x )
# 716 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 736 "vocal/gospel/ocaml-lib/uparser.mly"
                                                      ( xl )
# 721 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_bar_list1_raises_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState464 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xs_ = _endpos in
        let (xs : ((Uast.qualid * (Uast.pattern * Uast.term) option) list)) = _v in
        let _startpos_xs_ = _startpos in
        let ((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.qualid * (Uast.pattern * Uast.term) option)), _startpos_x_), _startpos__2_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_xs_ in
        let _v : ((Uast.qualid * (Uast.pattern * Uast.term) option) list) = 
# 243 "<standard.mly>"
    ( x :: xs )
# 737 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_BAR_raises_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState454 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xl_ = _endpos in
        let (xl : ((Uast.qualid * (Uast.pattern * Uast.term) option) list)) = _v in
        let _startpos_xl_ = _startpos in
        let _startpos = _startpos_xl_ in
        let _endpos = _endpos_xl_ in
        let _v : ((Uast.qualid * (Uast.pattern * Uast.term) option) list) = let _1 = 
# 124 "<standard.mly>"
    ( None )
# 751 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 736 "vocal/gospel/ocaml-lib/uparser.mly"
                                                      ( xl )
# 756 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_bar_list1_raises_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_option_func_spec_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.fun_spec option) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState393 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_spec_ = _endpos in
        let (spec : (Uast.fun_spec option)) = _v in
        let (((((_menhir_stack, _menhir_s, _startpos__1_), _, (r : (unit option))), _, (fname : (Identifier.preid))), _endpos_ps_, _, (ps : (Uast.param list))), _endpos_def_, _, (def : (Uast.term option))) = _menhir_stack in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _v : (Uast.function_) = let _endpos = _endpos_spec_ in
        let _startpos = _startpos__1_ in
        
# 178 "vocal/gospel/ocaml-lib/uparser.mly"
  ( let spec = match spec with
        None -> empty_fspec | Some spec -> rev_fspec spec in
    { fun_name = fname; fun_rec = Utils.opt2bool r; fun_type = None;
      fun_params = ps; fun_def = def; fun_spec = spec ;
      fun_loc = mk_loc _startpos _endpos} )
# 782 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_func _menhir_env _menhir_stack _menhir_s _v _startpos
    | MenhirState442 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_spec_ = _endpos in
        let (spec : (Uast.fun_spec option)) = _v in
        let ((((((_menhir_stack, _menhir_s, _startpos__1_), _, (r : (unit option))), _, (fname : (Identifier.preid))), _, (ps : (Uast.param list option))), _endpos_ty_, _, (ty : (Uast.pty)), _startpos_ty_), _endpos_def_, _, (def : (Uast.term option))) = _menhir_stack in
        let _5 = () in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _v : (Uast.function_) = let _endpos = _endpos_spec_ in
        let _startpos = _startpos__1_ in
        
# 170 "vocal/gospel/ocaml-lib/uparser.mly"
  ( let ps = match ps with | None -> [] | Some ps -> ps in
    let spec = match spec with
        None -> empty_fspec | Some spec -> rev_fspec spec in
    { fun_name = fname; fun_rec = Utils.opt2bool r; fun_type = Some ty;
      fun_params = ps; fun_def = def; fun_spec = spec;
      fun_loc = mk_loc _startpos _endpos} )
# 804 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_func _menhir_env _menhir_stack _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_reduce104 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let (_, _endpos) = Obj.magic _menhir_stack in
    let _v : (Uast.fun_spec option) = 
# 114 "<standard.mly>"
    ( None )
# 816 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_option_func_spec_ _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run394 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState394 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState394

and _menhir_run400 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _1 = () in
    let _endpos = _endpos__1_ in
    let _v : (Uast.fun_spec) = 
# 196 "vocal/gospel/ocaml-lib/uparser.mly"
             ( {empty_fspec with fun_coer = true})
# 893 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_func_spec _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_goto_bar_list1_separated_pair_pattern_ARROW_term__ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> ((Uast.pattern * Uast.term) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_cl_ = _endpos in
    let (cl : ((Uast.pattern * Uast.term) list)) = _v in
    let _endpos = _endpos_cl_ in
    let _v : ((Uast.pattern * Uast.term) list) = 
# 430 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( cl )
# 907 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    match _menhir_s with
    | MenhirState311 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__4_ = _endpos in
        let (_4 : ((Uast.pattern * Uast.term) list)) = _v in
        let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.term)), _startpos__2_), _, _startpos__3_) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : (Uast.term_desc) = 
# 404 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tcase (_2, _4) )
# 923 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState325 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__4_ = _endpos in
        let (_4 : ((Uast.pattern * Uast.term) list)) = _v in
        let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.term list)), _startpos__2_), _startpos__3_) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : (Uast.term_desc) = 
# 406 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tcase (mk_term (Ttuple _2) _startpos__2_ _endpos__2_, _4) )
# 939 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_BAR_comma_list1_term__ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.variant list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState198 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _endpos__1_, _startpos__1_), _, (_2 : (Uast.variant list))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (Uast.variant list) = 
# 439 "vocal/gospel/ocaml-lib/uparser.mly"
                                                                ( _2 )
# 966 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_triggers _menhir_env _menhir_stack _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState243 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.variant))), _startpos__2_), _, (xs : (Uast.variant list))) = _menhir_stack in
        let _2 = () in
        let _v : (Uast.variant list) = 
# 243 "<standard.mly>"
    ( x :: xs )
# 983 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_BAR_comma_list1_term__ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_mk_pat_pat_uni___ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pattern list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState78 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__1_ = _endpos in
        let (_1 : (Uast.pattern list)) = _v in
        let _endpos = _endpos__1_ in
        let _v : (Uast.pattern list) = 
# 748 "vocal/gospel/ocaml-lib/uparser.mly"
                                    ( _1 )
# 1001 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__3_ = _endpos in
        let (_3 : (Uast.pattern list)) = _v in
        let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pattern)), _startpos__1_), _) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Uast.pattern list) = 
# 744 "vocal/gospel/ocaml-lib/uparser.mly"
                         ( _1 :: _3 )
# 1014 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__1_ = _endpos in
        let (_1 : (Uast.pattern list)) = _v in
        let _startpos__1_ = _startpos in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.pat_desc) = 
# 586 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Ptuple _1 )
# 1026 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_pat_conj_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState82 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xs_ = _endpos in
        let (xs : (Uast.pattern list)) = _v in
        let ((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.pattern)), _startpos_x_), _) = _menhir_stack in
        let _2 = () in
        let _endpos = _endpos_xs_ in
        let _v : (Uast.pattern list) = 
# 243 "<standard.mly>"
    ( x :: xs )
# 1040 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_mk_pat_pat_uni___ _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run120 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.pattern) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState120 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState120

and _menhir_goto_pattern_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pat_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState325 | MenhirState311 | MenhirState317 | MenhirState312 | MenhirState21 | MenhirState125 | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pat_desc)), _startpos__1_) = _menhir_stack in
        let _endpos = _endpos__1_ in
        let _v : (Uast.pattern) = let _endpos = _endpos__1_ in
        let _startpos = _startpos__1_ in
        
# 572 "vocal/gospel/ocaml-lib/uparser.mly"
             ( mk_pat _1 _startpos _endpos )
# 1073 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__1_ = _endpos in
        let (_1 : (Uast.pattern)) = _v in
        let _endpos = _endpos__1_ in
        let _v : (Uast.pattern) = 
# 575 "vocal/gospel/ocaml-lib/uparser.mly"
                          ( _1 )
# 1083 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
        (match _menhir_s with
        | MenhirState52 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.qualid)), _startpos_x_), _endpos__2_, _startpos__2_), _endpos_y_, _, (y : (Uast.pattern))) = _menhir_stack in
            let _2 = () in
            let _v : (Uast.qualid * Uast.pattern) = let _1 = 
# 175 "<standard.mly>"
    ( (x, y) )
# 1095 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 619 "vocal/gospel/ocaml-lib/uparser.mly"
                                    ( _1 )
# 1100 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pattern_rec_field_pattern_ _menhir_env _menhir_stack _menhir_s _v
        | MenhirState125 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, (_1 : (Uast.pattern)), _startpos__1_), _startpos__2_), _endpos__3_, _, (_3 : (Uast.pattern))) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (Uast.pat_desc) = 
# 581 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Por (_1,_3) )
# 1113 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pattern_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | MenhirState21 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | EQUAL ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
                let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | ATTRIBUTE _v ->
                    _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | EXISTS ->
                    _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FALSE ->
                    _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FLOAT _v ->
                    _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FORALL ->
                    _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FUN ->
                    _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | IF ->
                    _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INTEGER _v ->
                    _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRC ->
                    _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRCCOLON ->
                    _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRCRIGHTBRC ->
                    _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTPAR ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTSQRIGHTSQ ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LET ->
                    _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LIDENT _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MATCH ->
                    _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NOT ->
                    _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OLD ->
                    _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP1 _v ->
                    _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP2 _v ->
                    _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP3 _v ->
                    _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP4 _v ->
                    _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OPPREF _v ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | STAR ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | TRUE ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | UIDENT _v ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState143 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState143)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | MenhirState325 | MenhirState311 | MenhirState317 | MenhirState312 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ARROW ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_stack = (_menhir_stack, _endpos) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | ATTRIBUTE _v ->
                    _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | EXISTS ->
                    _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FALSE ->
                    _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FLOAT _v ->
                    _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FORALL ->
                    _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FUN ->
                    _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | IF ->
                    _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INTEGER _v ->
                    _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRC ->
                    _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRCCOLON ->
                    _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRCRIGHTBRC ->
                    _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTPAR ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTSQRIGHTSQ ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LET ->
                    _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LIDENT _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MATCH ->
                    _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NOT ->
                    _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OLD ->
                    _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP1 _v ->
                    _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP2 _v ->
                    _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP3 _v ->
                    _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP4 _v ->
                    _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OPPREF _v ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | STAR ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | TRUE ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | UIDENT _v ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState315 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState315)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            _menhir_fail ())
    | MenhirState24 | MenhirState40 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.pat_desc)), _startpos__2_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (Uast.pat_desc) = 
# 610 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( _2 )
# 1286 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pat_arg_shared_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_nonempty_list_pat_arg_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pattern list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState58 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xs_ = _endpos in
        let (xs : (Uast.pattern list)) = _v in
        let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.pattern)), _startpos_x_) = _menhir_stack in
        let _endpos = _endpos_xs_ in
        let _v : (Uast.pattern list) = 
# 223 "<standard.mly>"
    ( x :: xs )
# 1311 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_nonempty_list_pat_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState53 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_2 : (Uast.pattern list)) = _v in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__2_ in
        let _v : (Uast.pat_desc) = 
# 593 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Papp (_1,_2) )
# 1325 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_pat_uni_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_semicolon_list1_term_rec_field_term__ : _menhir_env -> 'ttv_tail -> _menhir_state -> ((Uast.qualid * Uast.term) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState286 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (xl : ((Uast.qualid * Uast.term) list)) = _v in
        let (_menhir_stack, _menhir_s, (x : (Uast.qualid * Uast.term))) = _menhir_stack in
        let _2 = () in
        let _v : ((Uast.qualid * Uast.term) list) = 
# 753 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( x :: xl )
# 1343 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_semicolon_list1_term_rec_field_term__ _menhir_env _menhir_stack _menhir_s _v
    | MenhirState144 | MenhirState292 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (fl : ((Uast.qualid * Uast.term) list)) = _v in
        let _v : ((Uast.qualid * Uast.term) list) = 
# 418 "vocal/gospel/ocaml-lib/uparser.mly"
                                          ( fl )
# 1353 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        (match _menhir_s with
        | MenhirState292 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | RIGHTBRC ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__5_ = _endpos in
                let ((((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.term)), _startpos__2_), _, _startpos__3_), _, (_4 : ((Uast.qualid * Uast.term) list))) = _menhir_stack in
                let _5 = () in
                let _3 = () in
                let _1 = () in
                let _startpos = _startpos__1_ in
                let _endpos = _endpos__5_ in
                let _v : (Uast.term_desc) = 
# 474 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( Tupdate (_2,_4) )
# 1377 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_term_block_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | MenhirState144 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | RIGHTBRC ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__3_ = _endpos in
                let ((_menhir_stack, _menhir_s, _startpos__1_), _, (_2 : ((Uast.qualid * Uast.term) list))) = _menhir_stack in
                let _3 = () in
                let _1 = () in
                let _startpos = _startpos__1_ in
                let _endpos = _endpos__3_ in
                let _v : (Uast.term_desc) = 
# 473 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( Trecord _2 )
# 1405 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_term_block_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            _menhir_fail ())
    | _ ->
        _menhir_fail ()

and _menhir_goto_loption_separated_nonempty_list_COMMA_term__ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.variant) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState451 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (xs : (Uast.variant)) = _v in
        let ((_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_), _) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_bd_ in
        let _v : (Uast.val_spec) = let v = 
# 232 "<standard.mly>"
    ( xs )
# 1432 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 267 "vocal/gospel/ocaml-lib/uparser.mly"
  ( {bd with sp_diverge = false; sp_variant = v} )
# 1437 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos
    | MenhirState468 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (xs : (Uast.variant)) = _v in
        let ((_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_), _) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_bd_ in
        let _v : (Uast.val_spec) = let wr = 
# 232 "<standard.mly>"
    ( xs )
# 1450 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 269 "vocal/gospel/ocaml-lib/uparser.mly"
    ( { bd with sp_writes = wr @ bd.sp_writes } )
# 1455 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos
    | MenhirState473 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (xs : (Uast.variant)) = _v in
        let ((_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_), _) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_bd_ in
        let _v : (Uast.val_spec) = let cs = 
# 232 "<standard.mly>"
    ( xs )
# 1468 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 271 "vocal/gospel/ocaml-lib/uparser.mly"
    ( { bd with sp_consumes = cs @ bd.sp_consumes } )
# 1473 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_val_spec_header : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.labelled_arg list * Identifier.preid * Uast.labelled_arg list) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    _menhir_reduce277 _menhir_env (Obj.magic _menhir_stack) MenhirState449

and _menhir_goto_ret_name : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.labelled_arg list) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState495 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState495 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState495

and _menhir_goto_nonempty_list_located_term_arg__ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> ((Uast.term * Lexing.position * Lexing.position) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState174 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_2 : ((Uast.term * Lexing.position * Lexing.position) list)) = _v in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__2_ in
        let _v : (Uast.term_desc) = let _startpos = _startpos__1_ in
        
# 387 "vocal/gospel/ocaml-lib/uparser.mly"
    ( let join f (a,_,e) = mk_term (Tapply (f,a)) _startpos e in
      (List.fold_left join _1 _2).term_desc )
# 1517 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState261 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xs_ = _endpos in
        let (xs : ((Uast.term * Lexing.position * Lexing.position) list)) = _v in
        let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.term * Lexing.position * Lexing.position))) = _menhir_stack in
        let _endpos = _endpos_xs_ in
        let _v : ((Uast.term * Lexing.position * Lexing.position) list) = 
# 223 "<standard.mly>"
    ( x :: xs )
# 1530 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_nonempty_list_located_term_arg__ _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run175 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DOTDOT ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState175 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ATTRIBUTE _v ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EXISTS ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FALSE ->
            _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FLOAT _v ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FORALL ->
            _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FUN ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IF ->
            _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INTEGER _v ->
            _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRC ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRCCOLON ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRCRIGHTBRC ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQRIGHTSQ ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LET ->
            _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MATCH ->
            _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOT ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OLD ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OPPREF _v ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TRUE ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState176)
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState175 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState175

and _menhir_goto_option_params_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.param list option) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COLON ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState440 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState440 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QUESTION ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState440 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QUOTE_LIDENT _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState440 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState440 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState440)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_qualid : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.qualid) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState20 | MenhirState322 | MenhirState315 | MenhirState306 | MenhirState308 | MenhirState143 | MenhirState301 | MenhirState144 | MenhirState289 | MenhirState150 | MenhirState151 | MenhirState278 | MenhirState280 | MenhirState154 | MenhirState171 | MenhirState265 | MenhirState261 | MenhirState174 | MenhirState175 | MenhirState254 | MenhirState251 | MenhirState176 | MenhirState179 | MenhirState181 | MenhirState183 | MenhirState246 | MenhirState243 | MenhirState198 | MenhirState237 | MenhirState200 | MenhirState215 | MenhirState227 | MenhirState235 | MenhirState229 | MenhirState231 | MenhirState233 | MenhirState219 | MenhirState221 | MenhirState223 | MenhirState225 | MenhirState217 | MenhirState205 | MenhirState202 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.term_desc) = 
# 454 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( Tpreid _1 )
# 1708 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState346 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLONEQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState352 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState352 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState352 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState352)
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState350 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState350 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState350 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState350)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState350 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((((_menhir_stack, _menhir_s, _startpos__1_), _endpos_idl_, _, (idl : (Uast.qualid)), _startpos_idl_), _endpos__3_, _startpos__3_), _endpos_idr_, _, (idr : (Uast.qualid)), _startpos_idr_) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : (Uast.constraint_spec) = 
# 355 "vocal/gospel/ocaml-lib/uparser.mly"
    ( CPredicateShare (idl, idr) )
# 1764 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_single_constraint _menhir_env _menhir_stack _menhir_s _v
    | MenhirState352 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_idl_, _, (idl : (Uast.qualid)), _startpos_idl_), _endpos_idr_, _, (idr : (Uast.qualid)), _startpos_idr_) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : (Uast.constraint_spec) = 
# 357 "vocal/gospel/ocaml-lib/uparser.mly"
    ( CPredicateDestr (idl, idr) )
# 1776 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_single_constraint _menhir_env _menhir_stack _menhir_s _v
    | MenhirState354 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _endpos_q_, _, (q : (Uast.qualid)), _startpos_q_) = _menhir_stack in
        let _1 = () in
        let _v : (Uast.constraint_spec) = 
# 359 "vocal/gospel/ocaml-lib/uparser.mly"
    ( CGoal q )
# 1787 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_single_constraint _menhir_env _menhir_stack _menhir_s _v
    | MenhirState356 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLONEQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState360 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState360 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState360 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState360)
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState358 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState358 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState358 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState358)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState358 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((((_menhir_stack, _menhir_s, _startpos__1_), _endpos_idl_, _, (idl : (Uast.qualid)), _startpos_idl_), _endpos__3_, _startpos__3_), _endpos_idr_, _, (idr : (Uast.qualid)), _startpos_idr_) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : (Uast.constraint_spec) = 
# 351 "vocal/gospel/ocaml-lib/uparser.mly"
    ( CFunctionShare (idl, idr) )
# 1843 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_single_constraint _menhir_env _menhir_stack _menhir_s _v
    | MenhirState360 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_idl_, _, (idl : (Uast.qualid)), _startpos_idl_), _endpos_idr_, _, (idr : (Uast.qualid)), _startpos_idr_) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : (Uast.constraint_spec) = 
# 353 "vocal/gospel/ocaml-lib/uparser.mly"
    ( CFunctionDestr (idl, idr) )
# 1855 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_single_constraint _menhir_env _menhir_stack _menhir_s _v
    | MenhirState362 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_q_, _, (q : (Uast.qualid)), _startpos_q_) = _menhir_stack in
        let _1 = () in
        let _v : (Uast.constraint_spec) = 
# 361 "vocal/gospel/ocaml-lib/uparser.mly"
    ( CAxiom q )
# 1866 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_single_constraint _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run150 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DOT ->
        _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EQUAL ->
        _menhir_run132 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | RIGHTPAR ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState150

and _menhir_reduce117 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.qualid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.pat_desc) = 
# 606 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Papp (_1,[]) )
# 1951 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_pat_arg_shared_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run54 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.qualid) * Lexing.position -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState54 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState54

and _menhir_goto_separated_nonempty_list_COMMA_quant_vars_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.binder list list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState186 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_1 : (Uast.binder list list)) = _v in
        let _v : (Uast.binder list list) = 
# 748 "vocal/gospel/ocaml-lib/uparser.mly"
                                    ( _1 )
# 1978 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState198 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState198)
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _v : (Uast.variant list) = 
# 438 "vocal/gospel/ocaml-lib/uparser.mly"
                                                                ( [] )
# 2054 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_triggers _menhir_env _menhir_stack _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState189 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (xs : (Uast.binder list list)) = _v in
        let (_menhir_stack, _menhir_s, (x : (Uast.binder list))) = _menhir_stack in
        let _2 = () in
        let _v : (Uast.binder list list) = 
# 243 "<standard.mly>"
    ( x :: xs )
# 2072 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_quant_vars_ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_raises : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.qualid * (Uast.pattern * Uast.term) option) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState464 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState464)
    | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.qualid * (Uast.pattern * Uast.term) option)), _startpos_x_) = _menhir_stack in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : ((Uast.qualid * (Uast.pattern * Uast.term) option) list) = 
# 241 "<standard.mly>"
    ( [ x ] )
# 2106 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_BAR_raises_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_prop : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.prop) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | EOF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_menhir_stack, _menhir_s, (_1 : (Uast.prop)), _startpos__1_) = _menhir_stack in
        let _2 = () in
        let _v : (Uast.spec) = let _endpos = _endpos__2_ in
        let _startpos = _startpos__1_ in
        
# 152 "vocal/gospel/ocaml-lib/uparser.mly"
                    ( Sprop (_1, mk_loc _startpos _endpos))
# 2135 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_spec_init _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_func_spec : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.fun_spec) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COERCION ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_s = MenhirState404 in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_menhir_stack, _endpos_bd_, _menhir_s, (bd : (Uast.fun_spec))) = _menhir_stack in
        let _2 = () in
        let _endpos = _endpos__2_ in
        let _v : (Uast.fun_spec) = 
# 204 "vocal/gospel/ocaml-lib/uparser.mly"
    ( {bd with fun_coer = true} )
# 2165 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_func_spec _menhir_env _menhir_stack _endpos _menhir_s _v
    | ENSURES ->
        _menhir_run398 _menhir_env (Obj.magic _menhir_stack) MenhirState404
    | REQUIRES ->
        _menhir_run396 _menhir_env (Obj.magic _menhir_stack) MenhirState404
    | VARIANT ->
        _menhir_run394 _menhir_env (Obj.magic _menhir_stack) MenhirState404
    | EOF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.fun_spec))) = _menhir_stack in
        let _endpos = _endpos_x_ in
        let _v : (Uast.fun_spec option) = 
# 116 "<standard.mly>"
    ( Some x )
# 2181 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_option_func_spec_ _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState404

and _menhir_goto_option_preceded_EQUAL_term__ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.term option) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState390 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COERCION ->
            _menhir_run400 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState393
        | ENSURES ->
            _menhir_run398 _menhir_env (Obj.magic _menhir_stack) MenhirState393
        | REQUIRES ->
            _menhir_run396 _menhir_env (Obj.magic _menhir_stack) MenhirState393
        | VARIANT ->
            _menhir_run394 _menhir_env (Obj.magic _menhir_stack) MenhirState393
        | EOF ->
            _menhir_reduce104 _menhir_env (Obj.magic _menhir_stack) MenhirState393
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState393)
    | MenhirState441 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COERCION ->
            _menhir_run400 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState442
        | ENSURES ->
            _menhir_run398 _menhir_env (Obj.magic _menhir_stack) MenhirState442
        | REQUIRES ->
            _menhir_run396 _menhir_env (Obj.magic _menhir_stack) MenhirState442
        | VARIANT ->
            _menhir_run394 _menhir_env (Obj.magic _menhir_stack) MenhirState442
        | EOF ->
            _menhir_reduce104 _menhir_env (Obj.magic _menhir_stack) MenhirState442
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState442)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_BAR_separated_pair_pattern_ARROW_term__ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> ((Uast.pattern * Uast.term) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState312 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xl_ = _endpos in
        let (xl : ((Uast.pattern * Uast.term) list)) = _v in
        let (_menhir_stack, _menhir_s, _startpos_x_) = _menhir_stack in
        let x = () in
        let _endpos = _endpos_xl_ in
        let _v : ((Uast.pattern * Uast.term) list) = let _1 = 
# 126 "<standard.mly>"
    ( Some x )
# 2248 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 736 "vocal/gospel/ocaml-lib/uparser.mly"
                                                      ( xl )
# 2253 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_bar_list1_separated_pair_pattern_ARROW_term__ _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState317 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xs_ = _endpos in
        let (xs : ((Uast.pattern * Uast.term) list)) = _v in
        let ((((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.pattern))), _endpos__2_inlined1_), _endpos_y_, _, (y : (Uast.term)), _startpos_y_), _, _startpos__2_) = _menhir_stack in
        let _2 = () in
        let _2_inlined1 = () in
        let _endpos = _endpos_xs_ in
        let _v : ((Uast.pattern * Uast.term) list) = let x =
          let _2 = _2_inlined1 in
          
# 175 "<standard.mly>"
    ( (x, y) )
# 2270 "vocal/gospel/ocaml-lib/uparser.ml"
          
        in
        
# 243 "<standard.mly>"
    ( x :: xs )
# 2276 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_BAR_separated_pair_pattern_ARROW_term__ _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState325 | MenhirState311 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xl_ = _endpos in
        let (xl : ((Uast.pattern * Uast.term) list)) = _v in
        let _endpos = _endpos_xl_ in
        let _v : ((Uast.pattern * Uast.term) list) = let _1 = 
# 124 "<standard.mly>"
    ( None )
# 2288 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 736 "vocal/gospel/ocaml-lib/uparser.mly"
                                                      ( xl )
# 2293 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_bar_list1_separated_pair_pattern_ARROW_term__ _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run312 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTBRC ->
        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UNDERSCORE ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState312

and _menhir_run322 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState322 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState322

and _menhir_run283 : _menhir_env -> ('ttv_tail * _menhir_state * Lexing.position) * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__3_ = _endpos in
    let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
    let _3 = () in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__3_ in
    let _v : (Uast.term_desc) = 
# 469 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( t.term_desc )
# 2398 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_block_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_goto_separated_nonempty_list_COMMA_term_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.variant) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState237 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xs_ = _endpos in
        let (xs : (Uast.variant)) = _v in
        let ((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.term)), _startpos_x_), _) = _menhir_stack in
        let _2 = () in
        let _endpos = _endpos_xs_ in
        let _v : (Uast.variant) = 
# 243 "<standard.mly>"
    ( x :: xs )
# 2416 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_term_ _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState1 | MenhirState322 | MenhirState243 | MenhirState198 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__1_ = _endpos in
        let (_1 : (Uast.variant)) = _v in
        let _endpos = _endpos__1_ in
        let _v : (Uast.variant) = 
# 748 "vocal/gospel/ocaml-lib/uparser.mly"
                                    ( _1 )
# 2428 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
        (match _menhir_s with
        | MenhirState243 | MenhirState198 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
                let _menhir_stack = (_menhir_stack, _startpos) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | ATTRIBUTE _v ->
                    _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | EXISTS ->
                    _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FALSE ->
                    _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FLOAT _v ->
                    _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FORALL ->
                    _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FUN ->
                    _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | IF ->
                    _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INTEGER _v ->
                    _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRC ->
                    _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRCCOLON ->
                    _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRCRIGHTBRC ->
                    _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTPAR ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTSQRIGHTSQ ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LET ->
                    _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LIDENT _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MATCH ->
                    _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NOT ->
                    _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OLD ->
                    _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP1 _v ->
                    _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP2 _v ->
                    _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP3 _v ->
                    _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP4 _v ->
                    _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OPPREF _v ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | STAR ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | TRUE ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | UIDENT _v ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState243 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState243)
            | RIGHTSQ ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.variant))) = _menhir_stack in
                let _v : (Uast.variant list) = 
# 241 "<standard.mly>"
    ( [ x ] )
# 2506 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_separated_nonempty_list_BAR_comma_list1_term__ _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | MenhirState322 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_), _), _endpos__3_, _, (_3 : (Uast.variant))) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (Uast.term list) = 
# 744 "vocal/gospel/ocaml-lib/uparser.mly"
                         ( _1 :: _3 )
# 2525 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
            (match _menhir_s with
            | MenhirState20 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | WITH ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
                    let _menhir_stack = (_menhir_stack, _startpos) in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    (match _tok with
                    | BAR ->
                        _menhir_run312 _menhir_env (Obj.magic _menhir_stack) MenhirState325 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                    | LEFTBRC ->
                        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState325 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                    | LEFTPAR ->
                        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState325 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                    | LEFTSQRIGHTSQ ->
                        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState325 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                    | LIDENT _v ->
                        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState325 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                    | UIDENT _v ->
                        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState325 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                    | UNDERSCORE ->
                        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState325 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState325)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | MenhirState8 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | RIGHTPAR ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos__3_ = _endpos in
                    let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.term list)), _startpos__2_) = _menhir_stack in
                    let _3 = () in
                    let _1 = () in
                    let _startpos = _startpos__1_ in
                    let _endpos = _endpos__3_ in
                    let _v : (Uast.term_desc) = 
# 496 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( Ttuple _2 )
# 2584 "vocal/gospel/ocaml-lib/uparser.ml"
                     in
                    _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | _ ->
                _menhir_fail ())
        | MenhirState1 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | INVARIANT ->
                _menhir_run337 _menhir_env (Obj.magic _menhir_stack) MenhirState336 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VARIANT ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState336
            | EOF ->
                _menhir_reduce2 _menhir_env (Obj.magic _menhir_stack) MenhirState336
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState336)
        | _ ->
            _menhir_fail ())
    | MenhirState473 | MenhirState468 | MenhirState451 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_x_ = _endpos in
        let (x : (Uast.variant)) = _v in
        let _v : (Uast.variant) = 
# 144 "<standard.mly>"
    ( x )
# 2620 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_term__ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run179 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState179

and _menhir_run200 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState200

and _menhir_run181 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 2755 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState181

and _menhir_run202 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 2822 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState202 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState202

and _menhir_run217 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 2889 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState217 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState217

and _menhir_run219 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 2956 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState219 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState219

and _menhir_run221 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState221

and _menhir_run227 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState227 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState227

and _menhir_run223 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState223 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState223

and _menhir_run225 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState225 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState225

and _menhir_run229 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState229 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState229

and _menhir_run183 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> _menhir_state -> (
# 83 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 3338 "vocal/gospel/ocaml-lib/uparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState183 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState183

and _menhir_run235 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState235

and _menhir_run231 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState231

and _menhir_run233 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState233

and _menhir_reduce108 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let (_, _endpos) = Obj.magic _menhir_stack in
    let _v : (Uast.term option) = 
# 114 "<standard.mly>"
    ( None )
# 3597 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_option_preceded_EQUAL_term__ _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run391 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState391 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState391

and _menhir_goto_params : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.param list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState382 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            _menhir_run391 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState390 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COERCION | ENSURES | EOF | REQUIRES | VARIANT ->
            _menhir_reduce108 _menhir_env (Obj.magic _menhir_stack) MenhirState390
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState390)
    | MenhirState410 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.param list))), _endpos__2_, _, (_2 : (Uast.param list))) = _menhir_stack in
        let _endpos = _endpos__2_ in
        let _v : (Uast.param list) = 
# 334 "vocal/gospel/ocaml-lib/uparser.mly"
               ( _1 @ _2 )
# 3689 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_params _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState437 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.param list))) = _menhir_stack in
        let _v : (Uast.param list option) = 
# 116 "<standard.mly>"
    ( Some x )
# 3699 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_option_params_ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run383 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState383 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState383

and _menhir_goto_separated_nonempty_list_COMMA_typ_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.pty list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState114 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.pty)), _startpos_x_), _), _, (xs : (Uast.pty list))) = _menhir_stack in
        let _2 = () in
        let _v : (Uast.pty list) = 
# 243 "<standard.mly>"
    ( x :: xs )
# 3730 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_typ_ _menhir_env _menhir_stack _menhir_s _v
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState117 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState117 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState117)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_run93 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.pty) * Lexing.position -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState93 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUESTION ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUOTE_LIDENT _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState93 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState93 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState93

and _menhir_run84 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState84 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUOTE_LIDENT _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState84 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState84 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState84

and _menhir_reduce77 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.pat_desc) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pat_desc)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.pattern) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 572 "vocal/gospel/ocaml-lib/uparser.mly"
             ( mk_pat _1 _startpos _endpos )
# 3812 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState325 | MenhirState311 | MenhirState312 | MenhirState317 | MenhirState21 | MenhirState24 | MenhirState40 | MenhirState125 | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AS ->
            _menhir_run120 _menhir_env (Obj.magic _menhir_stack) MenhirState77
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState77
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState77 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBRC ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState78 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState78 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState78 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UNDERSCORE ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState78 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState78)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState77)
    | MenhirState82 | MenhirState78 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AS ->
            _menhir_run120 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState81 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBRC ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UNDERSCORE ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState82)
        | ARROW | BAR | EQUAL | RIGHTBRC | RIGHTPAR | SEMICOLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.pattern)), _startpos_x_) = _menhir_stack in
            let _endpos = _endpos_x_ in
            let _v : (Uast.pattern list) = 
# 241 "<standard.mly>"
    ( [ x ] )
# 3891 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_mk_pat_pat_uni___ _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState81)
    | _ ->
        _menhir_fail ()

and _menhir_goto_pat_conj_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pat_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ARROW | EQUAL | RIGHTBRC | RIGHTPAR | SEMICOLON ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pat_desc)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.pat_desc) = 
# 580 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( _1 )
# 3916 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_pattern_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | BAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pat_desc)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _v : (Uast.pattern) = let _endpos = _endpos__1_ in
        let _startpos = _startpos__1_ in
        
# 572 "vocal/gospel/ocaml-lib/uparser.mly"
             ( mk_pat _1 _startpos _endpos )
# 3928 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBRC ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState125 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState125 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState125 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState125 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState125 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UNDERSCORE ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState125 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState125)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_reduce75 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.pat_desc) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pat_desc)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.pattern) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 572 "vocal/gospel/ocaml-lib/uparser.mly"
             ( mk_pat _1 _startpos _endpos )
# 3981 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (Uast.pattern)) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.pattern) = 
# 576 "vocal/gospel/ocaml-lib/uparser.mly"
                          ( _1 )
# 3993 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState58 | MenhirState53 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTBRC ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQRIGHTSQ ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState58 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState58 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState58 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UNDERSCORE ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState58 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | AS | BAR | COLON | COMMA | EQUAL | RIGHTBRC | RIGHTPAR | SEMICOLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.pattern)), _startpos_x_) = _menhir_stack in
            let _endpos = _endpos_x_ in
            let _v : (Uast.pattern list) = 
# 221 "<standard.mly>"
    ( [ x ] )
# 4021 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_nonempty_list_pat_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState58)
    | MenhirState325 | MenhirState311 | MenhirState312 | MenhirState317 | MenhirState21 | MenhirState24 | MenhirState40 | MenhirState125 | MenhirState82 | MenhirState78 | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLONCOLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBRC ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState74 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState74 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState74 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState74 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState74 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UNDERSCORE ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState74 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState74)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState74 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pattern)), _startpos__1_), _endpos__3_, _, (_3 : (Uast.pattern)), _startpos__3_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Uast.pat_desc) = let _endpos = _endpos__3_ in
        let _startpos = _startpos__1_ in
        
# 592 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Papp (Qpreid (mk_pid (infix "::") _startpos _endpos),[_1;_3]) )
# 4072 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_pat_uni_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState456 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState460 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState460)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_term_rec_field_term_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.qualid * Uast.term) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | SEMICOLON ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState286 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState286 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTBRC ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (x : (Uast.qualid * Uast.term))) = _menhir_stack in
            let x_inlined1 = () in
            let _v : ((Uast.qualid * Uast.term) list) = let _2 =
              let x = x_inlined1 in
              
# 126 "<standard.mly>"
    ( Some x )
# 4177 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 752 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( [x] )
# 4183 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_semicolon_list1_term_rec_field_term__ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState286)
    | RIGHTBRC ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (x : (Uast.qualid * Uast.term))) = _menhir_stack in
        let _v : ((Uast.qualid * Uast.term) list) = let _2 = 
# 124 "<standard.mly>"
    ( None )
# 4196 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 752 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( [x] )
# 4201 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_semicolon_list1_term_rec_field_term__ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_term_dot_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.term_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_d_ = _endpos in
    let (d : (Uast.term_desc)) = _v in
    let _startpos_d_ = _startpos in
    let _startpos = _startpos_d_ in
    let _endpos = _endpos_d_ in
    let _v : (Uast.term) = let _endpos = _endpos_d_ in
    let _startpos = _startpos_d_ in
    
# 567 "vocal/gospel/ocaml-lib/uparser.mly"
                  ( mk_term d _startpos _endpos )
# 4225 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (Uast.term)) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.term) = 
# 450 "vocal/gospel/ocaml-lib/uparser.mly"
                             ( _1 )
# 4237 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState8 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState322 | MenhirState315 | MenhirState20 | MenhirState308 | MenhirState306 | MenhirState301 | MenhirState143 | MenhirState144 | MenhirState289 | MenhirState150 | MenhirState280 | MenhirState278 | MenhirState151 | MenhirState265 | MenhirState261 | MenhirState174 | MenhirState254 | MenhirState251 | MenhirState175 | MenhirState246 | MenhirState243 | MenhirState237 | MenhirState235 | MenhirState233 | MenhirState231 | MenhirState229 | MenhirState227 | MenhirState225 | MenhirState223 | MenhirState221 | MenhirState219 | MenhirState217 | MenhirState215 | MenhirState205 | MenhirState202 | MenhirState200 | MenhirState198 | MenhirState183 | MenhirState181 | MenhirState179 | MenhirState176 | MenhirState171 | MenhirState154 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_s = MenhirState170 in
                let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
                let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | ATTRIBUTE _v ->
                    _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | DOT ->
                    _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | EQUAL ->
                    _menhir_run132 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | EXISTS ->
                    _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FALSE ->
                    _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FLOAT _v ->
                    _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FORALL ->
                    _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FUN ->
                    _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | IF ->
                    _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INTEGER _v ->
                    _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRC ->
                    _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRCCOLON ->
                    _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBRCRIGHTBRC ->
                    _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTPAR ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTSQ ->
                    _menhir_run28 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTSQRIGHTSQ ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LET ->
                    _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LIDENT _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MATCH ->
                    _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NOT ->
                    _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OLD ->
                    _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP1 _v ->
                    _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP2 _v ->
                    _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP3 _v ->
                    _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OP4 _v ->
                    _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | OPPREF _v ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | STAR ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | TRUE ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | UIDENT _v ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState171)
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState170 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState170 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState170)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState5 | MenhirState10 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_o_, _menhir_s, (o : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 4344 "vocal/gospel/ocaml-lib/uparser.ml"
        )), _startpos_o_), _endpos_a_, _, (a : (Uast.term)), _startpos_a_) = _menhir_stack in
        let _startpos = _startpos_o_ in
        let _endpos = _endpos_a_ in
        let _v : (Uast.term_desc) = let o =
          let _endpos = _endpos_o_ in
          let _startpos = _startpos_o_ in
          
# 637 "vocal/gospel/ocaml-lib/uparser.mly"
             ( mk_pid (prefix o)  _startpos _endpos )
# 4354 "vocal/gospel/ocaml-lib/uparser.ml"
          
        in
        
# 464 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( Tidapp (Qpreid o, [a]) )
# 4360 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_dot_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_semicolon_list1_pattern_rec_field_pattern__ : _menhir_env -> 'ttv_tail -> _menhir_state -> ((Uast.qualid * Uast.pattern) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState41 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (fl : ((Uast.qualid * Uast.pattern) list)) = _v in
        let _v : ((Uast.qualid * Uast.pattern) list) = 
# 615 "vocal/gospel/ocaml-lib/uparser.mly"
                                             ( fl )
# 4376 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTBRC ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _, (_2 : ((Uast.qualid * Uast.pattern) list))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (Uast.pat_desc) = 
# 611 "vocal/gospel/ocaml-lib/uparser.mly"
                                          ( Prec _2 )
# 4397 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pat_arg_shared_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState49 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (xl : ((Uast.qualid * Uast.pattern) list)) = _v in
        let (_menhir_stack, _menhir_s, (x : (Uast.qualid * Uast.pattern))) = _menhir_stack in
        let _2 = () in
        let _v : ((Uast.qualid * Uast.pattern) list) = 
# 753 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( x :: xl )
# 4415 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_semicolon_list1_pattern_rec_field_pattern__ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_reduce68 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (Uast.variant) = 
# 142 "<standard.mly>"
    ( [] )
# 4426 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_loption_separated_nonempty_list_COMMA_term__ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_list_fun_arg_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.labelled_arg list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState496 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_args_ = _endpos in
        let (args : (Uast.labelled_arg list)) = _v in
        let ((_menhir_stack, _menhir_s, (ret : (Uast.labelled_arg list)), _startpos_ret_), _endpos_nm_, _, (nm : (Identifier.preid)), _startpos_nm_) = _menhir_stack in
        let _startpos = _startpos_ret_ in
        let _endpos = _endpos_args_ in
        let _v : (Uast.labelled_arg list * Identifier.preid * Uast.labelled_arg list) = 
# 256 "vocal/gospel/ocaml-lib/uparser.mly"
    ( ret, nm, args )
# 4444 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_val_spec_header _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState510 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xs_ = _endpos in
        let (xs : (Uast.labelled_arg list)) = _v in
        let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.labelled_arg))) = _menhir_stack in
        let _endpos = _endpos_xs_ in
        let _v : (Uast.labelled_arg list) = 
# 213 "<standard.mly>"
    ( x :: xs )
# 4457 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_list_fun_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState514 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_args_ = _endpos in
        let (args : (Uast.labelled_arg list)) = _v in
        let (_menhir_stack, _endpos_nm_, _menhir_s, (nm : (Identifier.preid)), _startpos_nm_) = _menhir_stack in
        let _startpos = _startpos_nm_ in
        let _endpos = _endpos_args_ in
        let _v : (Uast.labelled_arg list * Identifier.preid * Uast.labelled_arg list) = 
# 258 "vocal/gospel/ocaml-lib/uparser.mly"
    ( [], nm, args )
# 4471 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_val_spec_header _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_ret_value_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.labelled_arg list) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    match _menhir_s with
    | MenhirState344 | MenhirState423 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_1 : (Uast.labelled_arg list)) = _v in
        let _startpos__1_ = _startpos in
        let _startpos = _startpos__1_ in
        let _v : (Uast.labelled_arg list) = 
# 732 "vocal/gospel/ocaml-lib/uparser.mly"
                                    ( _1 )
# 4489 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
        (match _menhir_s with
        | MenhirState423 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | RIGHTPAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_stack = (_menhir_stack, _endpos) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | EQUAL ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                    let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos__4_ = _endpos in
                    let _startpos__4_ = _startpos in
                    let (((_menhir_stack, _menhir_s, _startpos__1_), _, (_2 : (Uast.labelled_arg list)), _startpos__2_), _endpos__3_) = _menhir_stack in
                    let _4 = () in
                    let _3 = () in
                    let _1 = () in
                    let _startpos = _startpos__1_ in
                    let _v : (Uast.labelled_arg list) = 
# 318 "vocal/gospel/ocaml-lib/uparser.mly"
    ( _2 )
# 4521 "vocal/gospel/ocaml-lib/uparser.ml"
                     in
                    _menhir_goto_ret_name _menhir_env _menhir_stack _menhir_s _v _startpos
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let ((_menhir_stack, _menhir_s, _, _), _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | MenhirState344 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | EQUAL ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__2_ = _endpos in
                let _startpos__2_ = _startpos in
                let (_menhir_stack, _menhir_s, (_1 : (Uast.labelled_arg list)), _startpos__1_) = _menhir_stack in
                let _2 = () in
                let _startpos = _startpos__1_ in
                let _v : (Uast.labelled_arg list) = 
# 320 "vocal/gospel/ocaml-lib/uparser.mly"
    ( _1 )
# 4555 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_ret_name _menhir_env _menhir_stack _menhir_s _v _startpos
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            _menhir_fail ())
    | MenhirState427 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (xs : (Uast.labelled_arg list)) = _v in
        let _startpos_xs_ = _startpos in
        let (_menhir_stack, _menhir_s, (x : (Uast.labelled_arg)), _startpos_x_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_x_ in
        let _v : (Uast.labelled_arg list) = 
# 243 "<standard.mly>"
    ( x :: xs )
# 4577 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_ret_value_ _menhir_env _menhir_stack _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_pat_arg_shared_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pat_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (Uast.pat_desc)) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.pat_desc) = 
# 600 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( _1 )
# 4595 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_pat_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_goto_term_sub_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.term_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term_desc)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.term_desc) = 
# 465 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( _1 )
# 4614 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_dot_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | AMPAMP | AND | ARROW | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | FALSE | FLOAT _ | IN | INTEGER _ | INVARIANT | LARROW | LEFTBRC | LEFTBRCCOLON | LEFTBRCRIGHTBRC | LEFTPAR | LEFTSQ | LEFTSQRIGHTSQ | LIDENT _ | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OPPREF _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | TRUE | UIDENT _ | VARIANT | WITH ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term_desc)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.term_desc) = 
# 459 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( _1 )
# 4625 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_reduce80 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.term_desc) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos_d_, _menhir_s, (d : (Uast.term_desc)), _startpos_d_) = _menhir_stack in
    let _startpos = _startpos_d_ in
    let _endpos = _endpos_d_ in
    let _v : (Uast.term) = let _endpos = _endpos_d_ in
    let _startpos = _startpos_d_ in
    
# 567 "vocal/gospel/ocaml-lib/uparser.mly"
                  ( mk_term d _startpos _endpos )
# 4645 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (Uast.term)) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.term) = 
# 449 "vocal/gospel/ocaml-lib/uparser.mly"
                             ( _1 )
# 4657 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState8 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState322 | MenhirState315 | MenhirState20 | MenhirState308 | MenhirState306 | MenhirState301 | MenhirState143 | MenhirState289 | MenhirState150 | MenhirState280 | MenhirState278 | MenhirState151 | MenhirState154 | MenhirState265 | MenhirState254 | MenhirState251 | MenhirState175 | MenhirState246 | MenhirState243 | MenhirState237 | MenhirState235 | MenhirState233 | MenhirState231 | MenhirState229 | MenhirState227 | MenhirState225 | MenhirState223 | MenhirState221 | MenhirState219 | MenhirState217 | MenhirState215 | MenhirState205 | MenhirState202 | MenhirState200 | MenhirState198 | MenhirState183 | MenhirState181 | MenhirState179 | MenhirState176 | MenhirState171 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | FALSE ->
            _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FLOAT _v ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INTEGER _v ->
            _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRC ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState174 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRCCOLON ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState174 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRCRIGHTBRC ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState174 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQ ->
            _menhir_run175 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQRIGHTSQ ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OPPREF _v ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TRUE ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState174 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState174)
    | MenhirState261 | MenhirState174 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTSQ ->
            _menhir_run175 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState259 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | FALSE | FLOAT _ | IN | INTEGER _ | INVARIANT | LARROW | LEFTBRC | LEFTBRCCOLON | LEFTBRCRIGHTBRC | LEFTPAR | LEFTSQRIGHTSQ | LIDENT _ | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OPPREF _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | TRUE | UIDENT _ | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_) = _menhir_stack in
            let _endpos = _endpos__1_ in
            let _v : (Uast.term * Lexing.position * Lexing.position) = let _endpos = _endpos__1_ in
            let _startpos = _startpos__1_ in
            
# 764 "vocal/gospel/ocaml-lib/uparser.mly"
              ( _1, _startpos, _endpos )
# 4712 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState261 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState261 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState261 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState261 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | AMPAMP | AND | ARROW | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | VARIANT | WITH ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.term * Lexing.position * Lexing.position))) = _menhir_stack in
                let _endpos = _endpos_x_ in
                let _v : ((Uast.term * Lexing.position * Lexing.position) list) = 
# 221 "<standard.mly>"
    ( [ x ] )
# 4750 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_nonempty_list_located_term_arg__ _menhir_env _menhir_stack _endpos _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState261)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState259)
    | MenhirState144 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTSQ ->
            _menhir_run175 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState291 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState291 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState292 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState292 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState292)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState291)
    | MenhirState5 | MenhirState10 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_o_, _menhir_s, (o : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 4794 "vocal/gospel/ocaml-lib/uparser.ml"
        )), _startpos_o_), _endpos_a_, _, (a : (Uast.term)), _startpos_a_) = _menhir_stack in
        let _startpos = _startpos_o_ in
        let _endpos = _endpos_a_ in
        let _v : (Uast.term_desc) = let o =
          let _endpos = _endpos_o_ in
          let _startpos = _startpos_o_ in
          
# 637 "vocal/gospel/ocaml-lib/uparser.mly"
             ( mk_pid (prefix o)  _startpos _endpos )
# 4804 "vocal/gospel/ocaml-lib/uparser.ml"
          
        in
        
# 458 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( Tidapp (Qpreid o, [a]) )
# 4810 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_func_name : _menhir_env -> 'ttv_tail -> _menhir_state -> (Identifier.preid) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState373 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run383 _menhir_env (Obj.magic _menhir_stack) MenhirState382 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState382)
    | MenhirState436 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run383 _menhir_env (Obj.magic _menhir_stack) MenhirState437 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState437 in
            let _v : (Uast.param list option) = 
# 114 "<standard.mly>"
    ( None )
# 4844 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_option_params_ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState437)
    | _ ->
        _menhir_fail ()

and _menhir_goto_lqualid_rich : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.qualid) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__3_ = _endpos in
    let (_3 : (Uast.qualid)) = _v in
    let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_), _endpos__2_, _startpos__2_) = _menhir_stack in
    let _2 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__3_ in
    let _v : (Uast.term_desc) = 
# 485 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( Tidapp (_3,[_1]) )
# 4867 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_goto_ident_rich : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Identifier.preid) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    match _menhir_s with
    | MenhirState348 | MenhirState149 | MenhirState158 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__3_ = _endpos in
        let (_3 : (Identifier.preid)) = _v in
        let _startpos__3_ = _startpos in
        let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_), _endpos__2_, _, _startpos__2_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Uast.qualid) = 
# 711 "vocal/gospel/ocaml-lib/uparser.mly"
                          ( Qdot (_1, _3) )
# 4887 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_qualid _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState362 | MenhirState356 | MenhirState360 | MenhirState358 | MenhirState354 | MenhirState346 | MenhirState352 | MenhirState350 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState20 | MenhirState322 | MenhirState315 | MenhirState306 | MenhirState308 | MenhirState143 | MenhirState301 | MenhirState144 | MenhirState289 | MenhirState150 | MenhirState151 | MenhirState278 | MenhirState280 | MenhirState154 | MenhirState171 | MenhirState265 | MenhirState174 | MenhirState261 | MenhirState175 | MenhirState254 | MenhirState251 | MenhirState176 | MenhirState179 | MenhirState181 | MenhirState183 | MenhirState246 | MenhirState243 | MenhirState198 | MenhirState237 | MenhirState200 | MenhirState202 | MenhirState215 | MenhirState227 | MenhirState235 | MenhirState229 | MenhirState231 | MenhirState233 | MenhirState219 | MenhirState221 | MenhirState223 | MenhirState225 | MenhirState217 | MenhirState205 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__1_ = _endpos in
        let (_1 : (Identifier.preid)) = _v in
        let _startpos__1_ = _startpos in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.qualid) = 
# 710 "vocal/gospel/ocaml-lib/uparser.mly"
                          ( Qpreid _1 )
# 4901 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_qualid _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_uqualid : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.qualid) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState503 | MenhirState492 | MenhirState440 | MenhirState420 | MenhirState385 | MenhirState292 | MenhirState286 | MenhirState119 | MenhirState84 | MenhirState117 | MenhirState114 | MenhirState112 | MenhirState86 | MenhirState108 | MenhirState106 | MenhirState95 | MenhirState98 | MenhirState99 | MenhirState96 | MenhirState93 | MenhirState91 | MenhirState89 | MenhirState49 | MenhirState41 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState42 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState43 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState43 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState43)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState42)
    | MenhirState325 | MenhirState311 | MenhirState317 | MenhirState312 | MenhirState21 | MenhirState24 | MenhirState40 | MenhirState125 | MenhirState82 | MenhirState78 | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_run54 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState53 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRC ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQRIGHTSQ ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState53 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState53 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState53 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UNDERSCORE ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState53 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | AS | BAR | COLON | COLONCOLON | COMMA | EQUAL | RIGHTBRC | RIGHTPAR | SEMICOLON ->
            _menhir_reduce117 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState53)
    | MenhirState456 | MenhirState74 | MenhirState58 | MenhirState53 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_run54 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState55 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | AS | BAR | COLON | COMMA | EQUAL | LEFTBRC | LEFTPAR | LEFTSQRIGHTSQ | LIDENT _ | RIGHTBRC | RIGHTPAR | SEMICOLON | UIDENT _ | UNDERSCORE ->
            _menhir_reduce117 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState55)
    | MenhirState144 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState148 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState149 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState149 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState149 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run150 _menhir_env (Obj.magic _menhir_stack) MenhirState149 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState149 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState149 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState149 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState149)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState148)
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState322 | MenhirState315 | MenhirState20 | MenhirState308 | MenhirState306 | MenhirState301 | MenhirState143 | MenhirState289 | MenhirState150 | MenhirState280 | MenhirState278 | MenhirState151 | MenhirState265 | MenhirState261 | MenhirState174 | MenhirState254 | MenhirState251 | MenhirState175 | MenhirState246 | MenhirState243 | MenhirState237 | MenhirState235 | MenhirState233 | MenhirState231 | MenhirState229 | MenhirState227 | MenhirState225 | MenhirState223 | MenhirState221 | MenhirState219 | MenhirState217 | MenhirState215 | MenhirState205 | MenhirState202 | MenhirState200 | MenhirState198 | MenhirState183 | MenhirState181 | MenhirState179 | MenhirState176 | MenhirState171 | MenhirState154 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState157 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run150 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState158)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState157)
    | MenhirState170 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState269 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState270 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState270 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState270 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState270)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState269)
    | MenhirState362 | MenhirState360 | MenhirState358 | MenhirState356 | MenhirState354 | MenhirState352 | MenhirState350 | MenhirState346 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState347 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState348)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState347)
    | MenhirState454 | MenhirState464 | MenhirState455 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState456 in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState457 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState457)
        | DOT ->
            _menhir_run54 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState456 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRC ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState456 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState456 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQRIGHTSQ ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState456 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState456 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState456 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UNDERSCORE ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState456 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_q_, _menhir_s, (q : (Uast.qualid)), _startpos_q_) = _menhir_stack in
            let _startpos = _startpos_q_ in
            let _endpos = _endpos_q_ in
            let _v : (Uast.qualid * (Uast.pattern * Uast.term) option) = 
# 329 "vocal/gospel/ocaml-lib/uparser.mly"
    ( q, None)
# 5194 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_raises _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState456)
    | _ ->
        _menhir_fail ()

and _menhir_goto_option_cast_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.pty option) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_2 : (Uast.pty option)) = _v in
    let (_menhir_stack, _menhir_s, (_1 : (Identifier.preid list))) = _menhir_stack in
    let _v : (Uast.binder list) = 
# 434 "vocal/gospel/ocaml-lib/uparser.mly"
                    ( List.map (fun id -> id, _2) _1 )
# 5213 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState152 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState154)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState189 | MenhirState186 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState189 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState189)
        | DOT | LEFTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (x : (Uast.binder list))) = _menhir_stack in
            let _v : (Uast.binder list list) = 
# 241 "<standard.mly>"
    ( [ x ] )
# 5313 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_quant_vars_ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_term_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.term_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_d_ = _endpos in
    let (d : (Uast.term_desc)) = _v in
    let _startpos_d_ = _startpos in
    let _startpos = _startpos_d_ in
    let _endpos = _endpos_d_ in
    let _v : (Uast.term) = let _endpos = _endpos_d_ in
    let _startpos = _startpos_d_ in
    
# 567 "vocal/gospel/ocaml-lib/uparser.mly"
                  ( mk_term d _startpos _endpos )
# 5339 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_t_ = _endpos in
    let (t : (Uast.term)) = _v in
    let _startpos_t_ = _startpos in
    let _startpos = _startpos_t_ in
    let _endpos = _endpos_t_ in
    let _v : (Uast.term) = 
# 363 "vocal/gospel/ocaml-lib/uparser.mly"
                         ( t )
# 5351 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState176 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState178
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState178
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState178
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState178
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState178
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState178
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState178 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState178
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState178 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState178 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState178 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState178 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState178 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState178
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState178 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__5_ = _endpos in
            let ((((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_), _endpos__2_, _, _startpos__2_), _), _endpos__4_, _, (_4 : (Uast.term)), _startpos__4_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__5_ in
            let _v : (Uast.term_desc) = 
# 495 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (below_op _startpos__2_ _endpos__2_, [_1;_4]) )
# 5406 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState178 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState178)
    | MenhirState179 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState180 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _endpos__1_, _, _startpos__1_), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o =
              let _endpos = _endpos__1_ in
              let _startpos = _startpos__1_ in
              
# 651 "vocal/gospel/ocaml-lib/uparser.mly"
            ( mk_pid (infix "*")   _startpos _endpos )
# 5436 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 380 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (Qpreid o, [l; r]) )
# 5442 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState180)
    | MenhirState181 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState182 _v
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _endpos_o_, _, (o : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 5461 "vocal/gospel/ocaml-lib/uparser.ml"
            )), _startpos_o_), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o =
              let _endpos = _endpos_o_ in
              let _startpos = _startpos_o_ in
              
# 652 "vocal/gospel/ocaml-lib/uparser.mly"
            ( mk_pid (infix o)    _startpos _endpos )
# 5471 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 380 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (Qpreid o, [l; r]) )
# 5477 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState182)
    | MenhirState183 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _, (o : (
# 83 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 5490 "vocal/gospel/ocaml-lib/uparser.ml"
        ))), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
        let _startpos = _startpos_l_ in
        let _endpos = _endpos_r_ in
        let _v : (Uast.term_desc) = let _endpos = _endpos_r_ in
        let _startpos = _startpos_l_ in
        
# 384 "vocal/gospel/ocaml-lib/uparser.mly"
    ( let id = mk_pid o _startpos _endpos in
      Tidapp (Qpreid id, [l; r]) )
# 5500 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState473 | MenhirState468 | MenhirState451 | MenhirState1 | MenhirState322 | MenhirState243 | MenhirState237 | MenhirState198 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState199
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState199
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState199
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState199 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState199
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState199
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState199
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState199 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState237 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState237)
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState199 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState199
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState199 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState199 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState199 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState199 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState199 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState199
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState199 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | INVARIANT | MODIFIES | RAISES | REQUIRES | RIGHTPAR | RIGHTSQ | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.term)), _startpos_x_) = _menhir_stack in
            let _endpos = _endpos_x_ in
            let _v : (Uast.variant) = 
# 241 "<standard.mly>"
    ( [ x ] )
# 5610 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_term_ _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState199)
    | MenhirState200 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState201
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState201
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState201 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState201
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState201
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState201 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState201 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState201 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState201 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState201 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState201 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState201
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState201 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | BAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o = 
# 506 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Tor )
# 5657 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 376 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tbinop (l, o, r) )
# 5662 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState201)
    | MenhirState202 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState203 _v
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState203 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _endpos_o_, _, (o : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 5683 "vocal/gospel/ocaml-lib/uparser.ml"
            )), _startpos_o_), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o =
              let _endpos = _endpos_o_ in
              let _startpos = _startpos_o_ in
              
# 650 "vocal/gospel/ocaml-lib/uparser.mly"
            ( mk_pid (infix o)    _startpos _endpos )
# 5693 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 380 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (Qpreid o, [l; r]) )
# 5699 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState203)
    | MenhirState205 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_), _endpos__2_, _, (_2 : (Uast.term)), _startpos__2_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__2_ in
        let _v : (Uast.term_desc) = 
# 374 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (Qpreid _1, [_2]) )
# 5715 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState215 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState216
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState216
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState216
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState216 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState216
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState216
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState216
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState216 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState216
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState216 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState216 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState216 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState216 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState216 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState216
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState216 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | COERCION | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (string)), _startpos__1_), _endpos__2_, _, (_2 : (Uast.term)), _startpos__2_) = _menhir_stack in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__2_ in
            let _v : (Uast.term_desc) = 
# 412 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tattr (_1, _2) )
# 5763 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState216)
    | MenhirState217 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState218 _v
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState218 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState218 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState218 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _endpos_o_, _, (o : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 5788 "vocal/gospel/ocaml-lib/uparser.ml"
            )), _startpos_o_), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o =
              let _endpos = _endpos_o_ in
              let _startpos = _startpos_o_ in
              
# 649 "vocal/gospel/ocaml-lib/uparser.mly"
            ( mk_pid (infix o)    _startpos _endpos )
# 5798 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 380 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (Qpreid o, [l; r]) )
# 5804 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState218)
    | MenhirState219 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState220 _v
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState220
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | MODEL | MODIFIES | MUTABLE | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _endpos_o_, _, (o : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 5839 "vocal/gospel/ocaml-lib/uparser.ml"
            )), _startpos_o_), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o =
              let _endpos = _endpos_o_ in
              let _startpos = _startpos_o_ in
              
# 645 "vocal/gospel/ocaml-lib/uparser.mly"
            ( mk_pid (infix o)    _startpos _endpos )
# 5849 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 378 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tinfix (l, o, r) )
# 5855 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState220)
    | MenhirState221 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState222 _v
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState222
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState222 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState222 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState222 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState222 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState222 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState222 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState222 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | MODEL | MODIFIES | MUTABLE | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _endpos__1_, _, _startpos__1_), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o =
              let _endpos = _endpos__1_ in
              let _startpos = _startpos__1_ in
              
# 647 "vocal/gospel/ocaml-lib/uparser.mly"
            ( mk_pid (infix "<>") _startpos _endpos )
# 5897 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 378 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tinfix (l, o, r) )
# 5903 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState222)
    | MenhirState223 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState224
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | MODEL | MODIFIES | MUTABLE | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _endpos__1_, _, _startpos__1_), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o =
              let _endpos = _endpos__1_ in
              let _startpos = _startpos__1_ in
              
# 646 "vocal/gospel/ocaml-lib/uparser.mly"
            ( mk_pid (infix "=")  _startpos _endpos )
# 5945 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 378 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tinfix (l, o, r) )
# 5951 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState224)
    | MenhirState225 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState226 _v
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState226
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState226 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState226 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState226 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState226 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let _endpos = _endpos_r_ in
            let _startpos = _startpos_l_ in
            
# 382 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (Qpreid (mk_pid (infix "::") _startpos _endpos), [l; r]) )
# 5986 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState226)
    | MenhirState227 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState228
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState228
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState228
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState228
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState228
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState228 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState228
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState228 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState228 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState228 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState228 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState228 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState228
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState228 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o = 
# 505 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Tiff )
# 6037 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 376 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tbinop (l, o, r) )
# 6042 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState228)
    | MenhirState229 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState230
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState230
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState230
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState230
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState230
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | BAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o = 
# 507 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Tor_asym )
# 6089 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 376 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tbinop (l, o, r) )
# 6094 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState230)
    | MenhirState231 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState232
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState232
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState232 _v
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState232
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState232 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState232 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState232 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState232 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState232 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState232 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState232 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | MODEL | MODIFIES | MUTABLE | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o = 
# 508 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Tand )
# 6137 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 376 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tbinop (l, o, r) )
# 6142 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState232)
    | MenhirState233 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState234
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState234
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState234 _v
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState234
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState234 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState234 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState234 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState234 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState234 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState234 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState234 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | MODEL | MODIFIES | MUTABLE | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o = 
# 509 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Tand_asym )
# 6185 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 376 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tbinop (l, o, r) )
# 6190 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState234)
    | MenhirState235 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState236
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState236
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState236
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState236 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState236
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState236
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState236 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState236
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState236 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState236 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState236 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState236 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState236 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState236
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState236 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_l_, _menhir_s, (l : (Uast.term)), _startpos_l_), _endpos__1_, _), _endpos_r_, _, (r : (Uast.term)), _startpos_r_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos_l_ in
            let _endpos = _endpos_r_ in
            let _v : (Uast.term_desc) = let o = 
# 504 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Timplies )
# 6241 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 376 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tbinop (l, o, r) )
# 6246 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState236)
    | MenhirState246 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState247
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState247
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState247
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState247
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState247
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState247
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState247
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | COERCION | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((_menhir_stack, _menhir_s, (_1 : (Uast.quant)), _startpos__1_), _, (_2 : (Uast.binder list list))), (_3 : (Uast.variant list))), _endpos__4_, _startpos__4_), _endpos__5_, _, (_5 : (Uast.term)), _startpos__5_) = _menhir_stack in
            let _4 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__5_ in
            let _v : (Uast.term_desc) = 
# 408 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tquant (_1, List.concat _2, _3, _5) )
# 6299 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState247)
    | MenhirState175 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState249 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | DOTDOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState249 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | RIGHTSQ ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_s = MenhirState254 in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__5_ = _endpos in
                let ((((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_), _endpos__2_, _, _startpos__2_), _endpos__3_, _, (_3 : (Uast.term)), _startpos__3_), _) = _menhir_stack in
                let _5 = () in
                let _4 = () in
                let _2 = () in
                let _startpos = _startpos__1_ in
                let _endpos = _endpos__5_ in
                let _v : (Uast.term_desc) = 
# 493 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (above_op _startpos__2_ _endpos__2_, [_1;_3]) )
# 6394 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState254)
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState249 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState251 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState251)
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState249
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState249 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__4_ = _endpos in
            let (((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_), _endpos__2_, _, _startpos__2_), _endpos__3_, _, (_3 : (Uast.term)), _startpos__3_) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__4_ in
            let _v : (Uast.term_desc) = 
# 487 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (get_op _startpos__2_ _endpos__2_, [_1;_3]) )
# 6501 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState249)
    | MenhirState251 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState252
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState252
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState252 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState252
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState252
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState252
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState252
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState252
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState252 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__6_ = _endpos in
            let (((((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_), _endpos__2_, _, _startpos__2_), _endpos__3_, _, (_3 : (Uast.term)), _startpos__3_), _), _endpos__5_, _, (_5 : (Uast.term)), _startpos__5_) = _menhir_stack in
            let _6 = () in
            let _4 = () in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__6_ in
            let _v : (Uast.term_desc) = 
# 489 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (set_op _startpos__2_ _endpos__2_, [_1;_3;_5]) )
# 6561 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState252)
    | MenhirState254 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState256
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState256
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState256
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState256
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState256
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState256
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState256 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState256
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState256 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState256 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState256 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState256 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState256 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState256
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState256 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__6_ = _endpos in
            let (((((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_), _endpos__2_, _, _startpos__2_), _endpos__3_, _, (_3 : (Uast.term)), _startpos__3_), _), _endpos__5_, _, (_5 : (Uast.term)), _startpos__5_) = _menhir_stack in
            let _6 = () in
            let _4 = () in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__6_ in
            let _v : (Uast.term_desc) = 
# 491 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (sub_op _startpos__2_ _endpos__2_, [_1;_3;_5]) )
# 6621 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState256 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState256)
    | MenhirState171 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState263
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState263
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState263
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState263 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState263
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState263
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState263
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState263 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState263 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState265)
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState263
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState263 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState263 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState263 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState263 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState263 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState263
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState263 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__5_ = _endpos in
            let ((((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_), _endpos__2_, _startpos__2_), _, _startpos__3_), _endpos__4_, _, (_4 : (Uast.term)), _startpos__4_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__5_ in
            let _v : (Uast.term_desc) = 
# 498 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (array_get _startpos__2_ _endpos__2_, [_1; _4]) )
# 6744 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState263 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState263)
    | MenhirState265 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState266
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState266
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState266
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState266 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState266
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState266
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState266
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState266 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState266
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState266 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState266 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState266 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState266 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState266 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState266
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState266 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__7_ = _endpos in
            let ((((((_menhir_stack, _endpos_t1_, _menhir_s, (t1 : (Uast.term)), _startpos_t1_), _endpos__2_, _startpos__2_), _, _startpos__3_), _endpos_t2_, _, (t2 : (Uast.term)), _startpos_t2_), _), _endpos_t3_, _, (t3 : (Uast.term)), _startpos_t3_) = _menhir_stack in
            let _7 = () in
            let _5 = () in
            let _3 = () in
            let _2 = () in
            let _startpos = _startpos_t1_ in
            let _endpos = _endpos__7_ in
            let _v : (Uast.term_desc) = 
# 500 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tidapp (set_op _startpos__2_ _endpos__2_, [t1;t2;t3]) )
# 6805 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState266 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState266)
    | MenhirState154 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState276
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState276
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState276
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState276 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState276
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState276
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState276 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState276
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState276 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState276 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState276 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState276 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState276 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState276
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState276 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s, _startpos__1_), _, (args : (Uast.binder list))), _endpos__3_), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos_t_ in
            let _v : (Uast.term_desc) = 
# 410 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tquant (Tlambda, args, [], t) )
# 6859 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState276)
    | MenhirState151 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState277
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState277
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState277 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState277
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState277
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState277
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState277
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState277
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState277 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState278 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState278)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState277)
    | MenhirState278 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState279
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState279
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState279
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState279
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState279
        | ELSE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState279 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState280)
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState279
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState279
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState279)
    | MenhirState280 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState281
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState281
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState281
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState281 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState281
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState281
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState281
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState281 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState281
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState281 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState281 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState281 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState281 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState281 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState281
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState281 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | COERCION | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.term)), _startpos__2_), _), _endpos__4_, _, (_4 : (Uast.term)), _startpos__4_), _), _endpos__6_, _, (_6 : (Uast.term)), _startpos__6_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__6_ in
            let _v : (Uast.term_desc) = 
# 390 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tif (_2, _4, _6) )
# 7122 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState281)
    | MenhirState150 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState282
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState282
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState282 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState282
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState282
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState282
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState282
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState282
        | RIGHTPAR ->
            _menhir_run283 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState282 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState282)
    | MenhirState289 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState290
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState290
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState290
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState290
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState290
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState290
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState290
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTBRC | SEMICOLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.qualid)), _startpos_x_), _endpos__2_, _startpos__2_), _endpos_y_, _, (y : (Uast.term)), _startpos_y_) = _menhir_stack in
            let _2 = () in
            let _v : (Uast.qualid * Uast.term) = let _1 = 
# 175 "<standard.mly>"
    ( (x, y) )
# 7216 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 422 "vocal/gospel/ocaml-lib/uparser.mly"
                                    ( _1 )
# 7221 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_rec_field_term_ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState290)
    | MenhirState143 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState300
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState300
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState300 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState300
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState300
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState300
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState300 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState301 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState301)
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState300
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState300
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState300)
    | MenhirState301 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState302
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState302
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState302
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState302 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState302
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState302
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState302
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState302 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState302
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState302 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState302 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState302 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState302 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState302 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState302
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState302 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | COERCION | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.pattern))), _endpos__3_, _startpos__3_), _endpos__4_, _, (_4 : (Uast.term)), _startpos__4_), _), _endpos__6_, _, (_6 : (Uast.term)), _startpos__6_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__6_ in
            let _v : (Uast.term_desc) = 
# 392 "vocal/gospel/ocaml-lib/uparser.mly"
    ( let cast ty = { _4 with term_desc = Tcast (_4, ty) } in
      let pat, def = match _2.pat_desc with
        | Ptuple [] -> { _2 with pat_desc = Pwild }, cast (PTtuple [])
        | Pcast ({pat_desc = (Pvar _|Pwild)} as p, ty) -> p, cast ty
        | _ -> _2, _4 in
      match pat.pat_desc with
      | Pvar id -> Tlet (id, def, _6)
      | Pwild -> Tlet (id_anonymous pat.pat_loc, def, _6)
      | _ -> Tcase (def, [pat, _6]) )
# 7388 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState302)
    | MenhirState306 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState307
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState307
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState307
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState307 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState307
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState307
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState307
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState307 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState307 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState308 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState308)
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState307
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState307 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState307 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState307 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState307 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState307 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState307
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState307 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState307)
    | MenhirState308 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState309
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState309
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState309
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState309 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState309
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState309
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState309
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState309 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState309
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState309 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState309 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState309 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState309 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState309 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState309
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState309 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | COERCION | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((((_menhir_stack, _menhir_s, _startpos__1_), _, (_2 : (Identifier.preid))), _endpos__3_, _startpos__3_), _endpos__4_, _, (_4 : (Uast.term)), _startpos__4_), _), _endpos__6_, _, (_6 : (Uast.term)), _startpos__6_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__6_ in
            let _v : (Uast.term_desc) = 
# 402 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tlet (_2, _4, _6) )
# 7547 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState309)
    | MenhirState20 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState310
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState310
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState310 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState310
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState310
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState310
        | COMMA ->
            _menhir_run322 _menhir_env (Obj.magic _menhir_stack) MenhirState310
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState310
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState310
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState310 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BAR ->
                _menhir_run312 _menhir_env (Obj.magic _menhir_stack) MenhirState311 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState311 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState311 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState311 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState311 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState311 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UNDERSCORE ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState311 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState311)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState310)
    | MenhirState315 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState316
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState316
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState316
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState316 _v
        | BAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState316 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBRC ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState317 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState317 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState317 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState317 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UNDERSCORE ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState317 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState317)
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState316
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState316
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState316 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState316
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState316 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState316 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState316 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState316 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState316 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState316
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState316 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | MODEL | MODIFIES | MUTABLE | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.pattern))), _endpos__2_), _endpos_y_, _, (y : (Uast.term)), _startpos_y_) = _menhir_stack in
            let _2 = () in
            let _endpos = _endpos_y_ in
            let _v : ((Uast.pattern * Uast.term) list) = let x = 
# 175 "<standard.mly>"
    ( (x, y) )
# 7690 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 241 "<standard.mly>"
    ( [ x ] )
# 7695 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_separated_nonempty_list_BAR_separated_pair_pattern_ARROW_term__ _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState316)
    | MenhirState19 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState327 _v
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState327
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState327 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState327 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState327 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState327 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState327 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState327 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState327 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | MODEL | MODIFIES | MUTABLE | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.term)), _startpos__2_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__2_ in
            let _v : (Uast.term_desc) = 
# 370 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tnot _2 )
# 7734 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState327)
    | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState328 _v
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState328 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState328 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState328 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState328 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.term)), _startpos__2_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__2_ in
            let _v : (Uast.term_desc) = 
# 372 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Told _2 )
# 7765 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState328)
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState329
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState329
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState329
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState329 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState329
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState329
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState329
        | COLONRIGHTBRC ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState329 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (Uast.term_desc) = let _endpos = _endpos__3_ in
            let _startpos = _startpos__1_ in
            
# 478 "vocal/gospel/ocaml-lib/uparser.mly"
    ( let id = Qpreid (mk_pid (mixfix "{:_:}") _startpos _endpos) in
      Tidapp (id, [t]) )
# 7809 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_block_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState329 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState329
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState329 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState329 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState329 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState329 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState329 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState329
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState329 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState329)
    | MenhirState8 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState333
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState333
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState333 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState333
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState333
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState333
        | COMMA ->
            _menhir_run322 _menhir_env (Obj.magic _menhir_stack) MenhirState333
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState333
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState333
        | RIGHTPAR ->
            _menhir_run283 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState333 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState333)
    | MenhirState337 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState338
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState338 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INVARIANT ->
            _menhir_run337 _menhir_env (Obj.magic _menhir_stack) MenhirState338 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState338 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState338 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState338 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState338 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState338 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState338 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | VARIANT ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | EOF ->
            _menhir_reduce2 _menhir_env (Obj.magic _menhir_stack) MenhirState338
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState338)
    | MenhirState391 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState392
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState392
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState392
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState392 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState392
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState392
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState392
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState392 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState392
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState392 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState392 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState392 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState392 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState392 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState392
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState392 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COERCION | ENSURES | EOF | REQUIRES | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _endpos_x_, _, (x : (Uast.term)), _startpos_x_) = _menhir_stack in
            let _1 = () in
            let _endpos = _endpos_x_ in
            let _v : (Uast.term option) = let x = 
# 183 "<standard.mly>"
    ( x )
# 7971 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            
# 116 "<standard.mly>"
    ( Some x )
# 7976 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_option_preceded_EQUAL_term__ _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState392)
    | MenhirState394 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState395
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState395
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState395
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState395 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState395
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState395
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState395
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState395 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState395
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState395 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState395 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState395 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState395 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState395 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState395
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState395 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COERCION | ENSURES | EOF | REQUIRES | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _1 = () in
            let _endpos = _endpos_t_ in
            let _v : (Uast.term) = 
# 208 "vocal/gospel/ocaml-lib/uparser.mly"
                 (t)
# 8028 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            (match _menhir_s with
            | MenhirState442 | MenhirState393 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_t_ = _endpos in
                let (t : (Uast.term)) = _v in
                let _endpos = _endpos_t_ in
                let _v : (Uast.fun_spec) = 
# 195 "vocal/gospel/ocaml-lib/uparser.mly"
             ( {empty_fspec with fun_variant = [t]} )
# 8040 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_func_spec _menhir_env _menhir_stack _endpos _menhir_s _v
            | MenhirState404 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_t_ = _endpos in
                let (t : (Uast.term)) = _v in
                let (_menhir_stack, _endpos_bd_, _menhir_s, (bd : (Uast.fun_spec))) = _menhir_stack in
                let _endpos = _endpos_t_ in
                let _v : (Uast.fun_spec) = 
# 202 "vocal/gospel/ocaml-lib/uparser.mly"
    ( {bd with fun_variant = t :: bd.fun_variant} )
# 8053 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_func_spec _menhir_env _menhir_stack _endpos _menhir_s _v
            | _ ->
                _menhir_fail ())
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState395)
    | MenhirState396 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState397
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState397
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState397
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState397 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState397
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState397
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState397
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState397 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState397
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState397 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState397 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState397 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState397 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState397 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState397
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState397 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | CHECKS | COERCION | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _1 = () in
            let _endpos = _endpos_t_ in
            let _v : (Uast.term) = 
# 212 "vocal/gospel/ocaml-lib/uparser.mly"
                  (t)
# 8107 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            (match _menhir_s with
            | MenhirState442 | MenhirState393 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_t_ = _endpos in
                let (t : (Uast.term)) = _v in
                let _endpos = _endpos_t_ in
                let _v : (Uast.fun_spec) = 
# 193 "vocal/gospel/ocaml-lib/uparser.mly"
             ( {empty_fspec with fun_req = [t]} )
# 8119 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_func_spec _menhir_env _menhir_stack _endpos _menhir_s _v
            | MenhirState404 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_t_ = _endpos in
                let (t : (Uast.term)) = _v in
                let (_menhir_stack, _endpos_bd_, _menhir_s, (bd : (Uast.fun_spec))) = _menhir_stack in
                let _endpos = _endpos_t_ in
                let _v : (Uast.fun_spec) = 
# 198 "vocal/gospel/ocaml-lib/uparser.mly"
    ( {bd with fun_req = t :: bd.fun_req} )
# 8132 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_func_spec _menhir_env _menhir_stack _endpos _menhir_s _v
            | MenhirState479 | MenhirState450 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_t_ = _endpos in
                let (t : (Uast.term)) = _v in
                let (_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_) = _menhir_stack in
                let _startpos = _startpos_bd_ in
                let _v : (Uast.val_spec) = 
# 273 "vocal/gospel/ocaml-lib/uparser.mly"
    ( { bd with sp_pre = (t,false) :: bd.sp_pre } )
# 8145 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos
            | _ ->
                _menhir_fail ())
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState397)
    | MenhirState398 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState399
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState399
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState399
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState399 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState399
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState399
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState399
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState399 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState399
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState399 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState399 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState399 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState399 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState399 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState399
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState399 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | CHECKS | COERCION | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _1 = () in
            let _endpos = _endpos_t_ in
            let _v : (Uast.term) = 
# 216 "vocal/gospel/ocaml-lib/uparser.mly"
                 (t)
# 8199 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            (match _menhir_s with
            | MenhirState404 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_t_ = _endpos in
                let (t : (Uast.term)) = _v in
                let (_menhir_stack, _endpos_bd_, _menhir_s, (bd : (Uast.fun_spec))) = _menhir_stack in
                let _endpos = _endpos_t_ in
                let _v : (Uast.fun_spec) = 
# 200 "vocal/gospel/ocaml-lib/uparser.mly"
    ( {bd with fun_ens = t :: bd.fun_ens} )
# 8212 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_func_spec _menhir_env _menhir_stack _endpos _menhir_s _v
            | MenhirState442 | MenhirState393 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_t_ = _endpos in
                let (t : (Uast.term)) = _v in
                let _endpos = _endpos_t_ in
                let _v : (Uast.fun_spec) = 
# 194 "vocal/gospel/ocaml-lib/uparser.mly"
             ( {empty_fspec with fun_ens = [t]} )
# 8224 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_func_spec _menhir_env _menhir_stack _endpos _menhir_s _v
            | MenhirState479 | MenhirState450 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_t_ = _endpos in
                let (t : (Uast.term)) = _v in
                let (_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_) = _menhir_stack in
                let _startpos = _startpos_bd_ in
                let _v : (Uast.val_spec) = 
# 277 "vocal/gospel/ocaml-lib/uparser.mly"
    ( { bd with sp_post = t :: bd.sp_post} )
# 8237 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos
            | _ ->
                _menhir_fail ())
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState399)
    | MenhirState416 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState417
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState417
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState417
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState417 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState417
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState417
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState417
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState417 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState417
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState417 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState417 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState417 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState417 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState417 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState417
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState417 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_id_, _, (id : (Identifier.preid)), _startpos_id_), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _v : (Uast.prop) = let _endpos = _endpos_t_ in
            let _startpos = _startpos__1_ in
            
# 163 "vocal/gospel/ocaml-lib/uparser.mly"
  ( {prop_name = id; prop_term = t;
     prop_loc = mk_loc _startpos _endpos; prop_kind = Plemma} )
# 8295 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_prop _menhir_env _menhir_stack _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState417)
    | MenhirState433 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState434
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState434
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState434
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState434 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState434
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState434
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState434
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState434 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState434
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState434 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState434 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState434 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState434 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState434 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState434
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState434 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EOF | EPHEMERAL | INVARIANT | MODEL | MUTABLE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_inv_, _, (inv : (Uast.term)), _startpos_inv_) = _menhir_stack in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos_inv_ in
            let _v : (Uast.term) = 
# 241 "vocal/gospel/ocaml-lib/uparser.mly"
  ( inv )
# 8348 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            (match _menhir_s with
            | MenhirState344 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_inv_ = _endpos in
                let (inv : (Uast.term)) = _v in
                let _startpos_inv_ = _startpos in
                let _startpos = _startpos_inv_ in
                let _endpos = _endpos_inv_ in
                let _v : (Uast.type_spec) = 
# 225 "vocal/gospel/ocaml-lib/uparser.mly"
    ( {empty_tspec with ty_invariant = [inv]} )
# 8362 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_type_spec _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | MenhirState484 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_inv_ = _endpos in
                let (inv : (Uast.term)) = _v in
                let _startpos_inv_ = _startpos in
                let (_menhir_stack, _endpos_ts_, _menhir_s, (ts : (Uast.type_spec)), _startpos_ts_) = _menhir_stack in
                let _startpos = _startpos_ts_ in
                let _endpos = _endpos_inv_ in
                let _v : (Uast.type_spec) = 
# 231 "vocal/gospel/ocaml-lib/uparser.mly"
  ( {ts with ty_invariant = inv :: ts.ty_invariant} )
# 8377 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_type_spec _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | _ ->
                _menhir_fail ())
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState434)
    | MenhirState447 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState448
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState448
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState448
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState448 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState448
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState448
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState448
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState448 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState448
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState448 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState448 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState448 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState448 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState448 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState448
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState448 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_id_, _, (id : (Identifier.preid)), _startpos_id_), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _v : (Uast.prop) = let _endpos = _endpos_t_ in
            let _startpos = _startpos__1_ in
            
# 160 "vocal/gospel/ocaml-lib/uparser.mly"
  ( {prop_name = id; prop_term = t;
     prop_loc = mk_loc _startpos _endpos; prop_kind = Paxiom} )
# 8435 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_prop _menhir_env _menhir_stack _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState448)
    | MenhirState457 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState458
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState458
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState458
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState458 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState458
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState458
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState458
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState458 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState458
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState458 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState458 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState458 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState458 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState458 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState458
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState458 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_q_, _menhir_s, (q : (Uast.qualid)), _startpos_q_), _endpos__2_, _), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_q_ in
            let _endpos = _endpos_t_ in
            let _v : (Uast.qualid * (Uast.pattern * Uast.term) option) = 
# 325 "vocal/gospel/ocaml-lib/uparser.mly"
    ( q, Some (mk_pat (Ptuple []) _startpos_q_ _endpos_q_, t) )
# 8488 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_raises _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState458)
    | MenhirState460 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState461
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState461
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState461
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState461 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState461
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState461
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState461
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState461 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState461
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState461 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState461 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState461 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState461 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState461 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState461
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState461 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | BAR | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _endpos_q_, _menhir_s, (q : (Uast.qualid)), _startpos_q_), _endpos_p_, _, (p : (Uast.pattern)), _startpos_p_), _endpos__3_), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _3 = () in
            let _startpos = _startpos_q_ in
            let _endpos = _endpos_t_ in
            let _v : (Uast.qualid * (Uast.pattern * Uast.term) option) = 
# 327 "vocal/gospel/ocaml-lib/uparser.mly"
    ( q, Some (p, t) )
# 8541 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_raises _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState461)
    | MenhirState475 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP ->
            _menhir_run233 _menhir_env (Obj.magic _menhir_stack) MenhirState476
        | AND ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState476
        | ARROW ->
            _menhir_run235 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState476
        | BACKQUOTE_LIDENT _v ->
            _menhir_run183 _menhir_env (Obj.magic _menhir_stack) MenhirState476 _v
        | BARBAR ->
            _menhir_run229 _menhir_env (Obj.magic _menhir_stack) MenhirState476
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState476
        | COLONCOLON ->
            _menhir_run225 _menhir_env (Obj.magic _menhir_stack) MenhirState476
        | EQUAL ->
            _menhir_run223 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState476 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LRARROW ->
            _menhir_run227 _menhir_env (Obj.magic _menhir_stack) MenhirState476
        | LTGT ->
            _menhir_run221 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState476 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run219 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState476 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState476 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run202 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState476 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState476 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OR ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState476
        | STAR ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState476 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_), _), _endpos_t_, _, (t : (Uast.term)), _startpos_t_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_bd_ in
            let _v : (Uast.val_spec) = 
# 275 "vocal/gospel/ocaml-lib/uparser.mly"
    ( { bd with sp_pre = (t,true) :: bd.sp_pre } )
# 8593 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState476)
    | _ ->
        _menhir_fail ()

and _menhir_goto_ty_tuple : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pty list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState96 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__3_ = _endpos in
        let (_3 : (Uast.pty list)) = _v in
        let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pty)), _startpos__1_), _endpos__2_, _, _startpos__2_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Uast.pty) = 
# 540 "vocal/gospel/ocaml-lib/uparser.mly"
    ( PTtuple (_1 :: _3) )
# 8618 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_typ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState99 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__3_ = _endpos in
        let (_3 : (Uast.pty list)) = _v in
        let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pty)), _startpos__1_), _endpos__2_, _, _startpos__2_) = _menhir_stack in
        let _2 = () in
        let _endpos = _endpos__3_ in
        let _v : (Uast.pty list) = 
# 547 "vocal/gospel/ocaml-lib/uparser.mly"
    ( _1 :: _3 )
# 8632 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_ty_tuple _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_typ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pty) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState89 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState91)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState91 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState92
        | COERCION | COMMA | ENSURES | EOF | EPHEMERAL | EQUAL | INVARIANT | MODEL | MUTABLE | REQUIRES | RIGHTPAR | RIGHTSQ | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((_menhir_stack, _menhir_s, _startpos__1_), _endpos_id_, _, (id : (Identifier.preid)), _startpos_id_), _endpos_aty_, _, (aty : (Uast.pty)), _startpos_aty_), _endpos__5_), _endpos_rty_, _, (rty : (Uast.pty)), _startpos_rty_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos_rty_ in
            let _v : (Uast.pty) = 
# 535 "vocal/gospel/ocaml-lib/uparser.mly"
    ( PTarrow (Lquestion id, aty, rty) )
# 8692 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_typ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState92)
    | MenhirState93 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState94
        | COERCION | COMMA | ENSURES | EOF | EPHEMERAL | EQUAL | INVARIANT | MODEL | MUTABLE | REQUIRES | RIGHTPAR | RIGHTSQ | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pty)), _startpos__1_), _endpos__2_, _), _endpos__3_, _, (_3 : (Uast.pty)), _startpos__3_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (Uast.pty) = 
# 537 "vocal/gospel/ocaml-lib/uparser.mly"
    ( let l = mk_loc _startpos__1_ _endpos__2_ in
      PTarrow (Lnone (id_anonymous l), _1, _3) )
# 8716 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_typ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState94)
    | MenhirState106 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState108 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState108 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState108 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState108)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState109
        | COERCION | COMMA | ENSURES | EOF | EPHEMERAL | EQUAL | INVARIANT | MODEL | MUTABLE | REQUIRES | RIGHTPAR | RIGHTSQ | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _endpos_id_, _menhir_s, (id : (Identifier.preid)), _startpos_id_), _endpos_aty_, _, (aty : (Uast.pty)), _startpos_aty_), _endpos__4_), _endpos_rty_, _, (rty : (Uast.pty)), _startpos_rty_) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _startpos = _startpos_id_ in
            let _endpos = _endpos_rty_ in
            let _v : (Uast.pty) = 
# 533 "vocal/gospel/ocaml-lib/uparser.mly"
    ( PTarrow (Lnamed id, aty, rty) )
# 8772 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_typ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState109)
    | MenhirState86 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState110
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState110 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112)
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState110 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.pty)), _startpos__2_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (Uast.pty) = 
# 556 "vocal/gospel/ocaml-lib/uparser.mly"
    ( _2 )
# 8822 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_ty_arg _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState110)
    | MenhirState114 | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState113
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState113 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState114 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState114 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState114 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState114 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState114 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState114)
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Uast.pty)), _startpos_x_) = _menhir_stack in
            let _v : (Uast.pty list) = 
# 241 "<standard.mly>"
    ( [ x ] )
# 8863 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_typ_ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState113)
    | MenhirState385 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState386
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState386 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__5_ = _endpos in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _, (params : (Identifier.preid list))), _endpos__1_inlined1_, _, (_1_inlined1 : (Uast.pty)), _startpos__1_inlined1_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _endpos = _endpos__5_ in
            let _v : (Uast.param list) = let t =
              let _1 = _1_inlined1 in
              
# 564 "vocal/gospel/ocaml-lib/uparser.mly"
      (_1)
# 8894 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            let _endpos = _endpos__5_ in
            let _startpos = _startpos__1_ in
            
# 339 "vocal/gospel/ocaml-lib/uparser.mly"
    ( List.map (fun x -> mk_loc _startpos _endpos, x, t) params )
# 8902 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run383 _menhir_env (Obj.magic _menhir_stack) MenhirState410 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | COERCION | COLON | ENSURES | EOF | EQUAL | REQUIRES | VARIANT ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.param list))) = _menhir_stack in
                let _endpos = _endpos__1_ in
                let _v : (Uast.param list) = 
# 333 "vocal/gospel/ocaml-lib/uparser.mly"
         ( _1 )
# 8918 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_params _menhir_env _menhir_stack _endpos _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState410)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState386)
    | MenhirState420 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState421
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState421 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__5_ = _endpos in
            let (((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _endpos_id_, _, (id : (Identifier.preid)), _startpos_id_), _endpos_ty_, _, (ty : (Uast.pty)), _startpos_ty_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _v : (Uast.labelled_arg) = 
# 314 "vocal/gospel/ocaml-lib/uparser.mly"
   ( Lghost (id, ty) )
# 8951 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_ret_value _menhir_env _menhir_stack _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState421)
    | MenhirState440 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState441
        | EQUAL ->
            _menhir_run391 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState441 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COERCION | ENSURES | EOF | REQUIRES | VARIANT ->
            _menhir_reduce108 _menhir_env (Obj.magic _menhir_stack) MenhirState441
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState441)
    | MenhirState492 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState493
        | EOF | EPHEMERAL | INVARIANT | MODEL | MUTABLE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, (mut : (bool)), _startpos_mut_), _endpos_id_, _, (id : (Identifier.preid)), _startpos_id_), _endpos_ty_, _, (ty : (Uast.pty)), _startpos_ty_) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _startpos = _startpos_mut_ in
            let _endpos = _endpos_ty_ in
            let _v : (Uast.field) = 
# 236 "vocal/gospel/ocaml-lib/uparser.mly"
  ( { f_preid = id; f_mutable = mut;
      f_pty = ty; f_loc = mk_loc _startpos_mut_ _endpos_ty_ })
# 8991 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            (match _menhir_s with
            | MenhirState344 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_field_ = _endpos in
                let (field : (Uast.field)) = _v in
                let _startpos_field_ = _startpos in
                let _startpos = _startpos_field_ in
                let _endpos = _endpos_field_ in
                let _v : (Uast.type_spec) = 
# 223 "vocal/gospel/ocaml-lib/uparser.mly"
    ( {empty_tspec with ty_field = [field]} )
# 9005 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_type_spec _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | MenhirState484 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_field_ = _endpos in
                let (field : (Uast.field)) = _v in
                let _startpos_field_ = _startpos in
                let (_menhir_stack, _endpos_ts_, _menhir_s, (ts : (Uast.type_spec)), _startpos_ts_) = _menhir_stack in
                let _startpos = _startpos_ts_ in
                let _endpos = _endpos_field_ in
                let _v : (Uast.type_spec) = 
# 229 "vocal/gospel/ocaml-lib/uparser.mly"
  ( {ts with ty_field = field :: ts.ty_field} )
# 9020 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_type_spec _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | _ ->
                _menhir_fail ())
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState493)
    | MenhirState503 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState504
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState504 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__5_ = _endpos in
            let (((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _endpos_id_, _, (id : (Identifier.preid)), _startpos_id_), _endpos_ty_, _, (ty : (Uast.pty)), _startpos_ty_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _endpos = _endpos__5_ in
            let _v : (Uast.labelled_arg) = 
# 307 "vocal/gospel/ocaml-lib/uparser.mly"
   ( Lghost (id, ty) )
# 9051 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_fun_arg _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState504)
    | _ ->
        _menhir_fail ()

and _menhir_goto_nonempty_list_binder_var_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Identifier.preid list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState152 | MenhirState186 | MenhirState189 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) MenhirState191
        | ARROW | COMMA | DOT | LEFTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState191 in
            let _v : (Uast.pty option) = 
# 114 "<standard.mly>"
    ( None )
# 9078 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_option_cast_ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState191)
    | MenhirState194 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (x : (Identifier.preid))), _, (xs : (Identifier.preid list))) = _menhir_stack in
        let _v : (Identifier.preid list) = 
# 223 "<standard.mly>"
    ( x :: xs )
# 9092 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_nonempty_list_binder_var_ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_pat_uni_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pat_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState325 | MenhirState311 | MenhirState312 | MenhirState317 | MenhirState21 | MenhirState24 | MenhirState40 | MenhirState125 | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW | BAR | EQUAL | RIGHTBRC | RIGHTPAR | SEMICOLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pat_desc)), _startpos__1_) = _menhir_stack in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__1_ in
            let _v : (Uast.pat_desc) = 
# 585 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( _1 )
# 9115 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pat_conj_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | AS | COLON | COMMA ->
            _menhir_reduce77 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState82 | MenhirState78 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce77 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        _menhir_fail ()

and _menhir_goto_pat_arg_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pat_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState456 | MenhirState74 | MenhirState58 | MenhirState53 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce75 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState325 | MenhirState311 | MenhirState312 | MenhirState317 | MenhirState21 | MenhirState24 | MenhirState40 | MenhirState125 | MenhirState82 | MenhirState78 | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ARROW | AS | BAR | COLON | COMMA | EQUAL | RIGHTBRC | RIGHTPAR | SEMICOLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pat_desc)), _startpos__1_) = _menhir_stack in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__1_ in
            let _v : (Uast.pat_desc) = 
# 590 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( _1 )
# 9152 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pat_uni_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | COLONCOLON ->
            _menhir_reduce75 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_reduce238 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.qualid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_) = _menhir_stack in
    let _v : (Uast.qualid * Uast.term) = 
# 423 "vocal/gospel/ocaml-lib/uparser.mly"
          ( let t = {term_desc = Tpreid _1;
                     term_loc = loc_of_qualid _1} in
            (_1,t)
          )
# 9175 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_rec_field_term_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run289 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.qualid) * Lexing.position -> Lexing.position -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState289

and _menhir_reduce234 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Uast.qualid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.term_desc) = 
# 463 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( Tpreid _1 )
# 9250 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_dot_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_goto_pattern_rec_field_pattern_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.qualid * Uast.pattern) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | SEMICOLON ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState49 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState49 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTBRC ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (x : (Uast.qualid * Uast.pattern))) = _menhir_stack in
            let x_inlined1 = () in
            let _v : ((Uast.qualid * Uast.pattern) list) = let _2 =
              let x = x_inlined1 in
              
# 126 "<standard.mly>"
    ( Some x )
# 9279 "vocal/gospel/ocaml-lib/uparser.ml"
              
            in
            
# 752 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( [x] )
# 9285 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_semicolon_list1_pattern_rec_field_pattern__ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState49)
    | RIGHTBRC ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (x : (Uast.qualid * Uast.pattern))) = _menhir_stack in
        let _v : ((Uast.qualid * Uast.pattern) list) = let _2 = 
# 124 "<standard.mly>"
    ( None )
# 9298 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        
# 752 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( [x] )
# 9303 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_semicolon_list1_pattern_rec_field_pattern__ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_val_spec : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.val_spec) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | EOF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_menhir_stack, _menhir_s, (_1 : (Uast.val_spec)), _startpos__1_) = _menhir_stack in
        let _2 = () in
        let _v : (Uast.spec) = let _endpos = _endpos__2_ in
        let _startpos = _startpos__1_ in
        
# 147 "vocal/gospel/ocaml-lib/uparser.mly"
                    ( Sval (_1, mk_loc _startpos _endpos) )
# 9332 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_spec_init _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run451 : _menhir_env -> 'ttv_tail * _menhir_state * (Uast.val_spec) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState451 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
        _menhir_reduce68 _menhir_env (Obj.magic _menhir_stack) MenhirState451
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState451

and _menhir_run396 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState396 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState396

and _menhir_run454 : _menhir_env -> 'ttv_tail * _menhir_state * (Uast.val_spec) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState454 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState455 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState455)
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState454 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState454

and _menhir_run468 : _menhir_env -> 'ttv_tail * _menhir_state * (Uast.val_spec) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState468 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
        _menhir_reduce68 _menhir_env (Obj.magic _menhir_stack) MenhirState468
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState468

and _menhir_run470 : _menhir_env -> 'ttv_tail * _menhir_state * (Uast.val_spec) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | STRING _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (e : (
# 84 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 9575 "vocal/gospel/ocaml-lib/uparser.ml"
        )) = _v in
        let ((_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_), _) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_bd_ in
        let _v : (Uast.val_spec) = 
# 282 "vocal/gospel/ocaml-lib/uparser.mly"
    ( { bd with sp_equiv = e :: bd.sp_equiv} )
# 9583 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run398 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState398 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState398

and _menhir_run472 : _menhir_env -> 'ttv_tail * _menhir_state * (Uast.val_spec) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_) = _menhir_stack in
    let _2 = () in
    let _startpos = _startpos_bd_ in
    let _v : (Uast.val_spec) = 
# 265 "vocal/gospel/ocaml-lib/uparser.mly"
  ( {bd with sp_diverge = true} )
# 9666 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos

and _menhir_run473 : _menhir_env -> 'ttv_tail * _menhir_state * (Uast.val_spec) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState473 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
        _menhir_reduce68 _menhir_env (Obj.magic _menhir_stack) MenhirState473
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState473

and _menhir_run475 : _menhir_env -> 'ttv_tail * _menhir_state * (Uast.val_spec) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState475 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState475

and _menhir_goto_option_UNDERSCORE_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit option) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_2 : (unit option)) = _v in
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 9806 "vocal/gospel/ocaml-lib/uparser.ml"
    )), _startpos__1_) = _menhir_stack in
    let _v : (string) = 
# 692 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( prefix _1       )
# 9811 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce134 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (string) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (string)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _v : (Identifier.preid) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 641 "vocal/gospel/ocaml-lib/uparser.mly"
            ( mk_pid (prefix _1)  _startpos _endpos )
# 9824 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState205

and _menhir_reduce48 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (string) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (string)), _startpos__1_) = _menhir_stack in
    let _v : (string) = 
# 689 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( infix _1        )
# 9894 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v

and _menhir_run139 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (string) * Lexing.position -> Lexing.position -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__2_ = _endpos in
    let _startpos__2_ = _startpos in
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (string)), _startpos__1_) = _menhir_stack in
    let _2 = () in
    let _v : (string) = 
# 690 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( prefix _1       )
# 9909 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v

and _menhir_run374 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EQUAL ->
        _menhir_run132 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState374 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | UNDERSCORE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COLONRIGHTBRC ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_stack = (_menhir_stack, _endpos) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | RIGHTPAR ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos__5_ = _endpos in
                    let ((((_menhir_stack, _menhir_s, _startpos__1_), _, _startpos__2_), _endpos__3_, _startpos__3_), _endpos__4_) = _menhir_stack in
                    let _5 = () in
                    let _4 = () in
                    let _3 = () in
                    let _2 = () in
                    let _1 = () in
                    let _v : (Identifier.preid) = let _endpos = _endpos__5_ in
                    let _startpos = _startpos__1_ in
                    
# 190 "vocal/gospel/ocaml-lib/uparser.mly"
    ( mk_pid (mixfix "{:_:}") _startpos _endpos )
# 9963 "vocal/gospel/ocaml-lib/uparser.ml"
                     in
                    _menhir_goto_func_name _menhir_env _menhir_stack _menhir_s _v
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let (((_menhir_stack, _menhir_s, _), _, _), _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s, _), _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | LEFTBRCRIGHTBRC ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_s = MenhirState374 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, _startpos__2_) = _menhir_stack in
            let _3 = () in
            let _2 = () in
            let _1 = () in
            let _v : (Identifier.preid) = let _endpos = _endpos__3_ in
            let _startpos = _startpos__1_ in
            
# 188 "vocal/gospel/ocaml-lib/uparser.mly"
    ( mk_pid (mixfix "{}") _startpos _endpos )
# 10008 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_func_name _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | LEFTSQ ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState374 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState374

and _menhir_reduce64 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let (_, _endpos) = Obj.magic _menhir_stack in
    let _v : (Uast.labelled_arg list) = 
# 211 "<standard.mly>"
    ( [] )
# 10042 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_list_fun_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run497 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState497 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState497

and _menhir_run499 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState499 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState499

and _menhir_run501 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState501 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState501

and _menhir_run506 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RIGHTPAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _endpos = _endpos__2_ in
        let _v : (Uast.labelled_arg) = let _endpos = _endpos__2_ in
        let _startpos = _startpos__1_ in
        
# 299 "vocal/gospel/ocaml-lib/uparser.mly"
   ( Lnone (create_pid "()" []  (mk_loc _startpos _endpos)) )
# 10106 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_fun_arg _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_ret_value : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.labelled_arg) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTSQ ->
            _menhir_run418 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState427 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState427 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState427)
    | EQUAL | RIGHTPAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (x : (Uast.labelled_arg)), _startpos_x_) = _menhir_stack in
        let _startpos = _startpos_x_ in
        let _v : (Uast.labelled_arg list) = 
# 241 "<standard.mly>"
    ( [ x ] )
# 10143 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_ret_value_ _menhir_env _menhir_stack _menhir_s _v _startpos
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run22 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.pat_desc) = 
# 605 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Pwild )
# 10165 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_pat_arg_shared_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run25 : _menhir_env -> 'ttv_tail * _menhir_state * Lexing.position -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__2_ = _endpos in
    let (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
    let _2 = () in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__2_ in
    let _v : (Uast.pat_desc) = 
# 607 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Ptuple [] )
# 10182 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_pat_arg_shared_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run23 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.pat_desc) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 609 "vocal/gospel/ocaml-lib/uparser.mly"
  ( Papp (Qpreid (mk_pid "[]"  _startpos _endpos), []) )
# 10200 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_pat_arg_shared_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run40 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTBRC ->
        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState40 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState40 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | RIGHTPAR ->
        _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState40
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState40 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UNDERSCORE ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState40 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState40

and _menhir_run41 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState41 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState41 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState41

and _menhir_run9 : _menhir_env -> 'ttv_tail * _menhir_state * Lexing.position -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__2_ = _endpos in
    let (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
    let _2 = () in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__2_ in
    let _v : (Uast.term_desc) = 
# 470 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( Ttuple [] )
# 10257 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_block_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run10 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 10264 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UNDERSCORE ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState10 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | RIGHTPAR ->
        _menhir_reduce100 _menhir_env (Obj.magic _menhir_stack) MenhirState10
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState10

and _menhir_run28 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOTDOT ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | LARROW ->
        _menhir_run35 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | UNDERSCORE ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState28 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState28

and _menhir_goto_term_block_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.term_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    match _menhir_s with
    | MenhirState149 | MenhirState158 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_d_ = _endpos in
        let (d : (Uast.term_desc)) = _v in
        let _startpos_d_ = _startpos in
        let _endpos = _endpos_d_ in
        let _v : (Uast.term) = let _endpos = _endpos_d_ in
        let _startpos = _startpos_d_ in
        
# 567 "vocal/gospel/ocaml-lib/uparser.mly"
                  ( mk_term d _startpos _endpos )
# 10336 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__3_ = _endpos in
        let (_3 : (Uast.term)) = _v in
        let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_), _endpos__2_, _, _startpos__2_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Uast.term_desc) = 
# 484 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( Tscope (_1, _3) )
# 10349 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState322 | MenhirState315 | MenhirState20 | MenhirState308 | MenhirState306 | MenhirState301 | MenhirState143 | MenhirState144 | MenhirState289 | MenhirState150 | MenhirState280 | MenhirState278 | MenhirState151 | MenhirState154 | MenhirState265 | MenhirState261 | MenhirState174 | MenhirState254 | MenhirState251 | MenhirState175 | MenhirState246 | MenhirState243 | MenhirState237 | MenhirState235 | MenhirState233 | MenhirState231 | MenhirState229 | MenhirState227 | MenhirState225 | MenhirState223 | MenhirState221 | MenhirState219 | MenhirState217 | MenhirState215 | MenhirState205 | MenhirState202 | MenhirState200 | MenhirState198 | MenhirState183 | MenhirState181 | MenhirState179 | MenhirState176 | MenhirState171 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__1_ = _endpos in
        let (_1 : (Uast.term_desc)) = _v in
        let _startpos__1_ = _startpos in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.term_desc) = 
# 483 "vocal/gospel/ocaml-lib/uparser.mly"
                                                    ( _1 )
# 10363 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_term_sub_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        _menhir_fail ()

and _menhir_goto_numeral : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Oasttypes.constant) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (Oasttypes.constant)) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.term_desc) = 
# 455 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( Tconst _1 )
# 10381 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_goto_term_arg_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.term_desc) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState8 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState322 | MenhirState315 | MenhirState20 | MenhirState308 | MenhirState306 | MenhirState301 | MenhirState143 | MenhirState289 | MenhirState150 | MenhirState280 | MenhirState278 | MenhirState151 | MenhirState154 | MenhirState265 | MenhirState254 | MenhirState251 | MenhirState175 | MenhirState246 | MenhirState243 | MenhirState237 | MenhirState235 | MenhirState233 | MenhirState231 | MenhirState229 | MenhirState227 | MenhirState225 | MenhirState223 | MenhirState221 | MenhirState219 | MenhirState217 | MenhirState215 | MenhirState205 | MenhirState202 | MenhirState200 | MenhirState198 | MenhirState183 | MenhirState181 | MenhirState179 | MenhirState176 | MenhirState171 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AMPAMP | AND | ARROW | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term_desc)), _startpos__1_) = _menhir_stack in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__1_ in
            let _v : (Uast.term_desc) = 
# 368 "vocal/gospel/ocaml-lib/uparser.mly"
    ( _1 )
# 10402 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | FALSE | FLOAT _ | INTEGER _ | LEFTBRC | LEFTBRCCOLON | LEFTBRCRIGHTBRC | LEFTPAR | LEFTSQ | LEFTSQRIGHTSQ | LIDENT _ | OPPREF _ | TRUE | UIDENT _ ->
            _menhir_reduce80 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState5 | MenhirState10 | MenhirState144 | MenhirState261 | MenhirState174 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce80 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        _menhir_fail ()

and _menhir_goto_quant : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.quant) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState186 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState186

and _menhir_goto_lident_rich : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Identifier.preid) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState362 | MenhirState356 | MenhirState360 | MenhirState358 | MenhirState354 | MenhirState346 | MenhirState352 | MenhirState350 | MenhirState348 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState20 | MenhirState322 | MenhirState315 | MenhirState306 | MenhirState308 | MenhirState143 | MenhirState301 | MenhirState144 | MenhirState289 | MenhirState149 | MenhirState150 | MenhirState151 | MenhirState278 | MenhirState280 | MenhirState154 | MenhirState171 | MenhirState265 | MenhirState174 | MenhirState261 | MenhirState175 | MenhirState254 | MenhirState251 | MenhirState176 | MenhirState179 | MenhirState181 | MenhirState183 | MenhirState246 | MenhirState243 | MenhirState198 | MenhirState237 | MenhirState200 | MenhirState202 | MenhirState215 | MenhirState227 | MenhirState235 | MenhirState229 | MenhirState231 | MenhirState233 | MenhirState219 | MenhirState221 | MenhirState223 | MenhirState225 | MenhirState217 | MenhirState205 | MenhirState158 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Identifier.preid) = 
# 676 "vocal/gospel/ocaml-lib/uparser.mly"
                ( _1 )
# 10446 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_ident_rich _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState270 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_), _endpos__2_, _, _startpos__2_), _endpos__3_, _, (_3 : (Identifier.preid)), _startpos__3_) = _menhir_stack in
        let _2 = () in
        let _endpos = _endpos__3_ in
        let _v : (Uast.qualid) = 
# 716 "vocal/gospel/ocaml-lib/uparser.mly"
                          ( Qdot (_1, _3) )
# 10458 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_lqualid_rich _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState170 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
        let _endpos = _endpos__1_ in
        let _v : (Uast.qualid) = 
# 715 "vocal/gospel/ocaml-lib/uparser.mly"
                          ( Qpreid _1 )
# 10469 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_lqualid_rich _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState436 | MenhirState373 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
        let _v : (Identifier.preid) = 
# 186 "vocal/gospel/ocaml-lib/uparser.mly"
              (_1)
# 10479 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_func_name _menhir_env _menhir_stack _menhir_s _v
    | MenhirState490 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState492 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState492 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState492 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState492 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState492 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState492)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState495 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run506 _menhir_env (Obj.magic _menhir_stack) MenhirState496 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQ ->
            _menhir_run501 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState496 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState496 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QUESTION ->
            _menhir_run499 _menhir_env (Obj.magic _menhir_stack) MenhirState496 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TILDA ->
            _menhir_run497 _menhir_env (Obj.magic _menhir_stack) MenhirState496
        | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
            _menhir_reduce64 _menhir_env (Obj.magic _menhir_stack) MenhirState496
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState496)
    | MenhirState344 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run506 _menhir_env (Obj.magic _menhir_stack) MenhirState514 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQ ->
            _menhir_run501 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState514 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState514 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QUESTION ->
            _menhir_run499 _menhir_env (Obj.magic _menhir_stack) MenhirState514 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TILDA ->
            _menhir_run497 _menhir_env (Obj.magic _menhir_stack) MenhirState514
        | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
            _menhir_reduce64 _menhir_env (Obj.magic _menhir_stack) MenhirState514
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState514)
    | _ ->
        _menhir_fail ()

and _menhir_reduce45 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Identifier.preid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Identifier.preid) = 
# 675 "vocal/gospel/ocaml-lib/uparser.mly"
                ( _1 )
# 10565 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_ident_rich _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_reduce273 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Identifier.preid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.qualid) = 
# 725 "vocal/gospel/ocaml-lib/uparser.mly"
                      ( Qpreid _1 )
# 10577 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_uqualid _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_reduce274 : _menhir_env -> (('ttv_tail * Lexing.position * _menhir_state * (Uast.qualid) * Lexing.position) * Lexing.position * _menhir_state * Lexing.position) * Lexing.position * _menhir_state * (Identifier.preid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_), _endpos__2_, _, _startpos__2_), _endpos__3_, _, (_3 : (Identifier.preid)), _startpos__3_) = _menhir_stack in
    let _2 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__3_ in
    let _v : (Uast.qualid) = 
# 726 "vocal/gospel/ocaml-lib/uparser.mly"
                      ( Qdot (_1, _3) )
# 10590 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_uqualid _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_goto_ty_arg : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.pty) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState503 | MenhirState492 | MenhirState440 | MenhirState420 | MenhirState385 | MenhirState86 | MenhirState112 | MenhirState114 | MenhirState89 | MenhirState91 | MenhirState106 | MenhirState108 | MenhirState93 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState95 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState95 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState96 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState96 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState96 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState96)
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState95 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | COERCION | COMMA | ENSURES | EOF | EPHEMERAL | EQUAL | INVARIANT | MODEL | MUTABLE | REQUIRES | RIGHTPAR | RIGHTSQ | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pty)), _startpos__1_) = _menhir_stack in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__1_ in
            let _v : (Uast.pty) = 
# 531 "vocal/gospel/ocaml-lib/uparser.mly"
    ( _1 )
# 10636 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_typ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState95)
    | MenhirState99 | MenhirState96 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState98 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState98 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState99 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState99 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState99 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState99 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState99)
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState98 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | COERCION | COMMA | ENSURES | EOF | EPHEMERAL | EQUAL | INVARIANT | MODEL | MUTABLE | REQUIRES | RIGHTPAR | RIGHTSQ | VARIANT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pty)), _startpos__1_) = _menhir_stack in
            let _endpos = _endpos__1_ in
            let _v : (Uast.pty list) = 
# 545 "vocal/gospel/ocaml-lib/uparser.mly"
    ( [_1] )
# 10680 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_ty_tuple _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState98)
    | MenhirState84 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState119 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState119 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AMPAMP | AND | ARROW | AS | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOT | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | IN | INVARIANT | LARROW | LEFTSQ | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | VARIANT | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _endpos__2_, _, (_2 : (Uast.pty)), _startpos__2_) = _menhir_stack in
            let _1 = () in
            let _endpos = _endpos__2_ in
            let _v : (Uast.pty) = 
# 343 "vocal/gospel/ocaml-lib/uparser.mly"
                ( _2 )
# 10704 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            (match _menhir_s with
            | MenhirState77 | MenhirState81 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__2_ = _endpos in
                let (_2 : (Uast.pty)) = _v in
                let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pattern)), _startpos__1_) = _menhir_stack in
                let _startpos = _startpos__1_ in
                let _endpos = _endpos__2_ in
                let _v : (Uast.pat_desc) = 
# 596 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Pcast (_1, _2) )
# 10718 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_pat_uni_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | MenhirState476 | MenhirState461 | MenhirState458 | MenhirState448 | MenhirState434 | MenhirState417 | MenhirState399 | MenhirState397 | MenhirState395 | MenhirState392 | MenhirState338 | MenhirState333 | MenhirState329 | MenhirState328 | MenhirState327 | MenhirState310 | MenhirState316 | MenhirState307 | MenhirState309 | MenhirState300 | MenhirState302 | MenhirState290 | MenhirState282 | MenhirState277 | MenhirState279 | MenhirState281 | MenhirState276 | MenhirState263 | MenhirState266 | MenhirState249 | MenhirState256 | MenhirState252 | MenhirState178 | MenhirState180 | MenhirState182 | MenhirState247 | MenhirState199 | MenhirState201 | MenhirState216 | MenhirState228 | MenhirState236 | MenhirState230 | MenhirState232 | MenhirState234 | MenhirState220 | MenhirState222 | MenhirState224 | MenhirState226 | MenhirState218 | MenhirState206 | MenhirState203 | MenhirState184 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__2_ = _endpos in
                let (_2 : (Uast.pty)) = _v in
                let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.term)), _startpos__1_) = _menhir_stack in
                let _startpos = _startpos__1_ in
                let _endpos = _endpos__2_ in
                let _v : (Uast.term_desc) = 
# 414 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tcast (_1, _2) )
# 10732 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_term_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
            | MenhirState191 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_x_ = _endpos in
                let (x : (Uast.pty)) = _v in
                let _v : (Uast.pty option) = 
# 116 "<standard.mly>"
    ( Some x )
# 10743 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_option_cast_ _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                _menhir_fail ())
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState119)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list_attr_ : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (string list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState61 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_2 : (string list)) = _v in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__2_ in
        let _v : (Identifier.preid) = 
# 442 "vocal/gospel/ocaml-lib/uparser.mly"
                  ( pid_add_lab _1 _2 )
# 10769 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        (match _menhir_s with
        | MenhirState456 | MenhirState325 | MenhirState311 | MenhirState312 | MenhirState317 | MenhirState21 | MenhirState24 | MenhirState40 | MenhirState52 | MenhirState125 | MenhirState78 | MenhirState82 | MenhirState74 | MenhirState53 | MenhirState58 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__1_ = _endpos in
            let (_1 : (Identifier.preid)) = _v in
            let _startpos__1_ = _startpos in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__1_ in
            let _v : (Uast.pat_desc) = 
# 601 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Pvar _1 )
# 10783 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pat_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | MenhirState120 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let (_3 : (Identifier.preid)) = _v in
            let _startpos__3_ = _startpos in
            let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pattern)), _startpos__1_), _) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (Uast.pat_desc) = 
# 595 "vocal/gospel/ocaml-lib/uparser.mly"
                                        ( Pas (_1,_3) )
# 10799 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pat_uni_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | MenhirState152 | MenhirState186 | MenhirState189 | MenhirState194 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__1_ = _endpos in
            let (_1 : (Identifier.preid)) = _v in
            let _startpos__1_ = _startpos in
            let _v : (Identifier.preid) = 
# 523 "vocal/gospel/ocaml-lib/uparser.mly"
                 ( _1 )
# 10811 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState194 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ARROW | COLON | COMMA | DOT | LEFTSQ ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, (x : (Identifier.preid))) = _menhir_stack in
                let _v : (Identifier.preid list) = 
# 221 "<standard.mly>"
    ( [ x ] )
# 10826 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_nonempty_list_binder_var_ _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState194)
        | _ ->
            _menhir_fail ())
    | MenhirState64 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_xs_ = _endpos in
        let (xs : (string list)) = _v in
        let (_menhir_stack, _endpos_x_, _menhir_s, (x : (string)), _startpos_x_) = _menhir_stack in
        let _endpos = _endpos_xs_ in
        let _v : (string list) = 
# 213 "<standard.mly>"
    ( x :: xs )
# 10845 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_list_attr_ _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState303 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_2 : (string list)) = _v in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
        let _v : (Identifier.preid) = 
# 442 "vocal/gospel/ocaml-lib/uparser.mly"
                  ( pid_add_lab _1 _2 )
# 10857 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState306)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_lqualid : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.qualid) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState41 | MenhirState49 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBRC ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState52 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState52 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState52 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState52 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState52 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UNDERSCORE ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState52 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState52)
        | RIGHTBRC | SEMICOLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_) = _menhir_stack in
            let _v : (Uast.qualid * Uast.pattern) = 
# 620 "vocal/gospel/ocaml-lib/uparser.mly"
          ( let p = {pat_desc = Pvar (qualid_preid _1);
                     pat_loc = loc_of_qualid _1} in
            (_1,p)
          )
# 10979 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_pattern_rec_field_pattern_ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState503 | MenhirState492 | MenhirState440 | MenhirState420 | MenhirState385 | MenhirState84 | MenhirState86 | MenhirState112 | MenhirState114 | MenhirState89 | MenhirState91 | MenhirState106 | MenhirState108 | MenhirState93 | MenhirState96 | MenhirState99 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.pty) = 
# 552 "vocal/gospel/ocaml-lib/uparser.mly"
    ( PTtyapp (_1, []) )
# 10997 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_ty_arg _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState119 | MenhirState95 | MenhirState98 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.pty)), _startpos__1_), _endpos__2_, _, (_2 : (Uast.qualid)), _startpos__2_) = _menhir_stack in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__2_ in
        let _v : (Uast.pty) = 
# 558 "vocal/gospel/ocaml-lib/uparser.mly"
    ( PTtyapp (_2, [_1]) )
# 11009 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_ty_arg _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState117 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((((((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Uast.pty)), _startpos__2_), _), _, (_4 : (Uast.pty list))), _endpos__5_), _endpos_id_, _, (id : (Uast.qualid)), _startpos_id_) = _menhir_stack in
        let _5 = () in
        let _3 = () in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_id_ in
        let _v : (Uast.pty) = 
# 560 "vocal/gospel/ocaml-lib/uparser.mly"
    ( PTtyapp (id, _2::_4) )
# 11024 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_ty_arg _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState20 | MenhirState322 | MenhirState315 | MenhirState306 | MenhirState308 | MenhirState143 | MenhirState301 | MenhirState289 | MenhirState150 | MenhirState151 | MenhirState278 | MenhirState280 | MenhirState154 | MenhirState171 | MenhirState265 | MenhirState261 | MenhirState174 | MenhirState175 | MenhirState254 | MenhirState251 | MenhirState176 | MenhirState179 | MenhirState181 | MenhirState183 | MenhirState246 | MenhirState243 | MenhirState198 | MenhirState237 | MenhirState200 | MenhirState202 | MenhirState215 | MenhirState227 | MenhirState235 | MenhirState229 | MenhirState231 | MenhirState233 | MenhirState219 | MenhirState221 | MenhirState223 | MenhirState225 | MenhirState217 | MenhirState205 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce234 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState292 | MenhirState286 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            _menhir_run289 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTBRC | SEMICOLON ->
            _menhir_reduce238 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState144 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            _menhir_run289 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTBRC | SEMICOLON ->
            _menhir_reduce238 _menhir_env (Obj.magic _menhir_stack)
        | DOT ->
            _menhir_reduce234 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto__loop_spec : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.invariant * Uast.term list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState338 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_t_, _, (t : (Uast.term)), _startpos_t_), _, (_3 : (Uast.invariant * Uast.term list))) = _menhir_stack in
        let _1 = () in
        let _v : (Uast.invariant * Uast.term list) = 
# 293 "vocal/gospel/ocaml-lib/uparser.mly"
    ( let inv, var = _3 in t :: inv, var )
# 11077 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto__loop_spec _menhir_env _menhir_stack _menhir_s _v
    | MenhirState336 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s), _endpos_t_, _, (t : (Uast.variant))), _, (_3 : (Uast.invariant * Uast.term list))) = _menhir_stack in
        let _1 = () in
        let _v : (Uast.invariant * Uast.term list) = 
# 295 "vocal/gospel/ocaml-lib/uparser.mly"
    ( let inv, var = _3 in inv, t @ var )
# 11088 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto__loop_spec _menhir_env _menhir_stack _menhir_s _v
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__2_ = _endpos in
            let (_menhir_stack, _menhir_s, (_1 : (Uast.invariant * Uast.term list))) = _menhir_stack in
            let _2 = () in
            let _v : (Uast.loop_spec) = 
# 286 "vocal/gospel/ocaml-lib/uparser.mly"
  ( let inv, var = _1 in
    { loop_invariant = inv; loop_variant = var } )
# 11107 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (Uast.loop_spec)) = _v in
            Obj.magic _1
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_val_spec_body : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.val_spec) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState449 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CHECKS ->
            _menhir_run475 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | CONSUMES ->
            _menhir_run473 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | DIVERGES ->
            _menhir_run472 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | ENSURES ->
            _menhir_run398 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | EQUIVALENT ->
            _menhir_run470 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | MODIFIES ->
            _menhir_run468 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | RAISES ->
            _menhir_run454 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | REQUIRES ->
            _menhir_run396 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | VARIANT ->
            _menhir_run451 _menhir_env (Obj.magic _menhir_stack) MenhirState450
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_hd_, _menhir_s, (hd : (Uast.labelled_arg list * Identifier.preid * Uast.labelled_arg list)), _startpos_hd_), _, (bd : (Uast.val_spec)), _startpos_bd_) = _menhir_stack in
            let _startpos = _startpos_hd_ in
            let _v : (Uast.val_spec) = 
# 245 "vocal/gospel/ocaml-lib/uparser.mly"
  ( let bd = rev_vspec bd in
    let (r,f,a) = hd in
    { bd with sp_hd_ret  = r;
      sp_hd_nm  = f; sp_hd_args = a;}
  )
# 11160 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_val_spec _menhir_env _menhir_stack _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState450)
    | MenhirState344 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CHECKS ->
            _menhir_run475 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | CONSUMES ->
            _menhir_run473 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | DIVERGES ->
            _menhir_run472 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | ENSURES ->
            _menhir_run398 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | EQUIVALENT ->
            _menhir_run470 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | MODIFIES ->
            _menhir_run468 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | RAISES ->
            _menhir_run454 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | REQUIRES ->
            _menhir_run396 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | VARIANT ->
            _menhir_run451 _menhir_env (Obj.magic _menhir_stack) MenhirState479
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (bd : (Uast.val_spec)), _startpos_bd_) = _menhir_stack in
            let _startpos = _startpos_bd_ in
            let _v : (Uast.val_spec) = 
# 251 "vocal/gospel/ocaml-lib/uparser.mly"
  ( rev_vspec bd )
# 11197 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_val_spec _menhir_env _menhir_stack _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState479)
    | _ ->
        _menhir_fail ()

and _menhir_run271 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EQUAL ->
        _menhir_run132 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState271

and _menhir_goto_boption_MUTABLE_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (bool) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | MODEL ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState490 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState490 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState490)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_reduce100 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (unit option) = 
# 114 "<standard.mly>"
    ( None )
# 11268 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_option_UNDERSCORE_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run11 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_x_ = _endpos in
    let _startpos_x_ = _startpos in
    let x = () in
    let _v : (unit option) = 
# 116 "<standard.mly>"
    ( Some x )
# 11282 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_option_UNDERSCORE_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_op_symbol : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (string) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState423 | MenhirState374 | MenhirState271 | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | UNDERSCORE ->
            _menhir_run139 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTPAR ->
            _menhir_reduce48 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState20 | MenhirState322 | MenhirState315 | MenhirState306 | MenhirState308 | MenhirState143 | MenhirState301 | MenhirState289 | MenhirState151 | MenhirState278 | MenhirState280 | MenhirState154 | MenhirState265 | MenhirState175 | MenhirState254 | MenhirState251 | MenhirState176 | MenhirState179 | MenhirState181 | MenhirState183 | MenhirState246 | MenhirState243 | MenhirState198 | MenhirState237 | MenhirState200 | MenhirState202 | MenhirState215 | MenhirState227 | MenhirState235 | MenhirState229 | MenhirState231 | MenhirState233 | MenhirState219 | MenhirState221 | MenhirState223 | MenhirState225 | MenhirState217 | MenhirState205 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce134 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState8 | MenhirState150 | MenhirState171 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | UNDERSCORE ->
            _menhir_run139 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ATTRIBUTE _ | EXISTS | FALSE | FLOAT _ | FORALL | FUN | IF | INTEGER _ | LEFTBRC | LEFTBRCCOLON | LEFTBRCRIGHTBRC | LEFTPAR | LEFTSQRIGHTSQ | LET | LIDENT _ | MATCH | NOT | OLD | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OPPREF _ | STAR | TRUE | UIDENT _ ->
            _menhir_reduce134 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTPAR ->
            _menhir_reduce48 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_lident_op : _menhir_env -> 'ttv_tail -> _menhir_state -> (string) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RIGHTPAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__3_ = _endpos in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _, (_2 : (string))) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Identifier.preid) = let _endpos = _endpos__3_ in
        let _startpos = _startpos__1_ in
        
# 685 "vocal/gospel/ocaml-lib/uparser.mly"
                              ( mk_pid _2 _startpos _endpos )
# 11351 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
        (match _menhir_s with
        | MenhirState344 | MenhirState495 | MenhirState490 | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState436 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState373 | MenhirState362 | MenhirState356 | MenhirState360 | MenhirState358 | MenhirState354 | MenhirState346 | MenhirState352 | MenhirState350 | MenhirState348 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState20 | MenhirState322 | MenhirState315 | MenhirState306 | MenhirState308 | MenhirState143 | MenhirState301 | MenhirState144 | MenhirState289 | MenhirState149 | MenhirState150 | MenhirState151 | MenhirState278 | MenhirState280 | MenhirState154 | MenhirState170 | MenhirState270 | MenhirState171 | MenhirState265 | MenhirState174 | MenhirState261 | MenhirState175 | MenhirState254 | MenhirState251 | MenhirState176 | MenhirState179 | MenhirState181 | MenhirState183 | MenhirState246 | MenhirState243 | MenhirState198 | MenhirState237 | MenhirState200 | MenhirState202 | MenhirState215 | MenhirState227 | MenhirState235 | MenhirState229 | MenhirState231 | MenhirState233 | MenhirState219 | MenhirState221 | MenhirState223 | MenhirState225 | MenhirState217 | MenhirState205 | MenhirState158 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__1_ in
            let _v : (Identifier.preid) = 
# 681 "vocal/gospel/ocaml-lib/uparser.mly"
                ( _1 )
# 11364 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_lident_rich _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | MenhirState21 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState303 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EQUAL ->
                _menhir_reduce62 _menhir_env (Obj.magic _menhir_stack) MenhirState303
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState303)
        | _ ->
            _menhir_fail ())
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_option_REC_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit option) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState371 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run374 _menhir_env (Obj.magic _menhir_stack) MenhirState373 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState373 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState373)
    | MenhirState435 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run374 _menhir_env (Obj.magic _menhir_stack) MenhirState436 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState436 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState436)
    | _ ->
        _menhir_fail ()

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_fun_arg : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.labelled_arg) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run506 _menhir_env (Obj.magic _menhir_stack) MenhirState510 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run501 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState510 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState510 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUESTION ->
        _menhir_run499 _menhir_env (Obj.magic _menhir_stack) MenhirState510 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TILDA ->
        _menhir_run497 _menhir_env (Obj.magic _menhir_stack) MenhirState510
    | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
        _menhir_reduce64 _menhir_env (Obj.magic _menhir_stack) MenhirState510
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState510

and _menhir_reduce149 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Identifier.preid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _v : (Uast.labelled_arg) = 
# 312 "vocal/gospel/ocaml-lib/uparser.mly"
   ( Lnone _1 )
# 11458 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_ret_value _menhir_env _menhir_stack _menhir_s _v _startpos

and _menhir_run3 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.term_desc) = 
# 456 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( Ttrue )
# 11474 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run5 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 11481 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState5 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState5

and _menhir_run18 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState18

and _menhir_run19 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState19 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState19

and _menhir_run20 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState20 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState20

and _menhir_run21 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTBRC ->
        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState21 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EQUAL ->
            _menhir_run132 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRC ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQ ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQRIGHTSQ ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OPPREF _v ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTPAR ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24
        | STAR ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UNDERSCORE ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState24)
    | LEFTSQRIGHTSQ ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UNDERSCORE ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState21

and _menhir_run7 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.term_desc) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 472 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tpreid (Qpreid (mk_pid "[]"  _startpos _endpos)) )
# 11785 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_block_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run8 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DOT ->
        _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EQUAL ->
        _menhir_run132 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | RIGHTPAR ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState8 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState8

and _menhir_run12 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.term_desc) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 476 "vocal/gospel/ocaml-lib/uparser.mly"
    ( Tpreid (Qpreid (mk_pid (mixfix "{}") _startpos _endpos)) )
# 11874 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_block_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run13 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13

and _menhir_run144 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState144

and _menhir_run145 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 79 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 11979 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 79 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 11988 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Oasttypes.constant) = 
# 518 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Oasttypes.Pconst_integer (_1,None) )
# 11996 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_numeral _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run151 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState151 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState151

and _menhir_run152 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState152 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState152

and _menhir_run155 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _v : (Uast.quant) = 
# 513 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Tforall )
# 12086 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_quant _menhir_env _menhir_stack _menhir_s _v _startpos

and _menhir_run146 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 81 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12093 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 81 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12102 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Oasttypes.constant) = 
# 519 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Oasttypes.Pconst_float (_1, None) )
# 12110 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_numeral _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run147 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.term_desc) = 
# 457 "vocal/gospel/ocaml-lib/uparser.mly"
                            ( Tfalse )
# 12126 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_term_arg_ _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run156 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _v : (Uast.quant) = 
# 514 "vocal/gospel/ocaml-lib/uparser.mly"
          ( Texists )
# 12140 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_quant _menhir_env _menhir_stack _menhir_s _v _startpos

and _menhir_goto_nonempty_list_lident_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Identifier.preid list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState383 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState385 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState385 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState385 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState385 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState385 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState385)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState388 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_x_, _menhir_s, (x : (Identifier.preid)), _startpos_x_), _, (xs : (Identifier.preid list))) = _menhir_stack in
        let _v : (Identifier.preid list) = 
# 223 "<standard.mly>"
    ( x :: xs )
# 12185 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_nonempty_list_lident_ _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_reduce60 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Identifier.preid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Identifier.preid) = 
# 680 "vocal/gospel/ocaml-lib/uparser.mly"
                ( _1 )
# 12199 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_lident_rich _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_reduce70 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (Identifier.preid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.qualid) = 
# 720 "vocal/gospel/ocaml-lib/uparser.mly"
                      ( Qpreid _1 )
# 12211 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_lqualid _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run2 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 78 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12218 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 78 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12227 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Identifier.preid) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 662 "vocal/gospel/ocaml-lib/uparser.mly"
                ( mk_pid _1 _startpos _endpos )
# 12237 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState270 | MenhirState54 | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce274 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState503 | MenhirState492 | MenhirState454 | MenhirState464 | MenhirState455 | MenhirState456 | MenhirState440 | MenhirState420 | MenhirState385 | MenhirState325 | MenhirState311 | MenhirState317 | MenhirState312 | MenhirState292 | MenhirState286 | MenhirState170 | MenhirState21 | MenhirState24 | MenhirState40 | MenhirState125 | MenhirState119 | MenhirState84 | MenhirState117 | MenhirState114 | MenhirState112 | MenhirState86 | MenhirState108 | MenhirState106 | MenhirState95 | MenhirState98 | MenhirState99 | MenhirState96 | MenhirState93 | MenhirState91 | MenhirState89 | MenhirState82 | MenhirState78 | MenhirState74 | MenhirState52 | MenhirState58 | MenhirState53 | MenhirState49 | MenhirState41 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce273 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState348 | MenhirState149 | MenhirState158 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_reduce274 _menhir_env (Obj.magic _menhir_stack)
        | AMPAMP | AND | ANDW | ARROW | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONEQUAL | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | FALSE | FLOAT _ | IN | INTEGER _ | INVARIANT | LARROW | LEFTBRC | LEFTBRCCOLON | LEFTBRCRIGHTBRC | LEFTPAR | LEFTSQ | LEFTSQRIGHTSQ | LIDENT _ | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OPPREF _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | TRUE | UIDENT _ | VARIANT | WITH ->
            _menhir_reduce45 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState362 | MenhirState360 | MenhirState358 | MenhirState356 | MenhirState354 | MenhirState352 | MenhirState350 | MenhirState346 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState322 | MenhirState315 | MenhirState20 | MenhirState308 | MenhirState306 | MenhirState301 | MenhirState143 | MenhirState289 | MenhirState144 | MenhirState150 | MenhirState280 | MenhirState278 | MenhirState151 | MenhirState265 | MenhirState261 | MenhirState174 | MenhirState254 | MenhirState251 | MenhirState175 | MenhirState246 | MenhirState243 | MenhirState237 | MenhirState235 | MenhirState233 | MenhirState231 | MenhirState229 | MenhirState227 | MenhirState225 | MenhirState223 | MenhirState221 | MenhirState219 | MenhirState217 | MenhirState215 | MenhirState205 | MenhirState202 | MenhirState200 | MenhirState198 | MenhirState183 | MenhirState181 | MenhirState179 | MenhirState176 | MenhirState171 | MenhirState154 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_reduce273 _menhir_env (Obj.magic _menhir_stack)
        | AMPAMP | AND | ANDW | ARROW | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONEQUAL | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | FALSE | FLOAT _ | IN | INTEGER _ | INVARIANT | LARROW | LEFTBRC | LEFTBRCCOLON | LEFTBRCRIGHTBRC | LEFTPAR | LEFTSQ | LEFTSQRIGHTSQ | LIDENT _ | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OPPREF _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | TRUE | UIDENT _ | VARIANT | WITH ->
            _menhir_reduce45 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_run85 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 82 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12283 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 82 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12292 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Identifier.preid) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 666 "vocal/gospel/ocaml-lib/uparser.mly"
                ( mk_pid _1 _startpos _endpos )
# 12302 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (Identifier.preid)) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Uast.pty) = 
# 554 "vocal/gospel/ocaml-lib/uparser.mly"
    ( PTtyvar _1 )
# 12314 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_ty_arg _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run87 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState87 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState87

and _menhir_run86 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState86 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState86 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUESTION ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState86 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUOTE_LIDENT _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState86 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState86 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState86

and _menhir_reduce62 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let (_, _endpos) = Obj.magic _menhir_stack in
    let _v : (string list) = 
# 211 "<standard.mly>"
    ( [] )
# 12358 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_list_attr_ _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run62 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 85 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12365 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 85 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12374 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (string) = 
# 446 "vocal/gospel/ocaml-lib/uparser.mly"
               ( _1 )
# 12382 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState303 | MenhirState64 | MenhirState61 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ATTRIBUTE _v ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState64 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | AS | BAR | COLON | COLONCOLON | COMMA | DOT | EQUAL | LEFTBRC | LEFTPAR | LEFTSQ | LEFTSQRIGHTSQ | LIDENT _ | RIGHTBRC | RIGHTPAR | SEMICOLON | UIDENT _ | UNDERSCORE ->
            _menhir_reduce62 _menhir_env (Obj.magic _menhir_stack) MenhirState64
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64)
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState1 | MenhirState337 | MenhirState8 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState20 | MenhirState322 | MenhirState315 | MenhirState306 | MenhirState308 | MenhirState143 | MenhirState301 | MenhirState289 | MenhirState150 | MenhirState151 | MenhirState278 | MenhirState280 | MenhirState154 | MenhirState171 | MenhirState265 | MenhirState175 | MenhirState254 | MenhirState251 | MenhirState176 | MenhirState179 | MenhirState181 | MenhirState183 | MenhirState246 | MenhirState198 | MenhirState243 | MenhirState237 | MenhirState200 | MenhirState202 | MenhirState215 | MenhirState227 | MenhirState235 | MenhirState229 | MenhirState231 | MenhirState233 | MenhirState219 | MenhirState221 | MenhirState223 | MenhirState225 | MenhirState217 | MenhirState205 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ATTRIBUTE _v ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EXISTS ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FALSE ->
            _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FLOAT _v ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FORALL ->
            _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FUN ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IF ->
            _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INTEGER _v ->
            _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRC ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRCCOLON ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBRCRIGHTBRC ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQRIGHTSQ ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LET ->
            _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MATCH ->
            _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOT ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OLD ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OPPREF _v ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TRUE ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | UIDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState215 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState215)
    | _ ->
        _menhir_fail ()

and _menhir_reduce71 : _menhir_env -> (('ttv_tail * Lexing.position * _menhir_state * (Uast.qualid) * Lexing.position) * Lexing.position * _menhir_state * Lexing.position) * Lexing.position * _menhir_state * (Identifier.preid) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (((_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.qualid)), _startpos__1_), _endpos__2_, _, _startpos__2_), _endpos__3_, _, (_3 : (Identifier.preid)), _startpos__3_) = _menhir_stack in
    let _2 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__3_ in
    let _v : (Uast.qualid) = 
# 721 "vocal/gospel/ocaml-lib/uparser.mly"
                      ( Qdot (_1, _3) )
# 12472 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_lqualid _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_reduce2 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (Uast.invariant * Uast.term list) = 
# 291 "vocal/gospel/ocaml-lib/uparser.mly"
    ( [], [] )
# 12481 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto__loop_spec _menhir_env _menhir_stack _menhir_s _v

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState1

and _menhir_run337 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState337

and _menhir_reduce14 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let (_, _startpos) = Obj.magic _menhir_stack in
    let _v : (bool) = 
# 133 "<standard.mly>"
    ( false )
# 12617 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_boption_MUTABLE_ _menhir_env _menhir_stack _menhir_s _v _startpos

and _menhir_reduce277 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let (_, _startpos) = Obj.magic _menhir_stack in
    let _v : (Uast.val_spec) = 
# 263 "vocal/gospel/ocaml-lib/uparser.mly"
  ( empty_vspec )
# 12627 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_val_spec_body _menhir_env _menhir_stack _menhir_s _v _startpos

and _menhir_run346 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState346 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState346 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState346 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState346

and _menhir_run354 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState354 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState354 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState354 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState354

and _menhir_run356 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState356 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState356 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState356 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState356

and _menhir_run362 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run271 _menhir_env (Obj.magic _menhir_stack) MenhirState362 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState362 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState362 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState362

and _menhir_goto_spec_init : _menhir_env -> 'ttv_tail -> _menhir_state -> (Uast.spec) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (Uast.spec)) = _v in
    Obj.magic _1

and _menhir_run413 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _v : (bool) = 
# 135 "<standard.mly>"
    ( true )
# 12716 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_boption_MUTABLE_ _menhir_env _menhir_stack _menhir_s _v _startpos

and _menhir_run418 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState418 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState418

and _menhir_run4 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (string) = 
# 633 "vocal/gospel/ocaml-lib/uparser.mly"
       ( "*" )
# 12745 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_op_symbol _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run26 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12752 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UNDERSCORE ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState26 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | RIGHTPAR ->
        _menhir_reduce100 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState26

and _menhir_run14 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12771 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12780 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (string) = 
# 632 "vocal/gospel/ocaml-lib/uparser.mly"
       ( _1 )
# 12788 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_op_symbol _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run15 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12795 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12804 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (string) = 
# 631 "vocal/gospel/ocaml-lib/uparser.mly"
       ( _1 )
# 12812 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_op_symbol _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run16 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12819 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12828 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (string) = 
# 630 "vocal/gospel/ocaml-lib/uparser.mly"
       ( _1 )
# 12836 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_op_symbol _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run17 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12843 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 80 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 12852 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (string) = 
# 629 "vocal/gospel/ocaml-lib/uparser.mly"
       ( _1 )
# 12860 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_op_symbol _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run29 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * Lexing.position -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOTDOT ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__4_ = _endpos in
            let ((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _endpos__2_, _, _startpos__2_) = _menhir_stack in
            let _4 = () in
            let _3 = () in
            let _2 = () in
            let _1 = () in
            let _v : (string) = 
# 699 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( mixfix "[_..]"  )
# 12889 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v
        | UNDERSCORE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | RIGHTSQ ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__5_ = _endpos in
                let (((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _endpos__2_, _, _startpos__2_), _endpos__4_, _startpos__4_) = _menhir_stack in
                let _5 = () in
                let _4 = () in
                let _3 = () in
                let _2 = () in
                let _1 = () in
                let _v : (string) = 
# 697 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( mixfix "[_.._]" )
# 12915 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _, _menhir_s, _), _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | RIGHTSQ ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__3_ = _endpos in
        let ((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _endpos__2_, _, _startpos__2_) = _menhir_stack in
        let _3 = () in
        let _2 = () in
        let _1 = () in
        let _v : (string) = 
# 695 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( mixfix "[_]"     )
# 12943 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run35 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RIGHTSQ ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__3_ = _endpos in
        let ((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _) = _menhir_stack in
        let _3 = () in
        let _2 = () in
        let _1 = () in
        let _v : (string) = 
# 696 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( mixfix "[<-]"   )
# 12972 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run37 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UNDERSCORE ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__4_ = _endpos in
            let (((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _), _endpos__3_, _startpos__3_) = _menhir_stack in
            let _4 = () in
            let _3 = () in
            let _2 = () in
            let _1 = () in
            let _v : (string) = 
# 698 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( mixfix "[.._]"  )
# 13010 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run132 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _v : (string) = 
# 691 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( infix "="       )
# 13036 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v

and _menhir_run133 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | RIGHTPAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__4_ = _endpos in
                let ((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _startpos__2_) = _menhir_stack in
                let _4 = () in
                let _3 = () in
                let _2 = () in
                let _1 = () in
                let _v : (string) = 
# 694 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( mixfix ".(<-)"  )
# 13072 "vocal/gospel/ocaml-lib/uparser.ml"
                 in
                _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _startpos__2_) = _menhir_stack in
            let _3 = () in
            let _2 = () in
            let _1 = () in
            let _v : (string) = 
# 693 "vocal/gospel/ocaml-lib/uparser.mly"
                                              ( mixfix ".()"    )
# 13094 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_lident_op _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _, _menhir_s, _), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run433 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ATTRIBUTE _v ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FLOAT _v ->
        _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUN ->
        _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRC ->
        _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCCOLON ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBRCRIGHTBRC ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQRIGHTSQ ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OLD ->
        _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP1 _v ->
        _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP2 _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP3 _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OP4 _v ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPPREF _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STAR ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | UIDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState433 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState433

and _menhir_reduce98 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (unit option) = 
# 114 "<standard.mly>"
    ( None )
# 13178 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_option_REC_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run372 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let x = () in
    let _v : (unit option) = 
# 116 "<standard.mly>"
    ( Some x )
# 13190 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    _menhir_goto_option_REC_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_type_spec : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (Uast.type_spec) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | EOF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_s = MenhirState484 in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Uast.type_spec)), _startpos__1_) = _menhir_stack in
        let _2 = () in
        let _v : (Uast.spec) = let _endpos = _endpos__2_ in
        let _startpos = _startpos__1_ in
        
# 146 "vocal/gospel/ocaml-lib/uparser.mly"
                    ( Stype (rev_tspec _1, mk_loc _startpos _endpos) )
# 13214 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_spec_init _menhir_env _menhir_stack _menhir_s _v
    | EPHEMERAL ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_s = MenhirState484 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__2_ = _endpos in
        let _startpos__2_ = _startpos in
        let (_menhir_stack, _endpos_ts_, _menhir_s, (ts : (Uast.type_spec)), _startpos_ts_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_ts_ in
        let _endpos = _endpos__2_ in
        let _v : (Uast.type_spec) = 
# 227 "vocal/gospel/ocaml-lib/uparser.mly"
  ( {ts with ty_ephemeral = true} )
# 13233 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_type_spec _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | INVARIANT ->
        _menhir_run433 _menhir_env (Obj.magic _menhir_stack) MenhirState484 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MUTABLE ->
        _menhir_run413 _menhir_env (Obj.magic _menhir_stack) MenhirState484 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MODEL ->
        _menhir_reduce14 _menhir_env (Obj.magic _menhir_stack) MenhirState484
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState484

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState514 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState510 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState504 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState503 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState501 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState499 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState497 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState496 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState495 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState493 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState492 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState490 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState484 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState479 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState476 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState475 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState473 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState468 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState464 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState461 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState460 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState458 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState457 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState456 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState455 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState454 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState451 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState450 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState449 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState448 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState447 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState445 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState442 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState441 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState440 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState437 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState436 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState435 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState434 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState433 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState427 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState424 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState423 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState421 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState420 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState418 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState417 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState416 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState414 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState410 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState404 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState399 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState398 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState397 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState396 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState395 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState394 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState393 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState392 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState391 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState390 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState388 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState386 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState385 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState383 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState382 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState374 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState373 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState371 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState365 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState362 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState360 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState358 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState356 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState354 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState352 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState350 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState348 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState347 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState346 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState345 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState344 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState338 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState337 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState336 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState333 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState329 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState328 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState327 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState325 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState322 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState317 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState316 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState315 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState312 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState311 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState310 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState309 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState308 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState307 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState306 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState303 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState302 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState301 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState300 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState292 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState291 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState290 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState289 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState286 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState282 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState281 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState280 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState279 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState278 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState277 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState276 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState271 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState270 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState269 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState266 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState265 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState263 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState261 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState259 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState256 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState254 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState252 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState251 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState249 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState247 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState246 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s, _), _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState243 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState237 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState236 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState235 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState234 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState233 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState232 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState231 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState230 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState229 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState228 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState227 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState226 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState225 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState224 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState223 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState222 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState221 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState220 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState219 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState218 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState217 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState216 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState215 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState206 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState205 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState203 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState202 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState201 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState200 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState199 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState198 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState194 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState191 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState189 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState186 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState184 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState183 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState182 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState181 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState180 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState179 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState178 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState176 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState175 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState174 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState171 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState170 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState158 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState157 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState154 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState152 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState151 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState150 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState149 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState148 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState144 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState143 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState125 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState120 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState119 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState117 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState114 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState113 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState110 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState109 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState106 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState99 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState98 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState96 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState95 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState94 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState93 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState92 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState91 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState89 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState87 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState86 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState84 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState82 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState81 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState78 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState77 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState74 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState64 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState61 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState58 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState55 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState54 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState53 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState49 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState41 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState40 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState28 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState26 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState21 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState20 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState19 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState10 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState8 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState5 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_run6 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 78 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 14223 "vocal/gospel/ocaml-lib/uparser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let (_1 : (
# 78 "vocal/gospel/ocaml-lib/uparser.mly"
       (string)
# 14232 "vocal/gospel/ocaml-lib/uparser.ml"
    )) = _v in
    let _startpos__1_ = _startpos in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (Identifier.preid) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 658 "vocal/gospel/ocaml-lib/uparser.mly"
                ( mk_pid _1 _startpos _endpos )
# 14242 "vocal/gospel/ocaml-lib/uparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce71 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState456 | MenhirState325 | MenhirState311 | MenhirState312 | MenhirState317 | MenhirState21 | MenhirState152 | MenhirState186 | MenhirState194 | MenhirState189 | MenhirState24 | MenhirState40 | MenhirState52 | MenhirState125 | MenhirState78 | MenhirState120 | MenhirState82 | MenhirState74 | MenhirState53 | MenhirState58 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ATTRIBUTE _v ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState61 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ARROW | AS | BAR | COLON | COLONCOLON | COMMA | DOT | EQUAL | LEFTBRC | LEFTPAR | LEFTSQ | LEFTSQRIGHTSQ | LIDENT _ | RIGHTBRC | RIGHTPAR | SEMICOLON | UIDENT _ | UNDERSCORE ->
            _menhir_reduce62 _menhir_env (Obj.magic _menhir_stack) MenhirState61
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState61)
    | MenhirState87 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState89 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState89 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState89 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState89)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState292 | MenhirState286 | MenhirState41 | MenhirState49 | MenhirState84 | MenhirState119 | MenhirState117 | MenhirState95 | MenhirState96 | MenhirState98 | MenhirState99 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce70 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState503 | MenhirState492 | MenhirState440 | MenhirState420 | MenhirState385 | MenhirState86 | MenhirState112 | MenhirState114 | MenhirState89 | MenhirState91 | MenhirState106 | MenhirState108 | MenhirState93 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState106 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState106 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState106 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState106)
        | ARROW | COERCION | COMMA | ENSURES | EOF | EPHEMERAL | EQUAL | INVARIANT | LIDENT _ | MODEL | MUTABLE | REQUIRES | RIGHTPAR | RIGHTSQ | STAR | UIDENT _ | VARIANT ->
            _menhir_reduce70 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState158 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_reduce71 _menhir_env (Obj.magic _menhir_stack)
        | AMPAMP | AND | ARROW | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | FALSE | FLOAT _ | IN | INTEGER _ | INVARIANT | LARROW | LEFTBRC | LEFTBRCCOLON | LEFTBRCRIGHTBRC | LEFTPAR | LEFTSQ | LEFTSQRIGHTSQ | LIDENT _ | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OPPREF _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | TRUE | UIDENT _ | VARIANT | WITH ->
            _menhir_reduce60 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState475 | MenhirState473 | MenhirState468 | MenhirState460 | MenhirState457 | MenhirState451 | MenhirState447 | MenhirState433 | MenhirState416 | MenhirState398 | MenhirState396 | MenhirState394 | MenhirState391 | MenhirState337 | MenhirState1 | MenhirState5 | MenhirState8 | MenhirState10 | MenhirState13 | MenhirState18 | MenhirState19 | MenhirState20 | MenhirState322 | MenhirState315 | MenhirState306 | MenhirState308 | MenhirState143 | MenhirState301 | MenhirState289 | MenhirState150 | MenhirState151 | MenhirState278 | MenhirState280 | MenhirState154 | MenhirState171 | MenhirState265 | MenhirState174 | MenhirState261 | MenhirState175 | MenhirState254 | MenhirState251 | MenhirState176 | MenhirState179 | MenhirState181 | MenhirState183 | MenhirState246 | MenhirState243 | MenhirState198 | MenhirState237 | MenhirState200 | MenhirState202 | MenhirState215 | MenhirState227 | MenhirState235 | MenhirState229 | MenhirState231 | MenhirState233 | MenhirState219 | MenhirState221 | MenhirState223 | MenhirState225 | MenhirState217 | MenhirState205 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_reduce70 _menhir_env (Obj.magic _menhir_stack)
        | AMPAMP | AND | ARROW | BACKQUOTE_LIDENT _ | BAR | BARBAR | CHECKS | COERCION | COLON | COLONCOLON | COLONRIGHTBRC | COMMA | CONSUMES | DIVERGES | DOTDOT | ELSE | ENSURES | EOF | EPHEMERAL | EQUAL | EQUIVALENT | FALSE | FLOAT _ | IN | INTEGER _ | INVARIANT | LARROW | LEFTBRC | LEFTBRCCOLON | LEFTBRCRIGHTBRC | LEFTPAR | LEFTSQ | LEFTSQRIGHTSQ | LIDENT _ | LRARROW | LTGT | MODEL | MODIFIES | MUTABLE | OP1 _ | OP2 _ | OP3 _ | OP4 _ | OPPREF _ | OR | RAISES | REQUIRES | RIGHTBRC | RIGHTPAR | RIGHTSQ | SEMICOLON | STAR | THEN | TRUE | UIDENT _ | VARIANT | WITH ->
            _menhir_reduce60 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState495 | MenhirState490 | MenhirState436 | MenhirState373 | MenhirState362 | MenhirState356 | MenhirState360 | MenhirState358 | MenhirState354 | MenhirState346 | MenhirState352 | MenhirState350 | MenhirState348 | MenhirState170 | MenhirState270 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce60 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState149 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT | EQUAL | RIGHTBRC | SEMICOLON ->
            _menhir_reduce71 _menhir_env (Obj.magic _menhir_stack)
        | LEFTSQ | WITH ->
            _menhir_reduce60 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState144 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT | EQUAL | RIGHTBRC | SEMICOLON ->
            _menhir_reduce70 _menhir_env (Obj.magic _menhir_stack)
        | LEFTSQ | WITH ->
            _menhir_reduce60 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState388 | MenhirState383 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState388 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_x_, _menhir_s, (x : (Identifier.preid)), _startpos_x_) = _menhir_stack in
            let _v : (Identifier.preid list) = 
# 221 "<standard.mly>"
    ( [ x ] )
# 14403 "vocal/gospel/ocaml-lib/uparser.ml"
             in
            _menhir_goto_nonempty_list_lident_ _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState388)
    | MenhirState414 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState416 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState416)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState424 | MenhirState418 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState420 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState420 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState420 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState420 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState420 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState420)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState423 | MenhirState427 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        _menhir_reduce149 _menhir_env (Obj.magic _menhir_stack)
    | MenhirState445 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ATTRIBUTE _v ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run156 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run147 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FLOAT _v ->
                _menhir_run146 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run155 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FUN ->
                _menhir_run152 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run151 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run145 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRC ->
                _menhir_run144 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCCOLON ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBRCRIGHTBRC ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQRIGHTSQ ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run21 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OLD ->
                _menhir_run18 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP1 _v ->
                _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP2 _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP3 _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OP4 _v ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | OPPREF _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STAR ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState447)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState497 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _endpos__2_, _, (_2 : (Identifier.preid)), _startpos__2_) = _menhir_stack in
        let _1 = () in
        let _endpos = _endpos__2_ in
        let _v : (Uast.labelled_arg) = 
# 303 "vocal/gospel/ocaml-lib/uparser.mly"
   ( Lnamed _2 )
# 14596 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_fun_arg _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState499 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos__2_, _, (_2 : (Identifier.preid)), _startpos__2_) = _menhir_stack in
        let _1 = () in
        let _endpos = _endpos__2_ in
        let _v : (Uast.labelled_arg) = 
# 305 "vocal/gospel/ocaml-lib/uparser.mly"
   ( Lquestion _2 )
# 14608 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_fun_arg _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState501 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTPAR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState503 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState503 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUESTION ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState503 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE_LIDENT _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState503 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UIDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState503 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState503)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState514 | MenhirState510 | MenhirState496 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos__1_, _menhir_s, (_1 : (Identifier.preid)), _startpos__1_) = _menhir_stack in
        let _endpos = _endpos__1_ in
        let _v : (Uast.labelled_arg) = 
# 301 "vocal/gospel/ocaml-lib/uparser.mly"
   ( Lnone _1 )
# 14649 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_fun_arg _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState344 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COMMA | EQUAL ->
            _menhir_reduce149 _menhir_env (Obj.magic _menhir_stack)
        | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | LEFTPAR | LEFTSQ | LIDENT _ | MODIFIES | QUESTION | RAISES | REQUIRES | TILDA | VARIANT ->
            _menhir_reduce60 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and loop_spec : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Uast.loop_spec) =
  fun lexer lexbuf ->
    let _menhir_env = {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = Obj.magic ();
      _menhir_error = false;
    } in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | INVARIANT ->
        _menhir_run337 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VARIANT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | EOF ->
        _menhir_reduce2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)

and spec_init : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Uast.spec) =
  fun lexer lexbuf ->
    let _menhir_env = {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = Obj.magic ();
      _menhir_error = false;
    } in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | AXIOM ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState445 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState445)
    | EPHEMERAL ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_s = MenhirState344 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__1_ = _endpos in
        let _startpos__1_ = _startpos in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Uast.type_spec) = 
# 221 "vocal/gospel/ocaml-lib/uparser.mly"
    ( {empty_tspec with ty_ephemeral = true} )
# 14746 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_type_spec _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | FUNCTION ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REC ->
            _menhir_run372 _menhir_env (Obj.magic _menhir_stack) MenhirState435
        | LEFTPAR | LIDENT _ ->
            _menhir_reduce98 _menhir_env (Obj.magic _menhir_stack) MenhirState435
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState435)
    | INVARIANT ->
        _menhir_run433 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EQUAL ->
            _menhir_run132 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState423 in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DOTDOT ->
                _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState424
            | LARROW ->
                _menhir_run35 _menhir_env (Obj.magic _menhir_stack) MenhirState424
            | LIDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState424 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | UNDERSCORE ->
                _menhir_run29 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState424 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState424)
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP1 _v ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP2 _v ->
            _menhir_run16 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP3 _v ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OP4 _v ->
            _menhir_run14 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | OPPREF _v ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STAR ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState423 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState423)
    | LEFTSQ ->
        _menhir_run418 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEMMA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LIDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState414 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState414)
    | LIDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MUTABLE ->
        _menhir_run413 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | OPEN ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _1 = () in
        let _v : (Uast.spec) = 
# 155 "vocal/gospel/ocaml-lib/uparser.mly"
                    ( raise Ghost_decl )
# 14846 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_spec_init _menhir_env _menhir_stack _menhir_s _v
    | PREDICATE ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REC ->
            _menhir_run372 _menhir_env (Obj.magic _menhir_stack) MenhirState371
        | LEFTPAR | LIDENT _ ->
            _menhir_reduce98 _menhir_env (Obj.magic _menhir_stack) MenhirState371
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState371)
    | TYPE ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _1 = () in
        let _v : (Uast.spec) = 
# 154 "vocal/gospel/ocaml-lib/uparser.mly"
                    ( raise Ghost_decl )
# 14873 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_spec_init _menhir_env _menhir_stack _menhir_s _v
    | VAL ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _1 = () in
        let _v : (Uast.spec) = 
# 153 "vocal/gospel/ocaml-lib/uparser.mly"
                    ( raise Ghost_decl )
# 14884 "vocal/gospel/ocaml-lib/uparser.ml"
         in
        _menhir_goto_spec_init _menhir_env _menhir_stack _menhir_s _v
    | WITH ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState344 in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AXIOM ->
            _menhir_run362 _menhir_env (Obj.magic _menhir_stack) MenhirState345 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FUNCTION ->
            _menhir_run356 _menhir_env (Obj.magic _menhir_stack) MenhirState345 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | GOAL ->
            _menhir_run354 _menhir_env (Obj.magic _menhir_stack) MenhirState345
        | PREDICATE ->
            _menhir_run346 _menhir_env (Obj.magic _menhir_stack) MenhirState345 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState345)
    | CHECKS | CONSUMES | DIVERGES | ENSURES | EOF | EQUIVALENT | MODIFIES | RAISES | REQUIRES | VARIANT ->
        _menhir_reduce277 _menhir_env (Obj.magic _menhir_stack) MenhirState344
    | MODEL ->
        _menhir_reduce14 _menhir_env (Obj.magic _menhir_stack) MenhirState344
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState344)

# 269 "<standard.mly>"
  

# 14919 "vocal/gospel/ocaml-lib/uparser.ml"

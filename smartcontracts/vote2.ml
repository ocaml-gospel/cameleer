
type config =
  { title          : string
  ; beginning_time : timestamp
  ; finish_time    : timestamp
  }

type action =
  | Vote of string
  | Init of config

type storage =
  { config     : config
  ; candidates : (string, int) map
  ; voters     : address set
  }

let [@logic] init (conf : config) =
  { config = conf
  ; candidates = Map [ ("Yes", 0); ("No", 0) ]
  ; voters     = Set []
  }

let vote (env : Env.t option) (name : string) (storage : storage) =
  let now = Global.get_now env in

  myassert (Timestamp.le storage.config.beginning_time now && Timestamp.lt now storage.config.finish_time);

  let addr = Global.get_source env in

  myassert (not (Set.mem addr storage.voters));

  let x = match Map.get String.eq name storage.candidates with
    | Some i -> i
    | None -> 0
  in
  ([] : operation list),
  { config = storage.config
  ; candidates = Map.update String.eq String.lt name (Some (x + 1)) storage.candidates
  ; voters = Set.update Address.eq Address.lt addr true storage.voters
  }
(*@ ops, stg = vote env name storage
    requires
      match env with None -> false | Some _ -> true
    ensures
      let now = Global.get_now env in
      Timestamp.le storage.config.beginning_time now && 
      Timestamp.lt now storage.config.finish_time && 
      not Set.mem (Global.get_source env) storage.voters ->
      ops = [] &&
      stg =
        let addr = Global.get_source env in
        let x = match Map.get String.eq name storage.candidates with Some i -> i | None -> 0 in
        { storage with
          candidates = Map.update String.eq String.lt name (Some (x + 1)) storage.candidates
          ; voters     = Set.update Address.eq Address.lt addr true storage.voters
        }
    raises
      Fail ->
      let now = Global.get_now env in
      not ( Timestamp.le storage.config.beginning_time now && 
            Timestamp.lt now storage.config.finish_time && 
            not Set.mem (Global.get_source env) storage.voters ) *)

let [@logic] pvote (env : Env.t option) (name : string) (storage : storage) = vote env name storage
(*@ ops, stg = pvote env name storage
    requires
      match env with None -> false | Some _ -> true
    requires
      let now = Global.get_now env in
      Timestamp.le storage.config.beginning_time now && 
      Timestamp.lt now storage.config.finish_time && 
      not Set.mem (Global.get_source env) storage.voters
    ensures
      ops = [] &&
      stg =
        let addr = Global.get_source env in
        let x = match Map.get String.eq name storage.candidates with Some i -> i | None -> 0 in
        { storage with
          candidates = Map.update String.eq String.lt name (Some (x + 1)) storage.candidates
          ; voters     = Set.update Address.eq Address.lt addr true storage.voters
        }
    raises
      Fail -> false *)

let main (env : Env.t option) (action : action) (storage : storage) = match action with
  | Vote name -> vote env name storage
  | Init config -> ([], init config)
(*@ ops, stg = main env action storage
    requires
      match env with None -> false | Some _ -> true
    ensures
        let rec compare_candidates new old =
            match new, old with
            | [], [] -> true
            | (idnew, cntnew)::tlnew, (idold, cntold)::tlold ->
                let diff = cntnew - cntold in
                idnew=idold && (diff = 0 || diff = 1) &&
                compare_candidates tlnew tlold
            | _ -> false
        in
        compare_candidates stg.candidate storage.candidate
    raises
      Fail ->
      let now = Global.get_now env in
      not ( Timestamp.le storage.config.beginning_time now && 
            Timestamp.lt now storage.config.finish_time && 
            not Set.mem (Global.get_source env) storage.voters ) *)

let [@logic] pmain (env : Env.t option) (action : action) (storage : storage) = main env action storage
(*@ ops, stg = pmain env action storage
    requires
      match env with None -> false | Some _ -> true
    requires
      let now = Global.get_now env in
      Timestamp.le storage.config.beginning_time now && 
      Timestamp.lt now storage.config.finish_time && 
      not Set.mem (Global.get_source env) storage.voters
    ensures
      let o, s =
        match action with
        | Vote name -> pvote env name storage
        | Init config -> ([], init config)
      in ops = o && stg = s
    raises
      Fail -> false *)

(* Just for test.  For real voting dApp, this function is not required *)
(* XXX optimized out! *)
let [@entry] test (env : Env.t option) () () =
  let conf =
    { title="test"
    ; beginning_time= Timestamp "2019-09-11T08:30:23Z"
    ; finish_time= Timestamp "2219-09-11T08:30:23Z"
    }
  in
  let storage = init conf in
  let _, storage = main env (Init conf) storage in
  let ops, _ = main env (Vote "hello") storage in (* XXX we need ignore *)
  ops, ()
(*@ ops, stg = test env u1 u2
    requires
      match env with None -> false | Some _ -> true
    ensures
      let conf =
        { title="test"
        ; beginning_time= Timestamp "2019-09-11T08:30:23Z"
        ; finish_time= Timestamp "2219-09-11T08:30:23Z"
        }
      in
      let storage = init conf in
      let now = Global.get_now env in
      Timestamp.le storage.config.beginning_time now && 
      Timestamp.lt now storage.config.finish_time && 
      not Set.mem (Global.get_source env) storage.voters ->
      ops =
        let conf =  { title="test"
                      ; beginning_time= Timestamp "2019-09-11T08:30:23Z"
                      ; finish_time= Timestamp "2219-09-11T08:30:23Z"
                    } in
        let s = init conf in
        let _, s = pmain env (Init conf) s in
        let o, _ = pmain env (Vote "hello") s in o
    raises
      Fail ->
      let conf =
        { title="test"
        ; beginning_time= Timestamp "2019-09-11T08:30:23Z"
        ; finish_time= Timestamp "2219-09-11T08:30:23Z"
        }
      in
      let storage = init conf in
      let now = Global.get_now env in
      not ( Timestamp.le storage.config.beginning_time now && 
            Timestamp.lt now storage.config.finish_time && 
            not Set.mem (Global.get_source env) storage.voters ) *)
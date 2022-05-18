
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

  if (compare now storage.config.beginning_time >= 0 && compare storage.config.finish_time now > 0) then () else failwith ();

  let addr = Global.get_source env in

  if (Set.mem addr storage.voters) then failwith () else ();

  let x = match Map.get name storage.candidates with
    | Some i -> i
    | None -> 0
  in
  ([] : operation list),
  { config = storage.config
  ; candidates = Map.update name (Some (x + 1)) storage.candidates
  ; voters = Set.update addr true storage.voters
  }
(*@ ops, stg = vote env name storage
    requires
      match env with None -> false | Some _ -> true
    ensures
      (compare (Global.get_now env) storage.config.beginning_time >= 0 && compare storage.config.finish_time (Global.get_now env) > 0) && not Set.mem (Global.get_source env) storage.voters ->
      ops = [] &&
      stg =
        let addr = Global.get_source env in
        let x = match Map.get name storage.candidates with Some i -> i | None -> 0 in
        { storage with
          candidates = Map.update name (Some (x + 1)) storage.candidates
          ; voters     = Set.update addr true storage.voters
        }
    raises
      Fail ->
      not (compare (Global.get_now env) storage.config.beginning_time >= 0 && compare storage.config.finish_time (Global.get_now env) > 0) || Set.mem (Global.get_source env) storage.voters *)

let main (env : Env.t option) (action : action) (storage : storage) = match action with
  | Vote name -> vote env name storage
  | Init config -> ([], init config)
(*@ ops, stg = main env action storage
    requires
      match env with None -> false | Some _ -> true
    ensures
      (compare (Global.get_now env) storage.config.beginning_time >= 0 && compare storage.config.finish_time (Global.get_now env) > 0) && not Set.mem (Global.get_source env) storage.voters ->
      let vote = fun env name storage ->
        let addr = Global.get_source env in
        let x = match Map.get name storage.candidates with Some i -> i | None -> 0 in
        let newstg = { storage with candidates = Map.update name (Some (x + 1)) storage.candidates ; voters = Set.update addr true storage.voters } in
        ([], newstg) in
      let o, s =
        match action with
        | Vote name -> vote env name storage
        | Init config -> ([], init config)
      in ops = o && stg = s
    raises
      Fail ->
      not (compare (Global.get_now env) storage.config.beginning_time >= 0 && compare storage.config.finish_time (Global.get_now env) > 0) || Set.mem (Global.get_source env) storage.voters *)

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
    requires match env with None -> false | Some _ -> true
    ensures
      let conf =
        { title="test"
        ; beginning_time= Timestamp "2019-09-11T08:30:23Z"
        ; finish_time= Timestamp "2219-09-11T08:30:23Z"
        }
      in
      let storage = init conf in
      compare (Global.get_now env) storage.config.beginning_time >= 0 &&
      compare storage.config.finish_time (Global.get_now env) > 0 &&
      not Set.mem (Global.get_source env) storage.voters ->
      ops =
        let vote = fun env name storage ->
          let addr = Global.get_source env in
          let x = match Map.get name storage.candidates with Some i -> i | None -> 0 in
          let newstg = { storage with candidates = Map.update name (Some (x + 1)) storage.candidates ; voters = Set.update addr true storage.voters } in
          ([], newstg) in
        let main = fun env action storage ->
          match action with
          | Vote name -> vote env name storage
          | Init config -> ([], init config) in
        let conf =  { title="test"
                      ; beginning_time= Timestamp "2019-09-11T08:30:23Z"
                      ; finish_time= Timestamp "2219-09-11T08:30:23Z"
                    } in
        let s = init conf in
        let _, s = main env (Init conf) s in
        let o, _ = main env (Vote "hello") s in o
    raises
      Fail ->
      let conf =
        { title="test"
        ; beginning_time= Timestamp "2019-09-11T08:30:23Z"
        ; finish_time= Timestamp "2219-09-11T08:30:23Z"
        }
      in
      let storage = init conf in
      not (compare (Global.get_now env) storage.config.beginning_time >= 0 && compare storage.config.finish_time (Global.get_now env) > 0) || Set.mem (Global.get_source env) storage.voters *)

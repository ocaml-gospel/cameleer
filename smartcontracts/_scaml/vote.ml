open SCaml

type config = {
  title : string;
  beginning_time : timestamp;
  finish_time : timestamp;
}
[@@deriving typerep]

type action = Vote of string | Init of config [@@deriving typerep]

type storage' = {
  config : config;
  candidates : (string, int) map;
  voters : address set;
}
[@@deriving typerep]

let init config =
  {config; candidates = Map ["Yes", Int 0; "No", Int 0]; voters = Set []}

let vote name storage =
  let now = Global.get_now () in

  assert (
    now >= storage.config.beginning_time && storage.config.finish_time > now) ;

  let addr = Global.get_source () in

  assert (not (Set.mem addr storage.voters)) ;

  let x =
    match Map.get name storage.candidates with Some i -> i | None -> Int 0
  in
  ( ([] : operation list),
    {
      storage with
      candidates = Map.update name (Some (x + Int 1)) storage.candidates;
      voters = Set.update addr true storage.voters;
    } )

let main action storage =
  match action with
  | Vote name -> vote name storage
  | Init config -> [], init config

(* Just for test.  For real voting dApp, this function is not required *)
(* XXX optimized out! *)
let[@entry] test () () =
  let conf =
    {
      title = "test";
      beginning_time = Timestamp "2019-09-11T08:30:23Z";
      finish_time = Timestamp "2219-09-11T08:30:23Z";
    }
  in
  let storage = init conf in
  let _, storage = main (Init conf) storage in
  let ops, _ = main (Vote "hello") storage in
  (* XXX we need ignore *)
  ops, ()

module Make (T: sig type t end) = struct
  let f (t: T.t) = t
end

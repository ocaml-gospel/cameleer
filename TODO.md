Things to Think About
=====================

1. Order of evaluation of arguments --> not-specified in OCaml, right-to-left in
   WhyML.
   For now, I should think about writing OCaml code in A-normal form.

2. Equality.
   We have polymorphic equality in OCaml, but we have no
   such thing in WhyML! One solution would be to write my OCaml code as a
   functor with equality on objects as an argument. Example: same fringe.

3. Records extended with ghost fields. An example:
   ```
   type 'a t = {
     front: 'a list;
     rear : 'a list;
   } (*@ model view: 'a seq;
         invariant view == front @ List.rev rear *)
   ```
   Now, we have the problem of building inhabitants of type `t`:
   ```
   let mk_t (front: 'a list) (rear: 'a list) =
     { front; rear }
   ```
   Field `view` is missing in such a definition.

   I can think of some solutions, none is perfect:
   * extend GOSPEL with an annotation to initialize ghost fields:
     ```
     { front; rear; (*@ view = front @ List.rev rear *) }
     ```
     What about accessing fields? Would we have something like
     ```
     match q.front, (*@ q.view *) with
     | Cons (_, tl), (*@ Cons (_, tlv) *) -> ...
     ```
     The above code is only "partially" ghost. What if we have a whole block
     that deals only with ghost code?
     ```
     (*@ match q.view with
         | Cons (x, _) -> x
         ... *)
     ```
     This means that GOSPEL should, in fact, be extended to support arbitrary
     OCaml expressions?

   * Use an OCaml attribte to state that a field is ghost:
     ```
     type 'a t = {
       front: 'a list;
       rear : 'a list;
       [@ghost] view: 'a list;
     } (*@ invariant ... *)
     ```
     But now, all hell breaks loose: field `view` will be visible to the
     compiler, and we can only use types that are defined by OCaml (not
     GOSPEL-related ones, such as `seq`).

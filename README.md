Cameleer
========
A Deductive Verification Tool for OCaml Programs

Install
-------
First, start by cloning the Cameleer project:
```
  $ git clone https://github.com/ocaml-gospel/cameleer
```
This will clone the Cameleer repository into a directory named `cameleer`.

Next, pin add the `cameleer` package:
```
  $ opam pin add path/to/cameleer
```
Press `RET` or type `y` to accept both the pin add procedure and again to
install `cameleer`.
Cameleer depends on the GOSPEL specification language (https://github.com/ocaml-gospel/gospel). Since the GOSPEL opam
package is yet to be released, this will pin that too for you (using a commit on the `implementations_gospel` branch).

After installation succeeds, you can try `cameleer` by doing
```
  $ cameleer --version
```

Installing external provers
---------------------------
Consider installing some external provers, in order to conduct proofs via
Why3. Check [here](https://www.lri.fr/~marche/MPRI-2-36-1/install.html) for a
detailed explanation on how to install automated provers Alt-Ergo, CVC4, and Z3,
as well as the Coq proof assistant.

Do not forget to run `why3 config detect` after installing all the provers.

Running Cameleer
----------------
Consider an OCaml file `example.ml` with the following content:
```
  let succ x = x + 1
  (*@ r = succ x
        ensures r > x *)
```
In order to start a proof of correctness of the `succ` function, simply type
```
  $ cameleer example.ml
```
This will launch the Why3 ide on the (translated) `succ` program. From there,
one can chose different theorem provers, in order to discharge the generated
proof obligation.

The `examples/` directory contains several case studies verified with Cameleer.

Using Vagrantfile
-----------------
We have included a `Vagrantfile`, in order to allow one to easily start a
Virtual Machine with all the required dependencies of the Cameleer
project. Simply to
```
vagrant up
```
in the `cameleer` folder in order to start the Virtual Machine. This will take
several minutes. This will install `opam`, the `why3` framework, the `alt-ergo`
solver, the `gospel` specification language, and finally the `cameleer` tool
itself. If it succeeds, expect to see the following message at the end of the
whole process:
```
default: File "test.ml", line 1, characters 39-44:
default: Goal Postcondition from verification condition succ'vc.
default: Prover result is: Valid (0.02s, 2 steps).
```
Then, one can do
```
vagrant ssh
```
to log into the Virtual Machine. We have not included a graphical interface and
we have only installed the `alt-ergo` solver in this setting. Hence, any use of
Cameleer should be performed using the `batch` mode. For instance:
```
cameleer --batch --prover alt-ergo applicative_queue
```
inside the `examples` folder. If you have any trouble running the `cameleer`
after `vagrant ssh`, please run `eval $(opam env)`.

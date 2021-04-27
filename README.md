Cameleer
========
A Deductive Verification Tool for OCaml Programs

Dependency on the VOCaL project
-------------------------------
Cameleer depends on the GOSPEL specification language. Since the GOSPEL opam
package is yet to be release, one should first clone it and install it before
`cameleer`:
```
git clone -b implementations_gospel https://github.com/ocaml-gospel/gospel
opam pin add path/to/gospel
```
This will pin the `gospel` package and ask to install it. Press `RET` or type
`y` to accept both the pin add procedure and the installation part.

Install
-------
First, start by cloning the Cameleer project:
```
  $ git clone git@github.com:mariojppereira/cameleer.git
```
This will clone the Cameleer repository into a directory named `cameleer`.
Note the use of the `--recursive` option, in order to fetch the `vocal`
repository.

Next, pin add the `cameleer` package:
```
  $ opam pin add path/to/cameleer
```
Press `RET` or type `y` to accept both the pin add procedure and again to
install `cameleer`.

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

Do not forget to run `why3 config --detect` after installing all the provers.

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
inside the `examples` folder.

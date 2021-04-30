# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2010"

# general configuration
config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y git
    apt-get install -y emacs
    apt-get install -y autoconf libgmp-dev pkg-config
    apt-get install -y zlib1g-dev
    apt-get install -y libexpat1-dev libgtk2.0-dev libgtksourceview2.0-dev
    apt upgrade -y
    apt-get install -y opam
    SHELL

# configuring the why3 framework
config.vm.provision "shell", privileged: false, inline: <<-SHELL
    opam init -y
    opam switch create 4.12.0
    opam install -y alt-ergo
    opam install -y why3
    SHELL

# installing cameleer and the gospel dependency
config.vm.provision "shell", privileged: false, inline: <<-SHELL
    eval `opam config env`
    git clone -b implementations_gospel https://github.com/ocaml-gospel/gospel
    git clone https://github.com/ocaml-gospel/cameleer
    opam pin add -y gospel
    opam pin add -y cameleer
    why3 config detect
    echo "let succ x = x + 1 (*@ r = succ x ensures r > x *)" > test.ml
    eval `opam config env`
    cameleer --batch --prover alt-ergo test.ml
    SHELL
end

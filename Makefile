all:
	dune build @install

install:
	dune build @install && dune install

clean:
	dune clean
	rm -f *~

.PHONY: all clean install

all:
	dune build @install

install:
	dune install
	why3 config --install-plugin=$(OPAM_SWITCH_PREFIX)/lib/why3/plugins/plugin_cameleer.cmxs

clean:
	dune clean
	rm -f *~

.PHONY: all clean install

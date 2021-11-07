MAINDIR=$(NAIGROOT)/src/$(DEPGEN)/main

all: headers

clean:
	rm -f bytecode.h slotmap.h grammar.asm grammar.byc

headers: slotmaph bytecodeh

slotmaph: grammar.asm

bytecodeh: grammar.byc
	$(MAINDIR)/../bin/genbychdr grammar.byc GRAMMAR > \
		bytecode.h

grammar.asm: grammar.naig
	$(MAINDIR)/compiler/naic \
		-C \
		-i grammar.naig \
		-o grammar.asm \
		-M slotmap.h

grammar.byc: grammar.asm
	$(MAINDIR)/assembler/naia \
		-i grammar.asm \
		-o grammar.byc

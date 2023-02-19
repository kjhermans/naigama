PREVGEN?=../../gen3

all: grammar assembly

clean:
	rm -f grammar.asm grammar.h grammar_slotmap.h
	rm -f assembly.asm assembly.h assembly_slotmap.h

grammar: grammar.h

grammar.h: grammar.asm
	$(PREVGEN)/main/assembler/naia -i grammar.asm -c -o grammar.h

grammar.asm: grammar.naig
	$(PREVGEN)/main/compiler/naic -C -i grammar.naig -o grammar.asm -M grammar_slotmap.h

assembly: assembly.h

assembly.h: assembly.asm
	$(PREVGEN)/main/assembler/naia -i assembly.asm -c -o assembly.h

assembly.asm: assembly.naig
	$(PREVGEN)/main/compiler/naic -i assembly.naig -o assembly.asm -M assembly_slotmap.h

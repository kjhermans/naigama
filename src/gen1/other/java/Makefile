all:
	./bin/gen_instr.pl ../../precomp/instructions.pl \
		> ./src/lib/naigama/Instructions.java
	../../main/compiler/naic -C -i ../../grammar/grammar.naig -o /tmp/grammar.asm -m /tmp/grammar.slotmap
	../../main/assembler/naia -i /tmp/grammar.asm -o /tmp/grammar.byc
	./bin/gen_bytecode.pl /tmp/grammar.byc 'lib.naigama.compiler' \
		> ./src/lib/naigama/compiler/Grammar.java
	./bin/gen_slotmap.pl /tmp/grammar.slotmap 'lib.naigama.compiler' \
		> ./src/lib/naigama/compiler/Slotmap.java
	./bin/gen_bytecode.pl ../../grammar/assembly.byc 'lib.naigama.assembler' \
		> ./src/lib/naigama/assembler/Grammar.java
	./bin/gen_slotmap.pl ../../grammar/assembly.slotmap 'lib.naigama.assembler' \
		> ./src/lib/naigama/assembler/Slotmap.java
	cd src && make

clean:
	cd src && make clean

superclean: clean
	rm -f ./src/lib/naigama/Instructions.java \
		./src/lib/naigama/compiler/Grammar.java \
		./src/lib/naigama/assembler/Grammar.java \
		./src/lib/naigama/compiler/Slotmap.java

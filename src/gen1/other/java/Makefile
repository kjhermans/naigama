all:
	./bin/gen_instr.pl ../../precomp/instructions.pl \
		> ./src/lib/naigama/Instructions.java
	./bin/gen_bytecode.pl ../../grammar/grammar.byc Grammar \
		> ./src/lib/naigama/Grammar.java
	./bin/gen_bytecode.pl ../../grammar/assembly.byc Assembly \
		> ./src/lib/naigama/Assembly.java
	cd src && make

clean:
	cd src && make clean

superclean: clean
	rm -f ./src/lib/naigama/Instructions.java \
		./src/lib/naigama/Grammar.java \
		./src/lib/naigama/Assembly.java

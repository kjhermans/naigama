all: pre bytecode_h slotmap_h error_h instrstring_c functions libraries executables #test

pre: instructions builtins

instructions:
	./bin/geninstr ./precomp/instructions.pl > \
		./include/naigama/instructions.h

builtins:
	./bin/genbltn ./precomp/builtins.pl > \
		./include/naigama/builtins.h

bytecode_h: \
	./include/naigama/compiler/naic_grammar.h \
	./include/naigama/assembler/naia_grammar.h \
	./include/naigama/engine/naie_dbgcmd.h

./include/naigama/engine/naie_dbgcmd.h: ./grammar/debugcmd.byc
	./bin/genbychdr ./grammar/debugcmd.byc DEBUGCOMMAND > \
		./include/naigama/engine/naie_dbgcmd.h

./grammar/debugcmd.byc: ./grammar/debugcmd.asm
	$(PREVGEN)/main/assembler/naia \
		-i ./grammar/debugcmd.asm \
		-o ./grammar/debugcmd.byc

./grammar/debugcmd.asm: ./grammar/debugcmd.naig
	$(PREVGEN)/main/compiler/naic \
		-i ./grammar/debugcmd.naig \
		-o ./grammar/debugcmd.asm \
		-m ./grammar/debugcmd.slotmap

./include/naigama/compiler/naic_grammar.h: ./grammar/grammar.byc
	./bin/genbychdr ./grammar/grammar.byc GRAMMAR > \
		./include/naigama/compiler/naic_grammar.h

./grammar/grammar.byc: ./grammar/grammar.asm
	$(PREVGEN)/main/assembler/naia \
		-i ./grammar/grammar.asm \
		-o ./grammar/grammar.byc

./grammar/grammar.asm: ./grammar/grammar.naig
	$(PREVGEN)/main/compiler/naic \
		-C \
		-i ./grammar/grammar.naig \
		-o ./grammar/grammar.asm \
		-m ./grammar/grammar.slotmap

./include/naigama/assembler/naia_grammar.h: ./grammar/assembly.byc
	./bin/genbychdr ./grammar/assembly.byc ASSEMBLY > \
		./include/naigama/assembler/naia_grammar.h

./grammar/assembly.byc: ./grammar/assembly.asm
	$(PREVGEN)/main/assembler/naia \
		-i ./grammar/assembly.asm \
		-o ./grammar/assembly.byc

./grammar/assembly.asm: ./grammar/assembly.naig
	$(PREVGEN)/main/compiler/naic \
		-i ./grammar/assembly.naig \
		-o ./grammar/assembly.asm \
		-m ./grammar/assembly.slotmap

slotmap_h: \
	./include/naigama/compiler/naic_slotmap.h \
	./include/naigama/assembler/naia_slotmap.h \
	./include/naigama/engine/naie_dbgcmd_slotmap.h

./include/naigama/engine/naie_dbgcmd_slotmap.h: ./grammar/debugcmd.slotmap
	./bin/genslthdr ./grammar/debugcmd.slotmap DEBUGCOMMAND > \
		./include/naigama/engine/naie_dbgcmd_slotmap.h

./grammar/debugcmd.slotmap: ./grammar/debugcmd.asm

./include/naigama/compiler/naic_slotmap.h: ./grammar/grammar.slotmap
	./bin/genslthdr ./grammar/grammar.slotmap GRAMMAR > \
		./include/naigama/compiler/naic_slotmap.h

/grammar/grammar.slotmap: ./grammar/grammar.asm

./include/naigama/assembler/naia_slotmap.h: ./grammar/assembly.slotmap
	./bin/genslthdr ./grammar/assembly.slotmap ASSEMBLY ASMSLOT > \
		./include/naigama/assembler/naia_slotmap.h

/grammar/assembly.slotmap: ./grammar/assembly.asm

error_h:
	perl ./bin/generrhdr . > ./include/naigama/naig_error.h

instrstring_c: ./lib/engine/naie_instr_string.c

./lib/engine/naie_instr_string.c: ./precomp/instructions.pl
	perl ./bin/geninstrstr ./precomp/instructions.pl > \
		./lib/engine/naie_instr_string.c 

functions:
	./bin/genfnchdr \
		-i NAIGAMA_COMPILER \
		-t naic_t \
		-t naic_nspnod_t \
		./lib/compiler \
		./lib/compiler/script \
		./lib/compiler/namespace \
		./lib/compiler/rule \
		./lib/compiler/firstpass > \
		./include/naigama/compiler/naic_functions.h
	./bin/genfnchdr ./lib/assembler \
		-i NAIGAMA_ASSEMBLER \
		-t naia_namespace_t \
		> ./include/naigama/assembler/naia_functions.h
	./bin/genfnchdr ./lib/disassembler \
		-i NAIGAMA_DISASSEMBLER \
		> ./include/naigama/disassembler/naid_functions.h
	./bin/genfnchdr ./lib/engine \
		-i NAIGAMA_ENGINE \
		> ./include/naigama/engine/naie_functions.h
	./bin/genfnchdr ./lib/util \
		-i NAIGAMA_UTIL \
		> ./include/naigama/util/util_functions.h
	./bin/genfnchdr ./lib/memio \
		-i NAIGAMA_MEMIO \
		-a fprefix.h \
		> ./include/naigama/memio/naio_functions.h
	./bin/genfnchdr ./lib/service \
		-i NAIGAMA_SERVICE \
		> ./include/naigama/service/nais_functions.h

#	@MFS=`find src/ -name Makefile | xargs grep -l 'functions:'`; \
#		for MF in $$MFS; do \
#			DIR=`dirname $$MF`; \
#			make -C $$DIR functions; \
#		done


libraries:
	cd lib && make

executables:
	cd main && make

rust:
	@cd other/rust && make

java:
	@cd other/java && make

perl:
	@cd other/perl && make

test:
	cd t/ && make

doc:
	cd d/ && make
	cd w/ && make

clean:

superclean:
	rm -f \
		./include/naigama/instructions.h \
		./include/naigama/builtins.h \
		./include/naigama/compiler/naic_functions.h \
		./include/naigama/assembler/naia_functions.h \
		./include/naigama/disassembler/naid_functions.h \
		./include/naigama/engine/naie_functions.h \
		./include/naigama/util/util_functions.h \
		./include/naigama/memio/naio_functions.h \
		./include/naigama/service/nais_functions.h \
		./grammar/grammar.asm \
		./grammar/grammar.slotmap \
		./grammar/grammar.byc \
		./include/naigama/compiler/naic_slotmap.h \
		./include/naigama/compiler/naic_grammar.h \
		./grammar/assembly.asm \
		./grammar/assembly.slotmap \
		./grammar/assembly.byc \
		./include/naigama/assembler/naia_slotmap.h \
		./include/naigama/assembler/naia_grammar.h \
		./grammar/debugcmd.asm \
		./grammar/debugcmd.slotmap \
		./grammar/debugcmd.byc \
		./include/naigama/engine/naie_dbgcmd.h \
		./include/naigama/engine/naie_dbgcmd.h \
		./include/naigama/engine/naie_dbgcmd_slotmap.h \

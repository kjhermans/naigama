all: instructions bytecode_h slotmap_h functions libraries #test

instructions: naia naid instructions_h

bytecode_h: ./include/naigama/engine/naie_dbgcmd.h

./include/naigama/engine/naie_dbgcmd.h: ./grammar/debugcmd.byc
	./bin/genbychdr ./grammar/debugcmd.byc DEBUGCOMMAND > \
		./include/naigama/engine/naie_dbgcmd.h

./grammar/debugcmd.byc: ./grammar/debugcmd.asm
	./main/assembler/naia ./grammar/debugcmd.asm ./grammar/debugcmd.byc

./grammar/debugcmd.asm: ./grammar/debugcmd.naig
	./main/compiler/naic \
		-i ./grammar/debugcmd.naig \
		-o ./grammar/debugcmd.asm \
		-m ./grammar/debugcmd.slotmap

slotmap_h: ./include/naigama/engine/naie_dbgcmd_slotmap.h

./include/naigama/engine/naie_dbgcmd_slotmap.h: ./grammar/debugcmd.slotmap
	./bin/genslthdr ./grammar/debugcmd.slotmap DEBUGCOMMAND > \
		./include/naigama/engine/naie_dbgcmd_slotmap.h

./grammar/debugcmd.slotmap: ./grammar/debugcmd.asm

functions:
	./bin/genfnchdr ./lib/util > \
		./include/naigama/util/util_functions.h
	./bin/genfnchdr ./lib/engine > \
		./include/naigama/engine/naie_functions.h
	./bin/genfnchdr ./lib/naigama > \
		./include/naigama/naig_functions.h

libraries:
	@cd lib && make

naia: ./main/assembler/naia

./main/assembler/naia: ./precomp/instructions.pl
	./bin/fillup ./main/assembler/naia DEADBEEF ./precomp/instructions.pl

naid: ./main/disassembler/naid

./main/disassembler/naid: ./precomp/instructions.pl
	./bin/fillup ./main/disassembler/naid DEADBEEF ./precomp/instructions.pl

instructions_h: ./include/naigama/instructions.h

./include/naigama/instructions.h: ./precomp/instructions.pl
	./bin/geninstr ./precomp/instructions.pl > \
		./include/naigama/instructions.h

test:
	@cd t/ && make

clean:

superclean:
	@echo "---- Removing instructions hash from assembler"
	rm -rf /tmp/empty
	touch /tmp/empty
	./bin/fillup ./main/assembler/naia DEADBEEF /tmp/empty
	./bin/fillup ./main/disassembler/naid DEADBEEF /tmp/empty
	sleep 1
	touch ./precomp/instructions.pl
	@echo "---- Done removing"
	rm -f ./include/naigama/instructions.h
	rm -f ./include/naigama/engine/naie_functions.h
	rm -f ./include/naigama/naig_functions.h
	rm -f ./include/naigama/util/util_functions.h
	rm -f ./include/naigama/engine/naie_dbgcmd.h
	rm -f ./grammar/debugcmd.asm
	rm -f ./grammar/debugcmd.byc
	rm -f ./grammar/debugcmd.slotmap
	rm -f ./include/naigama/engine/naie_dbgcmd.h
	rm -f ./include/naigama/engine/naie_dbgcmd_slotmap.h

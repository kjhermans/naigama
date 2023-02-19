NAIC=$(PREVGEN)/main/compiler/naic
NAIA=$(PREVGEN)/main/assembler/naia

all: binhdrs

binhdrs: json_bytecode.h json_slotmap.h

json_bytecode.h: json.asm
	$(NAIA) -c -i json.asm -o json_bytecode.h

json_slotmap: compilestep

json.asm: compilestep

compilestep: json.naig
	$(NAIC) -C -i json.naig -o json.asm -M json_slotmap.h

clean:
	rm -f json_bytecode.h json_slotmap.h json.asm

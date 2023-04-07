OBJECTS:=$(shell ls *.c | sort | sed -e 's/\.c$$/.o/')
LIB=libnaid.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CURGEN?=../..
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include

all: grammar_header functionsheader $(LIB)

grammar_header: grammar
	cat bytecode.byc | hexdump -v -e '16/1 "0x%.2x," "\n"' \
		| sed -e 's/0x,//g' > bytecode.h

grammar: bytecode.byc

bytecode.byc: bytecode.asm
	$(CURGEN)/main/assembler/naia -i bytecode.asm -o bytecode.byc

bytecode.asm: bytecode.naig
	$(CURGEN)/main/compiler/naic -M bytecode_slotmap.h \
		-i bytecode.naig -o bytecode.asm

bytecode.naig: $(CURGEN)/precomp/instructions.pl
	$(CURGEN)/bin/gennaid $(CURGEN)/precomp/instructions.pl \
		> bytecode.naig

functionsheader: ../../include/naigama/disassembler/naid_functions.h

../../include/naigama/disassembler/naid_functions.h: *.c
	$(CURGEN)/bin/genfnchdr -t NAIG_ERR_T -i NAID_FUNCTIONS . > \
	  ../../include/naigama/disassembler/naid_functions.h

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS) ../parser/naip.o

clean:
	rm -f $(OBJECTS) $(LIB)

superclean:
	rm -f bytecode.byc bytecode.naig bytecode.asm bytecode.h

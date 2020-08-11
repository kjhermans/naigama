stage_00: functions

functions: \
	naie_functions \
	naic_functions \
	naia_functions \
	naid_functions \
	util_functions

naie_functions: naigama/engine/naie_functions.h

naigama/engine/naie_functions.h: $(BUILDROOT)/src/gen1/lib/engine/*.c
	perl $(BUILDROOT)/bin/gen_functions_header.pl \
		$(BUILDROOT)/src/gen1/lib/engine/ \
		> naigama/engine/naie_functions.h

naic_functions: naigama/compiler/naic_functions.h

naigama/compiler/naic_functions.h: $(BUILDROOT)/src/gen1/lib/compiler/*.c
	perl $(BUILDROOT)/bin/gen_functions_header.pl \
		$(BUILDROOT)/src/gen1/lib/compiler/ \
		> naigama/compiler/naic_functions.h

naia_functions: naigama/assembler/naia_functions.h

naigama/assembler/naia_functions.h: $(BUILDROOT)/src/gen1/lib/assembler/*.c
	perl $(BUILDROOT)/bin/gen_functions_header.pl \
		$(BUILDROOT)/src/gen1/lib/assembler/ \
		> naigama/assembler/naia_functions.h

util_functions: naigama/util/util_functions.h

naid_functions: naigama/disassembler/naid_functions.h

naigama/disassembler/naid_functions.h: $(BUILDROOT)/src/gen1/lib/disassembler/*.c
	perl $(BUILDROOT)/bin/gen_functions_header.pl \
		$(BUILDROOT)/src/gen1/lib/disassembler/ \
		> naigama/disassembler/naid_functions.h

util_functions: naigama/util/util_functions.h

naigama/util/util_functions.h: $(BUILDROOT)/src/gen1/lib/util/*.c
	perl $(BUILDROOT)/bin/gen_functions_header.pl \
		$(BUILDROOT)/src/gen1/lib/util/ \
		> naigama/util/util_functions.h

superclean:
	@rm -f naigama/engine/naie_functions.h \
		naigama/compiler/naic_functions.h \
		naigama/assembler/naia_functions.h \
		naigama/util/util_functions.h

clean:

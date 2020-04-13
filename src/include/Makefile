functions: naie_functions naic_functions naia_functions util_functions

naie_functions: naigama/engine/naie_functions.h

naigama/engine/naie_functions.h: ../lib/engine/*.c
	perl ../../bin/gen_functions_header.pl ../lib/engine/ \
		> naigama/engine/naie_functions.h

naic_functions: naigama/compiler/naic_functions.h

naigama/compiler/naic_functions.h: ../lib/compiler/*.c
	perl ../../bin/gen_functions_header.pl ../lib/compiler/ \
		> naigama/compiler/naic_functions.h

naia_functions: naigama/assembler/naia_functions.h

naigama/assembler/naia_functions.h: ../lib/assembler/*.c
	perl ../../bin/gen_functions_header.pl ../lib/assembler/ \
		> naigama/assembler/naia_functions.h

util_functions: naigama/util/util_functions.h

naigama/util/util_functions.h: ../lib/util/*.c
	perl ../../bin/gen_functions_header.pl ../lib/util/ \
		> naigama/util/util_functions.h

superclean:
	@rm -f naigama/engine/naie_functions.h \
		naigama/compiler/naic_functions.h \
		naigama/assembler/naia_functions.h

clean:

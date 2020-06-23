all:
	@exit -1

stage_0:
	@$(BUILDROOT)/bin/gen_functions_header.pl ./lib/compiler > \
	  ./include/naigama/script/compiler/nasc_functions.h
	@$(BUILDROOT)/bin/gen_functions_header.pl ./lib/assembler > \
	  ./include/naigama/script/assembler/nasa_functions.h
	@$(BUILDROOT)/bin/gen_functions_header.pl ./lib/engine > \
	  ./include/naigama/script/engine/nase_functions.h

stage_6:
	@perl ./bin/generate.pl ./grammar/script.byc ./include

clean:
	@/bin/true

superclean:
	@rm -f ./include/script_bytecode.h ./include/script_slotmap.h

stage_00: functions

functions: naip_functions naic_functions

naip_functions: naigama/processor/naip_functions.h

naigama/processor/naip_functions.h: $(BUILDROOT)/src/gen3/lib/processor/*.c
	perl $(BUILDROOT)/bin/gen_functions_header.pl \
		$(BUILDROOT)/src/gen3/lib/processor/ \
		> naigama/processor/naip_functions.h

naic_functions: naigama/compiler/naic_functions.h

naigama/compiler/naic_functions.h: $(BUILDROOT)/src/gen3/lib/compiler/*.c
	perl $(BUILDROOT)/bin/gen_functions_header.pl \
		$(BUILDROOT)/src/gen3/lib/compiler/ \
		> naigama/compiler/naic_functions.h

superclean:
	@rm -f naigama/processor/naip_functions.h
	@rm -f naigama/compiler/naic_functions.h

clean:

stage_10: 
	@perl $(BUILDROOT)/bin/gen_grammar_headers.pl \
		$(BUILDROOT)/src/instructions.pl \
		$(BUILDROOT)/src/gen3/grammar/grammar.byc \
		$(BUILDROOT)/src/gen3/grammar/assembly.byc \
		$(BUILDROOT)/src/gen3/grammar/optimizer.byc \
		$(BUILDROOT)/src/gen3/grammar/optimizer.byc.labelmap \
		./include/

clean:

superclean:
	@rm -rf ./include/*

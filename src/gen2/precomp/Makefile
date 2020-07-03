stage_6: 
	@perl $(BUILDROOT)/bin/gen_grammar_headers.pl \
		$(BUILDROOT)/src/instructions.pl \
		$(BUILDROOT)/src/gen2/grammar/grammar.byc \
		$(BUILDROOT)/src/gen2/grammar/assembly.byc \
		$(BUILDROOT)/src/gen2/grammar/optimizer.byc \
		$(BUILDROOT)/src/gen2/grammar/optimizer.byc.labelmap \
		./include/

clean:

superclean:
	@rm -rf ./include/*

stage_1: 
	@perl ./generate.pl \
		$(BUILDROOT)/src/instructions.pl \
		$(BUILDROOT)/src/gen1/grammar/grammar.byc \
		$(BUILDROOT)/src/gen1/grammar/assembly.byc \
		$(BUILDROOT)/src/gen1/grammar/optimizer.byc \
		$(BUILDROOT)/src/gen1/grammar/optimizer.byc.labelmap \
		./include/

clean:

superclean:
	@rm -rf ./include/*

stage_5: grammar.byc assembly.byc optimizer.byc

grammar.byc: grammar.asm
	@./assemble.sh grammar.asm grammar.byc

grammar.asm: grammar.naig
	@./compile.sh grammar.naig grammar.asm grammar.slotmap

assembly.byc: assembly.asm
	@./assemble.sh assembly.asm assembly.byc

assembly.asm: assembly.naig
	@./compile.sh assembly.naig assembly.asm assembly.slotmap

optimizer.byc: optimizer.asm
	@./assemble.sh optimizer.asm optimizer.byc || true

optimizer.asm: optimizer.naig
	@./compile.sh optimizer.naig optimizer.asm optimizer.slotmap || true

clean:

superclean:
	@rm -f *.byc *.asm *.slotmap *.labelmap

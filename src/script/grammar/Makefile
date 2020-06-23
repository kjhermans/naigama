stage_5: all

all: script.byc

script.byc: script.asm
	@./assemble.sh script.asm script.byc || true

script.asm: script.naig
	@./compile.sh script.naig script.asm script.slotmap || true

clean:
	@/bin/true

superclean:
	@rm -f script.byc script.asm script.byc.labelmap script.slotmap


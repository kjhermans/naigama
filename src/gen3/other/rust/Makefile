all: precomp
	@cd naigama && cargo build --release

debug: precomp
	@cd naigama && cargo build

precomp:
	@perl ./bin/genrustinstr.pl ../../precomp/instructions.pl > \
		naigama/naigama/src/instructions.rs
	@perl ./bin/gennaig.pl "$(NAIGRELEASE)" > naigama/engine/src/naig.rs
	@../../main/compiler/naic -C \
		-i ../../grammar/grammar.naig \
		-o /tmp/grammar.asm \
		-m /tmp/grammar.slotmap
	@../../main/assembler/naia \
		-i /tmp/grammar.asm \
		-o ./naigama/compiler/src/grammar.byc
	@perl ./bin/genrustslotmap.pl \
		/tmp/grammar.slotmap \
		CMPSLT > ./naigama/compiler/src/naig_slotmap.rs

clean:
	@cd naigama && cargo clean

superclean: clean
	@rm -f naigama/compiler/src/grammar.byc
	@rm -f naigama/compiler/src/naig_slotmap.rs
	@rm -f naigama/Cargo.lock

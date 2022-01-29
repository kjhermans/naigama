all: precomp
	@cd naigama && cargo build

precomp:
	@perl ./bin/genrustinstr.pl ../../precomp/instructions.pl > \
		naigama/engine/src/instructions.rs
	@perl ./bin/gennaig.pl "$(NAIGRELEASE)" > naigama/engine/src/naig.rs
	@perl ./bin/genrustslotmap.pl \
		./naigama/compiler/src/grammar.slotmap \
		CMPSLT > ./naigama/compiler/src/naig_slotmap.rs

clean:
	@cd naigama && cargo clean

superclean: clean
	@rm -f naigama/Cargo.lock

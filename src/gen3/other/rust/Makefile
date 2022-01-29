all: precomp
	@cd naigama && cargo build

precomp:
	@perl ./bin/genrustinstr.pl ../../precomp/instructions.pl > \
		naigama/engine/src/instructions.rs
	@perl ./bin/gennaig.pl "$(NAIGRELEASE)" > naigama/engine/src/naig.rs

clean:
	@cd naigama && cargo clean

superclean: clean
	@rm -f naigama/Cargo.lock

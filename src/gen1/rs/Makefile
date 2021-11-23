all: precomp
	@cd naigama && cargo build

precomp:
	@perl ./genrustinstr.pl ../precomp/instructions.pl "$(NAIGRELEASE)" > \
		naigama/src/instructions.rs
	@perl ./gennaig.pl "$(NAIGRELEASE)" > naigama/src/naig.rs

clean:
	@cd naigama && cargo clean

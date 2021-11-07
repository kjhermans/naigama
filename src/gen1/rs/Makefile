all: precomp
	@cd naigama && cargo build

precomp:
	@perl ./genrustinstr.pl ../precomp/instructions.pl > \
		naigama/src/instructions.rs

clean:
	@cd naigama && cargo clean

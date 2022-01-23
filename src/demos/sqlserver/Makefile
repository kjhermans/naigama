DEPGEN=gen3
#USE_SLEEPYCAT=1

all: btree
	@cd sdbm_tree && make
	@cd grammar && make DEPGEN=$(DEPGEN)
	@cd lib && make DEPGEN=$(DEPGEN) USE_SLEEPYCAT=$(USE_SLEEPYCAT)
	@cd main && make DEPGEN=$(DEPGEN) USE_SLEEPYCAT=$(USE_SLEEPYCAT)

btree:
	git clone https://github.com/kjhermans/sdbm_tree || true
	rm -rf sdbm_tree/.git

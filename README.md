# naigama
Parser library and tools based on Parsing Expression Grammar.

Tour of the repository:

The 'src/instructions.pl' file should be(come) the single source of all
truth regarding the PEG assembly (and sub-assembly) instruction set.

The 'release', 'copyright.c' and 'Makefile' files should be
self-explanatory.

The 't' directory contains the tests. There are more tests, from earlier
work, which I shall add in due course.

The 'd' directory contains documentation. Yes, it's in LaTex. I like LaTex.

The 'bin' directory contains (build and test) supportive executables.
Although you can argue whether the disassembler is that.

In 'src/':

There are multiple generations of the compiler/assembler/engine.
This has different purposes:

gen0 is an implementation of the compiler and assembler (not engine)
in perl. This is to bootstrap the process. 'make superclean' causes you
to land here.

gen1 and gen2 are native compilers/assemblers/engines, that use the
previous generation's bytecode to parse the grammar and assembly.

gen3 is a new concept that incorporates a scripting language into the
grammar syntax. The idea is that, in the end, the entire compiler and
assembler can exist only as a bytecode.

src/genX/grammar  - contains the grammar for the compiler and assembler.

src/genX/include  - contains the header files, split up by library.

src/genX/lib      - contains the C code, split up by library.

src/genX/main     - contains the C code main functions, split up by library.

src/genX/precomp  - contains the precompiled stuff needed to make library
                    building work. Predominantly, a C translation of the
                    'instructions.pl' file, mentioned above.

src/subsys - EXPERIMENTAL. I'm trying to create a sub-assembly code
             that PEG's are compiled to.

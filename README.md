# naigama
Parser library and tools based on Parsing Expression Grammar.

Tour of the repository:

The 'instructions.pl' file should be(come) the single source of all
truth regarding the PEG assembly (and sub-assembly) instruction set.

The 'release', 'copyright.c' and 'Makefile' files should be
self-explanatory.

The 't' directory contains the tests. There are more tests, from earlier
work, which I shall add in due course.

The 'd' directory contains documentation. Yes, it's in LaTex. I like LaTex.

The 'bin' directory contains (build and test) supportive executables.
Although you can argue whether the disassembler is that.

In 'src/parser':

gen0    - you need this when you do a 'make superclean' and you haven't
          done 'make install'. It's to get things going from the very
          beginning; it bootstraps the grammar of the compiler and
          assembler themselves.

          'make superclean' without having previously installed
          the executables, requires perl btw, be warned.

grammar     - contains the grammar for the compiler and assembler.

include     - contains the header files, split up by library.

gen1/lib - contains the C code, split up by library.

gen1/main - contains the C code main functions, split up by library.

gen1/precomp - contains the precompiled stuff needed to make library
              building work. Predominantly, a C translation of the
              'instructions.pl' file, mentioned above.

subsys - EXPERIMENTAL. I'm trying to create a sub-assembly code
         that PEG's are compiled to.

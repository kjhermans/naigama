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

In 'src':

src/aux - you need this when you do a 'make superclean' and you haven't
          done 'make install'. It's to get things going from the very
          beginning; it bootstraps the grammar of the compiler and
          assembler themselves.

src/grammar - contains the grammar for the compiler and assembler.

src/include - contains the header files, split up by library.

src/lib - contains the C code, split up by library.

src/main - contains the C code main functions, split up by library.

src/precomp - contains the precompiled stuff needed to make library
              building work. Predominantly, a C translation of the
              'instructions.pl' file, mentioned above.

src/subsys - EXPERIMENTAL. I'm trying to create a sub-assembly code
             that PEG's are compiled to.

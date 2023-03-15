==== What is it?

Naigama is a collection of specifications, libraries and executables
implementing a Packrat parser modeled, by now loosely, on
Parsing Expression Grammars (more precisely Lua PEG or LPEG, see:
http://www.inf.puc-rio.br/~roberto/lpeg/).

It allows you to specify a set of parsing rules, which - via an
assembly stage - can be compiled into a bytecode, which can be fed
to an execution engine together with a data input, in order to
qualify the input, and / or capture regions from it, and / or modify it.

==== How do I build it?

This project requires shell script and (if you're building from superclean)
perl (don't worry, pythonheads - everything that requires perl is provided
as-is in this repo). It is best compiled on Linux.
I have no MacOS or Windows targets in mind. Feel free.

This is primarily a C language project.
To compile libraries and executables, on the command line, issue 'make'.

Building it creates the building tooling for PEGs, in n generations
compilers.  To compile for any specific generation <n>, do 'make gen<n>'.

To get a debug version, do 'make debug'.
When switching between 'production' and 'debug' builds, it's probably
best to do a 'make clean' in between (I do take care not to use debug
macroes inside typedefs, but there may be some things that go wrong
when you link both debug and non-debug objects).

This repo contains all the precompiled and generated code
(because it is generated in a deterministic fashion, the code shouldn't
change when the underlying collateral doesn't). For those with perl and
an appetite for adventure, 'make superclean' removes all those files as
well.

To compile everything (demo's, documentation, tests, etc), do 'make world'.

==== Generations

The idea behind the generational setup is that every subsequent generation
gets its own parsing needs served by the previous one. The grammar, for
example, has its own syntax specified by a grammar file.  The same goes
for the assembly. 'Naigama can parse itself'.

The current, 'best' generation is generation 3, (and indeed, if you issue
'make install' you'll get gen3) but gen4 is fast catching up.

==== Is there documentation?

Yes. Ongoing effort, but check ./src/gen3/d/compendium.pdf 

==== What else is there?

This project also contains implementations of the library and executables
int Java, Rust and Perl. Although I don't shy away from it, I'm not
super fond of Python, but - again - feel free. For now, this support
is a) immature, and b) beholden to gen1.

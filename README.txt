Naigama is a collection of specifications, libraries and executables
implementing a Packrat parser modeled, by now loosely, on
Parsing Expression Grammars.

It allows you to specify a set of parsing rules, which can be
compiled into a bytecode, which can be fed to an execution engine
together with a data input, in order to qualify said input,
and / or capture regions from it, and / or modify it.

<hr/>

This project requires shell script and perl. It is best compiled
on Linux. I have no MacOS or Windows targets in mind. Feel free.

It creates the building tooling for PEGs, in n generations compilers.

To compile for any specific generation <n>, do 'make gen<n>'.

To compile libraries and executables, do 'make'.

To compile everything (demo's, documentation, tests, etc), do 'make world'.

To get a debug version, do 'make debug'.
When switching between 'production' and 'debug' builds, it's probably
best to do a 'make clean' in between (I do take care not to use debug
macroes inside typedefs, but there may be some things that go wrong
when you link both debug and non-debug objects).

This repo contains all the precompiled and generated code
(because it is generated in a deterministic fashion, the code shouldn't change
when the underlying collateral doesn't).
For those with perl and an appetite for adventure, 'make superclean'
removes all those files as well.

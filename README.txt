This project requires shell script and perl.

It creates the building tooling for PEGs, in n generations compilers.

To compile for any specific generation <n>, do 'make gen<n>'.

To compile everything, do 'make'

To get a debug version, do 'make debug'.
When switching between 'production' and 'debug' builds, it's probably
best to do a 'make clean' in between.

When you really, really want to build from the get-go, do 'make superclean all'.

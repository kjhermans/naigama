-- Grammar:

TOP       <- XMLCHECK
__prefix  <- %s*
XMLCHECK  <- complexitem END
END       <- !.

item        <-  complexitem / simpleitem
simpleitem  <- '<' { %w+ } optattrs %s* '/>'
complexitem <- '<' {:tag: %w+ :} optattrs %s* '>'
               internals %s*
               '</' $tag '>'
internals   <- (item / { (!(%s* '<') .)+ })*
optattrs    <- ( %s+ attrname EQUALS attrvalue )*
attrname    <- {:brace: ['"] :} { %w+ } $brace
attrvalue   <- {:brace: ['"] :} { ( ! $brace . )* } $brace
EQUALS      <- '='

-- Input:

<person>
    <name>
    James
    </name>
    <address>Earth</address>
</person>

-- Result:

OK

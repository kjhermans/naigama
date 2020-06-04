-- Grammar:

TOP       <- XMLCHECK
__prefix  <- %s*
XMLCHECK  <- complexitem END
END       <- !.

item        <-  complexitem / simpleitem
simpleitem  <- '<' { %w+ } optattrs %s* '/>'
complexitem <- '<' {:tag: %w+ } optattrs %s* '>'
               complexbody %s*
               '</' $tag '>'
complexbody <- (item / { (!(%s* '<') .)+ })*
optattrs    <- ( ( attrname1 / attrname2 ) EQUALS attrvalue )*
attrname1   <- {:brace: ['"] } { %w+ } $brace
attrname2   <- { %w+ }
attrvalue   <- {:brace: ['"] } { ( ! $brace . )* } $brace
EQUALS      <- '='

-- Input:

<person "id"="foo" id='bar'>
    <name attr="oi">
    James
    </name>
    <address>Earth</address>
    <single/>
    <singlewithattr id='foo'/>
</person>

-- Result:

OK

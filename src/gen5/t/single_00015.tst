-- Grammar:

CHECK       <- UTF8CHECK XMLCHECK
  
UTF8CHECK   <- & UTF8TEXT
XMLCHECK    <- & XML

UTF8TEXT    <- UTF8CHAR* !.
UTF8CHAR    <- ASCII / DOUBLE / TRIPLE / QUADRUPLE
ASCII       <- [\000-\177]
DOUBLE      <- [\300-\337] [\200-\277]
TRIPLE      <- [\340-\357] [\200-\277] [\200-\277]
QUADRUPLE   <- [\360-\367] [\200-\277] [\200-\277] [\200-\277]

__prefix    <- %s*

XML         <- optheader complexitem END
END         <- !.

optheader   <- header?
header      <- '<?xml' optattrs %s* '?>'

item        <- complexitem / simpleitem
simpleitem  <- '<' { XMLIDENT } optattrs %s* '/>'
complexitem <- '<' {:tag: XMLIDENT } optattrs %s* '>'
               complexbody %s*
               '</' $tag '>'
complexbody <- (item / cdata / { (!(%s* '<') .)+ })*
cdata       <- '<![CDATA[' { ( !']]>' .)* } ']]>'
optattrs    <- ( ( attrname1 / attrname2 ) EQUALS attrvalue )*
attrname1   <- {:nbrace: ['"] } { XMLIDENT } $nbrace
attrname2   <- { XMLIDENT }
attrvalue   <- {:vbrace: ['"] } { ( ! $vbrace . )* } $vbrace
EQUALS      <- '='
XMLIDENT    <- [a-zA-Z][a-zA-Z0-9:]*

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

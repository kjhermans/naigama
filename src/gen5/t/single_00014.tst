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

-- Hexinput:

3c 78 6d 6c 3e

3c 73 6f 6d 65 20 22 76  61 6c 75 65 22 20 3d 20
27 62 61 72 27 20 27 66  6f 6f 27 20 3d 20 27 66
75 27 3e 3c 2f 73 6f 6d  65 3e 0a 3c 6f 74 68 65
72 2f 3e 0a

3c 73 75  62 3e

e285a0202d206f6e650ae285a1202d2074776f0a
e285a2202d2074687265650ae285a3202d20666f
75720ae285a4202d20666976650ae285a5202d20
7369780ae285a6202d20736576656e0ae285a720
2d2065696768740ae285a8202d206e696e650ae2
85a9202d2074656e

3c 2f 73 75  62 3e

3c 2f 78 6d 6c 3e

-- Result:

OK

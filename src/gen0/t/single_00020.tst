-- Grammar:

-- SQL

TOP           <- SQL
__prefix      <- ( '--' [^\n]* '\n' / %s+ )*

SQL           <- STMT+
STMT          <- (
                   SELECT
                   INSERT
                   UPDATE
                   DELETE
                   CREATE
                   DROP
                 ) SEMICOLON

SELECT        <- KW_SELECT SELECTFIELDLIST KW_FROM SET KW_WHERE CONDITION
INSERT        <- KW_INSERT KW_INTO TABLENAME
                 ( BOPEN INSERTFIELDLIST BCLOSE KW_VALUES )?
                 BOPEN INSERTVALUELIST BCLOSE

SELECTFIELDLIST  <- SELECTFIELD ( COMMA SELECTFIELD )*
SELECTFIELD      <- STAR / FIELDNAME KW_AS IDENT / FIELDNAME
INSERTFIELDLIST  <- INSERTFIELD ( COMMA INSERTFIELD )*
INSERTFIELD      <- FIELDNAME
FIELDNAME        <- IDENT
INSERTVALUELIST  <- INSERTVALUE ( COMMA INSERTVALUE )*
INSERTVALUE      <- BOPEN SELECT BCLOSE / LITERAL

SET           <- BOPEN SELECT BCLOSE / TABLENAME
TABLENAME     <- IDENT

CONDITION     <- EXPRESSION

EXPRESSION    <- EXPR2 ({ AND / OR } EXPR2 )*
EXPR2         <- EXPR3 ({ BITAND / BITOR / BITXOR } EXPR3 )*
EXPR3         <- EXPR4 ({ EQUALS / NEQUALS / LTEQ / LT / GTEQ / GT } EXPR4 )*
EXPR4         <- EXPR5 ({ POW / MUL / DIV } EXPR5 )*
EXPR5         <- EXPR6 ({ ADD / SUB } EXPR6 )*
EXPR6         <- ( UNARY )* TERM
UNARY         <- { NOT / INC / DEC }
TERM          <- { LITERAL } /
                 { IDENT } BOPEN ( EXPRESSION ( COMMA EXPRESSION )* )? BCLOSE /
                 { IDENT } /
                 BOPEN { EXPRESSION } BCLOSE


KW_SELECT     <- 'select'i
KW_INSERT     <- 'insert'i
KW_INTO       <- 'into'i
KW_VALUES     <- 'values'i
KW_UPDATE     <- 'update'i
KW_DELETE     <- 'delete'i
KW_CREATE     <- 'create'i
KW_DROP       <- 'drop'i
KW_FROM       <- 'from'i
KW_WHERE      <- 'where'i
KW_AS         <- 'as'i

IDENT         <- [a-zA-Z_][a-zA-Z0-9_]^0-63

AND           <- 'and'i / '&&'
OR            <- 'or'i / '||'
BITAND        <- '&'
BITOR         <- '|'
BITXOR        <- '^'
EQUALS        <- '=' / 'is'i
NEQUALS       <- '!='
LTEQ          <- '<='
LT            <- '<'
GTEQ          <- '>='
GT            <- '>'
POW           <- '**'
MUL           <- '*'
DIV           <- '/'
ADD           <- '+'
SUB           <- '-'
NOT           <- '!' / 'not'i
INC           <- '++'
DEC           <- '--'

LITERAL        <- STRINGLITERAL /
                  HASHLITERAL /
                  LISTLITERAL /
                  FLOATLITERAL /
                  INTLITERAL /
                  BOOLEANLITERAL
STRINGLITERAL  <- '\'' ( '\\' ([nrtv\\'] / [0-9]^3) / [^'\\] )* '\''
HASHLITERAL    <- CBOPEN ( HASHELT ( COMMA HASHELT )* )? CBCLOSE
HASHELT        <- HASHKEY COLON HASHVALUE
HASHKEY        <- TERM
HASHVALUE      <- TERM
LISTLITERAL    <- ABOPEN ( LISTELT ( COMMA LISTELT )* )? ABCLOSE
LISTELT        <- TERM
FLOATLITERAL   <- [0-9]* '.' [0-9]+
INTLITERAL     <- [0-9]+
BOOLEANLITERAL <- 'true' / 'false'

SEMICOLON       <- ';'
COMMA           <- ','
STAR            <- '*'

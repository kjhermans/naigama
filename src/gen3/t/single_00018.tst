-- Grammar:

-- A simple scripting language to be called
-- from rules.

TOP            <- SCRIPT END
__prefix       <- ( %s+ / '#' [^\n]* '\n' )*

END            <- !.
SCRIPT         <- ( TOPSTMT )*
TOPSTMT        <- { FUNCDECL } / { IMPORTSTMT }
IMPORTSTMT     <- KW_IMPORT { STRINGLITERAL } SEMICOLON
LOWSTMT        <- { IFSTMT } /
                  { WHILESTMT } /
                  { RETURNSTMT } /
                  { OTHERSTMT } /
                  { VARDECL } /
                  { ASSIGNMENT } /
                  ( EXPRESSION )? SEMICOLON

FUNCDECL       <- KW_FUNCTION { IDENT }
                   BOPEN ( IDENT ( COMMA IDENT )* )? BCLOSE
                   CBOPEN ( LOWSTMT )* CBCLOSE
IFSTMT         <- KW_IF BOPEN EXPRESSION BCLOSE CBOPEN ( LOWSTMT )* CBCLOSE
                  ( KW_ELSEIF BOPEN EXPRESSION BCLOSE
                    CBOPEN ( LOWSTMT )* CBCLOSE )*
                  ( KW_ELSE CBOPEN ( LOWSTMT )* CBCLOSE )?
WHILESTMT      <- KW_WHILE BOPEN EXPRESSION BCLOSE CBOPEN ( LOWSTMT )* CBCLOSE
RETURNSTMT     <- KW_RETURN EXPRESSION SEMICOLON
OTHERSTMT      <- ( KW_BREAK / KW_CONTINUE ) SEMICOLON
VARDECL        <- KW_VAR IDENT ( ASSIGN EXPRESSION )? SEMICOLON
ASSIGNMENT     <- IDENT ASSIGNS EXPRESSION SEMICOLON

EXPRESSION     <- EXPR2 (( AND / OR ) EXPR2 )*
EXPR2          <- EXPR3 (( BITAND / BITOR / BITXOR ) EXPR3 )*
EXPR3          <- EXPR4 (( EQUALS / NEQUALS / LTEQ / LT / GTEQ / GT ) EXPR4 )*
EXPR4          <- EXPR5 (( POW / MUL / DIV ) EXPR5 )*
EXPR5          <- EXPR6 (( ADD / SUB ) EXPR6 )*
EXPR6          <- { UNARY }* { TERM }
UNARY          <- NOT / INC / DEC
TERM           <- { LITERAL } /
                  { IDENT } BOPEN ( EXPRESSION ( COMMA EXPRESSION )* )? BCLOSE /
                  { IDENT } /
                  BOPEN { EXPRESSION } BCLOSE

LITERAL        <- STRINGLITERAL /
                  HASHLITERAL /
                  LISTLITERAL /
                  FLOATLITERAL /
                  INTLITERAL /
                  BOOLEANLITERAL

STRINGLITERAL  <- { '\'' ( '\\' ([nrtv\\'] / [0-9]^3) / [^'\\] )* '\'' }
HASHLITERAL    <- { CBOPEN ( HASHELT ( COMMA HASHELT )* )? CBCLOSE }
HASHELT        <- { HASHKEY COLON HASHVALUE }
HASHKEY        <- { TERM }
HASHVALUE      <- { TERM }
LISTLITERAL    <- { ABOPEN ( LISTELT ( COMMA LISTELT )* )? ABCLOSE }
LISTELT        <- { TERM }
FLOATLITERAL   <- { [0-9]* '.' [0-9]+ }
INTLITERAL     <- { [0-9]+ }
BOOLEANLITERAL <- { 'true' / 'false' }

KW_IMPORT      <- { 'import' }
KW_FUNCTION    <- { 'function' }
KW_VAR         <- { 'var' }
KW_WHILE       <- { 'while' }
KW_RETURN      <- { 'return' }
KW_IF          <- { 'if' }
KW_ELSEIF      <- { 'elseif' }
KW_ELSE        <- { 'else' }
KW_BREAK       <- { 'break' }
KW_CONTINUE    <- { 'continue' }

IDENT          <- { [a-zA-Z_][a-zA-Z0-9_]^0-63 }
BOPEN          <- { '(' }
BCLOSE         <- { ')' }
CBOPEN         <- { '{' }
CBCLOSE        <- { '}' }
ABOPEN         <- { '[' }
ABCLOSE        <- { ']' }
ASSIGNS        <- { ASSIGN / PLUSIS / MINIS / MULIS / DIVIS }
ASSIGN         <- { '=' }
PLUSIS         <- { '+=' }
MINIS          <- { '-=' }
MULIS          <- { '*=' }
DIVIS          <- { '/=' }
EQUALS         <- { '==' }
NEQUALS        <- { '!=' }
LT             <- { '<' !'=' }
GT             <- { '>' !'=' }
LTEQ           <- { '<=' }
GTEQ           <- { '>=' }
SEMICOLON      <- { ';' }
COLON          <- { ':' }
POW            <- { '**' }
MUL            <- { '*' !'*' }
DIV            <- { '/' !'=' }
ADD            <- { '+' ![+=] }
SUB            <- { '-' ![\-=] }
INC            <- { '++' }
DEC            <- { '--' }
AND            <- { '&&' }
OR             <- { '||' }
BITAND         <- { '&' ![&=] }
BITOR          <- { '|' ![|=] }
BITXOR         <- { '^' !'=' }
NOT            <- { '!' !'=' }
COMMA          <- { ',' }

-- Input:

function foo (bar) {
  var a=3;
  a=((a+1)*5);
  
  var b = [ 1, 2, 'foo' ];
  
  var c = {
    aa : 'bar',
    bb : foo(b)
  };

  if (foo) {
  } elseif (bar) {
    3;
  } elseif (fubar) {
    4;
  } else {
    barfu();
  }

  return foo(6);
}

-- Result:

OK

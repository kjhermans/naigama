-- Replace:

OPT     <- ((!QUAD .)* QUAD)*
QUAD    <- {
             'char' S { HEXBYTE } S
             'char' S { HEXBYTE } S
             'char' S { HEXBYTE } S
             'char' S { HEXBYTE }
           } -> 'quad ' $1 $2 $3 $4
HEXBYTE <- [0-9a-fA-F]^2
S       <- %s+

-- Input:

any
char 61
char 61
char 61
char 61
any

-- Result:

OK

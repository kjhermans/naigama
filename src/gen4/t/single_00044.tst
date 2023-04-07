-- Grammar:

TOP        <- NUMBERLIST END
__prefix   <- %s*
END        <- !.
NUMBERLIST <- NUMBER ( COMMA NUMBER )^-7
NUMBER     <- { [0-9]+ }
COMMA      <- ','

-- Input:

40,
60,
70, 402342,
42234,
66,

777,
3

-- Result:

OK

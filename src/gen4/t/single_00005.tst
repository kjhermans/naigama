-- Replace:

CSV       <- CSVRECORD ( '\n' CSVRECORD)* / ...
CSVRECORD <- { CSVFIELD ( COMMA CSVFIELD)* / ... }
          -> '<record>' $0 '</record>'
CSVFIELD  <- { ( '\\' [nrtv,] / [^,\n] )* }
          -> '<field>' $1 '</field>'
COMMA     <- { ',' } -> ' '

-- Input:
r1f1, r1f2, r1f3
r2f1,
, r3f2
,, r4f3
-- Result:

OK

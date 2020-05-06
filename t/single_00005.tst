-- Replace:

CSV       <- CSVRECORD ( '\n' CSVRECORD)* / ...
CSVRECORD <- { CSVFIELD ( ',' CSVFIELD)* / ... }
          -> '<record>\n' $0 '\n</record>'
CSVFIELD  <- { ( '\\' [nrtv,] / [^,\n] )* }
          -> '<field>' $1 '</field>\n'

-- Input:

foo,bar,foobar
barfu,barfu,fubar
,foo, foo

-- Result:

OK

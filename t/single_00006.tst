-- Replace:

CSV       <- CSVRECORD ( '\n' CSVRECORD)*
CSVRECORD <- { CSVFIELD ( ',' CSVFIELD)* } -> '<record>' $0 '</record>'
CSVFIELD  <- { ( '\\' [nrtv,] / [^,] )+ } -> '<field>' $1 '</field>'

-- Input:

foo,bar,foobar
barfu,barfu,fubar
,foo, foo

-- Result:

OK

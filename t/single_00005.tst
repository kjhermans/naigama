-- Replace:

CSV       <- { ( { CSVRECORD } '\n' )* } -> '<record>' $1 '</record>'
CSVRECORD <- { ( { CSVFIELD } ',' )* } -> '<field>' $1 '</field>'
CSVFIELD  <- ( '\\' [nrtv,] / [^,] )*

-- Input:

foo,bar,foobar
barfu,barfu,fubar
,foo, foo

-- Result:

OK

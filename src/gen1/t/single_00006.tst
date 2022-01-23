-- Replace:

CSV       <- { ( {:rec: CSVRECORD } '\n' )* } -> '<record>' $rec '</record>'
CSVRECORD <- { ( {:fld: CSVFIELD } ',' )* } -> '<field>' $fld '</field>'
CSVFIELD  <- ( '\\' [nrtv,] / [^\n,] )*

-- Input:

foo,bar,foobar
barfu,barfu,fubar
,foo, foo

-- Result:

OK

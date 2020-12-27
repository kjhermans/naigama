-- Grammar:

top      <- exp
__prefix <- %s*
exp      <- l3

l3       <- { { l2 } { ( ADD / SUB ) l2 }* }
l2       <- { { l1 } { ( MUL / DIV ) l1 }* }
l1       <- { [0-9]+ }

ADD      <- { '+' }
SUB      <- { '-' }
MUL      <- { '*' }
DIV      <- { '/' }

-- Input:

5 * 4 - 2 / 6 * 3 + 4 - 2 * 1

-- Result:

OK

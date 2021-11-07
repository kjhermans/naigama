-- Grammar:

snortrule  <- {action} sp+ {protocol} sp+ {expression} sp* {options}
action     <- 'alert'    /
              'log'      /
              'pass'     /
              'activate' /
              'dynamic'
protocol   <- 'tcp'      /
              'udp'      /
              'icmp'
expression <- {fromip} sp+ {fromport} sp* '->' sp* {toip} sp+ {toport}
fromip     <- ipdef / 'any'
toip       <- ipdef / 'any'
ipdef      <- '!'? sp* ip
ip         <- ipadrnaieg / iplist
ipadrnaieg <- ipseg / ipadr
ipseg      <- ipadr '/' [0-9]+
ipadr      <- [0-9]+ '.' [0-9]+ '.' [0-9]+ '.' [0-9]+
iplist     <- '[' sp* ipadrnaieg ( sp* ',' sp* ipadrnaieg )* sp* ']'
fromport   <- port
toport     <- port
port       <- [0-9]+ / 'any'
options    <- nvlist / ...
nvlist     <- '(' sp* namevalue ( sp* ';' sp* namevalue )* sp* ')'
namevalue  <- { name } sp* ':' sp* { value }
name       <- [a-zA-Z]+
value      <- '"' [^"]* '"'
sp         <- [ \t]

-- Input:
log udp any any -> 192.168.1.2 514

-- Result:

OK

-- Grammar:

LIST      <- 0x30 derlength <<ruint32:$_:OBJECTS>>
OBJECTS   <- OBJECT*
OBJECT    <- LIST / OID / IPV4
OID       <- 0x06 derlength <<ruint32:$_:oidvalue>>
IPV4      <- 0x40 0x04 { .... }

oidvalue <- { { . } { |80|80|* |00|80| }* }

derlength <- & |00|80| { . } / 0x81 { . } / 0x82 { .. } / 0x83 { ... } / 0x84 { .... }

-- Hexinput:

30 18 06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 01 40 04 C0 A8 50 01

-- Result:

OK

-- Grammar:

OID        <- 0x06 BERLENGTH <<ruint32:$_:OIDVALUE>>
OIDVALUE   <- { { . } { |80|80|* |00|80| }* }
BERLENGTH  <- & |00|80| { . } / 0x81 { . } / 0x82 { .. } / 0x83 { ... } / 0x84 { .... }

-- Hexinput:

06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 01

-- Result:

OK

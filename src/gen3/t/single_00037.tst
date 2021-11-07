-- Grammar:

SNMPV3         <- GENERICLIST

BERLENGTH      <- & |00|80| { . } / 0x81 { . } / 0x82 { .. } / 0x83 { ... } / 0x84 { .... }

ANY            <- GENERICLIST / OID / INTEGER / IPV4 / NULL /
                  BSTRING / PSTRING / ISTRING / USTRING / OSTRING /
                  GENERICSET / GCTXSPCLASS / TIMESTAMP /
                  BOOLEAN / GINTEGER

GENERICLIST    <- SEQUENCE BERLENGTH <<ruint32:$_:LISTCONTENT>>
GENERICSET     <- SET BERLENGTH <<ruint32:$_:LISTCONTENT>>
GCTXSPCLASS    <- CTXSPCLASS BERLENGTH <<ruint32:$_:LISTCONTENT>>
LISTCONTENT    <- { ANY }* !.

SEQUENCE       <- 0x30
SET            <- 0x31
CTXSPCLASS     <- 0xa3
INTEGER        <- INTEGERTYPE BERLENGTH <<ruint32:$_:INTEGERVALUE>>
INTEGERTYPE    <- 0x02 / 0xa0
INTEGERVALUE   <- { .* }
IPV4           <- 0x40 0x04 { .... } !.
NULL           <- 0x05 0x00
BITSTRING      <- 0x03
TIMESTAMP      <- 0x17 BERLENGTH <<ruint32:$_:TIMECONTENT>>
TIMECONTENT    <- { .* }
BOOLEAN        <- 0x01 0x01 { . } !.
GAUGE32        <- 0x42
GINTEGER       <- GAUGE32 BERLENGTH <<ruint32:$_:INTEGERVALUE>>

PRINTABLESTRING <- 0x13
IASTRING        <- 0x16
UTF8STRING      <- 0x0c
OCTETSTRING     <- 0x04

BSTRING         <- BITSTRING BERLENGTH <<ruint32:$_:STRINGCNT>>
PSTRING         <- PRINTABLESTRING BERLENGTH <<ruint32:$_:STRINGCNT>>
ISTRING         <- IASTRING BERLENGTH <<ruint32:$_:STRINGCNT>>
USTRING         <- UTF8STRING BERLENGTH <<ruint32:$_:STRINGCNT>>
OSTRING         <- OCTETSTRING BERLENGTH <<ruint32:$_:STRINGCNT>>
STRINGCNT       <- { .* }

OID            <- 0x06 BERLENGTH <<ruint32:$_:OIDVALUE>>
OIDVALUE       <- { { . } { |80|80|* |00|80| }* } !.

-- Hexinput:

30 81 E2
  02 01 03
  30 12
    02 04 58 08 EE 29
    02 04 7F FF FF FF
    04 01 04
    02 01 03
  04 25
    30 23
      04 10 80 00 70 7F 40 53 6B 79 54 61 6C 65 00 00 04 D2
      02 01 00
      02 03 12 41 29
      04 03 66 6F 6F
      04 00
      04 00
  30 81 A1
    04 10 80 00 70 7F 40 53 6B 79 54 61 6C 65 00 00 04 D2
    04 00
    A3 81 8A
      02 04 23 A8 57 69
      02 01 00
      02 01 00
      30 7C
        30 18
          06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 01
          40 04 C0 A8 50 01
        30 18
          06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 02
          40 04 C0 A8 50 00
        30 18
          06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 03
          40 04 FF FF FF 00
        30 15
          06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 04
          42 01 64
        30 15
          06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 05
          02 01 04

-- Result:

OK

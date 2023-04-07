-- Grammar:

SNMPv3          <- LIST
LIST            <- ( 0x30 / 0xa3 )
                   (
                     (
                       & |80|80|
                       {:lenlen;uint32: &7f . }
                       {:len;uint32: .}^$lenlen 
                     )
                     /
                     (
                       {:len;uint32: . }
                     )
                   ) {.}=> LISTCONTENTS ^$len
LISTCONTENTS    <- ( LIST / INT / STRING / NULL / OID / IPV4 / GAUGE )* !.
INT             <- 0x02 {:len;uint32: . } {.}^$len
STRING          <- 0x04 {:len;uint32: . } {.}^$len
NULL            <- 0x05 0x00
OID             <- 0x06 {:len;uint32: . } {.}^$len
IPV4            <- 0x40 {:len;uint32: . } {.}^$len
GAUGE           <- 0x42 {:len;uint32: . } {.}^$len

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

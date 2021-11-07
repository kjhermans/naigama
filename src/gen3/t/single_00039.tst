-- Grammar:

SEQUENCE       <- SEQUENCETYPE BERLENGTH <<ruint32:$_:SEQUENCEVALUE>>
SEQUENCEVALUE  <- OID EMAIL
OID            <- OIDTYPE BERLENGTH <<ruint32:$_:OIDVALUE>>
OIDVALUE       <- { { . } { |80|80|* |00|80| }* }
BERLENGTH      <- & |00|80| { . } / 0x81 { . } / 0x82 { .. } / 0x83 { ... } / 0x84 { .... }

EMAIL          <- IASTRING BERLENGTH <<ruint32:$_:EMAILVALUE>>

EMAILVALUE     <- { USERNAME '@' FQDN }
USERNAME       <- { [a-zA-Z0-9.]+ }
FQDN           <- { [a-zA-Z0-9.]+ }

SEQUENCETYPE   <- 0x30
OIDTYPE        <- 0x06
IASTRING       <- 0x16

-- Hexinput:

30 27
          06 09 2a 86 48 86 f7 0d 01 09 01
          16 1a 6b 65 65 73 2e 6a 61 6e 2e 68 65 72 6d 61 6e 73 40 67 6d 61 69 6c 2e 63 6f 6d

-- Result:

OK

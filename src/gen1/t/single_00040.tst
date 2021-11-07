-- Grammar:

IKE_MSG1     <- HDR SAi1 KEi Ni
IKE_MSG2     <- HDR SAr1 KEr Nr CERTREQ?

HDR          <- SPIi SPIr NextPayload Version ExchangeType Flags MsgID Length

SPIi         <- { ........ }
SPIr         <- { ........ }
NextPayload  <- {:np: NEXTPAYLOAD }
Version      <- 0x20
ExchangeType <- IKE_SA_INIT / IKE_AUTH / CREATE_CHILD_SA / INFORMATIONAL
Flags        <- &BIT_R &BIT_V &BIT_I .
MsgID        <- { .... }
Length       <- {:len: .... }

BIT_R        <- { |20|20| }
BIT_V        <- { |10|10| }
BIT_I        <- { |08|08| }

CFlags       <- { &|80|80| } .
PayloadLength <- {:pl: .. }

KEi          <- KE
KEr          <- KE
KE           <- NextPayload CFlags PayloadLength

SAi1         <- SA
SAr1         <- SA
SA           <- NextPayload CFlags PayloadLength

Ni           <- N
Nr           <- N
N            <- NextPayload CFlags PayloadLength

CERTREQ      <- NextPayload CFlags PayloadLength
                CertEncoding
CertEncoding <- { . }

IKE_SA_INIT     <- 0x22
IKE_AUTH        <- 0x23
CREATE_CHILD_SA <- 0x24
INFORMATIONAL   <- 0x25

NEXTPAYLOAD     <- NP_NONE /
                   NP_SA /
                   NP_KE /
                   NP_IDi /
                   NP_IDr /
                   NP_CERT /
                   NP_CERTREQ /
                   NP_AUTH /
                   NP_NiNr /
                   NP_N /
                   NP_D /
                   NP_V /
                   NP_TSi /
                   NP_TSr /
                   NP_SK /
                   NP_CP /
                   NP_EAP
NP_NONE         <- 0x00
NP_SA           <- 0x21
NP_KE           <- 0x22
NP_IDi          <- 0x23
NP_IDr          <- 0x24
NP_CERT         <- 0x25
NP_CERTREQ      <- 0x26
NP_AUTH         <- 0x27
NP_NiNr         <- 0x28
NP_N            <- 0x29
NP_D            <- 0x2a
NP_V            <- 0x2b
NP_TSi          <- 0x2c
NP_TSr          <- 0x2d
NP_SK           <- 0x2e
NP_CP           <- 0x2f
NP_EAP          <- 0x30

-- Hexinput:

54 c1 84 96 
1b c3 fd 77 63 86 aa 22
73 ed 39 72 21 20 22 20 
00 00 00 00 00 00 01 19
22 00 00 30 00 00 00 2c 
01 01 00 04 03 00 00 0c
01 00 00 0c 80 0e 00 80 
03 00 00 08 02 00 00 02
03 00 00 08 03 00 00 02 
00 00 00 08 04 00 00 02
28 00 00 88 00 02 00 00 
93 93 d1 e7 d1 47 63 96
c2 55 94 0d ac a9 88 e1 
d5 4f dc 9f 59 4d 7a 65
84 af 8f c8 90 30 8f e8 
b3 d3 42 81 04 cb c7 22
de 43 6f 82 1f a8 bb 2c 
67 fe 70 29 3e 97 f2 97
ca 5a 82 53 86 3c 2c 90 
4c ce 45 c3 39 49 70 1f
20 be 59 85 7d 49 ce 3f 
64 85 68 1e b4 03 31 27
3b 48 b6 f2 96 6f d3 43 
6a 11 bd 85 d6 bc 0e 51
4a 22 35 75 e8 a6 b6 77 
9b 06 15 36 4d 83 70 14
42 ed 89 35 44 c6 ce bb 
26 00 00 24 5f 1d a8 6c
f3 de 54 db 06 1b 7b 33 
4d ce 97 56 b8 52 54 c8
41 55 1b 0e 6c dc 8c d3 
c2 d5 86 7c 29 00 00 19
04 44 76 41 e5 26 8a d6 
a4 bc 5b 98 24 60 aa 0c
66 10 3c 05 c3 00 00 00 
08 00 00 40 08

-- Result:

Ok

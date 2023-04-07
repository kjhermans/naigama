-- Grammar:

CERTIFICATE    <- SEQUENCE BERLENGTH <<ruint32:$_:CERTCONTENT>>

BERLENGTH      <- & |00|80| { . } / 0x81 { . } / 0x82 { .. } / 0x83 { ... } / 0x84 { .... }

CERTCONTENT    <- TBSCERTIFICATE
                  SIGNATUREALGORITHM
                  SIGNATUREVALUE
TBSCERTIFICATE <- SEQUENCE BERLENGTH <<ruint32:$_:TBSCERTCONTENT>>
TBSCERTCONTENT <- VERSION
                  SERIALNUMBER
                  SIGNATURE
                  ISSUER
                  VALIDITY
                  SUBJECT
                  SUBJECTPUBKEYINFO
                  ISSUERUNIQUEID ?
VERSION        <- GCTXSPCLASS
SERIALNUMBER   <- INTEGER
SIGNATURE      <- SEQUENCE BERLENGTH <<ruint32:$_:ALGIDENTCONT>>
ALGIDENTCONT   <- ALGORITHM
                  PARAMETERS ?
ALGORITHM      <- { OID }
PARAMETERS     <- ANY
ISSUER         <- SEQUENCE BERLENGTH <<ruint32:$_:ISSUERCONTENT>>
ISSUERCONTENT  <- { ISSUERNV }*
ISSUERNV       <- SET BERLENGTH <<ruint32:$_:ISSUERNV_>>
ISSUERNV_      <- SEQUENCE BERLENGTH <<ruint32:$_:ISSUERNV__>>
ISSUERNV__     <- ISSUERNAME ISSUERVALUE
ISSUERNAME     <- { OID }
ISSUERVALUE    <- { ANY }
SIGNATUREALGORITHM <- SEQUENCE BERLENGTH <<ruint32:$_:SIGALGCONTENT>>
SIGALGCONTENT  <- OID ANY?
SIGNATUREVALUE <- BITSTRING BERLENGTH <<ruint32:$_:SIGVALCONTENT>>
SIGVALCONTENT  <- . { .* }
VALIDITY       <- SEQUENCE BERLENGTH <<ruint32:$_:VALIDITYCONTENT>>
VALIDITYCONTENT <- VALIDFROM VALIDUNTIL
VALIDFROM      <- TIMESTAMP
VALIDUNTIL     <- TIMESTAMP
SUBJECT        <- SEQUENCE BERLENGTH <<ruint32:$_:SUBJECTCONTENT>>
SUBJECTCONTENT <- SUBJENTRY*
SUBJENTRY      <- SET BERLENGTH <<ruint32:$_:SUBJENTRYNV_>>
SUBJENTRYNV_   <- SEQUENCE BERLENGTH <<ruint32:$_:SUBJENTRYNV__>>
SUBJENTRYNV__  <- SUBJENTRYNAME SUBJENTRYVALUE
SUBJENTRYNAME  <- { OID }
SUBJENTRYVALUE <- { ANY }
SUBJECTPUBKEYINFO <- SEQUENCE BERLENGTH <<ruint32:$_:SPKICONTENT>>
SPKICONTENT    <- { ANY }*
ISSUERUNIQUEID <- CTXSPCLASS BERLENGTH <<ruint32:$_:ISSUERUIDCONTENT>>
ISSUERUIDCONTENT <- { ANY }*

ANY            <- GENERICLIST / OID / INTEGER / IPV4 / NULL /
                  BSTRING / PSTRING / ISTRING / USTRING / OSTRING /
                  GENERICSET / GCTXSPCLASS / TIMESTAMP /
                  BOOLEAN

GENERICLIST    <- SEQUENCE BERLENGTH <<ruint32:$_:LISTCONTENT>>
GENERICSET     <- SET BERLENGTH <<ruint32:$_:LISTCONTENT>>
GCTXSPCLASS    <- CTXSPCLASS BERLENGTH <<ruint32:$_:LISTCONTENT>>
LISTCONTENT    <- { ANY }*

SEQUENCE       <- 0x30
SET            <- 0x31
CTXSPCLASS     <- 0xa3 / 0xa0
INTEGER        <- INTEGERTYPE BERLENGTH <<ruint32:$_:INTEGERVALUE>>
INTEGERTYPE    <- 0x02
INTEGERVALUE   <- { .* }
IPV4           <- 0x40 0x04 { .... }
NULL           <- 0x05 0x00
BITSTRING      <- 0x03
TIMESTAMP      <- 0x17 BERLENGTH <<ruint32:$_:TIMECONTENT>>
TIMECONTENT    <- { .* }
BOOLEAN        <- 0x01 0x01 { . }

PRINTABLESTRING <- 0x13
IASTRING        <- 0x16
UTF8STRING      <- 0x0c
OCTETSTRING     <- 0x04

BSTRING         <- BITSTRING BERLENGTH <<ruint32:$_:BSTRINGCNT>>
PSTRING         <- PRINTABLESTRING BERLENGTH <<ruint32:$_:STRINGCNT>>
ISTRING         <- IASTRING BERLENGTH <<ruint32:$_:STRINGCNT>>
USTRING         <- UTF8STRING BERLENGTH <<ruint32:$_:STRINGCNT>>
OSTRING         <- OCTETSTRING BERLENGTH <<ruint32:$_:STRINGCNT>>
STRINGCNT       <- { .* }
BSTRINGCNT      <- . { .* }

OID            <- 0x06 BERLENGTH <<ruint32:$_:OIDVALUE>>
OIDVALUE       <- { { . } { |80|80|* |00|80| }* }

-- Hexinput:

3082030c30820275a00302010202142a7ece09af363678e3d1fa7889a87c
cc7b71c698300d06092a864886f70d01010b0500308197310b3009060355
040613024e4c310b300906035504080c0255543110300e06035504070c07
4c65657264616d310e300c060355040a0c054d796f726731133011060355
040b0c0a54686573656374696f6e3119301706035504030c104b6565732d
4a616e204865726d616e733129302706092a864886f70d010901161a6b65
65732e6a616e2e6865726d616e7340676d61696c2e636f6d301e170d3231
303930353039303230315a170d3236303930343039303230315a30819731
0b3009060355040613024e4c310b300906035504080c0255543110300e06
035504070c074c65657264616d310e300c060355040a0c054d796f726731
133011060355040b0c0a54686573656374696f6e3119301706035504030c
104b6565732d4a616e204865726d616e733129302706092a864886f70d01
0901161a6b6565732e6a616e2e6865726d616e7340676d61696c2e636f6d
30819f300d06092a864886f70d010101050003818d0030818902818100b6
f317e578439323782b1e2772266d74e7839af1f3423fa1678421d54e7f99
edf412683d8a0098fbc3a84622c14df45d293f101059fdeac107d68f31ce
1e71df809950dad15da9336b4d933e8cab446834289d234a7c6ef7a88a23
8b406b831ae2be4ad589d77cfe123958b2fe359e7786abf3aef25f53170c
224e3d3d778b7f0203010001a3533051301d0603551d0e0416041410543d
8475fb406ca9f9accbbd77e9a9cffd3c7e301f0603551d23041830168014
10543d8475fb406ca9f9accbbd77e9a9cffd3c7e300f0603551d130101ff
040530030101ff300d06092a864886f70d01010b0500038181004583db1f
6fa3ce5be79c40413b268531e278dc85a8497fee687d11c742eb22233dff
3a66f795c1c952c3956b55736c5c0ac9837989343f0e86bc143852b9e97e
b6b3e0dc701282fa87ce382940a2fb21a510758aa16d6708dadaea5f83a7
37297b9b51be3c682fae327766676530f6362949a03b789a697d4935187d
e8df3b6e

-- Result:

OK

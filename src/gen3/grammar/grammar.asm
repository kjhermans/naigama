  call GRAMMAR
  end
-- Rule
GRAMMAR:
  catch __RIGHTHAND_6
  call DEFINITION
  catch __TERM_12
__TERM_11:
  call DEFINITION
  partialcommit __TERM_11
__TERM_12:
  commit __LEFTHAND_7
__RIGHTHAND_6:
  call SINGLE_EXPRESSION
__LEFTHAND_7:
  call END
  ret
-- Rule
S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __TERM_30
__TERM_29:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_29
__TERM_30:
  ret
-- Rule
COMMENT:
  char 2d
  char 2d
  catch __TERM_42
__TERM_41:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_41
__TERM_42:
  char 0a
  ret
-- Rule
__prefix:
  catch __TERM_54
__TERM_53:
  catch __RIGHTHAND_56
  call COMMENT
  commit __LEFTHAND_57
__RIGHTHAND_56:
  call S
__LEFTHAND_57:
  partialcommit __TERM_53
__TERM_54:
  ret
-- Rule
END:
  call __prefix
  catch __TERM_70
  any
  failtwice
__TERM_70:
  ret
-- Rule
DEFINITION:
  call __prefix
  catch __RIGHTHAND_76
  opencapture 0
  call FUNCDECL
  closecapture 0 0
  commit __LEFTHAND_77
__RIGHTHAND_76:
  opencapture 1
  call RULE
  closecapture 1 0
__LEFTHAND_77:
  ret
-- Rule
SINGLE_EXPRESSION:
  call __prefix
  call EXPRESSION
  ret
-- Rule
RULE:
  call __prefix
  opencapture 2
  call IDENT
  closecapture 2 0
  call LEFTARROW
  call EXPRESSION
  call SEMICOLON
  ret
-- Rule
EXPRESSION:
  call __prefix
  catch __RIGHTHAND_138
  opencapture 3
  call TERMS
  closecapture 3 0
  call OR
  call NOTHING
  commit __LEFTHAND_139
__RIGHTHAND_138:
  catch __RIGHTHAND_164
  opencapture 4
  call TERMS
  closecapture 4 0
  call OR
  call EXPRESSION
  commit __LEFTHAND_165
__RIGHTHAND_164:
  opencapture 5
  call TERMS
  closecapture 5 0
__LEFTHAND_165:
__LEFTHAND_139:
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 6
  call TERM
  closecapture 6 0
  catch __TERM_206
__TERM_205:
  opencapture 6
  call TERM
  closecapture 6 0
  partialcommit __TERM_205
__TERM_206:
  ret
-- Rule
TERM:
  call __prefix
  opencapture 7
  call ENDOWEDMATCHER
  closecapture 7 0
  ret
-- Rule
ENDOWEDMATCHER:
  call __prefix
  catch __TERM_235
  opencapture 8
  catch __RIGHTHAND_238
  call NOT
  commit __LEFTHAND_239
__RIGHTHAND_238:
  call AND
__LEFTHAND_239:
  closecapture 8 0
  commit __TERM_235
__TERM_235:
  call MATCHER
  catch __TERM_261
  opencapture 9
  call QUANTIFIER
  closecapture 9 0
  commit __TERM_261
__TERM_261:
  ret
-- Rule
QUANTIFIER:
  call __prefix
  catch __RIGHTHAND_270
  char 3f
  commit __LEFTHAND_271
__RIGHTHAND_270:
  catch __RIGHTHAND_278
  char 2b
  commit __LEFTHAND_279
__RIGHTHAND_278:
  catch __RIGHTHAND_286
  char 2a
  commit __LEFTHAND_287
__RIGHTHAND_286:
  catch __RIGHTHAND_294
  char 5e
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_312
__TERM_311:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_311
__TERM_312:
  closecapture 10 0
  char 2d
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_330
__TERM_329:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_329
__TERM_330:
  closecapture 11 0
  commit __LEFTHAND_295
__RIGHTHAND_294:
  catch __RIGHTHAND_332
  char 5e
  char 2d
  opencapture 12
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_356
__TERM_355:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_355
__TERM_356:
  closecapture 12 0
  commit __LEFTHAND_333
__RIGHTHAND_332:
  catch __RIGHTHAND_358
  char 5e
  opencapture 13
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_376
__TERM_375:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_375
__TERM_376:
  closecapture 13 0
  char 2d
  commit __LEFTHAND_359
__RIGHTHAND_358:
  catch __RIGHTHAND_384
  char 5e
  opencapture 14
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_402
__TERM_401:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_401
__TERM_402:
  closecapture 14 0
  commit __LEFTHAND_385
__RIGHTHAND_384:
  char 5e
  char 24
  opencapture 15
  call IDENT
  closecapture 15 0
__LEFTHAND_385:
__LEFTHAND_359:
__LEFTHAND_333:
__LEFTHAND_295:
__LEFTHAND_287:
__LEFTHAND_279:
__LEFTHAND_271:
  ret
-- Rule
MATCHER:
  call __prefix
  catch __RIGHTHAND_422
  opencapture 16
  call ANY
  closecapture 16 0
  commit __LEFTHAND_423
__RIGHTHAND_422:
  catch __RIGHTHAND_436
  opencapture 17
  call SET
  closecapture 17 0
  commit __LEFTHAND_437
__RIGHTHAND_436:
  catch __RIGHTHAND_450
  opencapture 18
  call STRING
  closecapture 18 0
  commit __LEFTHAND_451
__RIGHTHAND_450:
  catch __RIGHTHAND_464
  opencapture 19
  call BITMASK
  closecapture 19 0
  commit __LEFTHAND_465
__RIGHTHAND_464:
  catch __RIGHTHAND_478
  opencapture 20
  call HEXLITERAL
  closecapture 20 0
  commit __LEFTHAND_479
__RIGHTHAND_478:
  catch __RIGHTHAND_492
  opencapture 21
  call VARCAPTURE
  closecapture 21 0
  commit __LEFTHAND_493
__RIGHTHAND_492:
  catch __RIGHTHAND_506
  opencapture 22
  call CAPTURE
  closecapture 22 0
  commit __LEFTHAND_507
__RIGHTHAND_506:
  catch __RIGHTHAND_520
  opencapture 23
  call GROUP
  closecapture 23 0
  commit __LEFTHAND_521
__RIGHTHAND_520:
  catch __RIGHTHAND_534
  opencapture 24
  call MACRO
  closecapture 24 0
  commit __LEFTHAND_535
__RIGHTHAND_534:
  catch __RIGHTHAND_548
  opencapture 25
  call ENDFORCE
  closecapture 25 0
  commit __LEFTHAND_549
__RIGHTHAND_548:
  catch __RIGHTHAND_562
  opencapture 26
  call VARREFERENCE
  closecapture 26 0
  commit __LEFTHAND_563
__RIGHTHAND_562:
  opencapture 27
  call REFERENCE
  closecapture 27 0
__LEFTHAND_563:
__LEFTHAND_549:
__LEFTHAND_535:
__LEFTHAND_521:
__LEFTHAND_507:
__LEFTHAND_493:
__LEFTHAND_479:
__LEFTHAND_465:
__LEFTHAND_451:
__LEFTHAND_437:
__LEFTHAND_423:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__TERM_596:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_596
  char 7c
  counter 0 2
__TERM_608:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_608
  char 7c
  ret
-- Rule
VARCAPTURE:
  call __prefix
  call CBOPEN
  call COLON
  opencapture 28
  call IDENT
  closecapture 28 0
  catch __TERM_645
  opencapture 29
  call CAPTURETYPE
  closecapture 29 0
  commit __TERM_645
__TERM_645:
  call COLON
  call EXPRESSION
  opencapture 30
  call CBCLOSE
  closecapture 30 0
  call CAPTUREEND
  ret
-- Rule
CAPTURETYPE:
  call __prefix
  call SEMICOLON
  call TYPE
  ret
-- Rule
TYPE:
  call __prefix
  opencapture 31
  catch __RIGHTHAND_702
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_703
__RIGHTHAND_702:
  quad 696e7433
  char 32
__LEFTHAND_703:
  closecapture 31 0
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  opencapture 32
  call CBCLOSE
  closecapture 32 0
  call CAPTUREEND
  ret
-- Rule
GROUP:
  call __prefix
  call BOPEN
  call EXPRESSION
  opencapture 33
  call BCLOSE
  closecapture 33 0
  ret
-- Rule
CAPTUREEND:
  call __prefix
  catch __TERM_773
  catch __RIGHTHAND_776
  call REPLACE
  commit __LEFTHAND_777
__RIGHTHAND_776:
  call RECYCLE
__LEFTHAND_777:
  commit __TERM_773
__TERM_773:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 34
  catch __TERM_805
  call SETNOT
  commit __TERM_805
__TERM_805:
  closecapture 34 0
  catch __RIGHTHAND_814
  opencapture 35
  catch __RIGHTHAND_822
  char 5c
  catch __RIGHTHAND_836
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_837
__RIGHTHAND_836:
  counter 0 3
__TERM_846:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_846
__LEFTHAND_837:
  commit __LEFTHAND_823
__RIGHTHAND_822:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_823:
  closecapture 35 0
  char 2d
  opencapture 36
  catch __RIGHTHAND_868
  char 5c
  catch __RIGHTHAND_882
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_883
__RIGHTHAND_882:
  counter 0 3
__TERM_892:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_892
__LEFTHAND_883:
  commit __LEFTHAND_869
__RIGHTHAND_868:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_869:
  closecapture 36 0
  commit __LEFTHAND_815
__RIGHTHAND_814:
  opencapture 37
  catch __RIGHTHAND_908
  char 5c
  catch __RIGHTHAND_922
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_923
__RIGHTHAND_922:
  counter 0 3
__TERM_932:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_932
__LEFTHAND_923:
  commit __LEFTHAND_909
__RIGHTHAND_908:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_909:
  closecapture 37 0
__LEFTHAND_815:
  catch __TERM_812
__TERM_811:
  catch __RIGHTHAND_942
  opencapture 35
  catch __RIGHTHAND_950
  char 5c
  catch __RIGHTHAND_964
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_965
__RIGHTHAND_964:
  counter 0 3
__TERM_974:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_974
__LEFTHAND_965:
  commit __LEFTHAND_951
__RIGHTHAND_950:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_951:
  closecapture 35 0
  char 2d
  opencapture 36
  catch __RIGHTHAND_996
  char 5c
  catch __RIGHTHAND_1010
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1011
__RIGHTHAND_1010:
  counter 0 3
__TERM_1020:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1020
__LEFTHAND_1011:
  commit __LEFTHAND_997
__RIGHTHAND_996:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_997:
  closecapture 36 0
  commit __LEFTHAND_943
__RIGHTHAND_942:
  opencapture 37
  catch __RIGHTHAND_1036
  char 5c
  catch __RIGHTHAND_1050
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1051
__RIGHTHAND_1050:
  counter 0 3
__TERM_1060:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1060
__LEFTHAND_1051:
  commit __LEFTHAND_1037
__RIGHTHAND_1036:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1037:
  closecapture 37 0
__LEFTHAND_943:
  partialcommit __TERM_811
__TERM_812:
  opencapture 38
  call ABCLOSE
  closecapture 38 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1094
  opencapture 39
  call IDENT
  closecapture 39 0
  commit __LEFTHAND_1095
__RIGHTHAND_1094:
  opencapture 40
  call NUMBER
  closecapture 40 0
__LEFTHAND_1095:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1126
  call LEFTARROW
  failtwice
__TERM_1126:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 41
  call REPLACETERMS
  closecapture 41 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __TERM_1160
__TERM_1159:
  call REPLACETERM
  partialcommit __TERM_1159
__TERM_1160:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1162
  opencapture 42
  call STRINGLITERAL
  closecapture 42 0
  commit __LEFTHAND_1163
__RIGHTHAND_1162:
  catch __RIGHTHAND_1176
  opencapture 43
  call HEXLITERAL
  closecapture 43 0
  commit __LEFTHAND_1177
__RIGHTHAND_1176:
  opencapture 44
  call VARREFERENCE
  closecapture 44 0
__LEFTHAND_1177:
__LEFTHAND_1163:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 45
  call IDENT
  closecapture 45 0
  ret
-- Rule
LEFTARROW:
  call __prefix
  char 3c
  char 2d
  ret
-- Rule
RIGHTARROW:
  call __prefix
  char 2d
  char 3e
  ret
-- Rule
FATARROW:
  call __prefix
  char 3d
  char 3e
  ret
-- Rule
NOT:
  call __prefix
  char 21
  ret
-- Rule
AND:
  call __prefix
  char 26
  ret
-- Rule
MACRO:
  call __prefix
  char 25
  set 0000000000000000feffff07feffff0700000000000000000000000000000000
  catch __TERM_1266
__TERM_1265:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1265
__TERM_1266:
  ret
-- Rule
ENDFORCE:
  call __prefix
  quad 5f5f656e
  char 64
  call S
  opencapture 46
  call NUMBER
  closecapture 46 0
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 0 2
__TERM_1300:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1300
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1308
__TERM_1307:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1307
__TERM_1308:
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1319
  char 69
  commit __TERM_1319
__TERM_1319:
  ret
-- Rule
OR:
  call __prefix
  char 2f
  ret
-- Rule
ANY:
  call __prefix
  char 2e
  ret
-- Rule
NOTHING:
  call __prefix
  char 2e
  char 2e
  char 2e
  ret
-- Rule
SETNOT:
  call __prefix
  char 5e
  ret
-- Rule
FUNCDECL:
  call __prefix
  call KW_FUNCTION
  call S
  opencapture 47
  call IDENT
  closecapture 47 0
  opencapture 48
  call FUNCPARAMDECL
  closecapture 48 0
  opencapture 49
  call FUNCBODY
  closecapture 49 0
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  catch __TERM_1403
  opencapture 50
  call PARAMDECL
  closecapture 50 0
  catch __TERM_1422
__TERM_1421:
  call COMMA
  opencapture 51
  call PARAMDECL
  closecapture 51 0
  partialcommit __TERM_1421
__TERM_1422:
  commit __TERM_1403
__TERM_1403:
  call BCLOSE
  ret
-- Rule
PARAMDECL:
  call __prefix
  catch __RIGHTHAND_1448
  opencapture 52
  call IDENT
  closecapture 52 0
  opencapture 53
  call IDENT
  closecapture 53 0
  commit __LEFTHAND_1449
__RIGHTHAND_1448:
  opencapture 54
  call IDENT
  closecapture 54 0
__LEFTHAND_1449:
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  catch __TERM_1496
__TERM_1495:
  opencapture 55
  call LOWSTMT
  closecapture 55 0
  partialcommit __TERM_1495
__TERM_1496:
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1510
  opencapture 56
  call ST_IF
  closecapture 56 0
  commit __LEFTHAND_1511
__RIGHTHAND_1510:
  catch __RIGHTHAND_1524
  opencapture 57
  call ST_WHILE
  closecapture 57 0
  commit __LEFTHAND_1525
__RIGHTHAND_1524:
  catch __RIGHTHAND_1538
  opencapture 58
  call ST_RETURN
  closecapture 58 0
  commit __LEFTHAND_1539
__RIGHTHAND_1538:
  catch __RIGHTHAND_1552
  opencapture 59
  call ST_OTHER
  closecapture 59 0
  commit __LEFTHAND_1553
__RIGHTHAND_1552:
  catch __RIGHTHAND_1566
  opencapture 60
  call VARDECL
  closecapture 60 0
  commit __LEFTHAND_1567
__RIGHTHAND_1566:
  catch __RIGHTHAND_1580
  opencapture 61
  call ASSIGNMENT
  closecapture 61 0
  commit __LEFTHAND_1581
__RIGHTHAND_1580:
  catch __TERM_1597
  opencapture 62
  call SCR_EXPRESSION
  closecapture 62 0
  commit __TERM_1597
__TERM_1597:
  call SEMICOLON
__LEFTHAND_1581:
__LEFTHAND_1567:
__LEFTHAND_1553:
__LEFTHAND_1539:
__LEFTHAND_1525:
__LEFTHAND_1511:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 63
  call SCR_EXPRESSION
  closecapture 63 0
  call BCLOSE
  call CBOPEN
  opencapture 64
  catch __TERM_1658
__TERM_1657:
  call LOWSTMT
  partialcommit __TERM_1657
__TERM_1658:
  closecapture 64 0
  call CBCLOSE
  opencapture 65
  catch __TERM_1676
__TERM_1675:
  call IF_ELSEIF
  partialcommit __TERM_1675
__TERM_1676:
  closecapture 65 0
  opencapture 66
  catch __TERM_1687
  call IF_ELSE
  commit __TERM_1687
__TERM_1687:
  closecapture 66 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 67
  call SCR_EXPRESSION
  closecapture 67 0
  call BCLOSE
  call CBOPEN
  opencapture 68
  catch __TERM_1736
__TERM_1735:
  call LOWSTMT
  partialcommit __TERM_1735
__TERM_1736:
  closecapture 68 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 69
  catch __TERM_1766
__TERM_1765:
  call LOWSTMT
  partialcommit __TERM_1765
__TERM_1766:
  closecapture 69 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 70
  call SCR_EXPRESSION
  closecapture 70 0
  call BCLOSE
  call CBOPEN
  opencapture 71
  catch __TERM_1820
__TERM_1819:
  call LOWSTMT
  partialcommit __TERM_1819
__TERM_1820:
  closecapture 71 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 72
  catch __TERM_1843
  call SCR_EXPRESSION
  commit __TERM_1843
__TERM_1843:
  closecapture 72 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1858
  call KW_BREAK
  commit __LEFTHAND_1859
__RIGHTHAND_1858:
  call KW_CONTINUE
__LEFTHAND_1859:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1899
  call ASSIGN
  opencapture 73
  call SCR_EXPRESSION
  closecapture 73 0
  commit __TERM_1899
__TERM_1899:
  call SEMICOLON
  ret
-- Rule
ASSIGNMENT:
  call __prefix
  call IDENT
  call ASSIGNS
  call SCR_EXPRESSION
  call SEMICOLON
  ret
-- Rule
ASSIGNS:
  call __prefix
  opencapture 74
  catch __RIGHTHAND_1956
  call ASSIGN
  commit __LEFTHAND_1957
__RIGHTHAND_1956:
  catch __RIGHTHAND_1964
  call PLUSIS
  commit __LEFTHAND_1965
__RIGHTHAND_1964:
  catch __RIGHTHAND_1972
  call MINIS
  commit __LEFTHAND_1973
__RIGHTHAND_1972:
  catch __RIGHTHAND_1980
  call MULIS
  commit __LEFTHAND_1981
__RIGHTHAND_1980:
  catch __RIGHTHAND_1988
  call DIVIS
  commit __LEFTHAND_1989
__RIGHTHAND_1988:
  catch __RIGHTHAND_1996
  call BITANDIS
  commit __LEFTHAND_1997
__RIGHTHAND_1996:
  catch __RIGHTHAND_2004
  call BITORIS
  commit __LEFTHAND_2005
__RIGHTHAND_2004:
  catch __RIGHTHAND_2012
  call BITXORIS
  commit __LEFTHAND_2013
__RIGHTHAND_2012:
  catch __RIGHTHAND_2020
  call BITNOTIS
  commit __LEFTHAND_2021
__RIGHTHAND_2020:
  catch __RIGHTHAND_2028
  call LSHIFTIS
  commit __LEFTHAND_2029
__RIGHTHAND_2028:
  call RSHIFTIS
__LEFTHAND_2029:
__LEFTHAND_2021:
__LEFTHAND_2013:
__LEFTHAND_2005:
__LEFTHAND_1997:
__LEFTHAND_1989:
__LEFTHAND_1981:
__LEFTHAND_1973:
__LEFTHAND_1965:
__LEFTHAND_1957:
  closecapture 74 0
  ret
-- Rule
SCR_EXPRESSION:
  call __prefix
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  catch __RIGHTHAND_2054
  call BINOP_P11
  commit __LEFTHAND_2055
__RIGHTHAND_2054:
  call SCR_TERM
__LEFTHAND_2055:
  catch __TERM_2072
__TERM_2071:
  opencapture 75
  call LOGOR
  catch __RIGHTHAND_2092
  call BINOP_P11
  commit __LEFTHAND_2093
__RIGHTHAND_2092:
  call SCR_TERM
__LEFTHAND_2093:
  closecapture 75 0
  partialcommit __TERM_2071
__TERM_2072:
  ret
-- Rule
BINOP_P11:
  call __prefix
  catch __RIGHTHAND_2112
  call BINOP_P10
  commit __LEFTHAND_2113
__RIGHTHAND_2112:
  call SCR_TERM
__LEFTHAND_2113:
  catch __TERM_2130
__TERM_2129:
  opencapture 76
  call LOGAND
  catch __RIGHTHAND_2150
  call BINOP_P10
  commit __LEFTHAND_2151
__RIGHTHAND_2150:
  call SCR_TERM
__LEFTHAND_2151:
  closecapture 76 0
  partialcommit __TERM_2129
__TERM_2130:
  ret
-- Rule
BINOP_P10:
  call __prefix
  catch __RIGHTHAND_2170
  call BINOP_P09
  commit __LEFTHAND_2171
__RIGHTHAND_2170:
  call SCR_TERM
__LEFTHAND_2171:
  catch __TERM_2188
__TERM_2187:
  opencapture 77
  call BITOR
  catch __RIGHTHAND_2208
  call BINOP_P09
  commit __LEFTHAND_2209
__RIGHTHAND_2208:
  call SCR_TERM
__LEFTHAND_2209:
  closecapture 77 0
  partialcommit __TERM_2187
__TERM_2188:
  ret
-- Rule
BINOP_P09:
  call __prefix
  catch __RIGHTHAND_2228
  call BINOP_P08
  commit __LEFTHAND_2229
__RIGHTHAND_2228:
  call SCR_TERM
__LEFTHAND_2229:
  catch __TERM_2246
__TERM_2245:
  opencapture 78
  call BITXOR
  catch __RIGHTHAND_2266
  call BINOP_P08
  commit __LEFTHAND_2267
__RIGHTHAND_2266:
  call SCR_TERM
__LEFTHAND_2267:
  closecapture 78 0
  partialcommit __TERM_2245
__TERM_2246:
  ret
-- Rule
BINOP_P08:
  call __prefix
  catch __RIGHTHAND_2286
  call BINOP_P07
  commit __LEFTHAND_2287
__RIGHTHAND_2286:
  call SCR_TERM
__LEFTHAND_2287:
  catch __TERM_2304
__TERM_2303:
  opencapture 79
  call BITAND
  catch __RIGHTHAND_2324
  call BINOP_P07
  commit __LEFTHAND_2325
__RIGHTHAND_2324:
  call SCR_TERM
__LEFTHAND_2325:
  closecapture 79 0
  partialcommit __TERM_2303
__TERM_2304:
  ret
-- Rule
BINOP_P07:
  call __prefix
  catch __RIGHTHAND_2344
  call BINOP_P06
  commit __LEFTHAND_2345
__RIGHTHAND_2344:
  call SCR_TERM
__LEFTHAND_2345:
  catch __TERM_2362
__TERM_2361:
  opencapture 80
  catch __RIGHTHAND_2370
  call EQUALS
  commit __LEFTHAND_2371
__RIGHTHAND_2370:
  call NEQUALS
__LEFTHAND_2371:
  catch __RIGHTHAND_2390
  call BINOP_P06
  commit __LEFTHAND_2391
__RIGHTHAND_2390:
  call SCR_TERM
__LEFTHAND_2391:
  closecapture 80 0
  partialcommit __TERM_2361
__TERM_2362:
  ret
-- Rule
BINOP_P06:
  call __prefix
  catch __RIGHTHAND_2410
  call BINOP_P05
  commit __LEFTHAND_2411
__RIGHTHAND_2410:
  call SCR_TERM
__LEFTHAND_2411:
  catch __TERM_2428
__TERM_2427:
  opencapture 81
  catch __RIGHTHAND_2436
  call LTEQ
  commit __LEFTHAND_2437
__RIGHTHAND_2436:
  catch __RIGHTHAND_2444
  call LT
  commit __LEFTHAND_2445
__RIGHTHAND_2444:
  catch __RIGHTHAND_2452
  call GTEQ
  commit __LEFTHAND_2453
__RIGHTHAND_2452:
  call GT
__LEFTHAND_2453:
__LEFTHAND_2445:
__LEFTHAND_2437:
  catch __RIGHTHAND_2472
  call BINOP_P05
  commit __LEFTHAND_2473
__RIGHTHAND_2472:
  call SCR_TERM
__LEFTHAND_2473:
  closecapture 81 0
  partialcommit __TERM_2427
__TERM_2428:
  ret
-- Rule
BINOP_P05:
  call __prefix
  catch __RIGHTHAND_2492
  call BINOP_P04
  commit __LEFTHAND_2493
__RIGHTHAND_2492:
  call SCR_TERM
__LEFTHAND_2493:
  catch __TERM_2510
__TERM_2509:
  opencapture 82
  catch __RIGHTHAND_2518
  call LSHIFT
  commit __LEFTHAND_2519
__RIGHTHAND_2518:
  call RSHIFT
__LEFTHAND_2519:
  catch __RIGHTHAND_2538
  call BINOP_P04
  commit __LEFTHAND_2539
__RIGHTHAND_2538:
  call SCR_TERM
__LEFTHAND_2539:
  closecapture 82 0
  partialcommit __TERM_2509
__TERM_2510:
  ret
-- Rule
BINOP_P04:
  call __prefix
  catch __RIGHTHAND_2558
  call BINOP_P03
  commit __LEFTHAND_2559
__RIGHTHAND_2558:
  call SCR_TERM
__LEFTHAND_2559:
  catch __TERM_2576
__TERM_2575:
  opencapture 83
  catch __RIGHTHAND_2584
  call ADD
  commit __LEFTHAND_2585
__RIGHTHAND_2584:
  call SUB
__LEFTHAND_2585:
  catch __RIGHTHAND_2604
  call BINOP_P03
  commit __LEFTHAND_2605
__RIGHTHAND_2604:
  call SCR_TERM
__LEFTHAND_2605:
  closecapture 83 0
  partialcommit __TERM_2575
__TERM_2576:
  ret
-- Rule
BINOP_P03:
  call __prefix
  call SCR_TERM
  catch __TERM_2634
__TERM_2633:
  opencapture 84
  catch __RIGHTHAND_2642
  call MUL
  commit __LEFTHAND_2643
__RIGHTHAND_2642:
  catch __RIGHTHAND_2650
  call DIV
  commit __LEFTHAND_2651
__RIGHTHAND_2650:
  call POW
__LEFTHAND_2651:
__LEFTHAND_2643:
  call SCR_TERM
  closecapture 84 0
  partialcommit __TERM_2633
__TERM_2634:
  ret
-- Rule
UNOP:
  call __prefix
  opencapture 85
  catch __RIGHTHAND_2682
  call LOGNOT
  commit __LEFTHAND_2683
__RIGHTHAND_2682:
  catch __RIGHTHAND_2690
  call BITNOT
  commit __LEFTHAND_2691
__RIGHTHAND_2690:
  catch __RIGHTHAND_2698
  call INC
  commit __LEFTHAND_2699
__RIGHTHAND_2698:
  call DEC
__LEFTHAND_2699:
__LEFTHAND_2691:
__LEFTHAND_2683:
  closecapture 85 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2712
  opencapture 86
  call FUNCTIONCALL
  closecapture 86 0
  commit __LEFTHAND_2713
__RIGHTHAND_2712:
  catch __RIGHTHAND_2726
  opencapture 87
  call BOPEN
  opencapture 88
  call SCR_EXPRESSION
  closecapture 88 0
  call BCLOSE
  closecapture 87 0
  commit __LEFTHAND_2727
__RIGHTHAND_2726:
  catch __RIGHTHAND_2758
  opencapture 89
  call LITERAL
  closecapture 89 0
  commit __LEFTHAND_2759
__RIGHTHAND_2758:
  catch __TERM_2776
__TERM_2775:
  opencapture 90
  call UNOP
  closecapture 90 0
  partialcommit __TERM_2775
__TERM_2776:
  opencapture 91
  call SCR_REFERENCE
  closecapture 91 0
__LEFTHAND_2759:
__LEFTHAND_2727:
__LEFTHAND_2713:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 92
  call SCR_REFERENCE
  closecapture 92 0
  call BOPEN
  catch __TERM_2817
  opencapture 93
  call SCR_EXPRESSION
  closecapture 93 0
  catch __TERM_2836
__TERM_2835:
  call COMMA
  opencapture 94
  call SCR_EXPRESSION
  closecapture 94 0
  partialcommit __TERM_2835
__TERM_2836:
  commit __TERM_2817
__TERM_2817:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  opencapture 95
  call IDENT
  closecapture 95 0
  catch __TERM_2878
__TERM_2877:
  call INDEX
  partialcommit __TERM_2877
__TERM_2878:
  catch __TERM_2884
__TERM_2883:
  call DOT
  call SCR_REFERENCE
  partialcommit __TERM_2883
__TERM_2884:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 96
  call SCR_EXPRESSION
  closecapture 96 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_2922
  call STRINGLITERAL
  commit __LEFTHAND_2923
__RIGHTHAND_2922:
  catch __RIGHTHAND_2930
  call HASHLITERAL
  commit __LEFTHAND_2931
__RIGHTHAND_2930:
  catch __RIGHTHAND_2938
  call LISTLITERAL
  commit __LEFTHAND_2939
__RIGHTHAND_2938:
  catch __RIGHTHAND_2946
  call FLOATLITERAL
  commit __LEFTHAND_2947
__RIGHTHAND_2946:
  catch __RIGHTHAND_2954
  call INTLITERAL
  commit __LEFTHAND_2955
__RIGHTHAND_2954:
  call BOOLEANLITERAL
__LEFTHAND_2955:
__LEFTHAND_2947:
__LEFTHAND_2939:
__LEFTHAND_2931:
__LEFTHAND_2923:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 97
  catch __TERM_2984
__TERM_2983:
  catch __RIGHTHAND_2986
  char 5c
  catch __RIGHTHAND_3000
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_3001
__RIGHTHAND_3000:
  counter 0 3
__TERM_3010:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_3010
__LEFTHAND_3001:
  commit __LEFTHAND_2987
__RIGHTHAND_2986:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_2987:
  partialcommit __TERM_2983
__TERM_2984:
  closecapture 97 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 98
  call CBOPEN
  catch __TERM_3041
  call HASHELT
  catch __TERM_3054
__TERM_3053:
  call COMMA
  call HASHELT
  partialcommit __TERM_3053
__TERM_3054:
  commit __TERM_3041
__TERM_3041:
  call CBCLOSE
  closecapture 98 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 99
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 99 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 100
  call SCR_TERM
  closecapture 100 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 101
  call SCR_TERM
  closecapture 101 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 102
  call ABOPEN
  catch __TERM_3137
  call LISTELT
  catch __TERM_3150
__TERM_3149:
  call COMMA
  call LISTELT
  partialcommit __TERM_3149
__TERM_3150:
  commit __TERM_3137
__TERM_3137:
  call ABCLOSE
  closecapture 102 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 103
  call SCR_TERM
  closecapture 103 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 104
  catch __TERM_3192
__TERM_3191:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3191
__TERM_3192:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3204
__TERM_3203:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3203
__TERM_3204:
  closecapture 104 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 105
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3216
__TERM_3215:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3215
__TERM_3216:
  closecapture 105 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 106
  catch __RIGHTHAND_3224
  quad 74727565
  commit __LEFTHAND_3225
__RIGHTHAND_3224:
  quad 66616c73
  char 65
__LEFTHAND_3225:
  closecapture 106 0
  ret
-- Rule
KW_FUNCTION:
  call __prefix
  quad 66756e63
  quad 74696f6e
  ret
-- Rule
KW_VAR:
  call __prefix
  char 76
  char 61
  char 72
  ret
-- Rule
KW_WHILE:
  call __prefix
  quad 7768696c
  char 65
  ret
-- Rule
KW_RETURN:
  call __prefix
  quad 72657475
  char 72
  char 6e
  ret
-- Rule
KW_IF:
  call __prefix
  char 69
  char 66
  ret
-- Rule
KW_ELSEIF:
  call __prefix
  quad 656c7365
  char 69
  char 66
  ret
-- Rule
KW_ELSE:
  call __prefix
  quad 656c7365
  ret
-- Rule
KW_BREAK:
  call __prefix
  quad 62726561
  char 6b
  ret
-- Rule
KW_CONTINUE:
  call __prefix
  quad 636f6e74
  quad 696e7565
  ret
-- Rule
IDENT:
  call __prefix
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_3301
  counter 0 63
__TERM_3302:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_3303
__TERM_3303:
  condjump 0 __TERM_3302
  commit __TERM_3301
__TERM_3301:
  ret
-- Rule
BOPEN:
  call __prefix
  char 28
  ret
-- Rule
BCLOSE:
  call __prefix
  char 29
  ret
-- Rule
CBOPEN:
  call __prefix
  char 7b
  ret
-- Rule
CBCLOSE:
  call __prefix
  char 7d
  ret
-- Rule
ABOPEN:
  call __prefix
  char 5b
  ret
-- Rule
ABCLOSE:
  call __prefix
  char 5d
  ret
-- Rule
ASSIGN:
  call __prefix
  opencapture 107
  char 3d
  closecapture 107 0
  ret
-- Rule
PLUSIS:
  call __prefix
  opencapture 108
  char 2b
  char 3d
  closecapture 108 0
  ret
-- Rule
MINIS:
  call __prefix
  opencapture 109
  char 2d
  char 3d
  closecapture 109 0
  ret
-- Rule
MULIS:
  call __prefix
  opencapture 110
  char 2a
  char 3d
  closecapture 110 0
  ret
-- Rule
DIVIS:
  call __prefix
  opencapture 111
  char 2f
  char 3d
  closecapture 111 0
  ret
-- Rule
EQUALS:
  call __prefix
  opencapture 112
  char 3d
  char 3d
  closecapture 112 0
  ret
-- Rule
NEQUALS:
  call __prefix
  opencapture 113
  char 21
  char 3d
  closecapture 113 0
  ret
-- Rule
LT:
  call __prefix
  opencapture 114
  char 3c
  closecapture 114 0
  catch __TERM_3436
  char 3d
  failtwice
__TERM_3436:
  ret
-- Rule
GT:
  call __prefix
  opencapture 115
  char 3e
  closecapture 115 0
  catch __TERM_3454
  char 3d
  failtwice
__TERM_3454:
  ret
-- Rule
LTEQ:
  call __prefix
  opencapture 116
  char 3c
  char 3d
  closecapture 116 0
  ret
-- Rule
GTEQ:
  call __prefix
  opencapture 117
  char 3e
  char 3d
  closecapture 117 0
  ret
-- Rule
SEMICOLON:
  call __prefix
  char 3b
  ret
-- Rule
COLON:
  call __prefix
  opencapture 118
  char 3a
  closecapture 118 0
  ret
-- Rule
POW:
  call __prefix
  opencapture 119
  char 2a
  char 2a
  closecapture 119 0
  ret
-- Rule
MUL:
  call __prefix
  opencapture 120
  char 2a
  closecapture 120 0
  catch __TERM_3526
  char 2a
  failtwice
__TERM_3526:
  ret
-- Rule
DIV:
  call __prefix
  opencapture 121
  char 2f
  closecapture 121 0
  catch __TERM_3544
  char 3d
  failtwice
__TERM_3544:
  ret
-- Rule
ADD:
  call __prefix
  opencapture 122
  char 2b
  closecapture 122 0
  catch __TERM_3562
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3562:
  ret
-- Rule
SUB:
  call __prefix
  opencapture 123
  char 2d
  closecapture 123 0
  catch __TERM_3580
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3580:
  ret
-- Rule
INC:
  call __prefix
  opencapture 124
  char 2b
  char 2b
  closecapture 124 0
  ret
-- Rule
DEC:
  call __prefix
  opencapture 125
  char 2d
  char 2d
  closecapture 125 0
  ret
-- Rule
LOGAND:
  call __prefix
  opencapture 126
  char 26
  char 26
  closecapture 126 0
  ret
-- Rule
LOGOR:
  call __prefix
  opencapture 127
  char 7c
  char 7c
  closecapture 127 0
  ret
-- Rule
LOGNOT:
  call __prefix
  opencapture 128
  char 21
  closecapture 128 0
  catch __TERM_3646
  char 3d
  failtwice
__TERM_3646:
  ret
-- Rule
BITAND:
  call __prefix
  opencapture 129
  char 26
  closecapture 129 0
  catch __TERM_3664
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3664:
  ret
-- Rule
BITOR:
  call __prefix
  opencapture 130
  char 7c
  closecapture 130 0
  catch __TERM_3682
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3682:
  ret
-- Rule
BITXOR:
  call __prefix
  opencapture 131
  char 5e
  closecapture 131 0
  catch __TERM_3700
  char 3d
  failtwice
__TERM_3700:
  ret
-- Rule
BITNOT:
  call __prefix
  opencapture 132
  char 7e
  closecapture 132 0
  ret
-- Rule
BITANDIS:
  call __prefix
  opencapture 133
  char 26
  char 3d
  closecapture 133 0
  ret
-- Rule
BITORIS:
  call __prefix
  opencapture 134
  char 7c
  char 3d
  closecapture 134 0
  ret
-- Rule
BITXORIS:
  call __prefix
  opencapture 135
  char 5e
  char 3d
  closecapture 135 0
  ret
-- Rule
BITNOTIS:
  call __prefix
  opencapture 136
  char 7e
  char 3d
  closecapture 136 0
  ret
-- Rule
COMMA:
  call __prefix
  char 2c
  ret
-- Rule
DOT:
  call __prefix
  opencapture 137
  char 2e
  closecapture 137 0
  ret
-- Rule
LSHIFT:
  call __prefix
  opencapture 138
  char 3c
  char 3c
  closecapture 138 0
  catch __TERM_3796
  char 3d
  failtwice
__TERM_3796:
  ret
-- Rule
RSHIFT:
  call __prefix
  opencapture 139
  char 3e
  char 3e
  closecapture 139 0
  catch __TERM_3814
  char 3d
  failtwice
__TERM_3814:
  ret
-- Rule
LSHIFTIS:
  call __prefix
  opencapture 140
  char 3c
  char 3c
  char 3d
  closecapture 140 0
  ret
-- Rule
RSHIFTIS:
  call __prefix
  opencapture 141
  char 3e
  char 3e
  char 3d
  closecapture 141 0
  ret

  end 0

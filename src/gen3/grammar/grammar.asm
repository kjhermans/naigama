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
MULTILINECOMMENT:
  quad 2d2d5b5b
  catch __TERM_42
__TERM_41:
  catch __TERM_44
  char 5d
  char 5d
  failtwice
__TERM_44:
  any
  partialcommit __TERM_41
__TERM_42:
  char 5d
  char 5d
  ret
-- Rule
COMMENT:
  char 2d
  char 2d
  catch __TERM_72
__TERM_71:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_71
__TERM_72:
  char 0a
  ret
-- Rule
__prefix:
  catch __TERM_84
__TERM_83:
  catch __RIGHTHAND_86
  call MULTILINECOMMENT
  commit __LEFTHAND_87
__RIGHTHAND_86:
  catch __RIGHTHAND_94
  call COMMENT
  commit __LEFTHAND_95
__RIGHTHAND_94:
  call S
__LEFTHAND_95:
__LEFTHAND_87:
  partialcommit __TERM_83
__TERM_84:
  ret
-- Rule
END:
  call __prefix
  catch __TERM_108
  any
  failtwice
__TERM_108:
  ret
-- Rule
DEFINITION:
  call __prefix
  catch __RIGHTHAND_114
  opencapture 0
  call FUNCDECL
  closecapture 0 0
  commit __LEFTHAND_115
__RIGHTHAND_114:
  opencapture 1
  call RULE
  closecapture 1 0
__LEFTHAND_115:
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
  ret
-- Rule
EXPRESSION:
  call __prefix
  catch __RIGHTHAND_170
  opencapture 3
  call TERMS
  closecapture 3 0
  call OR
  call NOTHING
  commit __LEFTHAND_171
__RIGHTHAND_170:
  catch __RIGHTHAND_196
  opencapture 4
  call TERMS
  closecapture 4 0
  call OR
  call EXPRESSION
  commit __LEFTHAND_197
__RIGHTHAND_196:
  opencapture 5
  call TERMS
  closecapture 5 0
__LEFTHAND_197:
__LEFTHAND_171:
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 6
  call TERM
  closecapture 6 0
  catch __TERM_238
__TERM_237:
  opencapture 6
  call TERM
  closecapture 6 0
  partialcommit __TERM_237
__TERM_238:
  ret
-- Rule
TERM:
  call __prefix
  catch __RIGHTHAND_252
  opencapture 7
  call SCANMATCHER
  closecapture 7 0
  commit __LEFTHAND_253
__RIGHTHAND_252:
  opencapture 8
  call QUANTIFIEDMATCHER
  closecapture 8 0
__LEFTHAND_253:
  ret
-- Rule
SCANMATCHER:
  call __prefix
  catch __RIGHTHAND_284
  opencapture 9
  call NOT
  closecapture 9 0
  commit __LEFTHAND_285
__RIGHTHAND_284:
  opencapture 10
  call AND
  closecapture 10 0
__LEFTHAND_285:
  call MATCHER
  ret
-- Rule
QUANTIFIEDMATCHER:
  call __prefix
  call MATCHER
  catch __TERM_325
  opencapture 11
  call QUANTIFIER
  closecapture 11 0
  commit __TERM_325
__TERM_325:
  ret
-- Rule
QUANTIFIER:
  call __prefix
  catch __RIGHTHAND_334
  opencapture 12
  char 3f
  closecapture 12 0
  commit __LEFTHAND_335
__RIGHTHAND_334:
  catch __RIGHTHAND_348
  opencapture 13
  char 2b
  closecapture 13 0
  commit __LEFTHAND_349
__RIGHTHAND_348:
  catch __RIGHTHAND_362
  opencapture 14
  char 2a
  closecapture 14 0
  commit __LEFTHAND_363
__RIGHTHAND_362:
  catch __RIGHTHAND_376
  char 5e
  opencapture 15
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_394
__TERM_393:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_393
__TERM_394:
  closecapture 15 0
  char 2d
  opencapture 16
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_412
__TERM_411:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_411
__TERM_412:
  closecapture 16 0
  commit __LEFTHAND_377
__RIGHTHAND_376:
  catch __RIGHTHAND_414
  char 5e
  char 2d
  opencapture 17
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_438
__TERM_437:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_437
__TERM_438:
  closecapture 17 0
  commit __LEFTHAND_415
__RIGHTHAND_414:
  catch __RIGHTHAND_440
  char 5e
  opencapture 18
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_458
__TERM_457:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_457
__TERM_458:
  closecapture 18 0
  char 2d
  commit __LEFTHAND_441
__RIGHTHAND_440:
  catch __RIGHTHAND_466
  char 5e
  opencapture 19
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_484
__TERM_483:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_483
__TERM_484:
  closecapture 19 0
  commit __LEFTHAND_467
__RIGHTHAND_466:
  char 5e
  char 24
  opencapture 20
  call IDENT
  closecapture 20 0
__LEFTHAND_467:
__LEFTHAND_441:
__LEFTHAND_415:
__LEFTHAND_377:
__LEFTHAND_363:
__LEFTHAND_349:
__LEFTHAND_335:
  ret
-- Rule
MATCHER:
  call __prefix
  catch __RIGHTHAND_504
  opencapture 21
  call ANY
  closecapture 21 0
  commit __LEFTHAND_505
__RIGHTHAND_504:
  catch __RIGHTHAND_518
  opencapture 22
  call SET
  closecapture 22 0
  commit __LEFTHAND_519
__RIGHTHAND_518:
  catch __RIGHTHAND_532
  opencapture 23
  call STRING
  closecapture 23 0
  commit __LEFTHAND_533
__RIGHTHAND_532:
  catch __RIGHTHAND_546
  opencapture 24
  call BITMASK
  closecapture 24 0
  commit __LEFTHAND_547
__RIGHTHAND_546:
  catch __RIGHTHAND_560
  opencapture 25
  call HEXLITERAL
  closecapture 25 0
  commit __LEFTHAND_561
__RIGHTHAND_560:
  catch __RIGHTHAND_574
  opencapture 26
  call VARCAPTURE
  closecapture 26 0
  commit __LEFTHAND_575
__RIGHTHAND_574:
  catch __RIGHTHAND_588
  opencapture 27
  call CAPTURE
  closecapture 27 0
  commit __LEFTHAND_589
__RIGHTHAND_588:
  catch __RIGHTHAND_602
  opencapture 28
  call GROUP
  closecapture 28 0
  commit __LEFTHAND_603
__RIGHTHAND_602:
  catch __RIGHTHAND_616
  opencapture 29
  call MACRO
  closecapture 29 0
  commit __LEFTHAND_617
__RIGHTHAND_616:
  catch __RIGHTHAND_630
  opencapture 30
  call ENDFORCE
  closecapture 30 0
  commit __LEFTHAND_631
__RIGHTHAND_630:
  catch __RIGHTHAND_644
  opencapture 31
  call VARREFERENCE
  closecapture 31 0
  commit __LEFTHAND_645
__RIGHTHAND_644:
  opencapture 32
  call REFERENCE
  closecapture 32 0
__LEFTHAND_645:
__LEFTHAND_631:
__LEFTHAND_617:
__LEFTHAND_603:
__LEFTHAND_589:
__LEFTHAND_575:
__LEFTHAND_561:
__LEFTHAND_547:
__LEFTHAND_533:
__LEFTHAND_519:
__LEFTHAND_505:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__TERM_678:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_678
  char 7c
  counter 0 2
__TERM_690:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_690
  char 7c
  ret
-- Rule
VARCAPTURE:
  call __prefix
  call CBOPEN
  call COLON
  opencapture 33
  call IDENT
  closecapture 33 0
  catch __TERM_727
  opencapture 34
  call CAPTURETYPE
  closecapture 34 0
  commit __TERM_727
__TERM_727:
  call COLON
  call EXPRESSION
  opencapture 35
  call CBCLOSE
  closecapture 35 0
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
  opencapture 36
  catch __RIGHTHAND_784
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_785
__RIGHTHAND_784:
  quad 696e7433
  char 32
__LEFTHAND_785:
  closecapture 36 0
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  call CBCLOSE
  call CAPTUREEND
  ret
-- Rule
GROUP:
  call __prefix
  call BOPEN
  call EXPRESSION
  call BCLOSE
  ret
-- Rule
CAPTUREEND:
  call __prefix
  catch __TERM_843
  opencapture 37
  catch __RIGHTHAND_846
  call REPLACE
  commit __LEFTHAND_847
__RIGHTHAND_846:
  call RECYCLE
__LEFTHAND_847:
  closecapture 37 0
  commit __TERM_843
__TERM_843:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 38
  catch __TERM_875
  call SETNOT
  commit __TERM_875
__TERM_875:
  closecapture 38 0
  catch __RIGHTHAND_884
  opencapture 39
  catch __RIGHTHAND_892
  char 5c
  catch __RIGHTHAND_906
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_907
__RIGHTHAND_906:
  counter 0 3
__TERM_916:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_916
__LEFTHAND_907:
  commit __LEFTHAND_893
__RIGHTHAND_892:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_893:
  closecapture 39 0
  char 2d
  opencapture 40
  catch __RIGHTHAND_938
  char 5c
  catch __RIGHTHAND_952
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_953
__RIGHTHAND_952:
  counter 0 3
__TERM_962:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_962
__LEFTHAND_953:
  commit __LEFTHAND_939
__RIGHTHAND_938:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_939:
  closecapture 40 0
  commit __LEFTHAND_885
__RIGHTHAND_884:
  opencapture 41
  catch __RIGHTHAND_978
  char 5c
  catch __RIGHTHAND_992
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_993
__RIGHTHAND_992:
  counter 0 3
__TERM_1002:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1002
__LEFTHAND_993:
  commit __LEFTHAND_979
__RIGHTHAND_978:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_979:
  closecapture 41 0
__LEFTHAND_885:
  catch __TERM_882
__TERM_881:
  catch __RIGHTHAND_1012
  opencapture 39
  catch __RIGHTHAND_1020
  char 5c
  catch __RIGHTHAND_1034
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1035
__RIGHTHAND_1034:
  counter 0 3
__TERM_1044:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1044
__LEFTHAND_1035:
  commit __LEFTHAND_1021
__RIGHTHAND_1020:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1021:
  closecapture 39 0
  char 2d
  opencapture 40
  catch __RIGHTHAND_1066
  char 5c
  catch __RIGHTHAND_1080
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1081
__RIGHTHAND_1080:
  counter 0 3
__TERM_1090:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1090
__LEFTHAND_1081:
  commit __LEFTHAND_1067
__RIGHTHAND_1066:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1067:
  closecapture 40 0
  commit __LEFTHAND_1013
__RIGHTHAND_1012:
  opencapture 41
  catch __RIGHTHAND_1106
  char 5c
  catch __RIGHTHAND_1120
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1121
__RIGHTHAND_1120:
  counter 0 3
__TERM_1130:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1130
__LEFTHAND_1121:
  commit __LEFTHAND_1107
__RIGHTHAND_1106:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1107:
  closecapture 41 0
__LEFTHAND_1013:
  partialcommit __TERM_881
__TERM_882:
  call ABCLOSE
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1158
  opencapture 42
  call IDENT
  closecapture 42 0
  commit __LEFTHAND_1159
__RIGHTHAND_1158:
  opencapture 43
  call NUMBER
  closecapture 43 0
__LEFTHAND_1159:
  ret
-- Rule
REFERENCE:
  call __prefix
  catch __TERM_1184
  call KW_FUNCTION
  failtwice
__TERM_1184:
  opencapture 44
  call IDENT
  closecapture 44 0
  catch __TERM_1202
  call LEFTARROW
  failtwice
__TERM_1202:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 45
  call REPLACETERMS
  closecapture 45 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __TERM_1230
__TERM_1229:
  call REPLACETERM
  partialcommit __TERM_1229
__TERM_1230:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1232
  opencapture 46
  call STRINGLITERAL
  closecapture 46 0
  commit __LEFTHAND_1233
__RIGHTHAND_1232:
  catch __RIGHTHAND_1246
  opencapture 47
  call HEXLITERAL
  closecapture 47 0
  commit __LEFTHAND_1247
__RIGHTHAND_1246:
  opencapture 48
  call VARREFERENCE
  closecapture 48 0
__LEFTHAND_1247:
__LEFTHAND_1233:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 49
  call IDENT
  closecapture 49 0
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
  catch __TERM_1336
__TERM_1335:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1335
__TERM_1336:
  ret
-- Rule
ENDFORCE:
  call __prefix
  quad 5f5f656e
  char 64
  call S
  opencapture 50
  call NUMBER
  closecapture 50 0
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 0 2
__TERM_1370:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1370
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1378
__TERM_1377:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1377
__TERM_1378:
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1389
  char 69
  commit __TERM_1389
__TERM_1389:
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
  opencapture 51
  call IDENT
  closecapture 51 0
  opencapture 52
  call FUNCPARAMDECL
  closecapture 52 0
  opencapture 53
  call FUNCBODY
  closecapture 53 0
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  catch __TERM_1473
  opencapture 54
  call PARAMDECL
  closecapture 54 0
  catch __TERM_1492
__TERM_1491:
  call COMMA
  opencapture 55
  call PARAMDECL
  closecapture 55 0
  partialcommit __TERM_1491
__TERM_1492:
  commit __TERM_1473
__TERM_1473:
  call BCLOSE
  ret
-- Rule
PARAMDECL:
  call __prefix
  catch __RIGHTHAND_1518
  opencapture 56
  call IDENT
  closecapture 56 0
  opencapture 57
  call IDENT
  closecapture 57 0
  commit __LEFTHAND_1519
__RIGHTHAND_1518:
  opencapture 58
  call IDENT
  closecapture 58 0
__LEFTHAND_1519:
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  catch __TERM_1566
__TERM_1565:
  opencapture 59
  call LOWSTMT
  closecapture 59 0
  partialcommit __TERM_1565
__TERM_1566:
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1580
  opencapture 60
  call ST_IF
  closecapture 60 0
  commit __LEFTHAND_1581
__RIGHTHAND_1580:
  catch __RIGHTHAND_1594
  opencapture 61
  call ST_WHILE
  closecapture 61 0
  commit __LEFTHAND_1595
__RIGHTHAND_1594:
  catch __RIGHTHAND_1608
  opencapture 62
  call ST_RETURN
  closecapture 62 0
  commit __LEFTHAND_1609
__RIGHTHAND_1608:
  catch __RIGHTHAND_1622
  opencapture 63
  call ST_OTHER
  closecapture 63 0
  commit __LEFTHAND_1623
__RIGHTHAND_1622:
  catch __RIGHTHAND_1636
  opencapture 64
  call VARDECL
  closecapture 64 0
  commit __LEFTHAND_1637
__RIGHTHAND_1636:
  catch __RIGHTHAND_1650
  opencapture 65
  call ASSIGNMENT
  closecapture 65 0
  commit __LEFTHAND_1651
__RIGHTHAND_1650:
  catch __TERM_1667
  opencapture 66
  call SCR_EXPRESSION
  closecapture 66 0
  commit __TERM_1667
__TERM_1667:
  call SEMICOLON
__LEFTHAND_1651:
__LEFTHAND_1637:
__LEFTHAND_1623:
__LEFTHAND_1609:
__LEFTHAND_1595:
__LEFTHAND_1581:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 67
  call SCR_EXPRESSION
  closecapture 67 0
  call BCLOSE
  call CBOPEN
  opencapture 68
  catch __TERM_1728
__TERM_1727:
  call LOWSTMT
  partialcommit __TERM_1727
__TERM_1728:
  closecapture 68 0
  call CBCLOSE
  opencapture 69
  catch __TERM_1746
__TERM_1745:
  call IF_ELSEIF
  partialcommit __TERM_1745
__TERM_1746:
  closecapture 69 0
  opencapture 70
  catch __TERM_1757
  call IF_ELSE
  commit __TERM_1757
__TERM_1757:
  closecapture 70 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 71
  call SCR_EXPRESSION
  closecapture 71 0
  call BCLOSE
  call CBOPEN
  opencapture 72
  catch __TERM_1806
__TERM_1805:
  call LOWSTMT
  partialcommit __TERM_1805
__TERM_1806:
  closecapture 72 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 73
  catch __TERM_1836
__TERM_1835:
  call LOWSTMT
  partialcommit __TERM_1835
__TERM_1836:
  closecapture 73 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 74
  call SCR_EXPRESSION
  closecapture 74 0
  call BCLOSE
  call CBOPEN
  opencapture 75
  catch __TERM_1890
__TERM_1889:
  call LOWSTMT
  partialcommit __TERM_1889
__TERM_1890:
  closecapture 75 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 76
  catch __TERM_1913
  call SCR_EXPRESSION
  commit __TERM_1913
__TERM_1913:
  closecapture 76 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1928
  call KW_BREAK
  commit __LEFTHAND_1929
__RIGHTHAND_1928:
  call KW_CONTINUE
__LEFTHAND_1929:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1969
  call ASSIGN
  opencapture 77
  call SCR_EXPRESSION
  closecapture 77 0
  commit __TERM_1969
__TERM_1969:
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
  opencapture 78
  catch __RIGHTHAND_2026
  call ASSIGN
  commit __LEFTHAND_2027
__RIGHTHAND_2026:
  catch __RIGHTHAND_2034
  call PLUSIS
  commit __LEFTHAND_2035
__RIGHTHAND_2034:
  catch __RIGHTHAND_2042
  call MINIS
  commit __LEFTHAND_2043
__RIGHTHAND_2042:
  catch __RIGHTHAND_2050
  call MULIS
  commit __LEFTHAND_2051
__RIGHTHAND_2050:
  catch __RIGHTHAND_2058
  call DIVIS
  commit __LEFTHAND_2059
__RIGHTHAND_2058:
  catch __RIGHTHAND_2066
  call BITANDIS
  commit __LEFTHAND_2067
__RIGHTHAND_2066:
  catch __RIGHTHAND_2074
  call BITORIS
  commit __LEFTHAND_2075
__RIGHTHAND_2074:
  catch __RIGHTHAND_2082
  call BITXORIS
  commit __LEFTHAND_2083
__RIGHTHAND_2082:
  catch __RIGHTHAND_2090
  call BITNOTIS
  commit __LEFTHAND_2091
__RIGHTHAND_2090:
  catch __RIGHTHAND_2098
  call LSHIFTIS
  commit __LEFTHAND_2099
__RIGHTHAND_2098:
  call RSHIFTIS
__LEFTHAND_2099:
__LEFTHAND_2091:
__LEFTHAND_2083:
__LEFTHAND_2075:
__LEFTHAND_2067:
__LEFTHAND_2059:
__LEFTHAND_2051:
__LEFTHAND_2043:
__LEFTHAND_2035:
__LEFTHAND_2027:
  closecapture 78 0
  ret
-- Rule
SCR_EXPRESSION:
  call __prefix
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  catch __RIGHTHAND_2124
  call BINOP_P11
  commit __LEFTHAND_2125
__RIGHTHAND_2124:
  call SCR_TERM
__LEFTHAND_2125:
  catch __TERM_2142
__TERM_2141:
  opencapture 79
  call LOGOR
  catch __RIGHTHAND_2162
  call BINOP_P11
  commit __LEFTHAND_2163
__RIGHTHAND_2162:
  call SCR_TERM
__LEFTHAND_2163:
  closecapture 79 0
  partialcommit __TERM_2141
__TERM_2142:
  ret
-- Rule
BINOP_P11:
  call __prefix
  catch __RIGHTHAND_2182
  call BINOP_P10
  commit __LEFTHAND_2183
__RIGHTHAND_2182:
  call SCR_TERM
__LEFTHAND_2183:
  catch __TERM_2200
__TERM_2199:
  opencapture 80
  call LOGAND
  catch __RIGHTHAND_2220
  call BINOP_P10
  commit __LEFTHAND_2221
__RIGHTHAND_2220:
  call SCR_TERM
__LEFTHAND_2221:
  closecapture 80 0
  partialcommit __TERM_2199
__TERM_2200:
  ret
-- Rule
BINOP_P10:
  call __prefix
  catch __RIGHTHAND_2240
  call BINOP_P09
  commit __LEFTHAND_2241
__RIGHTHAND_2240:
  call SCR_TERM
__LEFTHAND_2241:
  catch __TERM_2258
__TERM_2257:
  opencapture 81
  call BITOR
  catch __RIGHTHAND_2278
  call BINOP_P09
  commit __LEFTHAND_2279
__RIGHTHAND_2278:
  call SCR_TERM
__LEFTHAND_2279:
  closecapture 81 0
  partialcommit __TERM_2257
__TERM_2258:
  ret
-- Rule
BINOP_P09:
  call __prefix
  catch __RIGHTHAND_2298
  call BINOP_P08
  commit __LEFTHAND_2299
__RIGHTHAND_2298:
  call SCR_TERM
__LEFTHAND_2299:
  catch __TERM_2316
__TERM_2315:
  opencapture 82
  call BITXOR
  catch __RIGHTHAND_2336
  call BINOP_P08
  commit __LEFTHAND_2337
__RIGHTHAND_2336:
  call SCR_TERM
__LEFTHAND_2337:
  closecapture 82 0
  partialcommit __TERM_2315
__TERM_2316:
  ret
-- Rule
BINOP_P08:
  call __prefix
  catch __RIGHTHAND_2356
  call BINOP_P07
  commit __LEFTHAND_2357
__RIGHTHAND_2356:
  call SCR_TERM
__LEFTHAND_2357:
  catch __TERM_2374
__TERM_2373:
  opencapture 83
  call BITAND
  catch __RIGHTHAND_2394
  call BINOP_P07
  commit __LEFTHAND_2395
__RIGHTHAND_2394:
  call SCR_TERM
__LEFTHAND_2395:
  closecapture 83 0
  partialcommit __TERM_2373
__TERM_2374:
  ret
-- Rule
BINOP_P07:
  call __prefix
  catch __RIGHTHAND_2414
  call BINOP_P06
  commit __LEFTHAND_2415
__RIGHTHAND_2414:
  call SCR_TERM
__LEFTHAND_2415:
  catch __TERM_2432
__TERM_2431:
  opencapture 84
  catch __RIGHTHAND_2440
  call EQUALS
  commit __LEFTHAND_2441
__RIGHTHAND_2440:
  call NEQUALS
__LEFTHAND_2441:
  catch __RIGHTHAND_2460
  call BINOP_P06
  commit __LEFTHAND_2461
__RIGHTHAND_2460:
  call SCR_TERM
__LEFTHAND_2461:
  closecapture 84 0
  partialcommit __TERM_2431
__TERM_2432:
  ret
-- Rule
BINOP_P06:
  call __prefix
  catch __RIGHTHAND_2480
  call BINOP_P05
  commit __LEFTHAND_2481
__RIGHTHAND_2480:
  call SCR_TERM
__LEFTHAND_2481:
  catch __TERM_2498
__TERM_2497:
  opencapture 85
  catch __RIGHTHAND_2506
  call LTEQ
  commit __LEFTHAND_2507
__RIGHTHAND_2506:
  catch __RIGHTHAND_2514
  call LT
  commit __LEFTHAND_2515
__RIGHTHAND_2514:
  catch __RIGHTHAND_2522
  call GTEQ
  commit __LEFTHAND_2523
__RIGHTHAND_2522:
  call GT
__LEFTHAND_2523:
__LEFTHAND_2515:
__LEFTHAND_2507:
  catch __RIGHTHAND_2542
  call BINOP_P05
  commit __LEFTHAND_2543
__RIGHTHAND_2542:
  call SCR_TERM
__LEFTHAND_2543:
  closecapture 85 0
  partialcommit __TERM_2497
__TERM_2498:
  ret
-- Rule
BINOP_P05:
  call __prefix
  catch __RIGHTHAND_2562
  call BINOP_P04
  commit __LEFTHAND_2563
__RIGHTHAND_2562:
  call SCR_TERM
__LEFTHAND_2563:
  catch __TERM_2580
__TERM_2579:
  opencapture 86
  catch __RIGHTHAND_2588
  call LSHIFT
  commit __LEFTHAND_2589
__RIGHTHAND_2588:
  call RSHIFT
__LEFTHAND_2589:
  catch __RIGHTHAND_2608
  call BINOP_P04
  commit __LEFTHAND_2609
__RIGHTHAND_2608:
  call SCR_TERM
__LEFTHAND_2609:
  closecapture 86 0
  partialcommit __TERM_2579
__TERM_2580:
  ret
-- Rule
BINOP_P04:
  call __prefix
  catch __RIGHTHAND_2628
  call BINOP_P03
  commit __LEFTHAND_2629
__RIGHTHAND_2628:
  call SCR_TERM
__LEFTHAND_2629:
  catch __TERM_2646
__TERM_2645:
  opencapture 87
  catch __RIGHTHAND_2654
  call ADD
  commit __LEFTHAND_2655
__RIGHTHAND_2654:
  call SUB
__LEFTHAND_2655:
  catch __RIGHTHAND_2674
  call BINOP_P03
  commit __LEFTHAND_2675
__RIGHTHAND_2674:
  call SCR_TERM
__LEFTHAND_2675:
  closecapture 87 0
  partialcommit __TERM_2645
__TERM_2646:
  ret
-- Rule
BINOP_P03:
  call __prefix
  call SCR_TERM
  catch __TERM_2704
__TERM_2703:
  opencapture 88
  catch __RIGHTHAND_2712
  call MUL
  commit __LEFTHAND_2713
__RIGHTHAND_2712:
  catch __RIGHTHAND_2720
  call DIV
  commit __LEFTHAND_2721
__RIGHTHAND_2720:
  call POW
__LEFTHAND_2721:
__LEFTHAND_2713:
  call SCR_TERM
  closecapture 88 0
  partialcommit __TERM_2703
__TERM_2704:
  ret
-- Rule
UNOP:
  call __prefix
  opencapture 89
  catch __RIGHTHAND_2752
  call LOGNOT
  commit __LEFTHAND_2753
__RIGHTHAND_2752:
  call BITNOT
__LEFTHAND_2753:
  closecapture 89 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2766
  opencapture 90
  call FUNCTIONCALL
  closecapture 90 0
  commit __LEFTHAND_2767
__RIGHTHAND_2766:
  catch __RIGHTHAND_2780
  opencapture 91
  call BOPEN
  opencapture 92
  call SCR_EXPRESSION
  closecapture 92 0
  call BCLOSE
  closecapture 91 0
  commit __LEFTHAND_2781
__RIGHTHAND_2780:
  catch __RIGHTHAND_2812
  opencapture 93
  call LITERAL
  closecapture 93 0
  commit __LEFTHAND_2813
__RIGHTHAND_2812:
  catch __TERM_2830
__TERM_2829:
  opencapture 94
  call UNOP
  closecapture 94 0
  partialcommit __TERM_2829
__TERM_2830:
  opencapture 95
  call SCR_REFERENCE
  closecapture 95 0
__LEFTHAND_2813:
__LEFTHAND_2781:
__LEFTHAND_2767:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 96
  call SCR_REFERENCE
  closecapture 96 0
  call BOPEN
  catch __TERM_2871
  opencapture 97
  call SCR_EXPRESSION
  closecapture 97 0
  catch __TERM_2890
__TERM_2889:
  call COMMA
  opencapture 98
  call SCR_EXPRESSION
  closecapture 98 0
  partialcommit __TERM_2889
__TERM_2890:
  commit __TERM_2871
__TERM_2871:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  opencapture 99
  call IDENT
  closecapture 99 0
  catch __TERM_2932
__TERM_2931:
  call INDEX
  partialcommit __TERM_2931
__TERM_2932:
  catch __TERM_2938
__TERM_2937:
  call DOT
  call SCR_REFERENCE
  partialcommit __TERM_2937
__TERM_2938:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 100
  call SCR_EXPRESSION
  closecapture 100 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_2976
  call STRINGLITERAL
  commit __LEFTHAND_2977
__RIGHTHAND_2976:
  catch __RIGHTHAND_2984
  call HASHLITERAL
  commit __LEFTHAND_2985
__RIGHTHAND_2984:
  catch __RIGHTHAND_2992
  call LISTLITERAL
  commit __LEFTHAND_2993
__RIGHTHAND_2992:
  catch __RIGHTHAND_3000
  call FLOATLITERAL
  commit __LEFTHAND_3001
__RIGHTHAND_3000:
  catch __RIGHTHAND_3008
  call INTLITERAL
  commit __LEFTHAND_3009
__RIGHTHAND_3008:
  call BOOLEANLITERAL
__LEFTHAND_3009:
__LEFTHAND_3001:
__LEFTHAND_2993:
__LEFTHAND_2985:
__LEFTHAND_2977:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 101
  catch __TERM_3038
__TERM_3037:
  catch __RIGHTHAND_3040
  char 5c
  catch __RIGHTHAND_3054
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_3055
__RIGHTHAND_3054:
  counter 0 3
__TERM_3064:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_3064
__LEFTHAND_3055:
  commit __LEFTHAND_3041
__RIGHTHAND_3040:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_3041:
  partialcommit __TERM_3037
__TERM_3038:
  closecapture 101 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 102
  call CBOPEN
  catch __TERM_3095
  call HASHELT
  catch __TERM_3108
__TERM_3107:
  call COMMA
  call HASHELT
  partialcommit __TERM_3107
__TERM_3108:
  commit __TERM_3095
__TERM_3095:
  call CBCLOSE
  closecapture 102 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 103
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 103 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 104
  call SCR_TERM
  closecapture 104 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 105
  call SCR_TERM
  closecapture 105 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 106
  call ABOPEN
  catch __TERM_3191
  call LISTELT
  catch __TERM_3204
__TERM_3203:
  call COMMA
  call LISTELT
  partialcommit __TERM_3203
__TERM_3204:
  commit __TERM_3191
__TERM_3191:
  call ABCLOSE
  closecapture 106 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 107
  call SCR_TERM
  closecapture 107 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 108
  catch __TERM_3246
__TERM_3245:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3245
__TERM_3246:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3258
__TERM_3257:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3257
__TERM_3258:
  closecapture 108 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 109
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3270
__TERM_3269:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3269
__TERM_3270:
  closecapture 109 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 110
  catch __RIGHTHAND_3278
  quad 74727565
  commit __LEFTHAND_3279
__RIGHTHAND_3278:
  quad 66616c73
  char 65
__LEFTHAND_3279:
  closecapture 110 0
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
  opencapture 111
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_3361
  counter 0 63
__TERM_3362:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_3363
__TERM_3363:
  condjump 0 __TERM_3362
  commit __TERM_3361
__TERM_3361:
  closecapture 111 0
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
  opencapture 112
  char 3d
  closecapture 112 0
  ret
-- Rule
PLUSIS:
  call __prefix
  opencapture 113
  char 2b
  char 3d
  closecapture 113 0
  ret
-- Rule
MINIS:
  call __prefix
  opencapture 114
  char 2d
  char 3d
  closecapture 114 0
  ret
-- Rule
MULIS:
  call __prefix
  opencapture 115
  char 2a
  char 3d
  closecapture 115 0
  ret
-- Rule
DIVIS:
  call __prefix
  opencapture 116
  char 2f
  char 3d
  closecapture 116 0
  ret
-- Rule
EQUALS:
  call __prefix
  opencapture 117
  char 3d
  char 3d
  closecapture 117 0
  ret
-- Rule
NEQUALS:
  call __prefix
  opencapture 118
  char 21
  char 3d
  closecapture 118 0
  ret
-- Rule
LT:
  call __prefix
  opencapture 119
  char 3c
  closecapture 119 0
  catch __TERM_3496
  char 3d
  failtwice
__TERM_3496:
  ret
-- Rule
GT:
  call __prefix
  opencapture 120
  char 3e
  closecapture 120 0
  catch __TERM_3514
  char 3d
  failtwice
__TERM_3514:
  ret
-- Rule
LTEQ:
  call __prefix
  opencapture 121
  char 3c
  char 3d
  closecapture 121 0
  ret
-- Rule
GTEQ:
  call __prefix
  opencapture 122
  char 3e
  char 3d
  closecapture 122 0
  ret
-- Rule
SEMICOLON:
  call __prefix
  char 3b
  ret
-- Rule
COLON:
  call __prefix
  char 3a
  ret
-- Rule
POW:
  call __prefix
  opencapture 123
  char 2a
  char 2a
  closecapture 123 0
  ret
-- Rule
MUL:
  call __prefix
  opencapture 124
  char 2a
  closecapture 124 0
  catch __TERM_3580
  char 2a
  failtwice
__TERM_3580:
  ret
-- Rule
DIV:
  call __prefix
  opencapture 125
  char 2f
  closecapture 125 0
  catch __TERM_3598
  char 3d
  failtwice
__TERM_3598:
  ret
-- Rule
ADD:
  call __prefix
  opencapture 126
  char 2b
  closecapture 126 0
  catch __TERM_3616
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3616:
  ret
-- Rule
SUB:
  call __prefix
  opencapture 127
  char 2d
  closecapture 127 0
  catch __TERM_3634
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3634:
  ret
-- Rule
INC:
  call __prefix
  opencapture 128
  char 2b
  char 2b
  closecapture 128 0
  ret
-- Rule
DEC:
  call __prefix
  opencapture 129
  char 2d
  char 2d
  closecapture 129 0
  ret
-- Rule
LOGAND:
  call __prefix
  opencapture 130
  char 26
  char 26
  closecapture 130 0
  ret
-- Rule
LOGOR:
  call __prefix
  opencapture 131
  char 7c
  char 7c
  closecapture 131 0
  ret
-- Rule
LOGNOT:
  call __prefix
  opencapture 132
  char 21
  closecapture 132 0
  catch __TERM_3700
  char 3d
  failtwice
__TERM_3700:
  ret
-- Rule
BITAND:
  call __prefix
  opencapture 133
  char 26
  closecapture 133 0
  catch __TERM_3718
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3718:
  ret
-- Rule
BITOR:
  call __prefix
  opencapture 134
  char 7c
  closecapture 134 0
  catch __TERM_3736
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3736:
  ret
-- Rule
BITXOR:
  call __prefix
  opencapture 135
  char 5e
  closecapture 135 0
  catch __TERM_3754
  char 3d
  failtwice
__TERM_3754:
  ret
-- Rule
BITNOT:
  call __prefix
  opencapture 136
  char 7e
  closecapture 136 0
  ret
-- Rule
BITANDIS:
  call __prefix
  opencapture 137
  char 26
  char 3d
  closecapture 137 0
  ret
-- Rule
BITORIS:
  call __prefix
  opencapture 138
  char 7c
  char 3d
  closecapture 138 0
  ret
-- Rule
BITXORIS:
  call __prefix
  opencapture 139
  char 5e
  char 3d
  closecapture 139 0
  ret
-- Rule
BITNOTIS:
  call __prefix
  opencapture 140
  char 7e
  char 3d
  closecapture 140 0
  ret
-- Rule
COMMA:
  call __prefix
  char 2c
  ret
-- Rule
DOT:
  call __prefix
  opencapture 141
  char 2e
  closecapture 141 0
  ret
-- Rule
LSHIFT:
  call __prefix
  opencapture 142
  char 3c
  char 3c
  closecapture 142 0
  catch __TERM_3850
  char 3d
  failtwice
__TERM_3850:
  ret
-- Rule
RSHIFT:
  call __prefix
  opencapture 143
  char 3e
  char 3e
  closecapture 143 0
  catch __TERM_3868
  char 3d
  failtwice
__TERM_3868:
  ret
-- Rule
LSHIFTIS:
  call __prefix
  opencapture 144
  char 3c
  char 3c
  char 3d
  closecapture 144 0
  ret
-- Rule
RSHIFTIS:
  call __prefix
  opencapture 145
  char 3e
  char 3e
  char 3d
  closecapture 145 0
  ret

  end 0

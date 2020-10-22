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
  opencapture 37
  call CBCLOSE
  closecapture 37 0
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
  catch __TERM_849
  catch __RIGHTHAND_852
  call REPLACE
  commit __LEFTHAND_853
__RIGHTHAND_852:
  call RECYCLE
__LEFTHAND_853:
  commit __TERM_849
__TERM_849:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 38
  catch __TERM_881
  call SETNOT
  commit __TERM_881
__TERM_881:
  closecapture 38 0
  catch __RIGHTHAND_890
  opencapture 39
  catch __RIGHTHAND_898
  char 5c
  catch __RIGHTHAND_912
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_913
__RIGHTHAND_912:
  counter 0 3
__TERM_922:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_922
__LEFTHAND_913:
  commit __LEFTHAND_899
__RIGHTHAND_898:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_899:
  closecapture 39 0
  char 2d
  opencapture 40
  catch __RIGHTHAND_944
  char 5c
  catch __RIGHTHAND_958
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_959
__RIGHTHAND_958:
  counter 0 3
__TERM_968:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_968
__LEFTHAND_959:
  commit __LEFTHAND_945
__RIGHTHAND_944:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_945:
  closecapture 40 0
  commit __LEFTHAND_891
__RIGHTHAND_890:
  opencapture 41
  catch __RIGHTHAND_984
  char 5c
  catch __RIGHTHAND_998
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_999
__RIGHTHAND_998:
  counter 0 3
__TERM_1008:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1008
__LEFTHAND_999:
  commit __LEFTHAND_985
__RIGHTHAND_984:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_985:
  closecapture 41 0
__LEFTHAND_891:
  catch __TERM_888
__TERM_887:
  catch __RIGHTHAND_1018
  opencapture 39
  catch __RIGHTHAND_1026
  char 5c
  catch __RIGHTHAND_1040
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1041
__RIGHTHAND_1040:
  counter 0 3
__TERM_1050:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1050
__LEFTHAND_1041:
  commit __LEFTHAND_1027
__RIGHTHAND_1026:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1027:
  closecapture 39 0
  char 2d
  opencapture 40
  catch __RIGHTHAND_1072
  char 5c
  catch __RIGHTHAND_1086
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1087
__RIGHTHAND_1086:
  counter 0 3
__TERM_1096:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1096
__LEFTHAND_1087:
  commit __LEFTHAND_1073
__RIGHTHAND_1072:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1073:
  closecapture 40 0
  commit __LEFTHAND_1019
__RIGHTHAND_1018:
  opencapture 41
  catch __RIGHTHAND_1112
  char 5c
  catch __RIGHTHAND_1126
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1127
__RIGHTHAND_1126:
  counter 0 3
__TERM_1136:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1136
__LEFTHAND_1127:
  commit __LEFTHAND_1113
__RIGHTHAND_1112:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1113:
  closecapture 41 0
__LEFTHAND_1019:
  partialcommit __TERM_887
__TERM_888:
  call ABCLOSE
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1164
  opencapture 42
  call IDENT
  closecapture 42 0
  commit __LEFTHAND_1165
__RIGHTHAND_1164:
  opencapture 43
  call NUMBER
  closecapture 43 0
__LEFTHAND_1165:
  ret
-- Rule
REFERENCE:
  call __prefix
  catch __TERM_1190
  call KW_FUNCTION
  failtwice
__TERM_1190:
  opencapture 44
  call IDENT
  closecapture 44 0
  catch __TERM_1208
  call LEFTARROW
  failtwice
__TERM_1208:
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
  catch __TERM_1236
__TERM_1235:
  call REPLACETERM
  partialcommit __TERM_1235
__TERM_1236:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1238
  opencapture 46
  call STRINGLITERAL
  closecapture 46 0
  commit __LEFTHAND_1239
__RIGHTHAND_1238:
  catch __RIGHTHAND_1252
  opencapture 47
  call HEXLITERAL
  closecapture 47 0
  commit __LEFTHAND_1253
__RIGHTHAND_1252:
  opencapture 48
  call VARREFERENCE
  closecapture 48 0
__LEFTHAND_1253:
__LEFTHAND_1239:
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
  catch __TERM_1342
__TERM_1341:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1341
__TERM_1342:
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
__TERM_1376:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1376
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1384
__TERM_1383:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1383
__TERM_1384:
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1395
  char 69
  commit __TERM_1395
__TERM_1395:
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
  catch __TERM_1479
  opencapture 54
  call PARAMDECL
  closecapture 54 0
  catch __TERM_1498
__TERM_1497:
  call COMMA
  opencapture 55
  call PARAMDECL
  closecapture 55 0
  partialcommit __TERM_1497
__TERM_1498:
  commit __TERM_1479
__TERM_1479:
  call BCLOSE
  ret
-- Rule
PARAMDECL:
  call __prefix
  catch __RIGHTHAND_1524
  opencapture 56
  call IDENT
  closecapture 56 0
  opencapture 57
  call IDENT
  closecapture 57 0
  commit __LEFTHAND_1525
__RIGHTHAND_1524:
  opencapture 58
  call IDENT
  closecapture 58 0
__LEFTHAND_1525:
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  catch __TERM_1572
__TERM_1571:
  opencapture 59
  call LOWSTMT
  closecapture 59 0
  partialcommit __TERM_1571
__TERM_1572:
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1586
  opencapture 60
  call ST_IF
  closecapture 60 0
  commit __LEFTHAND_1587
__RIGHTHAND_1586:
  catch __RIGHTHAND_1600
  opencapture 61
  call ST_WHILE
  closecapture 61 0
  commit __LEFTHAND_1601
__RIGHTHAND_1600:
  catch __RIGHTHAND_1614
  opencapture 62
  call ST_RETURN
  closecapture 62 0
  commit __LEFTHAND_1615
__RIGHTHAND_1614:
  catch __RIGHTHAND_1628
  opencapture 63
  call ST_OTHER
  closecapture 63 0
  commit __LEFTHAND_1629
__RIGHTHAND_1628:
  catch __RIGHTHAND_1642
  opencapture 64
  call VARDECL
  closecapture 64 0
  commit __LEFTHAND_1643
__RIGHTHAND_1642:
  catch __RIGHTHAND_1656
  opencapture 65
  call ASSIGNMENT
  closecapture 65 0
  commit __LEFTHAND_1657
__RIGHTHAND_1656:
  catch __TERM_1673
  opencapture 66
  call SCR_EXPRESSION
  closecapture 66 0
  commit __TERM_1673
__TERM_1673:
  call SEMICOLON
__LEFTHAND_1657:
__LEFTHAND_1643:
__LEFTHAND_1629:
__LEFTHAND_1615:
__LEFTHAND_1601:
__LEFTHAND_1587:
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
  catch __TERM_1734
__TERM_1733:
  call LOWSTMT
  partialcommit __TERM_1733
__TERM_1734:
  closecapture 68 0
  call CBCLOSE
  opencapture 69
  catch __TERM_1752
__TERM_1751:
  call IF_ELSEIF
  partialcommit __TERM_1751
__TERM_1752:
  closecapture 69 0
  opencapture 70
  catch __TERM_1763
  call IF_ELSE
  commit __TERM_1763
__TERM_1763:
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
  catch __TERM_1812
__TERM_1811:
  call LOWSTMT
  partialcommit __TERM_1811
__TERM_1812:
  closecapture 72 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 73
  catch __TERM_1842
__TERM_1841:
  call LOWSTMT
  partialcommit __TERM_1841
__TERM_1842:
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
  catch __TERM_1896
__TERM_1895:
  call LOWSTMT
  partialcommit __TERM_1895
__TERM_1896:
  closecapture 75 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 76
  catch __TERM_1919
  call SCR_EXPRESSION
  commit __TERM_1919
__TERM_1919:
  closecapture 76 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1934
  call KW_BREAK
  commit __LEFTHAND_1935
__RIGHTHAND_1934:
  call KW_CONTINUE
__LEFTHAND_1935:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1975
  call ASSIGN
  opencapture 77
  call SCR_EXPRESSION
  closecapture 77 0
  commit __TERM_1975
__TERM_1975:
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
  catch __RIGHTHAND_2032
  call ASSIGN
  commit __LEFTHAND_2033
__RIGHTHAND_2032:
  catch __RIGHTHAND_2040
  call PLUSIS
  commit __LEFTHAND_2041
__RIGHTHAND_2040:
  catch __RIGHTHAND_2048
  call MINIS
  commit __LEFTHAND_2049
__RIGHTHAND_2048:
  catch __RIGHTHAND_2056
  call MULIS
  commit __LEFTHAND_2057
__RIGHTHAND_2056:
  catch __RIGHTHAND_2064
  call DIVIS
  commit __LEFTHAND_2065
__RIGHTHAND_2064:
  catch __RIGHTHAND_2072
  call BITANDIS
  commit __LEFTHAND_2073
__RIGHTHAND_2072:
  catch __RIGHTHAND_2080
  call BITORIS
  commit __LEFTHAND_2081
__RIGHTHAND_2080:
  catch __RIGHTHAND_2088
  call BITXORIS
  commit __LEFTHAND_2089
__RIGHTHAND_2088:
  catch __RIGHTHAND_2096
  call BITNOTIS
  commit __LEFTHAND_2097
__RIGHTHAND_2096:
  catch __RIGHTHAND_2104
  call LSHIFTIS
  commit __LEFTHAND_2105
__RIGHTHAND_2104:
  call RSHIFTIS
__LEFTHAND_2105:
__LEFTHAND_2097:
__LEFTHAND_2089:
__LEFTHAND_2081:
__LEFTHAND_2073:
__LEFTHAND_2065:
__LEFTHAND_2057:
__LEFTHAND_2049:
__LEFTHAND_2041:
__LEFTHAND_2033:
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
  catch __RIGHTHAND_2130
  call BINOP_P11
  commit __LEFTHAND_2131
__RIGHTHAND_2130:
  call SCR_TERM
__LEFTHAND_2131:
  catch __TERM_2148
__TERM_2147:
  opencapture 79
  call LOGOR
  catch __RIGHTHAND_2168
  call BINOP_P11
  commit __LEFTHAND_2169
__RIGHTHAND_2168:
  call SCR_TERM
__LEFTHAND_2169:
  closecapture 79 0
  partialcommit __TERM_2147
__TERM_2148:
  ret
-- Rule
BINOP_P11:
  call __prefix
  catch __RIGHTHAND_2188
  call BINOP_P10
  commit __LEFTHAND_2189
__RIGHTHAND_2188:
  call SCR_TERM
__LEFTHAND_2189:
  catch __TERM_2206
__TERM_2205:
  opencapture 80
  call LOGAND
  catch __RIGHTHAND_2226
  call BINOP_P10
  commit __LEFTHAND_2227
__RIGHTHAND_2226:
  call SCR_TERM
__LEFTHAND_2227:
  closecapture 80 0
  partialcommit __TERM_2205
__TERM_2206:
  ret
-- Rule
BINOP_P10:
  call __prefix
  catch __RIGHTHAND_2246
  call BINOP_P09
  commit __LEFTHAND_2247
__RIGHTHAND_2246:
  call SCR_TERM
__LEFTHAND_2247:
  catch __TERM_2264
__TERM_2263:
  opencapture 81
  call BITOR
  catch __RIGHTHAND_2284
  call BINOP_P09
  commit __LEFTHAND_2285
__RIGHTHAND_2284:
  call SCR_TERM
__LEFTHAND_2285:
  closecapture 81 0
  partialcommit __TERM_2263
__TERM_2264:
  ret
-- Rule
BINOP_P09:
  call __prefix
  catch __RIGHTHAND_2304
  call BINOP_P08
  commit __LEFTHAND_2305
__RIGHTHAND_2304:
  call SCR_TERM
__LEFTHAND_2305:
  catch __TERM_2322
__TERM_2321:
  opencapture 82
  call BITXOR
  catch __RIGHTHAND_2342
  call BINOP_P08
  commit __LEFTHAND_2343
__RIGHTHAND_2342:
  call SCR_TERM
__LEFTHAND_2343:
  closecapture 82 0
  partialcommit __TERM_2321
__TERM_2322:
  ret
-- Rule
BINOP_P08:
  call __prefix
  catch __RIGHTHAND_2362
  call BINOP_P07
  commit __LEFTHAND_2363
__RIGHTHAND_2362:
  call SCR_TERM
__LEFTHAND_2363:
  catch __TERM_2380
__TERM_2379:
  opencapture 83
  call BITAND
  catch __RIGHTHAND_2400
  call BINOP_P07
  commit __LEFTHAND_2401
__RIGHTHAND_2400:
  call SCR_TERM
__LEFTHAND_2401:
  closecapture 83 0
  partialcommit __TERM_2379
__TERM_2380:
  ret
-- Rule
BINOP_P07:
  call __prefix
  catch __RIGHTHAND_2420
  call BINOP_P06
  commit __LEFTHAND_2421
__RIGHTHAND_2420:
  call SCR_TERM
__LEFTHAND_2421:
  catch __TERM_2438
__TERM_2437:
  opencapture 84
  catch __RIGHTHAND_2446
  call EQUALS
  commit __LEFTHAND_2447
__RIGHTHAND_2446:
  call NEQUALS
__LEFTHAND_2447:
  catch __RIGHTHAND_2466
  call BINOP_P06
  commit __LEFTHAND_2467
__RIGHTHAND_2466:
  call SCR_TERM
__LEFTHAND_2467:
  closecapture 84 0
  partialcommit __TERM_2437
__TERM_2438:
  ret
-- Rule
BINOP_P06:
  call __prefix
  catch __RIGHTHAND_2486
  call BINOP_P05
  commit __LEFTHAND_2487
__RIGHTHAND_2486:
  call SCR_TERM
__LEFTHAND_2487:
  catch __TERM_2504
__TERM_2503:
  opencapture 85
  catch __RIGHTHAND_2512
  call LTEQ
  commit __LEFTHAND_2513
__RIGHTHAND_2512:
  catch __RIGHTHAND_2520
  call LT
  commit __LEFTHAND_2521
__RIGHTHAND_2520:
  catch __RIGHTHAND_2528
  call GTEQ
  commit __LEFTHAND_2529
__RIGHTHAND_2528:
  call GT
__LEFTHAND_2529:
__LEFTHAND_2521:
__LEFTHAND_2513:
  catch __RIGHTHAND_2548
  call BINOP_P05
  commit __LEFTHAND_2549
__RIGHTHAND_2548:
  call SCR_TERM
__LEFTHAND_2549:
  closecapture 85 0
  partialcommit __TERM_2503
__TERM_2504:
  ret
-- Rule
BINOP_P05:
  call __prefix
  catch __RIGHTHAND_2568
  call BINOP_P04
  commit __LEFTHAND_2569
__RIGHTHAND_2568:
  call SCR_TERM
__LEFTHAND_2569:
  catch __TERM_2586
__TERM_2585:
  opencapture 86
  catch __RIGHTHAND_2594
  call LSHIFT
  commit __LEFTHAND_2595
__RIGHTHAND_2594:
  call RSHIFT
__LEFTHAND_2595:
  catch __RIGHTHAND_2614
  call BINOP_P04
  commit __LEFTHAND_2615
__RIGHTHAND_2614:
  call SCR_TERM
__LEFTHAND_2615:
  closecapture 86 0
  partialcommit __TERM_2585
__TERM_2586:
  ret
-- Rule
BINOP_P04:
  call __prefix
  catch __RIGHTHAND_2634
  call BINOP_P03
  commit __LEFTHAND_2635
__RIGHTHAND_2634:
  call SCR_TERM
__LEFTHAND_2635:
  catch __TERM_2652
__TERM_2651:
  opencapture 87
  catch __RIGHTHAND_2660
  call ADD
  commit __LEFTHAND_2661
__RIGHTHAND_2660:
  call SUB
__LEFTHAND_2661:
  catch __RIGHTHAND_2680
  call BINOP_P03
  commit __LEFTHAND_2681
__RIGHTHAND_2680:
  call SCR_TERM
__LEFTHAND_2681:
  closecapture 87 0
  partialcommit __TERM_2651
__TERM_2652:
  ret
-- Rule
BINOP_P03:
  call __prefix
  call SCR_TERM
  catch __TERM_2710
__TERM_2709:
  opencapture 88
  catch __RIGHTHAND_2718
  call MUL
  commit __LEFTHAND_2719
__RIGHTHAND_2718:
  catch __RIGHTHAND_2726
  call DIV
  commit __LEFTHAND_2727
__RIGHTHAND_2726:
  call POW
__LEFTHAND_2727:
__LEFTHAND_2719:
  call SCR_TERM
  closecapture 88 0
  partialcommit __TERM_2709
__TERM_2710:
  ret
-- Rule
UNOP:
  call __prefix
  opencapture 89
  catch __RIGHTHAND_2758
  call LOGNOT
  commit __LEFTHAND_2759
__RIGHTHAND_2758:
  call BITNOT
__LEFTHAND_2759:
  closecapture 89 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2772
  opencapture 90
  call FUNCTIONCALL
  closecapture 90 0
  commit __LEFTHAND_2773
__RIGHTHAND_2772:
  catch __RIGHTHAND_2786
  opencapture 91
  call BOPEN
  opencapture 92
  call SCR_EXPRESSION
  closecapture 92 0
  call BCLOSE
  closecapture 91 0
  commit __LEFTHAND_2787
__RIGHTHAND_2786:
  catch __RIGHTHAND_2818
  opencapture 93
  call LITERAL
  closecapture 93 0
  commit __LEFTHAND_2819
__RIGHTHAND_2818:
  catch __TERM_2836
__TERM_2835:
  opencapture 94
  call UNOP
  closecapture 94 0
  partialcommit __TERM_2835
__TERM_2836:
  opencapture 95
  call SCR_REFERENCE
  closecapture 95 0
__LEFTHAND_2819:
__LEFTHAND_2787:
__LEFTHAND_2773:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 96
  call SCR_REFERENCE
  closecapture 96 0
  call BOPEN
  catch __TERM_2877
  opencapture 97
  call SCR_EXPRESSION
  closecapture 97 0
  catch __TERM_2896
__TERM_2895:
  call COMMA
  opencapture 98
  call SCR_EXPRESSION
  closecapture 98 0
  partialcommit __TERM_2895
__TERM_2896:
  commit __TERM_2877
__TERM_2877:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  opencapture 99
  call IDENT
  closecapture 99 0
  catch __TERM_2938
__TERM_2937:
  call INDEX
  partialcommit __TERM_2937
__TERM_2938:
  catch __TERM_2944
__TERM_2943:
  call DOT
  call SCR_REFERENCE
  partialcommit __TERM_2943
__TERM_2944:
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
  catch __RIGHTHAND_2982
  call STRINGLITERAL
  commit __LEFTHAND_2983
__RIGHTHAND_2982:
  catch __RIGHTHAND_2990
  call HASHLITERAL
  commit __LEFTHAND_2991
__RIGHTHAND_2990:
  catch __RIGHTHAND_2998
  call LISTLITERAL
  commit __LEFTHAND_2999
__RIGHTHAND_2998:
  catch __RIGHTHAND_3006
  call FLOATLITERAL
  commit __LEFTHAND_3007
__RIGHTHAND_3006:
  catch __RIGHTHAND_3014
  call INTLITERAL
  commit __LEFTHAND_3015
__RIGHTHAND_3014:
  call BOOLEANLITERAL
__LEFTHAND_3015:
__LEFTHAND_3007:
__LEFTHAND_2999:
__LEFTHAND_2991:
__LEFTHAND_2983:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 101
  catch __TERM_3044
__TERM_3043:
  catch __RIGHTHAND_3046
  char 5c
  catch __RIGHTHAND_3060
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_3061
__RIGHTHAND_3060:
  counter 0 3
__TERM_3070:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_3070
__LEFTHAND_3061:
  commit __LEFTHAND_3047
__RIGHTHAND_3046:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_3047:
  partialcommit __TERM_3043
__TERM_3044:
  closecapture 101 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 102
  call CBOPEN
  catch __TERM_3101
  call HASHELT
  catch __TERM_3114
__TERM_3113:
  call COMMA
  call HASHELT
  partialcommit __TERM_3113
__TERM_3114:
  commit __TERM_3101
__TERM_3101:
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
  catch __TERM_3197
  call LISTELT
  catch __TERM_3210
__TERM_3209:
  call COMMA
  call LISTELT
  partialcommit __TERM_3209
__TERM_3210:
  commit __TERM_3197
__TERM_3197:
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
  catch __TERM_3252
__TERM_3251:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3251
__TERM_3252:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3264
__TERM_3263:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3263
__TERM_3264:
  closecapture 108 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 109
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3276
__TERM_3275:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3275
__TERM_3276:
  closecapture 109 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 110
  catch __RIGHTHAND_3284
  quad 74727565
  commit __LEFTHAND_3285
__RIGHTHAND_3284:
  quad 66616c73
  char 65
__LEFTHAND_3285:
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
  opencapture 111
  char 3d
  closecapture 111 0
  ret
-- Rule
PLUSIS:
  call __prefix
  opencapture 112
  char 2b
  char 3d
  closecapture 112 0
  ret
-- Rule
MINIS:
  call __prefix
  opencapture 113
  char 2d
  char 3d
  closecapture 113 0
  ret
-- Rule
MULIS:
  call __prefix
  opencapture 114
  char 2a
  char 3d
  closecapture 114 0
  ret
-- Rule
DIVIS:
  call __prefix
  opencapture 115
  char 2f
  char 3d
  closecapture 115 0
  ret
-- Rule
EQUALS:
  call __prefix
  opencapture 116
  char 3d
  char 3d
  closecapture 116 0
  ret
-- Rule
NEQUALS:
  call __prefix
  opencapture 117
  char 21
  char 3d
  closecapture 117 0
  ret
-- Rule
LT:
  call __prefix
  opencapture 118
  char 3c
  closecapture 118 0
  catch __TERM_3496
  char 3d
  failtwice
__TERM_3496:
  ret
-- Rule
GT:
  call __prefix
  opencapture 119
  char 3e
  closecapture 119 0
  catch __TERM_3514
  char 3d
  failtwice
__TERM_3514:
  ret
-- Rule
LTEQ:
  call __prefix
  opencapture 120
  char 3c
  char 3d
  closecapture 120 0
  ret
-- Rule
GTEQ:
  call __prefix
  opencapture 121
  char 3e
  char 3d
  closecapture 121 0
  ret
-- Rule
SEMICOLON:
  call __prefix
  char 3b
  ret
-- Rule
COLON:
  call __prefix
  opencapture 122
  char 3a
  closecapture 122 0
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
  catch __TERM_3586
  char 2a
  failtwice
__TERM_3586:
  ret
-- Rule
DIV:
  call __prefix
  opencapture 125
  char 2f
  closecapture 125 0
  catch __TERM_3604
  char 3d
  failtwice
__TERM_3604:
  ret
-- Rule
ADD:
  call __prefix
  opencapture 126
  char 2b
  closecapture 126 0
  catch __TERM_3622
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3622:
  ret
-- Rule
SUB:
  call __prefix
  opencapture 127
  char 2d
  closecapture 127 0
  catch __TERM_3640
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3640:
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
  catch __TERM_3706
  char 3d
  failtwice
__TERM_3706:
  ret
-- Rule
BITAND:
  call __prefix
  opencapture 133
  char 26
  closecapture 133 0
  catch __TERM_3724
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3724:
  ret
-- Rule
BITOR:
  call __prefix
  opencapture 134
  char 7c
  closecapture 134 0
  catch __TERM_3742
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3742:
  ret
-- Rule
BITXOR:
  call __prefix
  opencapture 135
  char 5e
  closecapture 135 0
  catch __TERM_3760
  char 3d
  failtwice
__TERM_3760:
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
  catch __TERM_3856
  char 3d
  failtwice
__TERM_3856:
  ret
-- Rule
RSHIFT:
  call __prefix
  opencapture 143
  char 3e
  char 3e
  closecapture 143 0
  catch __TERM_3874
  char 3d
  failtwice
__TERM_3874:
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

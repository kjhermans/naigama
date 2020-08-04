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
  call FUNCDECL
  commit __LEFTHAND_77
__RIGHTHAND_76:
  call RULE
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
  opencapture 0
  call IDENT
  closecapture 0 0
  call LEFTARROW
  call EXPRESSION
  ret
-- Rule
EXPRESSION:
  call __prefix
  catch __RIGHTHAND_120
  opencapture 1
  call TERMS
  closecapture 1 0
  call OR
  call NOTHING
  commit __LEFTHAND_121
__RIGHTHAND_120:
  catch __RIGHTHAND_146
  opencapture 2
  call TERMS
  closecapture 2 0
  call OR
  call EXPRESSION
  commit __LEFTHAND_147
__RIGHTHAND_146:
  opencapture 3
  call TERMS
  closecapture 3 0
__LEFTHAND_147:
__LEFTHAND_121:
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 4
  call TERM
  closecapture 4 0
  catch __TERM_188
__TERM_187:
  opencapture 4
  call TERM
  closecapture 4 0
  partialcommit __TERM_187
__TERM_188:
  ret
-- Rule
TERM:
  call __prefix
  catch __TERM_205
  opencapture 5
  catch __RIGHTHAND_208
  call NOT
  commit __LEFTHAND_209
__RIGHTHAND_208:
  call AND
__LEFTHAND_209:
  closecapture 5 0
  commit __TERM_205
__TERM_205:
  call MATCHER
  catch __TERM_231
  opencapture 6
  call QUANTIFIER
  closecapture 6 0
  commit __TERM_231
__TERM_231:
  ret
-- Rule
QUANTIFIER:
  call __prefix
  catch __RIGHTHAND_240
  char 3f
  commit __LEFTHAND_241
__RIGHTHAND_240:
  catch __RIGHTHAND_248
  char 2b
  commit __LEFTHAND_249
__RIGHTHAND_248:
  catch __RIGHTHAND_256
  char 2a
  commit __LEFTHAND_257
__RIGHTHAND_256:
  catch __RIGHTHAND_264
  char 5e
  opencapture 7
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_282
__TERM_281:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_281
__TERM_282:
  closecapture 7 0
  char 2d
  opencapture 8
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_300
__TERM_299:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_299
__TERM_300:
  closecapture 8 0
  commit __LEFTHAND_265
__RIGHTHAND_264:
  catch __RIGHTHAND_302
  char 5e
  char 2d
  opencapture 9
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_326
__TERM_325:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_325
__TERM_326:
  closecapture 9 0
  commit __LEFTHAND_303
__RIGHTHAND_302:
  catch __RIGHTHAND_328
  char 5e
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_346
__TERM_345:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_345
__TERM_346:
  closecapture 10 0
  char 2d
  commit __LEFTHAND_329
__RIGHTHAND_328:
  catch __RIGHTHAND_354
  char 5e
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_372
__TERM_371:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_371
__TERM_372:
  closecapture 11 0
  commit __LEFTHAND_355
__RIGHTHAND_354:
  char 5e
  char 24
  opencapture 12
  call IDENT
  closecapture 12 0
__LEFTHAND_355:
__LEFTHAND_329:
__LEFTHAND_303:
__LEFTHAND_265:
__LEFTHAND_257:
__LEFTHAND_249:
__LEFTHAND_241:
  ret
-- Rule
MATCHER:
  call __prefix
  catch __RIGHTHAND_392
  opencapture 13
  call ANY
  closecapture 13 0
  commit __LEFTHAND_393
__RIGHTHAND_392:
  catch __RIGHTHAND_406
  opencapture 14
  call SET
  closecapture 14 0
  commit __LEFTHAND_407
__RIGHTHAND_406:
  catch __RIGHTHAND_420
  opencapture 15
  call STRING
  closecapture 15 0
  commit __LEFTHAND_421
__RIGHTHAND_420:
  catch __RIGHTHAND_434
  opencapture 16
  call BITMASK
  closecapture 16 0
  commit __LEFTHAND_435
__RIGHTHAND_434:
  catch __RIGHTHAND_448
  opencapture 17
  call HEXLITERAL
  closecapture 17 0
  commit __LEFTHAND_449
__RIGHTHAND_448:
  catch __RIGHTHAND_462
  opencapture 18
  call VARCAPTURE
  closecapture 18 0
  commit __LEFTHAND_463
__RIGHTHAND_462:
  catch __RIGHTHAND_476
  opencapture 19
  call CAPTURE
  closecapture 19 0
  commit __LEFTHAND_477
__RIGHTHAND_476:
  catch __RIGHTHAND_490
  opencapture 20
  call GROUP
  closecapture 20 0
  commit __LEFTHAND_491
__RIGHTHAND_490:
  catch __RIGHTHAND_504
  opencapture 21
  call MACRO
  closecapture 21 0
  commit __LEFTHAND_505
__RIGHTHAND_504:
  catch __RIGHTHAND_518
  opencapture 22
  call VARREFERENCE
  closecapture 22 0
  commit __LEFTHAND_519
__RIGHTHAND_518:
  opencapture 23
  call REFERENCE
  closecapture 23 0
__LEFTHAND_519:
__LEFTHAND_505:
__LEFTHAND_491:
__LEFTHAND_477:
__LEFTHAND_463:
__LEFTHAND_449:
__LEFTHAND_435:
__LEFTHAND_421:
__LEFTHAND_407:
__LEFTHAND_393:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__TERM_552:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_552
  char 7c
  counter 1 2
__TERM_564:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __TERM_564
  char 7c
  ret
-- Rule
VARCAPTURE:
  call __prefix
  call CBOPEN
  call COLON
  opencapture 24
  call IDENT
  closecapture 24 0
  catch __TERM_601
  opencapture 25
  call CAPTURETYPE
  closecapture 25 0
  commit __TERM_601
__TERM_601:
  call COLON
  call EXPRESSION
  opencapture 26
  call CBCLOSE
  closecapture 26 0
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
  opencapture 27
  catch __RIGHTHAND_658
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_659
__RIGHTHAND_658:
  quad 696e7433
  char 32
__LEFTHAND_659:
  closecapture 27 0
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  opencapture 28
  call CBCLOSE
  closecapture 28 0
  call CAPTUREEND
  ret
-- Rule
GROUP:
  call __prefix
  call BOPEN
  call EXPRESSION
  opencapture 29
  call BCLOSE
  closecapture 29 0
  ret
-- Rule
CAPTUREEND:
  call __prefix
  catch __TERM_729
  catch __RIGHTHAND_732
  call REPLACE
  commit __LEFTHAND_733
__RIGHTHAND_732:
  call RECYCLE
__LEFTHAND_733:
  commit __TERM_729
__TERM_729:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 30
  catch __TERM_761
  call SETNOT
  commit __TERM_761
__TERM_761:
  closecapture 30 0
  catch __RIGHTHAND_770
  opencapture 31
  catch __RIGHTHAND_778
  char 5c
  catch __RIGHTHAND_792
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_793
__RIGHTHAND_792:
  counter 2 3
__TERM_802:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_802
__LEFTHAND_793:
  commit __LEFTHAND_779
__RIGHTHAND_778:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_779:
  closecapture 31 0
  char 2d
  opencapture 32
  catch __RIGHTHAND_824
  char 5c
  catch __RIGHTHAND_838
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_839
__RIGHTHAND_838:
  counter 2 3
__TERM_848:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_848
__LEFTHAND_839:
  commit __LEFTHAND_825
__RIGHTHAND_824:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_825:
  closecapture 32 0
  commit __LEFTHAND_771
__RIGHTHAND_770:
  opencapture 33
  catch __RIGHTHAND_864
  char 5c
  catch __RIGHTHAND_878
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_879
__RIGHTHAND_878:
  counter 2 3
__TERM_888:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_888
__LEFTHAND_879:
  commit __LEFTHAND_865
__RIGHTHAND_864:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_865:
  closecapture 33 0
__LEFTHAND_771:
  catch __TERM_768
__TERM_767:
  catch __RIGHTHAND_898
  opencapture 31
  catch __RIGHTHAND_906
  char 5c
  catch __RIGHTHAND_920
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_921
__RIGHTHAND_920:
  counter 2 3
__TERM_930:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_930
__LEFTHAND_921:
  commit __LEFTHAND_907
__RIGHTHAND_906:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_907:
  closecapture 31 0
  char 2d
  opencapture 32
  catch __RIGHTHAND_952
  char 5c
  catch __RIGHTHAND_966
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_967
__RIGHTHAND_966:
  counter 2 3
__TERM_976:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_976
__LEFTHAND_967:
  commit __LEFTHAND_953
__RIGHTHAND_952:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_953:
  closecapture 32 0
  commit __LEFTHAND_899
__RIGHTHAND_898:
  opencapture 33
  catch __RIGHTHAND_992
  char 5c
  catch __RIGHTHAND_1006
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1007
__RIGHTHAND_1006:
  counter 2 3
__TERM_1016:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_1016
__LEFTHAND_1007:
  commit __LEFTHAND_993
__RIGHTHAND_992:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_993:
  closecapture 33 0
__LEFTHAND_899:
  partialcommit __TERM_767
__TERM_768:
  opencapture 34
  call ABCLOSE
  closecapture 34 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1050
  opencapture 35
  call IDENT
  closecapture 35 0
  commit __LEFTHAND_1051
__RIGHTHAND_1050:
  opencapture 36
  call NUMBER
  closecapture 36 0
__LEFTHAND_1051:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1082
  call LEFTARROW
  failtwice
__TERM_1082:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 37
  call REPLACETERMS
  closecapture 37 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __TERM_1116
__TERM_1115:
  call REPLACETERM
  partialcommit __TERM_1115
__TERM_1116:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1118
  opencapture 38
  call STRINGLITERAL
  closecapture 38 0
  commit __LEFTHAND_1119
__RIGHTHAND_1118:
  catch __RIGHTHAND_1132
  opencapture 39
  call HEXLITERAL
  closecapture 39 0
  commit __LEFTHAND_1133
__RIGHTHAND_1132:
  opencapture 40
  call VARREFERENCE
  closecapture 40 0
__LEFTHAND_1133:
__LEFTHAND_1119:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 41
  call IDENT
  closecapture 41 0
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
  catch __TERM_1222
__TERM_1221:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1221
__TERM_1222:
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 2 2
__TERM_1232:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 2 __TERM_1232
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1240
__TERM_1239:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1239
__TERM_1240:
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1251
  char 69
  commit __TERM_1251
__TERM_1251:
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
  call IDENT
  call FUNCPARAMDECL
  call FUNCBODY
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  opencapture 42
  catch __TERM_1323
  call IDENT
  catch __TERM_1336
__TERM_1335:
  call COMMA
  call IDENT
  partialcommit __TERM_1335
__TERM_1336:
  commit __TERM_1323
__TERM_1323:
  closecapture 42 0
  call BCLOSE
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  opencapture 43
  catch __TERM_1372
__TERM_1371:
  call LOWSTMT
  partialcommit __TERM_1371
__TERM_1372:
  closecapture 43 0
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1380
  opencapture 44
  call ST_IF
  closecapture 44 0
  commit __LEFTHAND_1381
__RIGHTHAND_1380:
  catch __RIGHTHAND_1394
  opencapture 45
  call ST_WHILE
  closecapture 45 0
  commit __LEFTHAND_1395
__RIGHTHAND_1394:
  catch __RIGHTHAND_1408
  opencapture 46
  call ST_RETURN
  closecapture 46 0
  commit __LEFTHAND_1409
__RIGHTHAND_1408:
  catch __RIGHTHAND_1422
  opencapture 47
  call ST_OTHER
  closecapture 47 0
  commit __LEFTHAND_1423
__RIGHTHAND_1422:
  catch __RIGHTHAND_1436
  opencapture 48
  call VARDECL
  closecapture 48 0
  commit __LEFTHAND_1437
__RIGHTHAND_1436:
  catch __RIGHTHAND_1450
  opencapture 49
  call ASSIGNMENT
  closecapture 49 0
  commit __LEFTHAND_1451
__RIGHTHAND_1450:
  catch __TERM_1467
  call SCR_EXPRESSION
  commit __TERM_1467
__TERM_1467:
  call SEMICOLON
__LEFTHAND_1451:
__LEFTHAND_1437:
__LEFTHAND_1423:
__LEFTHAND_1409:
__LEFTHAND_1395:
__LEFTHAND_1381:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 50
  call SCR_EXPRESSION
  closecapture 50 0
  call BCLOSE
  call CBOPEN
  opencapture 51
  catch __TERM_1528
__TERM_1527:
  call LOWSTMT
  partialcommit __TERM_1527
__TERM_1528:
  closecapture 51 0
  call CBCLOSE
  opencapture 52
  catch __TERM_1546
__TERM_1545:
  call IF_ELSEIF
  partialcommit __TERM_1545
__TERM_1546:
  closecapture 52 0
  opencapture 53
  catch __TERM_1557
  call IF_ELSE
  commit __TERM_1557
__TERM_1557:
  closecapture 53 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 54
  call SCR_EXPRESSION
  closecapture 54 0
  call BCLOSE
  call CBOPEN
  opencapture 55
  catch __TERM_1606
__TERM_1605:
  call LOWSTMT
  partialcommit __TERM_1605
__TERM_1606:
  closecapture 55 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 56
  catch __TERM_1636
__TERM_1635:
  call LOWSTMT
  partialcommit __TERM_1635
__TERM_1636:
  closecapture 56 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 57
  call SCR_EXPRESSION
  closecapture 57 0
  call BCLOSE
  call CBOPEN
  opencapture 58
  catch __TERM_1690
__TERM_1689:
  call LOWSTMT
  partialcommit __TERM_1689
__TERM_1690:
  closecapture 58 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 59
  catch __TERM_1713
  call SCR_EXPRESSION
  commit __TERM_1713
__TERM_1713:
  closecapture 59 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1728
  call KW_BREAK
  commit __LEFTHAND_1729
__RIGHTHAND_1728:
  call KW_CONTINUE
__LEFTHAND_1729:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1769
  call ASSIGN
  opencapture 60
  call SCR_EXPRESSION
  closecapture 60 0
  commit __TERM_1769
__TERM_1769:
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
SCR_EXPRESSION:
  call __prefix
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  opencapture 61
  call BINOP_P11
  closecapture 61 0
  catch __TERM_1842
__TERM_1841:
  call LOGOR
  call BINOP_P11
  partialcommit __TERM_1841
__TERM_1842:
  ret
-- Rule
BINOP_P11:
  call __prefix
  opencapture 62
  call BINOP_P10
  closecapture 62 0
  catch __TERM_1872
__TERM_1871:
  call LOGAND
  call BINOP_P10
  partialcommit __TERM_1871
__TERM_1872:
  ret
-- Rule
BINOP_P10:
  call __prefix
  opencapture 63
  call BINOP_P09
  closecapture 63 0
  catch __TERM_1902
__TERM_1901:
  call BITOR
  call BINOP_P09
  partialcommit __TERM_1901
__TERM_1902:
  ret
-- Rule
BINOP_P09:
  call __prefix
  opencapture 64
  call BINOP_P08
  closecapture 64 0
  catch __TERM_1932
__TERM_1931:
  call BITXOR
  call BINOP_P08
  partialcommit __TERM_1931
__TERM_1932:
  ret
-- Rule
BINOP_P08:
  call __prefix
  opencapture 65
  call BINOP_P07
  closecapture 65 0
  catch __TERM_1962
__TERM_1961:
  call BITAND
  call BINOP_P07
  partialcommit __TERM_1961
__TERM_1962:
  ret
-- Rule
BINOP_P07:
  call __prefix
  opencapture 66
  call BINOP_P06
  closecapture 66 0
  catch __TERM_1992
__TERM_1991:
  catch __RIGHTHAND_2000
  call EQUALS
  commit __LEFTHAND_2001
__RIGHTHAND_2000:
  call NEQUALS
__LEFTHAND_2001:
  call BINOP_P06
  partialcommit __TERM_1991
__TERM_1992:
  ret
-- Rule
BINOP_P06:
  call __prefix
  opencapture 67
  call BINOP_P05
  closecapture 67 0
  catch __TERM_2036
__TERM_2035:
  catch __RIGHTHAND_2044
  call LTEQ
  commit __LEFTHAND_2045
__RIGHTHAND_2044:
  catch __RIGHTHAND_2052
  call LT
  commit __LEFTHAND_2053
__RIGHTHAND_2052:
  catch __RIGHTHAND_2060
  call GTEQ
  commit __LEFTHAND_2061
__RIGHTHAND_2060:
  call GT
__LEFTHAND_2061:
__LEFTHAND_2053:
__LEFTHAND_2045:
  call BINOP_P05
  partialcommit __TERM_2035
__TERM_2036:
  ret
-- Rule
BINOP_P05:
  call __prefix
  opencapture 68
  call BINOP_P04
  closecapture 68 0
  catch __TERM_2096
__TERM_2095:
  catch __RIGHTHAND_2104
  call LSHIFT
  commit __LEFTHAND_2105
__RIGHTHAND_2104:
  call RSHIFT
__LEFTHAND_2105:
  call BINOP_P04
  partialcommit __TERM_2095
__TERM_2096:
  ret
-- Rule
BINOP_P04:
  call __prefix
  opencapture 69
  call BINOP_P03
  closecapture 69 0
  catch __TERM_2140
__TERM_2139:
  catch __RIGHTHAND_2148
  call ADD
  commit __LEFTHAND_2149
__RIGHTHAND_2148:
  call SUB
__LEFTHAND_2149:
  call BINOP_P03
  partialcommit __TERM_2139
__TERM_2140:
  ret
-- Rule
BINOP_P03:
  call __prefix
  opencapture 70
  call UNARIES
  closecapture 70 0
  catch __TERM_2184
__TERM_2183:
  catch __RIGHTHAND_2192
  call MUL
  commit __LEFTHAND_2193
__RIGHTHAND_2192:
  catch __RIGHTHAND_2200
  call DIV
  commit __LEFTHAND_2201
__RIGHTHAND_2200:
  call POW
__LEFTHAND_2201:
__LEFTHAND_2193:
  call UNARIES
  partialcommit __TERM_2183
__TERM_2184:
  ret
-- Rule
UNARIES:
  call __prefix
  catch __TERM_2224
__TERM_2223:
  opencapture 71
  call UNARY
  closecapture 71 0
  partialcommit __TERM_2223
__TERM_2224:
  opencapture 72
  call SCR_TERM
  closecapture 72 0
  ret
-- Rule
UNARY:
  call __prefix
  opencapture 73
  catch __RIGHTHAND_2250
  call LOGNOT
  commit __LEFTHAND_2251
__RIGHTHAND_2250:
  catch __RIGHTHAND_2258
  call BITNOT
  commit __LEFTHAND_2259
__RIGHTHAND_2258:
  catch __RIGHTHAND_2266
  call INC
  commit __LEFTHAND_2267
__RIGHTHAND_2266:
  call DEC
__LEFTHAND_2267:
__LEFTHAND_2259:
__LEFTHAND_2251:
  closecapture 73 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2280
  opencapture 74
  call LITERAL
  closecapture 74 0
  commit __LEFTHAND_2281
__RIGHTHAND_2280:
  catch __RIGHTHAND_2294
  opencapture 75
  call FUNCTIONCALL
  closecapture 75 0
  commit __LEFTHAND_2295
__RIGHTHAND_2294:
  catch __RIGHTHAND_2308
  opencapture 76
  call SCR_REFERENCE
  closecapture 76 0
  commit __LEFTHAND_2309
__RIGHTHAND_2308:
  opencapture 77
  call BOPEN
  opencapture 78
  call SCR_EXPRESSION
  closecapture 78 0
  call BCLOSE
  closecapture 77 0
__LEFTHAND_2309:
__LEFTHAND_2295:
__LEFTHAND_2281:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 79
  call SCR_REFERENCE
  closecapture 79 0
  call BOPEN
  catch __TERM_2373
  call SCR_EXPRESSION
  catch __TERM_2386
__TERM_2385:
  call COMMA
  call SCR_EXPRESSION
  partialcommit __TERM_2385
__TERM_2386:
  commit __TERM_2373
__TERM_2373:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_2416
__TERM_2415:
  call DOT
  call IDENT
  partialcommit __TERM_2415
__TERM_2416:
  catch __TERM_2434
__TERM_2433:
  call INDEX
  partialcommit __TERM_2433
__TERM_2434:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 80
  call SCR_EXPRESSION
  closecapture 80 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_2460
  call STRINGLITERAL
  commit __LEFTHAND_2461
__RIGHTHAND_2460:
  catch __RIGHTHAND_2468
  call HASHLITERAL
  commit __LEFTHAND_2469
__RIGHTHAND_2468:
  catch __RIGHTHAND_2476
  call LISTLITERAL
  commit __LEFTHAND_2477
__RIGHTHAND_2476:
  catch __RIGHTHAND_2484
  call FLOATLITERAL
  commit __LEFTHAND_2485
__RIGHTHAND_2484:
  catch __RIGHTHAND_2492
  call INTLITERAL
  commit __LEFTHAND_2493
__RIGHTHAND_2492:
  call BOOLEANLITERAL
__LEFTHAND_2493:
__LEFTHAND_2485:
__LEFTHAND_2477:
__LEFTHAND_2469:
__LEFTHAND_2461:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 81
  catch __TERM_2522
__TERM_2521:
  catch __RIGHTHAND_2524
  char 5c
  catch __RIGHTHAND_2538
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_2539
__RIGHTHAND_2538:
  counter 3 3
__TERM_2548:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __TERM_2548
__LEFTHAND_2539:
  commit __LEFTHAND_2525
__RIGHTHAND_2524:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_2525:
  partialcommit __TERM_2521
__TERM_2522:
  closecapture 81 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 82
  call CBOPEN
  catch __TERM_2579
  call HASHELT
  catch __TERM_2592
__TERM_2591:
  call COMMA
  call HASHELT
  partialcommit __TERM_2591
__TERM_2592:
  commit __TERM_2579
__TERM_2579:
  call CBCLOSE
  closecapture 82 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 83
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 83 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 84
  call SCR_TERM
  closecapture 84 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 85
  call SCR_TERM
  closecapture 85 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 86
  call ABOPEN
  catch __TERM_2675
  call LISTELT
  catch __TERM_2688
__TERM_2687:
  call COMMA
  call LISTELT
  partialcommit __TERM_2687
__TERM_2688:
  commit __TERM_2675
__TERM_2675:
  call ABCLOSE
  closecapture 86 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 87
  call SCR_TERM
  closecapture 87 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 88
  catch __TERM_2730
__TERM_2729:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2729
__TERM_2730:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2742
__TERM_2741:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2741
__TERM_2742:
  closecapture 88 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 89
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2754
__TERM_2753:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2753
__TERM_2754:
  closecapture 89 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 90
  catch __RIGHTHAND_2762
  quad 74727565
  commit __LEFTHAND_2763
__RIGHTHAND_2762:
  quad 66616c73
  char 65
__LEFTHAND_2763:
  closecapture 90 0
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
  opencapture 91
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_2845
  counter 3 63
__TERM_2846:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_2847
__TERM_2847:
  condjump 3 __TERM_2846
  commit __TERM_2845
__TERM_2845:
  closecapture 91 0
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
ASSIGNS:
  call __prefix
  opencapture 92
  catch __RIGHTHAND_2890
  call ASSIGN
  commit __LEFTHAND_2891
__RIGHTHAND_2890:
  catch __RIGHTHAND_2898
  call PLUSIS
  commit __LEFTHAND_2899
__RIGHTHAND_2898:
  catch __RIGHTHAND_2906
  call MINIS
  commit __LEFTHAND_2907
__RIGHTHAND_2906:
  catch __RIGHTHAND_2914
  call MULIS
  commit __LEFTHAND_2915
__RIGHTHAND_2914:
  catch __RIGHTHAND_2922
  call DIVIS
  commit __LEFTHAND_2923
__RIGHTHAND_2922:
  catch __RIGHTHAND_2930
  call BITANDIS
  commit __LEFTHAND_2931
__RIGHTHAND_2930:
  catch __RIGHTHAND_2938
  call BITORIS
  commit __LEFTHAND_2939
__RIGHTHAND_2938:
  catch __RIGHTHAND_2946
  call BITXORIS
  commit __LEFTHAND_2947
__RIGHTHAND_2946:
  catch __RIGHTHAND_2954
  call BITNOTIS
  commit __LEFTHAND_2955
__RIGHTHAND_2954:
  catch __RIGHTHAND_2962
  call LSHIFTIS
  commit __LEFTHAND_2963
__RIGHTHAND_2962:
  call RSHIFTIS
__LEFTHAND_2963:
__LEFTHAND_2955:
__LEFTHAND_2947:
__LEFTHAND_2939:
__LEFTHAND_2931:
__LEFTHAND_2923:
__LEFTHAND_2915:
__LEFTHAND_2907:
__LEFTHAND_2899:
__LEFTHAND_2891:
  closecapture 92 0
  ret
-- Rule
ASSIGN:
  call __prefix
  char 3d
  ret
-- Rule
PLUSIS:
  call __prefix
  char 2b
  char 3d
  ret
-- Rule
MINIS:
  call __prefix
  char 2d
  char 3d
  ret
-- Rule
MULIS:
  call __prefix
  char 2a
  char 3d
  ret
-- Rule
DIVIS:
  call __prefix
  char 2f
  char 3d
  ret
-- Rule
EQUALS:
  call __prefix
  char 3d
  char 3d
  ret
-- Rule
NEQUALS:
  call __prefix
  char 21
  char 3d
  ret
-- Rule
LT:
  call __prefix
  char 3c
  catch __TERM_3024
  char 3d
  failtwice
__TERM_3024:
  ret
-- Rule
GT:
  call __prefix
  char 3e
  catch __TERM_3036
  char 3d
  failtwice
__TERM_3036:
  ret
-- Rule
LTEQ:
  call __prefix
  char 3c
  char 3d
  ret
-- Rule
GTEQ:
  call __prefix
  char 3e
  char 3d
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
  char 2a
  char 2a
  ret
-- Rule
MUL:
  call __prefix
  char 2a
  catch __TERM_3078
  char 2a
  failtwice
__TERM_3078:
  ret
-- Rule
DIV:
  call __prefix
  char 2f
  catch __TERM_3090
  char 3d
  failtwice
__TERM_3090:
  ret
-- Rule
ADD:
  call __prefix
  char 2b
  catch __TERM_3102
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3102:
  ret
-- Rule
SUB:
  call __prefix
  char 2d
  catch __TERM_3114
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3114:
  ret
-- Rule
INC:
  call __prefix
  char 2b
  char 2b
  ret
-- Rule
DEC:
  call __prefix
  char 2d
  char 2d
  ret
-- Rule
LOGAND:
  call __prefix
  char 26
  char 26
  ret
-- Rule
LOGOR:
  call __prefix
  char 7c
  char 7c
  ret
-- Rule
LOGNOT:
  call __prefix
  char 21
  catch __TERM_3150
  char 3d
  failtwice
__TERM_3150:
  ret
-- Rule
BITAND:
  call __prefix
  char 26
  catch __TERM_3162
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3162:
  ret
-- Rule
BITOR:
  call __prefix
  char 7c
  catch __TERM_3174
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3174:
  ret
-- Rule
BITXOR:
  call __prefix
  char 5e
  catch __TERM_3186
  char 3d
  failtwice
__TERM_3186:
  ret
-- Rule
BITNOT:
  call __prefix
  char 7e
  ret
-- Rule
BITANDIS:
  call __prefix
  char 26
  char 3d
  ret
-- Rule
BITORIS:
  call __prefix
  char 7c
  char 3d
  ret
-- Rule
BITXORIS:
  call __prefix
  char 5e
  char 3d
  ret
-- Rule
BITNOTIS:
  call __prefix
  char 7e
  char 3d
  ret
-- Rule
COMMA:
  call __prefix
  char 2c
  ret
-- Rule
DOT:
  call __prefix
  char 2e
  ret
-- Rule
LSHIFT:
  call __prefix
  char 3c
  char 3c
  catch __TERM_3240
  char 3d
  failtwice
__TERM_3240:
  ret
-- Rule
RSHIFT:
  call __prefix
  char 3e
  char 3e
  catch __TERM_3252
  char 3d
  failtwice
__TERM_3252:
  ret
-- Rule
LSHIFTIS:
  call __prefix
  char 3c
  char 3c
  char 3d
  ret
-- Rule
RSHIFTIS:
  call __prefix
  char 3e
  char 3e
  char 3d
  ret

  end 0

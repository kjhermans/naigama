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
  call SEMICOLON
  ret
-- Rule
EXPRESSION:
  call __prefix
  catch __RIGHTHAND_126
  opencapture 1
  call TERMS
  closecapture 1 0
  call OR
  call NOTHING
  commit __LEFTHAND_127
__RIGHTHAND_126:
  catch __RIGHTHAND_152
  opencapture 2
  call TERMS
  closecapture 2 0
  call OR
  call EXPRESSION
  commit __LEFTHAND_153
__RIGHTHAND_152:
  opencapture 3
  call TERMS
  closecapture 3 0
__LEFTHAND_153:
__LEFTHAND_127:
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 4
  call TERM
  closecapture 4 0
  catch __TERM_194
__TERM_193:
  opencapture 4
  call TERM
  closecapture 4 0
  partialcommit __TERM_193
__TERM_194:
  ret
-- Rule
TERM:
  call __prefix
  opencapture 5
  call ENDOWEDMATCHER
  closecapture 5 0
  ret
-- Rule
ENDOWEDMATCHER:
  call __prefix
  catch __TERM_223
  opencapture 6
  catch __RIGHTHAND_226
  call NOT
  commit __LEFTHAND_227
__RIGHTHAND_226:
  call AND
__LEFTHAND_227:
  closecapture 6 0
  commit __TERM_223
__TERM_223:
  call MATCHER
  catch __TERM_249
  opencapture 7
  call QUANTIFIER
  closecapture 7 0
  commit __TERM_249
__TERM_249:
  ret
-- Rule
QUANTIFIER:
  call __prefix
  catch __RIGHTHAND_258
  char 3f
  commit __LEFTHAND_259
__RIGHTHAND_258:
  catch __RIGHTHAND_266
  char 2b
  commit __LEFTHAND_267
__RIGHTHAND_266:
  catch __RIGHTHAND_274
  char 2a
  commit __LEFTHAND_275
__RIGHTHAND_274:
  catch __RIGHTHAND_282
  char 5e
  opencapture 8
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_300
__TERM_299:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_299
__TERM_300:
  closecapture 8 0
  char 2d
  opencapture 9
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_318
__TERM_317:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_317
__TERM_318:
  closecapture 9 0
  commit __LEFTHAND_283
__RIGHTHAND_282:
  catch __RIGHTHAND_320
  char 5e
  char 2d
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_344
__TERM_343:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_343
__TERM_344:
  closecapture 10 0
  commit __LEFTHAND_321
__RIGHTHAND_320:
  catch __RIGHTHAND_346
  char 5e
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_364
__TERM_363:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_363
__TERM_364:
  closecapture 11 0
  char 2d
  commit __LEFTHAND_347
__RIGHTHAND_346:
  catch __RIGHTHAND_372
  char 5e
  opencapture 12
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_390
__TERM_389:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_389
__TERM_390:
  closecapture 12 0
  commit __LEFTHAND_373
__RIGHTHAND_372:
  char 5e
  char 24
  opencapture 13
  call IDENT
  closecapture 13 0
__LEFTHAND_373:
__LEFTHAND_347:
__LEFTHAND_321:
__LEFTHAND_283:
__LEFTHAND_275:
__LEFTHAND_267:
__LEFTHAND_259:
  ret
-- Rule
MATCHER:
  call __prefix
  catch __RIGHTHAND_410
  opencapture 14
  call ANY
  closecapture 14 0
  commit __LEFTHAND_411
__RIGHTHAND_410:
  catch __RIGHTHAND_424
  opencapture 15
  call SET
  closecapture 15 0
  commit __LEFTHAND_425
__RIGHTHAND_424:
  catch __RIGHTHAND_438
  opencapture 16
  call STRING
  closecapture 16 0
  commit __LEFTHAND_439
__RIGHTHAND_438:
  catch __RIGHTHAND_452
  opencapture 17
  call BITMASK
  closecapture 17 0
  commit __LEFTHAND_453
__RIGHTHAND_452:
  catch __RIGHTHAND_466
  opencapture 18
  call HEXLITERAL
  closecapture 18 0
  commit __LEFTHAND_467
__RIGHTHAND_466:
  catch __RIGHTHAND_480
  opencapture 19
  call VARCAPTURE
  closecapture 19 0
  commit __LEFTHAND_481
__RIGHTHAND_480:
  catch __RIGHTHAND_494
  opencapture 20
  call CAPTURE
  closecapture 20 0
  commit __LEFTHAND_495
__RIGHTHAND_494:
  catch __RIGHTHAND_508
  opencapture 21
  call GROUP
  closecapture 21 0
  commit __LEFTHAND_509
__RIGHTHAND_508:
  catch __RIGHTHAND_522
  opencapture 22
  call MACRO
  closecapture 22 0
  commit __LEFTHAND_523
__RIGHTHAND_522:
  catch __RIGHTHAND_536
  opencapture 23
  call VARREFERENCE
  closecapture 23 0
  commit __LEFTHAND_537
__RIGHTHAND_536:
  opencapture 24
  call REFERENCE
  closecapture 24 0
__LEFTHAND_537:
__LEFTHAND_523:
__LEFTHAND_509:
__LEFTHAND_495:
__LEFTHAND_481:
__LEFTHAND_467:
__LEFTHAND_453:
__LEFTHAND_439:
__LEFTHAND_425:
__LEFTHAND_411:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__TERM_570:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_570
  char 7c
  counter 1 2
__TERM_582:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __TERM_582
  char 7c
  ret
-- Rule
VARCAPTURE:
  call __prefix
  call CBOPEN
  call COLON
  opencapture 25
  call IDENT
  closecapture 25 0
  catch __TERM_619
  opencapture 26
  call CAPTURETYPE
  closecapture 26 0
  commit __TERM_619
__TERM_619:
  call COLON
  call EXPRESSION
  opencapture 27
  call CBCLOSE
  closecapture 27 0
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
  opencapture 28
  catch __RIGHTHAND_676
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_677
__RIGHTHAND_676:
  quad 696e7433
  char 32
__LEFTHAND_677:
  closecapture 28 0
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  opencapture 29
  call CBCLOSE
  closecapture 29 0
  call CAPTUREEND
  ret
-- Rule
GROUP:
  call __prefix
  call BOPEN
  call EXPRESSION
  opencapture 30
  call BCLOSE
  closecapture 30 0
  ret
-- Rule
CAPTUREEND:
  call __prefix
  catch __TERM_747
  catch __RIGHTHAND_750
  call REPLACE
  commit __LEFTHAND_751
__RIGHTHAND_750:
  call RECYCLE
__LEFTHAND_751:
  commit __TERM_747
__TERM_747:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 31
  catch __TERM_779
  call SETNOT
  commit __TERM_779
__TERM_779:
  closecapture 31 0
  catch __RIGHTHAND_788
  opencapture 32
  catch __RIGHTHAND_796
  char 5c
  catch __RIGHTHAND_810
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_811
__RIGHTHAND_810:
  counter 2 3
__TERM_820:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_820
__LEFTHAND_811:
  commit __LEFTHAND_797
__RIGHTHAND_796:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_797:
  closecapture 32 0
  char 2d
  opencapture 33
  catch __RIGHTHAND_842
  char 5c
  catch __RIGHTHAND_856
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_857
__RIGHTHAND_856:
  counter 2 3
__TERM_866:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_866
__LEFTHAND_857:
  commit __LEFTHAND_843
__RIGHTHAND_842:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_843:
  closecapture 33 0
  commit __LEFTHAND_789
__RIGHTHAND_788:
  opencapture 34
  catch __RIGHTHAND_882
  char 5c
  catch __RIGHTHAND_896
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_897
__RIGHTHAND_896:
  counter 2 3
__TERM_906:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_906
__LEFTHAND_897:
  commit __LEFTHAND_883
__RIGHTHAND_882:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_883:
  closecapture 34 0
__LEFTHAND_789:
  catch __TERM_786
__TERM_785:
  catch __RIGHTHAND_916
  opencapture 32
  catch __RIGHTHAND_924
  char 5c
  catch __RIGHTHAND_938
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_939
__RIGHTHAND_938:
  counter 2 3
__TERM_948:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_948
__LEFTHAND_939:
  commit __LEFTHAND_925
__RIGHTHAND_924:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_925:
  closecapture 32 0
  char 2d
  opencapture 33
  catch __RIGHTHAND_970
  char 5c
  catch __RIGHTHAND_984
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_985
__RIGHTHAND_984:
  counter 2 3
__TERM_994:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_994
__LEFTHAND_985:
  commit __LEFTHAND_971
__RIGHTHAND_970:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_971:
  closecapture 33 0
  commit __LEFTHAND_917
__RIGHTHAND_916:
  opencapture 34
  catch __RIGHTHAND_1010
  char 5c
  catch __RIGHTHAND_1024
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1025
__RIGHTHAND_1024:
  counter 2 3
__TERM_1034:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_1034
__LEFTHAND_1025:
  commit __LEFTHAND_1011
__RIGHTHAND_1010:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1011:
  closecapture 34 0
__LEFTHAND_917:
  partialcommit __TERM_785
__TERM_786:
  opencapture 35
  call ABCLOSE
  closecapture 35 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1068
  opencapture 36
  call IDENT
  closecapture 36 0
  commit __LEFTHAND_1069
__RIGHTHAND_1068:
  opencapture 37
  call NUMBER
  closecapture 37 0
__LEFTHAND_1069:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1100
  call LEFTARROW
  failtwice
__TERM_1100:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 38
  call REPLACETERMS
  closecapture 38 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __TERM_1134
__TERM_1133:
  call REPLACETERM
  partialcommit __TERM_1133
__TERM_1134:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1136
  opencapture 39
  call STRINGLITERAL
  closecapture 39 0
  commit __LEFTHAND_1137
__RIGHTHAND_1136:
  catch __RIGHTHAND_1150
  opencapture 40
  call HEXLITERAL
  closecapture 40 0
  commit __LEFTHAND_1151
__RIGHTHAND_1150:
  opencapture 41
  call VARREFERENCE
  closecapture 41 0
__LEFTHAND_1151:
__LEFTHAND_1137:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 42
  call IDENT
  closecapture 42 0
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
  catch __TERM_1240
__TERM_1239:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1239
__TERM_1240:
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 2 2
__TERM_1250:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 2 __TERM_1250
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1258
__TERM_1257:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1257
__TERM_1258:
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1269
  char 69
  commit __TERM_1269
__TERM_1269:
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
  opencapture 43
  call IDENT
  closecapture 43 0
  call FUNCPARAMDECL
  call FUNCBODY
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  opencapture 44
  catch __TERM_1347
  call IDENT
  catch __TERM_1360
__TERM_1359:
  call COMMA
  call IDENT
  partialcommit __TERM_1359
__TERM_1360:
  commit __TERM_1347
__TERM_1347:
  closecapture 44 0
  call BCLOSE
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  opencapture 45
  catch __TERM_1396
__TERM_1395:
  call LOWSTMT
  partialcommit __TERM_1395
__TERM_1396:
  closecapture 45 0
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1404
  opencapture 46
  call ST_IF
  closecapture 46 0
  commit __LEFTHAND_1405
__RIGHTHAND_1404:
  catch __RIGHTHAND_1418
  opencapture 47
  call ST_WHILE
  closecapture 47 0
  commit __LEFTHAND_1419
__RIGHTHAND_1418:
  catch __RIGHTHAND_1432
  opencapture 48
  call ST_RETURN
  closecapture 48 0
  commit __LEFTHAND_1433
__RIGHTHAND_1432:
  catch __RIGHTHAND_1446
  opencapture 49
  call ST_OTHER
  closecapture 49 0
  commit __LEFTHAND_1447
__RIGHTHAND_1446:
  catch __RIGHTHAND_1460
  opencapture 50
  call VARDECL
  closecapture 50 0
  commit __LEFTHAND_1461
__RIGHTHAND_1460:
  catch __RIGHTHAND_1474
  opencapture 51
  call ASSIGNMENT
  closecapture 51 0
  commit __LEFTHAND_1475
__RIGHTHAND_1474:
  catch __TERM_1491
  call SCR_EXPRESSION
  commit __TERM_1491
__TERM_1491:
  call SEMICOLON
__LEFTHAND_1475:
__LEFTHAND_1461:
__LEFTHAND_1447:
__LEFTHAND_1433:
__LEFTHAND_1419:
__LEFTHAND_1405:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 52
  call SCR_EXPRESSION
  closecapture 52 0
  call BCLOSE
  call CBOPEN
  opencapture 53
  catch __TERM_1552
__TERM_1551:
  call LOWSTMT
  partialcommit __TERM_1551
__TERM_1552:
  closecapture 53 0
  call CBCLOSE
  opencapture 54
  catch __TERM_1570
__TERM_1569:
  call IF_ELSEIF
  partialcommit __TERM_1569
__TERM_1570:
  closecapture 54 0
  opencapture 55
  catch __TERM_1581
  call IF_ELSE
  commit __TERM_1581
__TERM_1581:
  closecapture 55 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 56
  call SCR_EXPRESSION
  closecapture 56 0
  call BCLOSE
  call CBOPEN
  opencapture 57
  catch __TERM_1630
__TERM_1629:
  call LOWSTMT
  partialcommit __TERM_1629
__TERM_1630:
  closecapture 57 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 58
  catch __TERM_1660
__TERM_1659:
  call LOWSTMT
  partialcommit __TERM_1659
__TERM_1660:
  closecapture 58 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 59
  call SCR_EXPRESSION
  closecapture 59 0
  call BCLOSE
  call CBOPEN
  opencapture 60
  catch __TERM_1714
__TERM_1713:
  call LOWSTMT
  partialcommit __TERM_1713
__TERM_1714:
  closecapture 60 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 61
  catch __TERM_1737
  call SCR_EXPRESSION
  commit __TERM_1737
__TERM_1737:
  closecapture 61 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1752
  call KW_BREAK
  commit __LEFTHAND_1753
__RIGHTHAND_1752:
  call KW_CONTINUE
__LEFTHAND_1753:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1793
  call ASSIGN
  opencapture 62
  call SCR_EXPRESSION
  closecapture 62 0
  commit __TERM_1793
__TERM_1793:
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
  opencapture 63
  catch __RIGHTHAND_1850
  call ASSIGN
  commit __LEFTHAND_1851
__RIGHTHAND_1850:
  catch __RIGHTHAND_1858
  call PLUSIS
  commit __LEFTHAND_1859
__RIGHTHAND_1858:
  catch __RIGHTHAND_1866
  call MINIS
  commit __LEFTHAND_1867
__RIGHTHAND_1866:
  catch __RIGHTHAND_1874
  call MULIS
  commit __LEFTHAND_1875
__RIGHTHAND_1874:
  catch __RIGHTHAND_1882
  call DIVIS
  commit __LEFTHAND_1883
__RIGHTHAND_1882:
  catch __RIGHTHAND_1890
  call BITANDIS
  commit __LEFTHAND_1891
__RIGHTHAND_1890:
  catch __RIGHTHAND_1898
  call BITORIS
  commit __LEFTHAND_1899
__RIGHTHAND_1898:
  catch __RIGHTHAND_1906
  call BITXORIS
  commit __LEFTHAND_1907
__RIGHTHAND_1906:
  catch __RIGHTHAND_1914
  call BITNOTIS
  commit __LEFTHAND_1915
__RIGHTHAND_1914:
  catch __RIGHTHAND_1922
  call LSHIFTIS
  commit __LEFTHAND_1923
__RIGHTHAND_1922:
  call RSHIFTIS
__LEFTHAND_1923:
__LEFTHAND_1915:
__LEFTHAND_1907:
__LEFTHAND_1899:
__LEFTHAND_1891:
__LEFTHAND_1883:
__LEFTHAND_1875:
__LEFTHAND_1867:
__LEFTHAND_1859:
__LEFTHAND_1851:
  closecapture 63 0
  ret
-- Rule
SCR_EXPRESSION:
  call __prefix
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  opencapture 64
  call BINOP_P11
  closecapture 64 0
  catch __TERM_1958
__TERM_1957:
  call LOGOR
  call BINOP_P11
  partialcommit __TERM_1957
__TERM_1958:
  ret
-- Rule
BINOP_P11:
  call __prefix
  opencapture 65
  call BINOP_P10
  closecapture 65 0
  catch __TERM_1988
__TERM_1987:
  call LOGAND
  call BINOP_P10
  partialcommit __TERM_1987
__TERM_1988:
  ret
-- Rule
BINOP_P10:
  call __prefix
  opencapture 66
  call BINOP_P09
  closecapture 66 0
  catch __TERM_2018
__TERM_2017:
  call BITOR
  call BINOP_P09
  partialcommit __TERM_2017
__TERM_2018:
  ret
-- Rule
BINOP_P09:
  call __prefix
  opencapture 67
  call BINOP_P08
  closecapture 67 0
  catch __TERM_2048
__TERM_2047:
  call BITXOR
  call BINOP_P08
  partialcommit __TERM_2047
__TERM_2048:
  ret
-- Rule
BINOP_P08:
  call __prefix
  opencapture 68
  call BINOP_P07
  closecapture 68 0
  catch __TERM_2078
__TERM_2077:
  call BITAND
  call BINOP_P07
  partialcommit __TERM_2077
__TERM_2078:
  ret
-- Rule
BINOP_P07:
  call __prefix
  opencapture 69
  call BINOP_P06
  closecapture 69 0
  catch __TERM_2108
__TERM_2107:
  catch __RIGHTHAND_2116
  call EQUALS
  commit __LEFTHAND_2117
__RIGHTHAND_2116:
  call NEQUALS
__LEFTHAND_2117:
  call BINOP_P06
  partialcommit __TERM_2107
__TERM_2108:
  ret
-- Rule
BINOP_P06:
  call __prefix
  opencapture 70
  call BINOP_P05
  closecapture 70 0
  catch __TERM_2152
__TERM_2151:
  catch __RIGHTHAND_2160
  call LTEQ
  commit __LEFTHAND_2161
__RIGHTHAND_2160:
  catch __RIGHTHAND_2168
  call LT
  commit __LEFTHAND_2169
__RIGHTHAND_2168:
  catch __RIGHTHAND_2176
  call GTEQ
  commit __LEFTHAND_2177
__RIGHTHAND_2176:
  call GT
__LEFTHAND_2177:
__LEFTHAND_2169:
__LEFTHAND_2161:
  call BINOP_P05
  partialcommit __TERM_2151
__TERM_2152:
  ret
-- Rule
BINOP_P05:
  call __prefix
  opencapture 71
  call BINOP_P04
  closecapture 71 0
  catch __TERM_2212
__TERM_2211:
  catch __RIGHTHAND_2220
  call LSHIFT
  commit __LEFTHAND_2221
__RIGHTHAND_2220:
  call RSHIFT
__LEFTHAND_2221:
  call BINOP_P04
  partialcommit __TERM_2211
__TERM_2212:
  ret
-- Rule
BINOP_P04:
  call __prefix
  opencapture 72
  call BINOP_P03
  closecapture 72 0
  catch __TERM_2256
__TERM_2255:
  catch __RIGHTHAND_2264
  call ADD
  commit __LEFTHAND_2265
__RIGHTHAND_2264:
  call SUB
__LEFTHAND_2265:
  call BINOP_P03
  partialcommit __TERM_2255
__TERM_2256:
  ret
-- Rule
BINOP_P03:
  call __prefix
  opencapture 73
  call UNARIES
  closecapture 73 0
  catch __TERM_2300
__TERM_2299:
  catch __RIGHTHAND_2308
  call MUL
  commit __LEFTHAND_2309
__RIGHTHAND_2308:
  catch __RIGHTHAND_2316
  call DIV
  commit __LEFTHAND_2317
__RIGHTHAND_2316:
  call POW
__LEFTHAND_2317:
__LEFTHAND_2309:
  call UNARIES
  partialcommit __TERM_2299
__TERM_2300:
  ret
-- Rule
UNARIES:
  call __prefix
  catch __TERM_2340
__TERM_2339:
  opencapture 74
  call UNARY
  closecapture 74 0
  partialcommit __TERM_2339
__TERM_2340:
  opencapture 75
  call SCR_TERM
  closecapture 75 0
  ret
-- Rule
UNARY:
  call __prefix
  opencapture 76
  catch __RIGHTHAND_2366
  call LOGNOT
  commit __LEFTHAND_2367
__RIGHTHAND_2366:
  catch __RIGHTHAND_2374
  call BITNOT
  commit __LEFTHAND_2375
__RIGHTHAND_2374:
  catch __RIGHTHAND_2382
  call INC
  commit __LEFTHAND_2383
__RIGHTHAND_2382:
  call DEC
__LEFTHAND_2383:
__LEFTHAND_2375:
__LEFTHAND_2367:
  closecapture 76 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2396
  opencapture 77
  call LITERAL
  closecapture 77 0
  commit __LEFTHAND_2397
__RIGHTHAND_2396:
  catch __RIGHTHAND_2410
  opencapture 78
  call FUNCTIONCALL
  closecapture 78 0
  commit __LEFTHAND_2411
__RIGHTHAND_2410:
  catch __RIGHTHAND_2424
  opencapture 79
  call SCR_REFERENCE
  closecapture 79 0
  commit __LEFTHAND_2425
__RIGHTHAND_2424:
  opencapture 80
  call BOPEN
  opencapture 81
  call SCR_EXPRESSION
  closecapture 81 0
  call BCLOSE
  closecapture 80 0
__LEFTHAND_2425:
__LEFTHAND_2411:
__LEFTHAND_2397:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 82
  call SCR_REFERENCE
  closecapture 82 0
  call BOPEN
  catch __TERM_2489
  call SCR_EXPRESSION
  catch __TERM_2502
__TERM_2501:
  call COMMA
  call SCR_EXPRESSION
  partialcommit __TERM_2501
__TERM_2502:
  commit __TERM_2489
__TERM_2489:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_2532
__TERM_2531:
  call DOT
  call IDENT
  partialcommit __TERM_2531
__TERM_2532:
  catch __TERM_2550
__TERM_2549:
  call INDEX
  partialcommit __TERM_2549
__TERM_2550:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 83
  call SCR_EXPRESSION
  closecapture 83 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_2576
  call STRINGLITERAL
  commit __LEFTHAND_2577
__RIGHTHAND_2576:
  catch __RIGHTHAND_2584
  call HASHLITERAL
  commit __LEFTHAND_2585
__RIGHTHAND_2584:
  catch __RIGHTHAND_2592
  call LISTLITERAL
  commit __LEFTHAND_2593
__RIGHTHAND_2592:
  catch __RIGHTHAND_2600
  call FLOATLITERAL
  commit __LEFTHAND_2601
__RIGHTHAND_2600:
  catch __RIGHTHAND_2608
  call INTLITERAL
  commit __LEFTHAND_2609
__RIGHTHAND_2608:
  call BOOLEANLITERAL
__LEFTHAND_2609:
__LEFTHAND_2601:
__LEFTHAND_2593:
__LEFTHAND_2585:
__LEFTHAND_2577:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 84
  catch __TERM_2638
__TERM_2637:
  catch __RIGHTHAND_2640
  char 5c
  catch __RIGHTHAND_2654
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_2655
__RIGHTHAND_2654:
  counter 3 3
__TERM_2664:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __TERM_2664
__LEFTHAND_2655:
  commit __LEFTHAND_2641
__RIGHTHAND_2640:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_2641:
  partialcommit __TERM_2637
__TERM_2638:
  closecapture 84 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 85
  call CBOPEN
  catch __TERM_2695
  call HASHELT
  catch __TERM_2708
__TERM_2707:
  call COMMA
  call HASHELT
  partialcommit __TERM_2707
__TERM_2708:
  commit __TERM_2695
__TERM_2695:
  call CBCLOSE
  closecapture 85 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 86
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 86 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 87
  call SCR_TERM
  closecapture 87 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 88
  call SCR_TERM
  closecapture 88 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 89
  call ABOPEN
  catch __TERM_2791
  call LISTELT
  catch __TERM_2804
__TERM_2803:
  call COMMA
  call LISTELT
  partialcommit __TERM_2803
__TERM_2804:
  commit __TERM_2791
__TERM_2791:
  call ABCLOSE
  closecapture 89 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 90
  call SCR_TERM
  closecapture 90 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 91
  catch __TERM_2846
__TERM_2845:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2845
__TERM_2846:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2858
__TERM_2857:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2857
__TERM_2858:
  closecapture 91 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 92
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2870
__TERM_2869:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2869
__TERM_2870:
  closecapture 92 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 93
  catch __RIGHTHAND_2878
  quad 74727565
  commit __LEFTHAND_2879
__RIGHTHAND_2878:
  quad 66616c73
  char 65
__LEFTHAND_2879:
  closecapture 93 0
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
  catch __TERM_2955
  counter 3 63
__TERM_2956:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_2957
__TERM_2957:
  condjump 3 __TERM_2956
  commit __TERM_2955
__TERM_2955:
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
  catch __TERM_3042
  char 3d
  failtwice
__TERM_3042:
  ret
-- Rule
GT:
  call __prefix
  char 3e
  catch __TERM_3054
  char 3d
  failtwice
__TERM_3054:
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
  catch __TERM_3096
  char 2a
  failtwice
__TERM_3096:
  ret
-- Rule
DIV:
  call __prefix
  char 2f
  catch __TERM_3108
  char 3d
  failtwice
__TERM_3108:
  ret
-- Rule
ADD:
  call __prefix
  char 2b
  catch __TERM_3120
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3120:
  ret
-- Rule
SUB:
  call __prefix
  char 2d
  catch __TERM_3132
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3132:
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
  catch __TERM_3168
  char 3d
  failtwice
__TERM_3168:
  ret
-- Rule
BITAND:
  call __prefix
  char 26
  catch __TERM_3180
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3180:
  ret
-- Rule
BITOR:
  call __prefix
  char 7c
  catch __TERM_3192
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3192:
  ret
-- Rule
BITXOR:
  call __prefix
  char 5e
  catch __TERM_3204
  char 3d
  failtwice
__TERM_3204:
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
  catch __TERM_3258
  char 3d
  failtwice
__TERM_3258:
  ret
-- Rule
RSHIFT:
  call __prefix
  char 3e
  char 3e
  catch __TERM_3270
  char 3d
  failtwice
__TERM_3270:
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

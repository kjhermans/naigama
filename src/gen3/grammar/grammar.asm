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
  opencapture 44
  call FUNCPARAMDECL
  closecapture 44 0
  opencapture 45
  call FUNCBODY
  closecapture 45 0
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  opencapture 46
  catch __TERM_1359
  opencapture 47
  call IDENT
  closecapture 47 0
  catch __TERM_1378
__TERM_1377:
  call COMMA
  opencapture 48
  call IDENT
  closecapture 48 0
  partialcommit __TERM_1377
__TERM_1378:
  commit __TERM_1359
__TERM_1359:
  closecapture 46 0
  call BCLOSE
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  catch __TERM_1414
__TERM_1413:
  call LOWSTMT
  partialcommit __TERM_1413
__TERM_1414:
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1422
  opencapture 49
  call ST_IF
  closecapture 49 0
  commit __LEFTHAND_1423
__RIGHTHAND_1422:
  catch __RIGHTHAND_1436
  opencapture 50
  call ST_WHILE
  closecapture 50 0
  commit __LEFTHAND_1437
__RIGHTHAND_1436:
  catch __RIGHTHAND_1450
  opencapture 51
  call ST_RETURN
  closecapture 51 0
  commit __LEFTHAND_1451
__RIGHTHAND_1450:
  catch __RIGHTHAND_1464
  opencapture 52
  call ST_OTHER
  closecapture 52 0
  commit __LEFTHAND_1465
__RIGHTHAND_1464:
  catch __RIGHTHAND_1478
  opencapture 53
  call VARDECL
  closecapture 53 0
  commit __LEFTHAND_1479
__RIGHTHAND_1478:
  catch __RIGHTHAND_1492
  opencapture 54
  call ASSIGNMENT
  closecapture 54 0
  commit __LEFTHAND_1493
__RIGHTHAND_1492:
  catch __TERM_1509
  call SCR_EXPRESSION
  commit __TERM_1509
__TERM_1509:
  call SEMICOLON
__LEFTHAND_1493:
__LEFTHAND_1479:
__LEFTHAND_1465:
__LEFTHAND_1451:
__LEFTHAND_1437:
__LEFTHAND_1423:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 55
  call SCR_EXPRESSION
  closecapture 55 0
  call BCLOSE
  call CBOPEN
  opencapture 56
  catch __TERM_1570
__TERM_1569:
  call LOWSTMT
  partialcommit __TERM_1569
__TERM_1570:
  closecapture 56 0
  call CBCLOSE
  opencapture 57
  catch __TERM_1588
__TERM_1587:
  call IF_ELSEIF
  partialcommit __TERM_1587
__TERM_1588:
  closecapture 57 0
  opencapture 58
  catch __TERM_1599
  call IF_ELSE
  commit __TERM_1599
__TERM_1599:
  closecapture 58 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 59
  call SCR_EXPRESSION
  closecapture 59 0
  call BCLOSE
  call CBOPEN
  opencapture 60
  catch __TERM_1648
__TERM_1647:
  call LOWSTMT
  partialcommit __TERM_1647
__TERM_1648:
  closecapture 60 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 61
  catch __TERM_1678
__TERM_1677:
  call LOWSTMT
  partialcommit __TERM_1677
__TERM_1678:
  closecapture 61 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 62
  call SCR_EXPRESSION
  closecapture 62 0
  call BCLOSE
  call CBOPEN
  opencapture 63
  catch __TERM_1732
__TERM_1731:
  call LOWSTMT
  partialcommit __TERM_1731
__TERM_1732:
  closecapture 63 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 64
  catch __TERM_1755
  call SCR_EXPRESSION
  commit __TERM_1755
__TERM_1755:
  closecapture 64 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1770
  call KW_BREAK
  commit __LEFTHAND_1771
__RIGHTHAND_1770:
  call KW_CONTINUE
__LEFTHAND_1771:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1811
  call ASSIGN
  opencapture 65
  call SCR_EXPRESSION
  closecapture 65 0
  commit __TERM_1811
__TERM_1811:
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
  opencapture 66
  catch __RIGHTHAND_1868
  call ASSIGN
  commit __LEFTHAND_1869
__RIGHTHAND_1868:
  catch __RIGHTHAND_1876
  call PLUSIS
  commit __LEFTHAND_1877
__RIGHTHAND_1876:
  catch __RIGHTHAND_1884
  call MINIS
  commit __LEFTHAND_1885
__RIGHTHAND_1884:
  catch __RIGHTHAND_1892
  call MULIS
  commit __LEFTHAND_1893
__RIGHTHAND_1892:
  catch __RIGHTHAND_1900
  call DIVIS
  commit __LEFTHAND_1901
__RIGHTHAND_1900:
  catch __RIGHTHAND_1908
  call BITANDIS
  commit __LEFTHAND_1909
__RIGHTHAND_1908:
  catch __RIGHTHAND_1916
  call BITORIS
  commit __LEFTHAND_1917
__RIGHTHAND_1916:
  catch __RIGHTHAND_1924
  call BITXORIS
  commit __LEFTHAND_1925
__RIGHTHAND_1924:
  catch __RIGHTHAND_1932
  call BITNOTIS
  commit __LEFTHAND_1933
__RIGHTHAND_1932:
  catch __RIGHTHAND_1940
  call LSHIFTIS
  commit __LEFTHAND_1941
__RIGHTHAND_1940:
  call RSHIFTIS
__LEFTHAND_1941:
__LEFTHAND_1933:
__LEFTHAND_1925:
__LEFTHAND_1917:
__LEFTHAND_1909:
__LEFTHAND_1901:
__LEFTHAND_1893:
__LEFTHAND_1885:
__LEFTHAND_1877:
__LEFTHAND_1869:
  closecapture 66 0
  ret
-- Rule
SCR_EXPRESSION:
  call __prefix
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  opencapture 67
  call BINOP_P11
  closecapture 67 0
  catch __TERM_1976
__TERM_1975:
  call LOGOR
  call BINOP_P11
  partialcommit __TERM_1975
__TERM_1976:
  ret
-- Rule
BINOP_P11:
  call __prefix
  opencapture 68
  call BINOP_P10
  closecapture 68 0
  catch __TERM_2006
__TERM_2005:
  call LOGAND
  call BINOP_P10
  partialcommit __TERM_2005
__TERM_2006:
  ret
-- Rule
BINOP_P10:
  call __prefix
  opencapture 69
  call BINOP_P09
  closecapture 69 0
  catch __TERM_2036
__TERM_2035:
  call BITOR
  call BINOP_P09
  partialcommit __TERM_2035
__TERM_2036:
  ret
-- Rule
BINOP_P09:
  call __prefix
  opencapture 70
  call BINOP_P08
  closecapture 70 0
  catch __TERM_2066
__TERM_2065:
  call BITXOR
  call BINOP_P08
  partialcommit __TERM_2065
__TERM_2066:
  ret
-- Rule
BINOP_P08:
  call __prefix
  opencapture 71
  call BINOP_P07
  closecapture 71 0
  catch __TERM_2096
__TERM_2095:
  call BITAND
  call BINOP_P07
  partialcommit __TERM_2095
__TERM_2096:
  ret
-- Rule
BINOP_P07:
  call __prefix
  opencapture 72
  call BINOP_P06
  closecapture 72 0
  catch __TERM_2126
__TERM_2125:
  catch __RIGHTHAND_2134
  call EQUALS
  commit __LEFTHAND_2135
__RIGHTHAND_2134:
  call NEQUALS
__LEFTHAND_2135:
  call BINOP_P06
  partialcommit __TERM_2125
__TERM_2126:
  ret
-- Rule
BINOP_P06:
  call __prefix
  opencapture 73
  call BINOP_P05
  closecapture 73 0
  catch __TERM_2170
__TERM_2169:
  catch __RIGHTHAND_2178
  call LTEQ
  commit __LEFTHAND_2179
__RIGHTHAND_2178:
  catch __RIGHTHAND_2186
  call LT
  commit __LEFTHAND_2187
__RIGHTHAND_2186:
  catch __RIGHTHAND_2194
  call GTEQ
  commit __LEFTHAND_2195
__RIGHTHAND_2194:
  call GT
__LEFTHAND_2195:
__LEFTHAND_2187:
__LEFTHAND_2179:
  call BINOP_P05
  partialcommit __TERM_2169
__TERM_2170:
  ret
-- Rule
BINOP_P05:
  call __prefix
  opencapture 74
  call BINOP_P04
  closecapture 74 0
  catch __TERM_2230
__TERM_2229:
  catch __RIGHTHAND_2238
  call LSHIFT
  commit __LEFTHAND_2239
__RIGHTHAND_2238:
  call RSHIFT
__LEFTHAND_2239:
  call BINOP_P04
  partialcommit __TERM_2229
__TERM_2230:
  ret
-- Rule
BINOP_P04:
  call __prefix
  opencapture 75
  call BINOP_P03
  closecapture 75 0
  catch __TERM_2274
__TERM_2273:
  catch __RIGHTHAND_2282
  call ADD
  commit __LEFTHAND_2283
__RIGHTHAND_2282:
  call SUB
__LEFTHAND_2283:
  call BINOP_P03
  partialcommit __TERM_2273
__TERM_2274:
  ret
-- Rule
BINOP_P03:
  call __prefix
  opencapture 76
  call UNARIES
  closecapture 76 0
  catch __TERM_2318
__TERM_2317:
  catch __RIGHTHAND_2326
  call MUL
  commit __LEFTHAND_2327
__RIGHTHAND_2326:
  catch __RIGHTHAND_2334
  call DIV
  commit __LEFTHAND_2335
__RIGHTHAND_2334:
  call POW
__LEFTHAND_2335:
__LEFTHAND_2327:
  call UNARIES
  partialcommit __TERM_2317
__TERM_2318:
  ret
-- Rule
UNARIES:
  call __prefix
  catch __TERM_2358
__TERM_2357:
  opencapture 77
  call UNARY
  closecapture 77 0
  partialcommit __TERM_2357
__TERM_2358:
  opencapture 78
  call SCR_TERM
  closecapture 78 0
  ret
-- Rule
UNARY:
  call __prefix
  opencapture 79
  catch __RIGHTHAND_2384
  call LOGNOT
  commit __LEFTHAND_2385
__RIGHTHAND_2384:
  catch __RIGHTHAND_2392
  call BITNOT
  commit __LEFTHAND_2393
__RIGHTHAND_2392:
  catch __RIGHTHAND_2400
  call INC
  commit __LEFTHAND_2401
__RIGHTHAND_2400:
  call DEC
__LEFTHAND_2401:
__LEFTHAND_2393:
__LEFTHAND_2385:
  closecapture 79 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2414
  opencapture 80
  call LITERAL
  closecapture 80 0
  commit __LEFTHAND_2415
__RIGHTHAND_2414:
  catch __RIGHTHAND_2428
  opencapture 81
  call FUNCTIONCALL
  closecapture 81 0
  commit __LEFTHAND_2429
__RIGHTHAND_2428:
  catch __RIGHTHAND_2442
  opencapture 82
  call SCR_REFERENCE
  closecapture 82 0
  commit __LEFTHAND_2443
__RIGHTHAND_2442:
  opencapture 83
  call BOPEN
  opencapture 84
  call SCR_EXPRESSION
  closecapture 84 0
  call BCLOSE
  closecapture 83 0
__LEFTHAND_2443:
__LEFTHAND_2429:
__LEFTHAND_2415:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 85
  call SCR_REFERENCE
  closecapture 85 0
  call BOPEN
  catch __TERM_2507
  call SCR_EXPRESSION
  catch __TERM_2520
__TERM_2519:
  call COMMA
  call SCR_EXPRESSION
  partialcommit __TERM_2519
__TERM_2520:
  commit __TERM_2507
__TERM_2507:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_2550
__TERM_2549:
  call DOT
  call IDENT
  partialcommit __TERM_2549
__TERM_2550:
  catch __TERM_2568
__TERM_2567:
  call INDEX
  partialcommit __TERM_2567
__TERM_2568:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 86
  call SCR_EXPRESSION
  closecapture 86 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_2594
  call STRINGLITERAL
  commit __LEFTHAND_2595
__RIGHTHAND_2594:
  catch __RIGHTHAND_2602
  call HASHLITERAL
  commit __LEFTHAND_2603
__RIGHTHAND_2602:
  catch __RIGHTHAND_2610
  call LISTLITERAL
  commit __LEFTHAND_2611
__RIGHTHAND_2610:
  catch __RIGHTHAND_2618
  call FLOATLITERAL
  commit __LEFTHAND_2619
__RIGHTHAND_2618:
  catch __RIGHTHAND_2626
  call INTLITERAL
  commit __LEFTHAND_2627
__RIGHTHAND_2626:
  call BOOLEANLITERAL
__LEFTHAND_2627:
__LEFTHAND_2619:
__LEFTHAND_2611:
__LEFTHAND_2603:
__LEFTHAND_2595:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 87
  catch __TERM_2656
__TERM_2655:
  catch __RIGHTHAND_2658
  char 5c
  catch __RIGHTHAND_2672
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_2673
__RIGHTHAND_2672:
  counter 3 3
__TERM_2682:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __TERM_2682
__LEFTHAND_2673:
  commit __LEFTHAND_2659
__RIGHTHAND_2658:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_2659:
  partialcommit __TERM_2655
__TERM_2656:
  closecapture 87 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 88
  call CBOPEN
  catch __TERM_2713
  call HASHELT
  catch __TERM_2726
__TERM_2725:
  call COMMA
  call HASHELT
  partialcommit __TERM_2725
__TERM_2726:
  commit __TERM_2713
__TERM_2713:
  call CBCLOSE
  closecapture 88 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 89
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 89 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 90
  call SCR_TERM
  closecapture 90 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 91
  call SCR_TERM
  closecapture 91 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 92
  call ABOPEN
  catch __TERM_2809
  call LISTELT
  catch __TERM_2822
__TERM_2821:
  call COMMA
  call LISTELT
  partialcommit __TERM_2821
__TERM_2822:
  commit __TERM_2809
__TERM_2809:
  call ABCLOSE
  closecapture 92 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 93
  call SCR_TERM
  closecapture 93 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 94
  catch __TERM_2864
__TERM_2863:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2863
__TERM_2864:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2876
__TERM_2875:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2875
__TERM_2876:
  closecapture 94 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 95
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2888
__TERM_2887:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2887
__TERM_2888:
  closecapture 95 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 96
  catch __RIGHTHAND_2896
  quad 74727565
  commit __LEFTHAND_2897
__RIGHTHAND_2896:
  quad 66616c73
  char 65
__LEFTHAND_2897:
  closecapture 96 0
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
  catch __TERM_2973
  counter 3 63
__TERM_2974:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_2975
__TERM_2975:
  condjump 3 __TERM_2974
  commit __TERM_2973
__TERM_2973:
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
  catch __TERM_3060
  char 3d
  failtwice
__TERM_3060:
  ret
-- Rule
GT:
  call __prefix
  char 3e
  catch __TERM_3072
  char 3d
  failtwice
__TERM_3072:
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
  catch __TERM_3114
  char 2a
  failtwice
__TERM_3114:
  ret
-- Rule
DIV:
  call __prefix
  char 2f
  catch __TERM_3126
  char 3d
  failtwice
__TERM_3126:
  ret
-- Rule
ADD:
  call __prefix
  char 2b
  catch __TERM_3138
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3138:
  ret
-- Rule
SUB:
  call __prefix
  char 2d
  catch __TERM_3150
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3150:
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
  catch __TERM_3186
  char 3d
  failtwice
__TERM_3186:
  ret
-- Rule
BITAND:
  call __prefix
  char 26
  catch __TERM_3198
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3198:
  ret
-- Rule
BITOR:
  call __prefix
  char 7c
  catch __TERM_3210
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3210:
  ret
-- Rule
BITXOR:
  call __prefix
  char 5e
  catch __TERM_3222
  char 3d
  failtwice
__TERM_3222:
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
  catch __TERM_3276
  char 3d
  failtwice
__TERM_3276:
  ret
-- Rule
RSHIFT:
  call __prefix
  char 3e
  char 3e
  catch __TERM_3288
  char 3d
  failtwice
__TERM_3288:
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

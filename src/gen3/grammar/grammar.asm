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
  counter 0 2
__TERM_582:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_582
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
  counter 0 3
__TERM_820:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_820
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
  counter 0 3
__TERM_866:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_866
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
  counter 0 3
__TERM_906:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_906
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
  counter 0 3
__TERM_948:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_948
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
  counter 0 3
__TERM_994:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_994
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
  counter 0 3
__TERM_1034:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1034
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
  counter 0 2
__TERM_1250:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1250
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
  catch __TERM_1353
  opencapture 46
  call PARAMDECL
  closecapture 46 0
  catch __TERM_1372
__TERM_1371:
  call COMMA
  opencapture 47
  call PARAMDECL
  closecapture 47 0
  partialcommit __TERM_1371
__TERM_1372:
  commit __TERM_1353
__TERM_1353:
  call BCLOSE
  ret
-- Rule
PARAMDECL:
  call __prefix
  catch __RIGHTHAND_1398
  opencapture 48
  call IDENT
  closecapture 48 0
  opencapture 49
  call IDENT
  closecapture 49 0
  commit __LEFTHAND_1399
__RIGHTHAND_1398:
  opencapture 50
  call IDENT
  closecapture 50 0
__LEFTHAND_1399:
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  catch __TERM_1446
__TERM_1445:
  opencapture 51
  call LOWSTMT
  closecapture 51 0
  partialcommit __TERM_1445
__TERM_1446:
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1460
  opencapture 52
  call ST_IF
  closecapture 52 0
  commit __LEFTHAND_1461
__RIGHTHAND_1460:
  catch __RIGHTHAND_1474
  opencapture 53
  call ST_WHILE
  closecapture 53 0
  commit __LEFTHAND_1475
__RIGHTHAND_1474:
  catch __RIGHTHAND_1488
  opencapture 54
  call ST_RETURN
  closecapture 54 0
  commit __LEFTHAND_1489
__RIGHTHAND_1488:
  catch __RIGHTHAND_1502
  opencapture 55
  call ST_OTHER
  closecapture 55 0
  commit __LEFTHAND_1503
__RIGHTHAND_1502:
  catch __RIGHTHAND_1516
  opencapture 56
  call VARDECL
  closecapture 56 0
  commit __LEFTHAND_1517
__RIGHTHAND_1516:
  catch __RIGHTHAND_1530
  opencapture 57
  call ASSIGNMENT
  closecapture 57 0
  commit __LEFTHAND_1531
__RIGHTHAND_1530:
  catch __TERM_1547
  call SCR_EXPRESSION
  commit __TERM_1547
__TERM_1547:
  call SEMICOLON
__LEFTHAND_1531:
__LEFTHAND_1517:
__LEFTHAND_1503:
__LEFTHAND_1489:
__LEFTHAND_1475:
__LEFTHAND_1461:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 58
  call SCR_EXPRESSION
  closecapture 58 0
  call BCLOSE
  call CBOPEN
  opencapture 59
  catch __TERM_1608
__TERM_1607:
  call LOWSTMT
  partialcommit __TERM_1607
__TERM_1608:
  closecapture 59 0
  call CBCLOSE
  opencapture 60
  catch __TERM_1626
__TERM_1625:
  call IF_ELSEIF
  partialcommit __TERM_1625
__TERM_1626:
  closecapture 60 0
  opencapture 61
  catch __TERM_1637
  call IF_ELSE
  commit __TERM_1637
__TERM_1637:
  closecapture 61 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 62
  call SCR_EXPRESSION
  closecapture 62 0
  call BCLOSE
  call CBOPEN
  opencapture 63
  catch __TERM_1686
__TERM_1685:
  call LOWSTMT
  partialcommit __TERM_1685
__TERM_1686:
  closecapture 63 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 64
  catch __TERM_1716
__TERM_1715:
  call LOWSTMT
  partialcommit __TERM_1715
__TERM_1716:
  closecapture 64 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 65
  call SCR_EXPRESSION
  closecapture 65 0
  call BCLOSE
  call CBOPEN
  opencapture 66
  catch __TERM_1770
__TERM_1769:
  call LOWSTMT
  partialcommit __TERM_1769
__TERM_1770:
  closecapture 66 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 67
  catch __TERM_1793
  call SCR_EXPRESSION
  commit __TERM_1793
__TERM_1793:
  closecapture 67 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1808
  call KW_BREAK
  commit __LEFTHAND_1809
__RIGHTHAND_1808:
  call KW_CONTINUE
__LEFTHAND_1809:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1849
  call ASSIGN
  opencapture 68
  call SCR_EXPRESSION
  closecapture 68 0
  commit __TERM_1849
__TERM_1849:
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
  opencapture 69
  catch __RIGHTHAND_1906
  call ASSIGN
  commit __LEFTHAND_1907
__RIGHTHAND_1906:
  catch __RIGHTHAND_1914
  call PLUSIS
  commit __LEFTHAND_1915
__RIGHTHAND_1914:
  catch __RIGHTHAND_1922
  call MINIS
  commit __LEFTHAND_1923
__RIGHTHAND_1922:
  catch __RIGHTHAND_1930
  call MULIS
  commit __LEFTHAND_1931
__RIGHTHAND_1930:
  catch __RIGHTHAND_1938
  call DIVIS
  commit __LEFTHAND_1939
__RIGHTHAND_1938:
  catch __RIGHTHAND_1946
  call BITANDIS
  commit __LEFTHAND_1947
__RIGHTHAND_1946:
  catch __RIGHTHAND_1954
  call BITORIS
  commit __LEFTHAND_1955
__RIGHTHAND_1954:
  catch __RIGHTHAND_1962
  call BITXORIS
  commit __LEFTHAND_1963
__RIGHTHAND_1962:
  catch __RIGHTHAND_1970
  call BITNOTIS
  commit __LEFTHAND_1971
__RIGHTHAND_1970:
  catch __RIGHTHAND_1978
  call LSHIFTIS
  commit __LEFTHAND_1979
__RIGHTHAND_1978:
  call RSHIFTIS
__LEFTHAND_1979:
__LEFTHAND_1971:
__LEFTHAND_1963:
__LEFTHAND_1955:
__LEFTHAND_1947:
__LEFTHAND_1939:
__LEFTHAND_1931:
__LEFTHAND_1923:
__LEFTHAND_1915:
__LEFTHAND_1907:
  closecapture 69 0
  ret
-- Rule
SCR_EXPRESSION:
  call __prefix
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  opencapture 70
  call BINOP_P11
  closecapture 70 0
  catch __TERM_2014
__TERM_2013:
  opencapture 71
  call LOGOR
  call SCR_EXPRESSION
  closecapture 71 0
  partialcommit __TERM_2013
__TERM_2014:
  ret
-- Rule
BINOP_P11:
  call __prefix
  opencapture 72
  call BINOP_P10
  closecapture 72 0
  catch __TERM_2044
__TERM_2043:
  opencapture 73
  call LOGAND
  call SCR_EXPRESSION
  closecapture 73 0
  partialcommit __TERM_2043
__TERM_2044:
  ret
-- Rule
BINOP_P10:
  call __prefix
  opencapture 74
  call BINOP_P09
  closecapture 74 0
  catch __TERM_2074
__TERM_2073:
  opencapture 75
  call BITOR
  call SCR_EXPRESSION
  closecapture 75 0
  partialcommit __TERM_2073
__TERM_2074:
  ret
-- Rule
BINOP_P09:
  call __prefix
  opencapture 76
  call BINOP_P08
  closecapture 76 0
  catch __TERM_2104
__TERM_2103:
  opencapture 77
  call BITXOR
  call SCR_EXPRESSION
  closecapture 77 0
  partialcommit __TERM_2103
__TERM_2104:
  ret
-- Rule
BINOP_P08:
  call __prefix
  opencapture 78
  call BINOP_P07
  closecapture 78 0
  catch __TERM_2134
__TERM_2133:
  opencapture 79
  call BITAND
  call SCR_EXPRESSION
  closecapture 79 0
  partialcommit __TERM_2133
__TERM_2134:
  ret
-- Rule
BINOP_P07:
  call __prefix
  opencapture 80
  call BINOP_P06
  closecapture 80 0
  catch __TERM_2164
__TERM_2163:
  opencapture 81
  catch __RIGHTHAND_2172
  call EQUALS
  commit __LEFTHAND_2173
__RIGHTHAND_2172:
  call NEQUALS
__LEFTHAND_2173:
  call SCR_EXPRESSION
  closecapture 81 0
  partialcommit __TERM_2163
__TERM_2164:
  ret
-- Rule
BINOP_P06:
  call __prefix
  opencapture 82
  call BINOP_P05
  closecapture 82 0
  catch __TERM_2208
__TERM_2207:
  opencapture 83
  catch __RIGHTHAND_2216
  call LTEQ
  commit __LEFTHAND_2217
__RIGHTHAND_2216:
  catch __RIGHTHAND_2224
  call LT
  commit __LEFTHAND_2225
__RIGHTHAND_2224:
  catch __RIGHTHAND_2232
  call GTEQ
  commit __LEFTHAND_2233
__RIGHTHAND_2232:
  call GT
__LEFTHAND_2233:
__LEFTHAND_2225:
__LEFTHAND_2217:
  call SCR_EXPRESSION
  closecapture 83 0
  partialcommit __TERM_2207
__TERM_2208:
  ret
-- Rule
BINOP_P05:
  call __prefix
  opencapture 84
  call BINOP_P04
  closecapture 84 0
  catch __TERM_2268
__TERM_2267:
  opencapture 85
  catch __RIGHTHAND_2276
  call LSHIFT
  commit __LEFTHAND_2277
__RIGHTHAND_2276:
  call RSHIFT
__LEFTHAND_2277:
  call SCR_EXPRESSION
  closecapture 85 0
  partialcommit __TERM_2267
__TERM_2268:
  ret
-- Rule
BINOP_P04:
  call __prefix
  opencapture 86
  call BINOP_P03
  closecapture 86 0
  catch __TERM_2312
__TERM_2311:
  opencapture 87
  catch __RIGHTHAND_2320
  call ADD
  commit __LEFTHAND_2321
__RIGHTHAND_2320:
  call SUB
__LEFTHAND_2321:
  call SCR_EXPRESSION
  closecapture 87 0
  partialcommit __TERM_2311
__TERM_2312:
  ret
-- Rule
BINOP_P03:
  call __prefix
  opencapture 88
  call UNARIES
  closecapture 88 0
  catch __TERM_2356
__TERM_2355:
  opencapture 89
  catch __RIGHTHAND_2364
  call MUL
  commit __LEFTHAND_2365
__RIGHTHAND_2364:
  catch __RIGHTHAND_2372
  call DIV
  commit __LEFTHAND_2373
__RIGHTHAND_2372:
  call POW
__LEFTHAND_2373:
__LEFTHAND_2365:
  call SCR_EXPRESSION
  closecapture 89 0
  partialcommit __TERM_2355
__TERM_2356:
  ret
-- Rule
UNARIES:
  call __prefix
  catch __TERM_2396
__TERM_2395:
  opencapture 90
  call UNARY
  closecapture 90 0
  partialcommit __TERM_2395
__TERM_2396:
  opencapture 91
  call SCR_TERM
  closecapture 91 0
  ret
-- Rule
UNARY:
  call __prefix
  opencapture 92
  catch __RIGHTHAND_2422
  call LOGNOT
  commit __LEFTHAND_2423
__RIGHTHAND_2422:
  catch __RIGHTHAND_2430
  call BITNOT
  commit __LEFTHAND_2431
__RIGHTHAND_2430:
  catch __RIGHTHAND_2438
  call INC
  commit __LEFTHAND_2439
__RIGHTHAND_2438:
  call DEC
__LEFTHAND_2439:
__LEFTHAND_2431:
__LEFTHAND_2423:
  closecapture 92 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2452
  opencapture 93
  call LITERAL
  closecapture 93 0
  commit __LEFTHAND_2453
__RIGHTHAND_2452:
  catch __RIGHTHAND_2466
  opencapture 94
  call FUNCTIONCALL
  closecapture 94 0
  commit __LEFTHAND_2467
__RIGHTHAND_2466:
  catch __RIGHTHAND_2480
  opencapture 95
  call SCR_REFERENCE
  closecapture 95 0
  commit __LEFTHAND_2481
__RIGHTHAND_2480:
  opencapture 96
  call BOPEN
  opencapture 97
  call SCR_EXPRESSION
  closecapture 97 0
  call BCLOSE
  closecapture 96 0
__LEFTHAND_2481:
__LEFTHAND_2467:
__LEFTHAND_2453:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 98
  call SCR_REFERENCE
  closecapture 98 0
  call BOPEN
  catch __TERM_2545
  call SCR_EXPRESSION
  catch __TERM_2558
__TERM_2557:
  call COMMA
  call SCR_EXPRESSION
  partialcommit __TERM_2557
__TERM_2558:
  commit __TERM_2545
__TERM_2545:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_2588
__TERM_2587:
  call DOT
  call IDENT
  partialcommit __TERM_2587
__TERM_2588:
  catch __TERM_2606
__TERM_2605:
  call INDEX
  partialcommit __TERM_2605
__TERM_2606:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 99
  call SCR_EXPRESSION
  closecapture 99 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_2632
  call STRINGLITERAL
  commit __LEFTHAND_2633
__RIGHTHAND_2632:
  catch __RIGHTHAND_2640
  call HASHLITERAL
  commit __LEFTHAND_2641
__RIGHTHAND_2640:
  catch __RIGHTHAND_2648
  call LISTLITERAL
  commit __LEFTHAND_2649
__RIGHTHAND_2648:
  catch __RIGHTHAND_2656
  call FLOATLITERAL
  commit __LEFTHAND_2657
__RIGHTHAND_2656:
  catch __RIGHTHAND_2664
  call INTLITERAL
  commit __LEFTHAND_2665
__RIGHTHAND_2664:
  call BOOLEANLITERAL
__LEFTHAND_2665:
__LEFTHAND_2657:
__LEFTHAND_2649:
__LEFTHAND_2641:
__LEFTHAND_2633:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 100
  catch __TERM_2694
__TERM_2693:
  catch __RIGHTHAND_2696
  char 5c
  catch __RIGHTHAND_2710
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_2711
__RIGHTHAND_2710:
  counter 0 3
__TERM_2720:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_2720
__LEFTHAND_2711:
  commit __LEFTHAND_2697
__RIGHTHAND_2696:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_2697:
  partialcommit __TERM_2693
__TERM_2694:
  closecapture 100 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 101
  call CBOPEN
  catch __TERM_2751
  call HASHELT
  catch __TERM_2764
__TERM_2763:
  call COMMA
  call HASHELT
  partialcommit __TERM_2763
__TERM_2764:
  commit __TERM_2751
__TERM_2751:
  call CBCLOSE
  closecapture 101 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 102
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 102 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 103
  call SCR_TERM
  closecapture 103 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 104
  call SCR_TERM
  closecapture 104 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 105
  call ABOPEN
  catch __TERM_2847
  call LISTELT
  catch __TERM_2860
__TERM_2859:
  call COMMA
  call LISTELT
  partialcommit __TERM_2859
__TERM_2860:
  commit __TERM_2847
__TERM_2847:
  call ABCLOSE
  closecapture 105 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 106
  call SCR_TERM
  closecapture 106 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 107
  catch __TERM_2902
__TERM_2901:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2901
__TERM_2902:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2914
__TERM_2913:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2913
__TERM_2914:
  closecapture 107 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 108
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2926
__TERM_2925:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2925
__TERM_2926:
  closecapture 108 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 109
  catch __RIGHTHAND_2934
  quad 74727565
  commit __LEFTHAND_2935
__RIGHTHAND_2934:
  quad 66616c73
  char 65
__LEFTHAND_2935:
  closecapture 109 0
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
  catch __TERM_3011
  counter 0 63
__TERM_3012:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_3013
__TERM_3013:
  condjump 0 __TERM_3012
  commit __TERM_3011
__TERM_3011:
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
  opencapture 110
  char 3d
  closecapture 110 0
  ret
-- Rule
PLUSIS:
  call __prefix
  opencapture 111
  char 2b
  char 3d
  closecapture 111 0
  ret
-- Rule
MINIS:
  call __prefix
  opencapture 112
  char 2d
  char 3d
  closecapture 112 0
  ret
-- Rule
MULIS:
  call __prefix
  opencapture 113
  char 2a
  char 3d
  closecapture 113 0
  ret
-- Rule
DIVIS:
  call __prefix
  opencapture 114
  char 2f
  char 3d
  closecapture 114 0
  ret
-- Rule
EQUALS:
  call __prefix
  opencapture 115
  char 3d
  char 3d
  closecapture 115 0
  ret
-- Rule
NEQUALS:
  call __prefix
  opencapture 116
  char 21
  char 3d
  closecapture 116 0
  ret
-- Rule
LT:
  call __prefix
  opencapture 117
  char 3c
  closecapture 117 0
  catch __TERM_3146
  char 3d
  failtwice
__TERM_3146:
  ret
-- Rule
GT:
  call __prefix
  opencapture 118
  char 3e
  closecapture 118 0
  catch __TERM_3164
  char 3d
  failtwice
__TERM_3164:
  ret
-- Rule
LTEQ:
  call __prefix
  opencapture 119
  char 3c
  char 3d
  closecapture 119 0
  ret
-- Rule
GTEQ:
  call __prefix
  opencapture 120
  char 3e
  char 3d
  closecapture 120 0
  ret
-- Rule
SEMICOLON:
  call __prefix
  char 3b
  ret
-- Rule
COLON:
  call __prefix
  opencapture 121
  char 3a
  closecapture 121 0
  ret
-- Rule
POW:
  call __prefix
  opencapture 122
  char 2a
  char 2a
  closecapture 122 0
  ret
-- Rule
MUL:
  call __prefix
  opencapture 123
  char 2a
  closecapture 123 0
  catch __TERM_3236
  char 2a
  failtwice
__TERM_3236:
  ret
-- Rule
DIV:
  call __prefix
  opencapture 124
  char 2f
  closecapture 124 0
  catch __TERM_3254
  char 3d
  failtwice
__TERM_3254:
  ret
-- Rule
ADD:
  call __prefix
  opencapture 125
  char 2b
  closecapture 125 0
  catch __TERM_3272
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3272:
  ret
-- Rule
SUB:
  call __prefix
  opencapture 126
  char 2d
  closecapture 126 0
  catch __TERM_3290
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3290:
  ret
-- Rule
INC:
  call __prefix
  opencapture 127
  char 2b
  char 2b
  closecapture 127 0
  ret
-- Rule
DEC:
  call __prefix
  opencapture 128
  char 2d
  char 2d
  closecapture 128 0
  ret
-- Rule
LOGAND:
  call __prefix
  opencapture 129
  char 26
  char 26
  closecapture 129 0
  ret
-- Rule
LOGOR:
  call __prefix
  opencapture 130
  char 7c
  char 7c
  closecapture 130 0
  ret
-- Rule
LOGNOT:
  call __prefix
  opencapture 131
  char 21
  closecapture 131 0
  catch __TERM_3356
  char 3d
  failtwice
__TERM_3356:
  ret
-- Rule
BITAND:
  call __prefix
  opencapture 132
  char 26
  closecapture 132 0
  catch __TERM_3374
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3374:
  ret
-- Rule
BITOR:
  call __prefix
  opencapture 133
  char 7c
  closecapture 133 0
  catch __TERM_3392
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3392:
  ret
-- Rule
BITXOR:
  call __prefix
  opencapture 134
  char 5e
  closecapture 134 0
  catch __TERM_3410
  char 3d
  failtwice
__TERM_3410:
  ret
-- Rule
BITNOT:
  call __prefix
  opencapture 135
  char 7e
  closecapture 135 0
  ret
-- Rule
BITANDIS:
  call __prefix
  opencapture 136
  char 26
  char 3d
  closecapture 136 0
  ret
-- Rule
BITORIS:
  call __prefix
  opencapture 137
  char 7c
  char 3d
  closecapture 137 0
  ret
-- Rule
BITXORIS:
  call __prefix
  opencapture 138
  char 5e
  char 3d
  closecapture 138 0
  ret
-- Rule
BITNOTIS:
  call __prefix
  opencapture 139
  char 7e
  char 3d
  closecapture 139 0
  ret
-- Rule
COMMA:
  call __prefix
  char 2c
  ret
-- Rule
DOT:
  call __prefix
  opencapture 140
  char 2e
  closecapture 140 0
  ret
-- Rule
LSHIFT:
  call __prefix
  opencapture 141
  char 3c
  char 3c
  closecapture 141 0
  catch __TERM_3506
  char 3d
  failtwice
__TERM_3506:
  ret
-- Rule
RSHIFT:
  call __prefix
  opencapture 142
  char 3e
  char 3e
  closecapture 142 0
  catch __TERM_3524
  char 3d
  failtwice
__TERM_3524:
  ret
-- Rule
LSHIFTIS:
  call __prefix
  opencapture 143
  char 3c
  char 3c
  char 3d
  closecapture 143 0
  ret
-- Rule
RSHIFTIS:
  call __prefix
  opencapture 144
  char 3e
  char 3e
  char 3d
  closecapture 144 0
  ret

  end 0

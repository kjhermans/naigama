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
  call ENDFORCE
  closecapture 23 0
  commit __LEFTHAND_537
__RIGHTHAND_536:
  catch __RIGHTHAND_550
  opencapture 24
  call VARREFERENCE
  closecapture 24 0
  commit __LEFTHAND_551
__RIGHTHAND_550:
  opencapture 25
  call REFERENCE
  closecapture 25 0
__LEFTHAND_551:
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
__TERM_584:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_584
  char 7c
  counter 0 2
__TERM_596:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_596
  char 7c
  ret
-- Rule
VARCAPTURE:
  call __prefix
  call CBOPEN
  call COLON
  opencapture 26
  call IDENT
  closecapture 26 0
  catch __TERM_633
  opencapture 27
  call CAPTURETYPE
  closecapture 27 0
  commit __TERM_633
__TERM_633:
  call COLON
  call EXPRESSION
  opencapture 28
  call CBCLOSE
  closecapture 28 0
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
  opencapture 29
  catch __RIGHTHAND_690
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_691
__RIGHTHAND_690:
  quad 696e7433
  char 32
__LEFTHAND_691:
  closecapture 29 0
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  opencapture 30
  call CBCLOSE
  closecapture 30 0
  call CAPTUREEND
  ret
-- Rule
GROUP:
  call __prefix
  call BOPEN
  call EXPRESSION
  opencapture 31
  call BCLOSE
  closecapture 31 0
  ret
-- Rule
CAPTUREEND:
  call __prefix
  catch __TERM_761
  catch __RIGHTHAND_764
  call REPLACE
  commit __LEFTHAND_765
__RIGHTHAND_764:
  call RECYCLE
__LEFTHAND_765:
  commit __TERM_761
__TERM_761:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 32
  catch __TERM_793
  call SETNOT
  commit __TERM_793
__TERM_793:
  closecapture 32 0
  catch __RIGHTHAND_802
  opencapture 33
  catch __RIGHTHAND_810
  char 5c
  catch __RIGHTHAND_824
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_825
__RIGHTHAND_824:
  counter 0 3
__TERM_834:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_834
__LEFTHAND_825:
  commit __LEFTHAND_811
__RIGHTHAND_810:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_811:
  closecapture 33 0
  char 2d
  opencapture 34
  catch __RIGHTHAND_856
  char 5c
  catch __RIGHTHAND_870
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_871
__RIGHTHAND_870:
  counter 0 3
__TERM_880:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_880
__LEFTHAND_871:
  commit __LEFTHAND_857
__RIGHTHAND_856:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_857:
  closecapture 34 0
  commit __LEFTHAND_803
__RIGHTHAND_802:
  opencapture 35
  catch __RIGHTHAND_896
  char 5c
  catch __RIGHTHAND_910
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_911
__RIGHTHAND_910:
  counter 0 3
__TERM_920:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_920
__LEFTHAND_911:
  commit __LEFTHAND_897
__RIGHTHAND_896:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_897:
  closecapture 35 0
__LEFTHAND_803:
  catch __TERM_800
__TERM_799:
  catch __RIGHTHAND_930
  opencapture 33
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
  closecapture 33 0
  char 2d
  opencapture 34
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
  closecapture 34 0
  commit __LEFTHAND_931
__RIGHTHAND_930:
  opencapture 35
  catch __RIGHTHAND_1024
  char 5c
  catch __RIGHTHAND_1038
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1039
__RIGHTHAND_1038:
  counter 0 3
__TERM_1048:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1048
__LEFTHAND_1039:
  commit __LEFTHAND_1025
__RIGHTHAND_1024:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1025:
  closecapture 35 0
__LEFTHAND_931:
  partialcommit __TERM_799
__TERM_800:
  opencapture 36
  call ABCLOSE
  closecapture 36 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1082
  opencapture 37
  call IDENT
  closecapture 37 0
  commit __LEFTHAND_1083
__RIGHTHAND_1082:
  opencapture 38
  call NUMBER
  closecapture 38 0
__LEFTHAND_1083:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1114
  call LEFTARROW
  failtwice
__TERM_1114:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 39
  call REPLACETERMS
  closecapture 39 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __TERM_1148
__TERM_1147:
  call REPLACETERM
  partialcommit __TERM_1147
__TERM_1148:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1150
  opencapture 40
  call STRINGLITERAL
  closecapture 40 0
  commit __LEFTHAND_1151
__RIGHTHAND_1150:
  catch __RIGHTHAND_1164
  opencapture 41
  call HEXLITERAL
  closecapture 41 0
  commit __LEFTHAND_1165
__RIGHTHAND_1164:
  opencapture 42
  call VARREFERENCE
  closecapture 42 0
__LEFTHAND_1165:
__LEFTHAND_1151:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 43
  call IDENT
  closecapture 43 0
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
  catch __TERM_1254
__TERM_1253:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1253
__TERM_1254:
  ret
-- Rule
ENDFORCE:
  call __prefix
  quad 5f5f656e
  char 64
  call S
  opencapture 44
  call NUMBER
  closecapture 44 0
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 0 2
__TERM_1288:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1288
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1296
__TERM_1295:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1295
__TERM_1296:
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1307
  char 69
  commit __TERM_1307
__TERM_1307:
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
  opencapture 45
  call IDENT
  closecapture 45 0
  opencapture 46
  call FUNCPARAMDECL
  closecapture 46 0
  opencapture 47
  call FUNCBODY
  closecapture 47 0
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  catch __TERM_1391
  opencapture 48
  call PARAMDECL
  closecapture 48 0
  catch __TERM_1410
__TERM_1409:
  call COMMA
  opencapture 49
  call PARAMDECL
  closecapture 49 0
  partialcommit __TERM_1409
__TERM_1410:
  commit __TERM_1391
__TERM_1391:
  call BCLOSE
  ret
-- Rule
PARAMDECL:
  call __prefix
  catch __RIGHTHAND_1436
  opencapture 50
  call IDENT
  closecapture 50 0
  opencapture 51
  call IDENT
  closecapture 51 0
  commit __LEFTHAND_1437
__RIGHTHAND_1436:
  opencapture 52
  call IDENT
  closecapture 52 0
__LEFTHAND_1437:
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  catch __TERM_1484
__TERM_1483:
  opencapture 53
  call LOWSTMT
  closecapture 53 0
  partialcommit __TERM_1483
__TERM_1484:
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1498
  opencapture 54
  call ST_IF
  closecapture 54 0
  commit __LEFTHAND_1499
__RIGHTHAND_1498:
  catch __RIGHTHAND_1512
  opencapture 55
  call ST_WHILE
  closecapture 55 0
  commit __LEFTHAND_1513
__RIGHTHAND_1512:
  catch __RIGHTHAND_1526
  opencapture 56
  call ST_RETURN
  closecapture 56 0
  commit __LEFTHAND_1527
__RIGHTHAND_1526:
  catch __RIGHTHAND_1540
  opencapture 57
  call ST_OTHER
  closecapture 57 0
  commit __LEFTHAND_1541
__RIGHTHAND_1540:
  catch __RIGHTHAND_1554
  opencapture 58
  call VARDECL
  closecapture 58 0
  commit __LEFTHAND_1555
__RIGHTHAND_1554:
  catch __RIGHTHAND_1568
  opencapture 59
  call ASSIGNMENT
  closecapture 59 0
  commit __LEFTHAND_1569
__RIGHTHAND_1568:
  catch __TERM_1585
  call SCR_EXPRESSION
  commit __TERM_1585
__TERM_1585:
  call SEMICOLON
__LEFTHAND_1569:
__LEFTHAND_1555:
__LEFTHAND_1541:
__LEFTHAND_1527:
__LEFTHAND_1513:
__LEFTHAND_1499:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 60
  call SCR_EXPRESSION
  closecapture 60 0
  call BCLOSE
  call CBOPEN
  opencapture 61
  catch __TERM_1646
__TERM_1645:
  call LOWSTMT
  partialcommit __TERM_1645
__TERM_1646:
  closecapture 61 0
  call CBCLOSE
  opencapture 62
  catch __TERM_1664
__TERM_1663:
  call IF_ELSEIF
  partialcommit __TERM_1663
__TERM_1664:
  closecapture 62 0
  opencapture 63
  catch __TERM_1675
  call IF_ELSE
  commit __TERM_1675
__TERM_1675:
  closecapture 63 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 64
  call SCR_EXPRESSION
  closecapture 64 0
  call BCLOSE
  call CBOPEN
  opencapture 65
  catch __TERM_1724
__TERM_1723:
  call LOWSTMT
  partialcommit __TERM_1723
__TERM_1724:
  closecapture 65 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 66
  catch __TERM_1754
__TERM_1753:
  call LOWSTMT
  partialcommit __TERM_1753
__TERM_1754:
  closecapture 66 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 67
  call SCR_EXPRESSION
  closecapture 67 0
  call BCLOSE
  call CBOPEN
  opencapture 68
  catch __TERM_1808
__TERM_1807:
  call LOWSTMT
  partialcommit __TERM_1807
__TERM_1808:
  closecapture 68 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 69
  catch __TERM_1831
  call SCR_EXPRESSION
  commit __TERM_1831
__TERM_1831:
  closecapture 69 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1846
  call KW_BREAK
  commit __LEFTHAND_1847
__RIGHTHAND_1846:
  call KW_CONTINUE
__LEFTHAND_1847:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1887
  call ASSIGN
  opencapture 70
  call SCR_EXPRESSION
  closecapture 70 0
  commit __TERM_1887
__TERM_1887:
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
  opencapture 71
  catch __RIGHTHAND_1944
  call ASSIGN
  commit __LEFTHAND_1945
__RIGHTHAND_1944:
  catch __RIGHTHAND_1952
  call PLUSIS
  commit __LEFTHAND_1953
__RIGHTHAND_1952:
  catch __RIGHTHAND_1960
  call MINIS
  commit __LEFTHAND_1961
__RIGHTHAND_1960:
  catch __RIGHTHAND_1968
  call MULIS
  commit __LEFTHAND_1969
__RIGHTHAND_1968:
  catch __RIGHTHAND_1976
  call DIVIS
  commit __LEFTHAND_1977
__RIGHTHAND_1976:
  catch __RIGHTHAND_1984
  call BITANDIS
  commit __LEFTHAND_1985
__RIGHTHAND_1984:
  catch __RIGHTHAND_1992
  call BITORIS
  commit __LEFTHAND_1993
__RIGHTHAND_1992:
  catch __RIGHTHAND_2000
  call BITXORIS
  commit __LEFTHAND_2001
__RIGHTHAND_2000:
  catch __RIGHTHAND_2008
  call BITNOTIS
  commit __LEFTHAND_2009
__RIGHTHAND_2008:
  catch __RIGHTHAND_2016
  call LSHIFTIS
  commit __LEFTHAND_2017
__RIGHTHAND_2016:
  call RSHIFTIS
__LEFTHAND_2017:
__LEFTHAND_2009:
__LEFTHAND_2001:
__LEFTHAND_1993:
__LEFTHAND_1985:
__LEFTHAND_1977:
__LEFTHAND_1969:
__LEFTHAND_1961:
__LEFTHAND_1953:
__LEFTHAND_1945:
  closecapture 71 0
  ret
-- Rule
SCR_EXPRESSION:
  call __prefix
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  catch __RIGHTHAND_2042
  call BINOP_P11
  commit __LEFTHAND_2043
__RIGHTHAND_2042:
  call EXPATOM
__LEFTHAND_2043:
  catch __TERM_2060
__TERM_2059:
  opencapture 72
  opencapture 73
  call LOGOR
  closecapture 73 0
  catch __RIGHTHAND_2080
  call BINOP_P11
  commit __LEFTHAND_2081
__RIGHTHAND_2080:
  call EXPATOM
__LEFTHAND_2081:
  closecapture 72 0
  partialcommit __TERM_2059
__TERM_2060:
  ret
-- Rule
BINOP_P11:
  call __prefix
  catch __RIGHTHAND_2100
  call BINOP_P10
  commit __LEFTHAND_2101
__RIGHTHAND_2100:
  call EXPATOM
__LEFTHAND_2101:
  catch __TERM_2118
__TERM_2117:
  opencapture 74
  opencapture 75
  call LOGAND
  closecapture 75 0
  catch __RIGHTHAND_2138
  call BINOP_P10
  commit __LEFTHAND_2139
__RIGHTHAND_2138:
  call EXPATOM
__LEFTHAND_2139:
  closecapture 74 0
  partialcommit __TERM_2117
__TERM_2118:
  ret
-- Rule
BINOP_P10:
  call __prefix
  catch __RIGHTHAND_2158
  call BINOP_P09
  commit __LEFTHAND_2159
__RIGHTHAND_2158:
  call EXPATOM
__LEFTHAND_2159:
  catch __TERM_2176
__TERM_2175:
  opencapture 76
  opencapture 77
  call BITOR
  closecapture 77 0
  catch __RIGHTHAND_2196
  call BINOP_P09
  commit __LEFTHAND_2197
__RIGHTHAND_2196:
  call EXPATOM
__LEFTHAND_2197:
  closecapture 76 0
  partialcommit __TERM_2175
__TERM_2176:
  ret
-- Rule
BINOP_P09:
  call __prefix
  catch __RIGHTHAND_2216
  call BINOP_P08
  commit __LEFTHAND_2217
__RIGHTHAND_2216:
  call EXPATOM
__LEFTHAND_2217:
  catch __TERM_2234
__TERM_2233:
  opencapture 78
  opencapture 79
  call BITXOR
  closecapture 79 0
  catch __RIGHTHAND_2254
  call BINOP_P08
  commit __LEFTHAND_2255
__RIGHTHAND_2254:
  call EXPATOM
__LEFTHAND_2255:
  closecapture 78 0
  partialcommit __TERM_2233
__TERM_2234:
  ret
-- Rule
BINOP_P08:
  call __prefix
  catch __RIGHTHAND_2274
  call BINOP_P07
  commit __LEFTHAND_2275
__RIGHTHAND_2274:
  call EXPATOM
__LEFTHAND_2275:
  catch __TERM_2292
__TERM_2291:
  opencapture 80
  opencapture 81
  call BITAND
  closecapture 81 0
  catch __RIGHTHAND_2312
  call BINOP_P07
  commit __LEFTHAND_2313
__RIGHTHAND_2312:
  call EXPATOM
__LEFTHAND_2313:
  closecapture 80 0
  partialcommit __TERM_2291
__TERM_2292:
  ret
-- Rule
BINOP_P07:
  call __prefix
  catch __RIGHTHAND_2332
  call BINOP_P06
  commit __LEFTHAND_2333
__RIGHTHAND_2332:
  call EXPATOM
__LEFTHAND_2333:
  catch __TERM_2350
__TERM_2349:
  opencapture 82
  opencapture 83
  catch __RIGHTHAND_2358
  call EQUALS
  commit __LEFTHAND_2359
__RIGHTHAND_2358:
  call NEQUALS
__LEFTHAND_2359:
  closecapture 83 0
  catch __RIGHTHAND_2378
  call BINOP_P06
  commit __LEFTHAND_2379
__RIGHTHAND_2378:
  call EXPATOM
__LEFTHAND_2379:
  closecapture 82 0
  partialcommit __TERM_2349
__TERM_2350:
  ret
-- Rule
BINOP_P06:
  call __prefix
  catch __RIGHTHAND_2398
  call BINOP_P05
  commit __LEFTHAND_2399
__RIGHTHAND_2398:
  call EXPATOM
__LEFTHAND_2399:
  catch __TERM_2416
__TERM_2415:
  opencapture 84
  opencapture 85
  catch __RIGHTHAND_2424
  call LTEQ
  commit __LEFTHAND_2425
__RIGHTHAND_2424:
  catch __RIGHTHAND_2432
  call LT
  commit __LEFTHAND_2433
__RIGHTHAND_2432:
  catch __RIGHTHAND_2440
  call GTEQ
  commit __LEFTHAND_2441
__RIGHTHAND_2440:
  call GT
__LEFTHAND_2441:
__LEFTHAND_2433:
__LEFTHAND_2425:
  closecapture 85 0
  catch __RIGHTHAND_2460
  call BINOP_P05
  commit __LEFTHAND_2461
__RIGHTHAND_2460:
  call EXPATOM
__LEFTHAND_2461:
  closecapture 84 0
  partialcommit __TERM_2415
__TERM_2416:
  ret
-- Rule
BINOP_P05:
  call __prefix
  catch __RIGHTHAND_2480
  call BINOP_P04
  commit __LEFTHAND_2481
__RIGHTHAND_2480:
  call EXPATOM
__LEFTHAND_2481:
  catch __TERM_2498
__TERM_2497:
  opencapture 86
  opencapture 87
  catch __RIGHTHAND_2506
  call LSHIFT
  commit __LEFTHAND_2507
__RIGHTHAND_2506:
  call RSHIFT
__LEFTHAND_2507:
  closecapture 87 0
  catch __RIGHTHAND_2526
  call BINOP_P04
  commit __LEFTHAND_2527
__RIGHTHAND_2526:
  call EXPATOM
__LEFTHAND_2527:
  closecapture 86 0
  partialcommit __TERM_2497
__TERM_2498:
  ret
-- Rule
BINOP_P04:
  call __prefix
  catch __RIGHTHAND_2546
  call BINOP_P03
  commit __LEFTHAND_2547
__RIGHTHAND_2546:
  call EXPATOM
__LEFTHAND_2547:
  catch __TERM_2564
__TERM_2563:
  opencapture 88
  opencapture 89
  catch __RIGHTHAND_2572
  call ADD
  commit __LEFTHAND_2573
__RIGHTHAND_2572:
  call SUB
__LEFTHAND_2573:
  closecapture 89 0
  catch __RIGHTHAND_2592
  call BINOP_P03
  commit __LEFTHAND_2593
__RIGHTHAND_2592:
  call EXPATOM
__LEFTHAND_2593:
  closecapture 88 0
  partialcommit __TERM_2563
__TERM_2564:
  ret
-- Rule
BINOP_P03:
  call __prefix
  call EXPATOM
  catch __TERM_2622
__TERM_2621:
  opencapture 90
  opencapture 91
  catch __RIGHTHAND_2630
  call MUL
  commit __LEFTHAND_2631
__RIGHTHAND_2630:
  catch __RIGHTHAND_2638
  call DIV
  commit __LEFTHAND_2639
__RIGHTHAND_2638:
  call POW
__LEFTHAND_2639:
__LEFTHAND_2631:
  closecapture 91 0
  call EXPATOM
  closecapture 90 0
  partialcommit __TERM_2621
__TERM_2622:
  ret
-- Rule
EXPATOM:
  call __prefix
  catch __TERM_2668
__TERM_2667:
  opencapture 92
  call UNARY
  closecapture 92 0
  partialcommit __TERM_2667
__TERM_2668:
  opencapture 93
  call SCR_TERM
  closecapture 93 0
  ret
-- Rule
UNARY:
  call __prefix
  opencapture 94
  catch __RIGHTHAND_2694
  call LOGNOT
  commit __LEFTHAND_2695
__RIGHTHAND_2694:
  catch __RIGHTHAND_2702
  call BITNOT
  commit __LEFTHAND_2703
__RIGHTHAND_2702:
  catch __RIGHTHAND_2710
  call INC
  commit __LEFTHAND_2711
__RIGHTHAND_2710:
  call DEC
__LEFTHAND_2711:
__LEFTHAND_2703:
__LEFTHAND_2695:
  closecapture 94 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2724
  opencapture 95
  call LITERAL
  closecapture 95 0
  commit __LEFTHAND_2725
__RIGHTHAND_2724:
  catch __RIGHTHAND_2738
  opencapture 96
  call FUNCTIONCALL
  closecapture 96 0
  commit __LEFTHAND_2739
__RIGHTHAND_2738:
  catch __RIGHTHAND_2752
  opencapture 97
  call SCR_REFERENCE
  closecapture 97 0
  commit __LEFTHAND_2753
__RIGHTHAND_2752:
  opencapture 98
  call BOPEN
  opencapture 99
  call SCR_EXPRESSION
  closecapture 99 0
  call BCLOSE
  closecapture 98 0
__LEFTHAND_2753:
__LEFTHAND_2739:
__LEFTHAND_2725:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 100
  call SCR_REFERENCE
  closecapture 100 0
  call BOPEN
  catch __TERM_2817
  call SCR_EXPRESSION
  catch __TERM_2830
__TERM_2829:
  call COMMA
  call SCR_EXPRESSION
  partialcommit __TERM_2829
__TERM_2830:
  commit __TERM_2817
__TERM_2817:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_2860
__TERM_2859:
  call INDEX
  partialcommit __TERM_2859
__TERM_2860:
  catch __TERM_2866
__TERM_2865:
  call DOT
  call SCR_REFERENCE
  partialcommit __TERM_2865
__TERM_2866:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 101
  call SCR_EXPRESSION
  closecapture 101 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_2904
  call STRINGLITERAL
  commit __LEFTHAND_2905
__RIGHTHAND_2904:
  catch __RIGHTHAND_2912
  call HASHLITERAL
  commit __LEFTHAND_2913
__RIGHTHAND_2912:
  catch __RIGHTHAND_2920
  call LISTLITERAL
  commit __LEFTHAND_2921
__RIGHTHAND_2920:
  catch __RIGHTHAND_2928
  call FLOATLITERAL
  commit __LEFTHAND_2929
__RIGHTHAND_2928:
  catch __RIGHTHAND_2936
  call INTLITERAL
  commit __LEFTHAND_2937
__RIGHTHAND_2936:
  call BOOLEANLITERAL
__LEFTHAND_2937:
__LEFTHAND_2929:
__LEFTHAND_2921:
__LEFTHAND_2913:
__LEFTHAND_2905:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 102
  catch __TERM_2966
__TERM_2965:
  catch __RIGHTHAND_2968
  char 5c
  catch __RIGHTHAND_2982
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_2983
__RIGHTHAND_2982:
  counter 0 3
__TERM_2992:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_2992
__LEFTHAND_2983:
  commit __LEFTHAND_2969
__RIGHTHAND_2968:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_2969:
  partialcommit __TERM_2965
__TERM_2966:
  closecapture 102 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 103
  call CBOPEN
  catch __TERM_3023
  call HASHELT
  catch __TERM_3036
__TERM_3035:
  call COMMA
  call HASHELT
  partialcommit __TERM_3035
__TERM_3036:
  commit __TERM_3023
__TERM_3023:
  call CBCLOSE
  closecapture 103 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 104
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 104 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 105
  call SCR_TERM
  closecapture 105 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 106
  call SCR_TERM
  closecapture 106 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 107
  call ABOPEN
  catch __TERM_3119
  call LISTELT
  catch __TERM_3132
__TERM_3131:
  call COMMA
  call LISTELT
  partialcommit __TERM_3131
__TERM_3132:
  commit __TERM_3119
__TERM_3119:
  call ABCLOSE
  closecapture 107 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 108
  call SCR_TERM
  closecapture 108 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 109
  catch __TERM_3174
__TERM_3173:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3173
__TERM_3174:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3186
__TERM_3185:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3185
__TERM_3186:
  closecapture 109 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 110
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3198
__TERM_3197:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3197
__TERM_3198:
  closecapture 110 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 111
  catch __RIGHTHAND_3206
  quad 74727565
  commit __LEFTHAND_3207
__RIGHTHAND_3206:
  quad 66616c73
  char 65
__LEFTHAND_3207:
  closecapture 111 0
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
  catch __TERM_3283
  counter 0 63
__TERM_3284:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_3285
__TERM_3285:
  condjump 0 __TERM_3284
  commit __TERM_3283
__TERM_3283:
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
  catch __TERM_3418
  char 3d
  failtwice
__TERM_3418:
  ret
-- Rule
GT:
  call __prefix
  opencapture 120
  char 3e
  closecapture 120 0
  catch __TERM_3436
  char 3d
  failtwice
__TERM_3436:
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
  opencapture 123
  char 3a
  closecapture 123 0
  ret
-- Rule
POW:
  call __prefix
  opencapture 124
  char 2a
  char 2a
  closecapture 124 0
  ret
-- Rule
MUL:
  call __prefix
  opencapture 125
  char 2a
  closecapture 125 0
  catch __TERM_3508
  char 2a
  failtwice
__TERM_3508:
  ret
-- Rule
DIV:
  call __prefix
  opencapture 126
  char 2f
  closecapture 126 0
  catch __TERM_3526
  char 3d
  failtwice
__TERM_3526:
  ret
-- Rule
ADD:
  call __prefix
  opencapture 127
  char 2b
  closecapture 127 0
  catch __TERM_3544
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3544:
  ret
-- Rule
SUB:
  call __prefix
  opencapture 128
  char 2d
  closecapture 128 0
  catch __TERM_3562
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3562:
  ret
-- Rule
INC:
  call __prefix
  opencapture 129
  char 2b
  char 2b
  closecapture 129 0
  ret
-- Rule
DEC:
  call __prefix
  opencapture 130
  char 2d
  char 2d
  closecapture 130 0
  ret
-- Rule
LOGAND:
  call __prefix
  opencapture 131
  char 26
  char 26
  closecapture 131 0
  ret
-- Rule
LOGOR:
  call __prefix
  opencapture 132
  char 7c
  char 7c
  closecapture 132 0
  ret
-- Rule
LOGNOT:
  call __prefix
  opencapture 133
  char 21
  closecapture 133 0
  catch __TERM_3628
  char 3d
  failtwice
__TERM_3628:
  ret
-- Rule
BITAND:
  call __prefix
  opencapture 134
  char 26
  closecapture 134 0
  catch __TERM_3646
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3646:
  ret
-- Rule
BITOR:
  call __prefix
  opencapture 135
  char 7c
  closecapture 135 0
  catch __TERM_3664
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3664:
  ret
-- Rule
BITXOR:
  call __prefix
  opencapture 136
  char 5e
  closecapture 136 0
  catch __TERM_3682
  char 3d
  failtwice
__TERM_3682:
  ret
-- Rule
BITNOT:
  call __prefix
  opencapture 137
  char 7e
  closecapture 137 0
  ret
-- Rule
BITANDIS:
  call __prefix
  opencapture 138
  char 26
  char 3d
  closecapture 138 0
  ret
-- Rule
BITORIS:
  call __prefix
  opencapture 139
  char 7c
  char 3d
  closecapture 139 0
  ret
-- Rule
BITXORIS:
  call __prefix
  opencapture 140
  char 5e
  char 3d
  closecapture 140 0
  ret
-- Rule
BITNOTIS:
  call __prefix
  opencapture 141
  char 7e
  char 3d
  closecapture 141 0
  ret
-- Rule
COMMA:
  call __prefix
  char 2c
  ret
-- Rule
DOT:
  call __prefix
  opencapture 142
  char 2e
  closecapture 142 0
  ret
-- Rule
LSHIFT:
  call __prefix
  opencapture 143
  char 3c
  char 3c
  closecapture 143 0
  catch __TERM_3778
  char 3d
  failtwice
__TERM_3778:
  ret
-- Rule
RSHIFT:
  call __prefix
  opencapture 144
  char 3e
  char 3e
  closecapture 144 0
  catch __TERM_3796
  char 3d
  failtwice
__TERM_3796:
  ret
-- Rule
LSHIFTIS:
  call __prefix
  opencapture 145
  char 3c
  char 3c
  char 3d
  closecapture 145 0
  ret
-- Rule
RSHIFTIS:
  call __prefix
  opencapture 146
  char 3e
  char 3e
  char 3d
  closecapture 146 0
  ret

  end 0

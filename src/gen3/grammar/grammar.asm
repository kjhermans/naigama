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
  call COLON
  call EXPRESSION
  opencapture 25
  call CBCLOSE
  closecapture 25 0
  call CAPTUREEND
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  opencapture 26
  call CBCLOSE
  closecapture 26 0
  call CAPTUREEND
  ret
-- Rule
GROUP:
  call __prefix
  call BOPEN
  call EXPRESSION
  opencapture 27
  call BCLOSE
  closecapture 27 0
  ret
-- Rule
CAPTUREEND:
  call __prefix
  catch __TERM_685
  catch __RIGHTHAND_688
  call REPLACE
  commit __LEFTHAND_689
__RIGHTHAND_688:
  call RECYCLE
__LEFTHAND_689:
  commit __TERM_685
__TERM_685:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 28
  catch __TERM_717
  call SETNOT
  commit __TERM_717
__TERM_717:
  closecapture 28 0
  catch __RIGHTHAND_726
  opencapture 29
  catch __RIGHTHAND_734
  char 5c
  catch __RIGHTHAND_748
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_749
__RIGHTHAND_748:
  counter 2 3
__TERM_758:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_758
__LEFTHAND_749:
  commit __LEFTHAND_735
__RIGHTHAND_734:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_735:
  closecapture 29 0
  char 2d
  opencapture 30
  catch __RIGHTHAND_780
  char 5c
  catch __RIGHTHAND_794
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_795
__RIGHTHAND_794:
  counter 2 3
__TERM_804:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_804
__LEFTHAND_795:
  commit __LEFTHAND_781
__RIGHTHAND_780:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_781:
  closecapture 30 0
  commit __LEFTHAND_727
__RIGHTHAND_726:
  opencapture 31
  catch __RIGHTHAND_820
  char 5c
  catch __RIGHTHAND_834
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_835
__RIGHTHAND_834:
  counter 2 3
__TERM_844:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_844
__LEFTHAND_835:
  commit __LEFTHAND_821
__RIGHTHAND_820:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_821:
  closecapture 31 0
__LEFTHAND_727:
  catch __TERM_724
__TERM_723:
  catch __RIGHTHAND_854
  opencapture 29
  catch __RIGHTHAND_862
  char 5c
  catch __RIGHTHAND_876
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_877
__RIGHTHAND_876:
  counter 2 3
__TERM_886:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_886
__LEFTHAND_877:
  commit __LEFTHAND_863
__RIGHTHAND_862:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_863:
  closecapture 29 0
  char 2d
  opencapture 30
  catch __RIGHTHAND_908
  char 5c
  catch __RIGHTHAND_922
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_923
__RIGHTHAND_922:
  counter 2 3
__TERM_932:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_932
__LEFTHAND_923:
  commit __LEFTHAND_909
__RIGHTHAND_908:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_909:
  closecapture 30 0
  commit __LEFTHAND_855
__RIGHTHAND_854:
  opencapture 31
  catch __RIGHTHAND_948
  char 5c
  catch __RIGHTHAND_962
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_963
__RIGHTHAND_962:
  counter 2 3
__TERM_972:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_972
__LEFTHAND_963:
  commit __LEFTHAND_949
__RIGHTHAND_948:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_949:
  closecapture 31 0
__LEFTHAND_855:
  partialcommit __TERM_723
__TERM_724:
  opencapture 32
  call ABCLOSE
  closecapture 32 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1006
  opencapture 33
  call IDENT
  closecapture 33 0
  commit __LEFTHAND_1007
__RIGHTHAND_1006:
  opencapture 34
  call NUMBER
  closecapture 34 0
__LEFTHAND_1007:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1038
  call LEFTARROW
  failtwice
__TERM_1038:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 35
  call REPLACETERMS
  closecapture 35 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __TERM_1072
__TERM_1071:
  call REPLACETERM
  partialcommit __TERM_1071
__TERM_1072:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1074
  opencapture 36
  call STRINGLITERAL
  closecapture 36 0
  commit __LEFTHAND_1075
__RIGHTHAND_1074:
  catch __RIGHTHAND_1088
  opencapture 37
  call HEXLITERAL
  closecapture 37 0
  commit __LEFTHAND_1089
__RIGHTHAND_1088:
  opencapture 38
  call VARREFERENCE
  closecapture 38 0
__LEFTHAND_1089:
__LEFTHAND_1075:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 39
  call IDENT
  closecapture 39 0
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
  catch __TERM_1178
__TERM_1177:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1177
__TERM_1178:
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 2 2
__TERM_1188:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 2 __TERM_1188
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1196
__TERM_1195:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1195
__TERM_1196:
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1207
  char 69
  commit __TERM_1207
__TERM_1207:
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
  opencapture 40
  catch __TERM_1279
  call IDENT
  catch __TERM_1292
__TERM_1291:
  call COMMA
  call IDENT
  partialcommit __TERM_1291
__TERM_1292:
  commit __TERM_1279
__TERM_1279:
  closecapture 40 0
  call BCLOSE
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  opencapture 41
  catch __TERM_1328
__TERM_1327:
  call LOWSTMT
  partialcommit __TERM_1327
__TERM_1328:
  closecapture 41 0
  call CBCLOSE
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1336
  opencapture 42
  call ST_IF
  closecapture 42 0
  commit __LEFTHAND_1337
__RIGHTHAND_1336:
  catch __RIGHTHAND_1350
  opencapture 43
  call ST_WHILE
  closecapture 43 0
  commit __LEFTHAND_1351
__RIGHTHAND_1350:
  catch __RIGHTHAND_1364
  opencapture 44
  call ST_RETURN
  closecapture 44 0
  commit __LEFTHAND_1365
__RIGHTHAND_1364:
  catch __RIGHTHAND_1378
  opencapture 45
  call ST_OTHER
  closecapture 45 0
  commit __LEFTHAND_1379
__RIGHTHAND_1378:
  catch __RIGHTHAND_1392
  opencapture 46
  call VARDECL
  closecapture 46 0
  commit __LEFTHAND_1393
__RIGHTHAND_1392:
  catch __RIGHTHAND_1406
  opencapture 47
  call ASSIGNMENT
  closecapture 47 0
  commit __LEFTHAND_1407
__RIGHTHAND_1406:
  catch __TERM_1423
  call SCR_EXPRESSION
  commit __TERM_1423
__TERM_1423:
  call SEMICOLON
__LEFTHAND_1407:
__LEFTHAND_1393:
__LEFTHAND_1379:
__LEFTHAND_1365:
__LEFTHAND_1351:
__LEFTHAND_1337:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 48
  call SCR_EXPRESSION
  closecapture 48 0
  call BCLOSE
  call CBOPEN
  opencapture 49
  catch __TERM_1484
__TERM_1483:
  call LOWSTMT
  partialcommit __TERM_1483
__TERM_1484:
  closecapture 49 0
  call CBCLOSE
  opencapture 50
  catch __TERM_1502
__TERM_1501:
  call IF_ELSEIF
  partialcommit __TERM_1501
__TERM_1502:
  closecapture 50 0
  opencapture 51
  catch __TERM_1513
  call IF_ELSE
  commit __TERM_1513
__TERM_1513:
  closecapture 51 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 52
  call SCR_EXPRESSION
  closecapture 52 0
  call BCLOSE
  call CBOPEN
  opencapture 53
  catch __TERM_1562
__TERM_1561:
  call LOWSTMT
  partialcommit __TERM_1561
__TERM_1562:
  closecapture 53 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 54
  catch __TERM_1592
__TERM_1591:
  call LOWSTMT
  partialcommit __TERM_1591
__TERM_1592:
  closecapture 54 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 55
  call SCR_EXPRESSION
  closecapture 55 0
  call BCLOSE
  call CBOPEN
  opencapture 56
  catch __TERM_1646
__TERM_1645:
  call LOWSTMT
  partialcommit __TERM_1645
__TERM_1646:
  closecapture 56 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 57
  catch __TERM_1669
  call SCR_EXPRESSION
  commit __TERM_1669
__TERM_1669:
  closecapture 57 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_1684
  call KW_BREAK
  commit __LEFTHAND_1685
__RIGHTHAND_1684:
  call KW_CONTINUE
__LEFTHAND_1685:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  call IDENT
  catch __TERM_1725
  call ASSIGN
  opencapture 58
  call SCR_EXPRESSION
  closecapture 58 0
  commit __TERM_1725
__TERM_1725:
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
  opencapture 59
  call BINOP_P11
  closecapture 59 0
  catch __TERM_1798
__TERM_1797:
  call LOGOR
  call BINOP_P11
  partialcommit __TERM_1797
__TERM_1798:
  ret
-- Rule
BINOP_P11:
  call __prefix
  opencapture 60
  call BINOP_P10
  closecapture 60 0
  catch __TERM_1828
__TERM_1827:
  call LOGAND
  call BINOP_P10
  partialcommit __TERM_1827
__TERM_1828:
  ret
-- Rule
BINOP_P10:
  call __prefix
  opencapture 61
  call BINOP_P09
  closecapture 61 0
  catch __TERM_1858
__TERM_1857:
  call BITOR
  call BINOP_P09
  partialcommit __TERM_1857
__TERM_1858:
  ret
-- Rule
BINOP_P09:
  call __prefix
  opencapture 62
  call BINOP_P08
  closecapture 62 0
  catch __TERM_1888
__TERM_1887:
  call BITXOR
  call BINOP_P08
  partialcommit __TERM_1887
__TERM_1888:
  ret
-- Rule
BINOP_P08:
  call __prefix
  opencapture 63
  call BINOP_P07
  closecapture 63 0
  catch __TERM_1918
__TERM_1917:
  call BITAND
  call BINOP_P07
  partialcommit __TERM_1917
__TERM_1918:
  ret
-- Rule
BINOP_P07:
  call __prefix
  opencapture 64
  call BINOP_P06
  closecapture 64 0
  catch __TERM_1948
__TERM_1947:
  catch __RIGHTHAND_1956
  call EQUALS
  commit __LEFTHAND_1957
__RIGHTHAND_1956:
  call NEQUALS
__LEFTHAND_1957:
  call BINOP_P06
  partialcommit __TERM_1947
__TERM_1948:
  ret
-- Rule
BINOP_P06:
  call __prefix
  opencapture 65
  call BINOP_P05
  closecapture 65 0
  catch __TERM_1992
__TERM_1991:
  catch __RIGHTHAND_2000
  call LTEQ
  commit __LEFTHAND_2001
__RIGHTHAND_2000:
  catch __RIGHTHAND_2008
  call LT
  commit __LEFTHAND_2009
__RIGHTHAND_2008:
  catch __RIGHTHAND_2016
  call GTEQ
  commit __LEFTHAND_2017
__RIGHTHAND_2016:
  call GT
__LEFTHAND_2017:
__LEFTHAND_2009:
__LEFTHAND_2001:
  call BINOP_P05
  partialcommit __TERM_1991
__TERM_1992:
  ret
-- Rule
BINOP_P05:
  call __prefix
  opencapture 66
  call BINOP_P04
  closecapture 66 0
  catch __TERM_2052
__TERM_2051:
  catch __RIGHTHAND_2060
  call LSHIFT
  commit __LEFTHAND_2061
__RIGHTHAND_2060:
  call RSHIFT
__LEFTHAND_2061:
  call BINOP_P04
  partialcommit __TERM_2051
__TERM_2052:
  ret
-- Rule
BINOP_P04:
  call __prefix
  opencapture 67
  call BINOP_P03
  closecapture 67 0
  catch __TERM_2096
__TERM_2095:
  catch __RIGHTHAND_2104
  call ADD
  commit __LEFTHAND_2105
__RIGHTHAND_2104:
  call SUB
__LEFTHAND_2105:
  call BINOP_P03
  partialcommit __TERM_2095
__TERM_2096:
  ret
-- Rule
BINOP_P03:
  call __prefix
  opencapture 68
  call UNARIES
  closecapture 68 0
  catch __TERM_2140
__TERM_2139:
  catch __RIGHTHAND_2148
  call MUL
  commit __LEFTHAND_2149
__RIGHTHAND_2148:
  catch __RIGHTHAND_2156
  call DIV
  commit __LEFTHAND_2157
__RIGHTHAND_2156:
  call POW
__LEFTHAND_2157:
__LEFTHAND_2149:
  call UNARIES
  partialcommit __TERM_2139
__TERM_2140:
  ret
-- Rule
UNARIES:
  call __prefix
  catch __TERM_2180
__TERM_2179:
  opencapture 69
  call UNARY
  closecapture 69 0
  partialcommit __TERM_2179
__TERM_2180:
  opencapture 70
  call SCR_TERM
  closecapture 70 0
  ret
-- Rule
UNARY:
  call __prefix
  opencapture 71
  catch __RIGHTHAND_2206
  call LOGNOT
  commit __LEFTHAND_2207
__RIGHTHAND_2206:
  catch __RIGHTHAND_2214
  call BITNOT
  commit __LEFTHAND_2215
__RIGHTHAND_2214:
  catch __RIGHTHAND_2222
  call INC
  commit __LEFTHAND_2223
__RIGHTHAND_2222:
  call DEC
__LEFTHAND_2223:
__LEFTHAND_2215:
__LEFTHAND_2207:
  closecapture 71 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2236
  opencapture 72
  call LITERAL
  closecapture 72 0
  commit __LEFTHAND_2237
__RIGHTHAND_2236:
  catch __RIGHTHAND_2250
  opencapture 73
  call FUNCTIONCALL
  closecapture 73 0
  commit __LEFTHAND_2251
__RIGHTHAND_2250:
  catch __RIGHTHAND_2264
  opencapture 74
  call SCR_REFERENCE
  closecapture 74 0
  commit __LEFTHAND_2265
__RIGHTHAND_2264:
  opencapture 75
  call BOPEN
  opencapture 76
  call SCR_EXPRESSION
  closecapture 76 0
  call BCLOSE
  closecapture 75 0
__LEFTHAND_2265:
__LEFTHAND_2251:
__LEFTHAND_2237:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 77
  call SCR_REFERENCE
  closecapture 77 0
  call BOPEN
  catch __TERM_2329
  call SCR_EXPRESSION
  catch __TERM_2342
__TERM_2341:
  call COMMA
  call SCR_EXPRESSION
  partialcommit __TERM_2341
__TERM_2342:
  commit __TERM_2329
__TERM_2329:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_2372
__TERM_2371:
  call DOT
  call IDENT
  partialcommit __TERM_2371
__TERM_2372:
  catch __TERM_2390
__TERM_2389:
  call INDEX
  partialcommit __TERM_2389
__TERM_2390:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 78
  call SCR_EXPRESSION
  closecapture 78 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_2416
  call STRINGLITERAL
  commit __LEFTHAND_2417
__RIGHTHAND_2416:
  catch __RIGHTHAND_2424
  call HASHLITERAL
  commit __LEFTHAND_2425
__RIGHTHAND_2424:
  catch __RIGHTHAND_2432
  call LISTLITERAL
  commit __LEFTHAND_2433
__RIGHTHAND_2432:
  catch __RIGHTHAND_2440
  call FLOATLITERAL
  commit __LEFTHAND_2441
__RIGHTHAND_2440:
  catch __RIGHTHAND_2448
  call INTLITERAL
  commit __LEFTHAND_2449
__RIGHTHAND_2448:
  call BOOLEANLITERAL
__LEFTHAND_2449:
__LEFTHAND_2441:
__LEFTHAND_2433:
__LEFTHAND_2425:
__LEFTHAND_2417:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 79
  catch __TERM_2478
__TERM_2477:
  catch __RIGHTHAND_2480
  char 5c
  catch __RIGHTHAND_2494
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_2495
__RIGHTHAND_2494:
  counter 3 3
__TERM_2504:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __TERM_2504
__LEFTHAND_2495:
  commit __LEFTHAND_2481
__RIGHTHAND_2480:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_2481:
  partialcommit __TERM_2477
__TERM_2478:
  closecapture 79 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 80
  call CBOPEN
  catch __TERM_2535
  call HASHELT
  catch __TERM_2548
__TERM_2547:
  call COMMA
  call HASHELT
  partialcommit __TERM_2547
__TERM_2548:
  commit __TERM_2535
__TERM_2535:
  call CBCLOSE
  closecapture 80 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 81
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 81 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 82
  call SCR_TERM
  closecapture 82 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 83
  call SCR_TERM
  closecapture 83 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 84
  call ABOPEN
  catch __TERM_2631
  call LISTELT
  catch __TERM_2644
__TERM_2643:
  call COMMA
  call LISTELT
  partialcommit __TERM_2643
__TERM_2644:
  commit __TERM_2631
__TERM_2631:
  call ABCLOSE
  closecapture 84 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 85
  call SCR_TERM
  closecapture 85 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 86
  catch __TERM_2686
__TERM_2685:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2685
__TERM_2686:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2698
__TERM_2697:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2697
__TERM_2698:
  closecapture 86 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 87
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2710
__TERM_2709:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2709
__TERM_2710:
  closecapture 87 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 88
  catch __RIGHTHAND_2718
  quad 74727565
  commit __LEFTHAND_2719
__RIGHTHAND_2718:
  quad 66616c73
  char 65
__LEFTHAND_2719:
  closecapture 88 0
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
  opencapture 89
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_2801
  counter 3 63
__TERM_2802:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_2803
__TERM_2803:
  condjump 3 __TERM_2802
  commit __TERM_2801
__TERM_2801:
  closecapture 89 0
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
  opencapture 90
  catch __RIGHTHAND_2846
  call ASSIGN
  commit __LEFTHAND_2847
__RIGHTHAND_2846:
  catch __RIGHTHAND_2854
  call PLUSIS
  commit __LEFTHAND_2855
__RIGHTHAND_2854:
  catch __RIGHTHAND_2862
  call MINIS
  commit __LEFTHAND_2863
__RIGHTHAND_2862:
  catch __RIGHTHAND_2870
  call MULIS
  commit __LEFTHAND_2871
__RIGHTHAND_2870:
  catch __RIGHTHAND_2878
  call DIVIS
  commit __LEFTHAND_2879
__RIGHTHAND_2878:
  catch __RIGHTHAND_2886
  call BITANDIS
  commit __LEFTHAND_2887
__RIGHTHAND_2886:
  catch __RIGHTHAND_2894
  call BITORIS
  commit __LEFTHAND_2895
__RIGHTHAND_2894:
  catch __RIGHTHAND_2902
  call BITXORIS
  commit __LEFTHAND_2903
__RIGHTHAND_2902:
  catch __RIGHTHAND_2910
  call BITNOTIS
  commit __LEFTHAND_2911
__RIGHTHAND_2910:
  catch __RIGHTHAND_2918
  call LSHIFTIS
  commit __LEFTHAND_2919
__RIGHTHAND_2918:
  call RSHIFTIS
__LEFTHAND_2919:
__LEFTHAND_2911:
__LEFTHAND_2903:
__LEFTHAND_2895:
__LEFTHAND_2887:
__LEFTHAND_2879:
__LEFTHAND_2871:
__LEFTHAND_2863:
__LEFTHAND_2855:
__LEFTHAND_2847:
  closecapture 90 0
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
  catch __TERM_2980
  char 3d
  failtwice
__TERM_2980:
  ret
-- Rule
GT:
  call __prefix
  char 3e
  catch __TERM_2992
  char 3d
  failtwice
__TERM_2992:
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
  catch __TERM_3034
  char 2a
  failtwice
__TERM_3034:
  ret
-- Rule
DIV:
  call __prefix
  char 2f
  catch __TERM_3046
  char 3d
  failtwice
__TERM_3046:
  ret
-- Rule
ADD:
  call __prefix
  char 2b
  catch __TERM_3058
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3058:
  ret
-- Rule
SUB:
  call __prefix
  char 2d
  catch __TERM_3070
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3070:
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
  catch __TERM_3106
  char 3d
  failtwice
__TERM_3106:
  ret
-- Rule
BITAND:
  call __prefix
  char 26
  catch __TERM_3118
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3118:
  ret
-- Rule
BITOR:
  call __prefix
  char 7c
  catch __TERM_3130
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3130:
  ret
-- Rule
BITXOR:
  call __prefix
  char 5e
  catch __TERM_3142
  char 3d
  failtwice
__TERM_3142:
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
  catch __TERM_3196
  char 3d
  failtwice
__TERM_3196:
  ret
-- Rule
RSHIFT:
  call __prefix
  char 3e
  char 3e
  catch __TERM_3208
  char 3d
  failtwice
__TERM_3208:
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

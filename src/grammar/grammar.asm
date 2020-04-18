  call GRAMMAR
  end
-- Rule
GRAMMAR:
  catch __LABEL_6 -- terms or expression
  call DEFINITION
  catch __LABEL_12 -- 2
__LABEL_11:
  call DEFINITION
  partialcommit __LABEL_11
__LABEL_12:
  commit __LABEL_7
__LABEL_6:
  call SINGLE_EXPRESSION
__LABEL_7:
  call END
  ret
-- Rule
__prefix:
  catch __LABEL_30 -- 2
__LABEL_29:
  catch __LABEL_32 -- terms or expression
  char 2d
  char 2d
  catch __LABEL_44 -- 2
__LABEL_43:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __LABEL_43
__LABEL_44:
  char 0a
  commit __LABEL_33
__LABEL_32:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __LABEL_56 -- 2
__LABEL_55:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __LABEL_55
__LABEL_56:
__LABEL_33:
  partialcommit __LABEL_29
__LABEL_30:
  ret
-- Rule
END:
  call __prefix
  catch __LABEL_58  -- 1
  any
  failtwice
__LABEL_58:
  ret
-- Rule
DEFINITION:
  call __prefix
  call RULE
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
  call OPTARGS
  call LEFTARROW
  call EXPRESSION
  ret
-- Rule
EXPRESSION:
  call __prefix
  catch __LABEL_106 -- terms or expression
  opencapture 1
  call TERMS
  closecapture 1 0
  call OR
  call NOTHING
  commit __LABEL_107
__LABEL_106:
  catch __LABEL_132 -- terms or expression
  opencapture 2
  call TERMS
  closecapture 2 0
  call OR
  call EXPRESSION
  commit __LABEL_133
__LABEL_132:
  catch __LABEL_158 -- terms or expression
  opencapture 3
  call TERMS
  closecapture 3 0
  commit __LABEL_159
__LABEL_158:
  call CALL
__LABEL_159:
__LABEL_133:
__LABEL_107:
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 4
  call TERM
  closecapture 4 0
  catch __LABEL_182 -- 2
__LABEL_181:
  opencapture 4
  call TERM
  closecapture 4 0
  partialcommit __LABEL_181
__LABEL_182:
  ret
-- Rule
TERM:
  call __prefix
  catch __LABEL_199 -- 4
  opencapture 5
  catch __LABEL_202 -- terms or expression
  call NOT
  commit __LABEL_203
__LABEL_202:
  call AND
__LABEL_203:
  closecapture 5 0
  partialcommit __LABEL_200
__LABEL_200:
  commit __LABEL_199
__LABEL_199:
  call MATCHER
  catch __LABEL_225 -- 4
  opencapture 6
  call QUANTIFIER
  closecapture 6 0
  partialcommit __LABEL_226
__LABEL_226:
  commit __LABEL_225
__LABEL_225:
  ret
-- Rule
QUANTIFIER:
  call __prefix
  catch __LABEL_234 -- terms or expression
  char 3f
  commit __LABEL_235
__LABEL_234:
  catch __LABEL_242 -- terms or expression
  char 2b
  commit __LABEL_243
__LABEL_242:
  catch __LABEL_250 -- terms or expression
  char 2a
  commit __LABEL_251
__LABEL_250:
  catch __LABEL_258 -- terms or expression
  char 5e
  opencapture 7
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __LABEL_276 -- 2
__LABEL_275:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __LABEL_275
__LABEL_276:
  closecapture 7 0
  char 2d
  opencapture 8
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __LABEL_294 -- 2
__LABEL_293:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __LABEL_293
__LABEL_294:
  closecapture 8 0
  commit __LABEL_259
__LABEL_258:
  catch __LABEL_296 -- terms or expression
  char 5e
  char 2d
  opencapture 9
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __LABEL_320 -- 2
__LABEL_319:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __LABEL_319
__LABEL_320:
  closecapture 9 0
  commit __LABEL_297
__LABEL_296:
  catch __LABEL_322 -- terms or expression
  char 5e
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __LABEL_340 -- 2
__LABEL_339:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __LABEL_339
__LABEL_340:
  closecapture 10 0
  char 2d
  commit __LABEL_323
__LABEL_322:
  catch __LABEL_348 -- terms or expression
  char 5e
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __LABEL_366 -- 2
__LABEL_365:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __LABEL_365
__LABEL_366:
  closecapture 11 0
  commit __LABEL_349
__LABEL_348:
  char 5e
  char 24
  opencapture 12
  call IDENT
  closecapture 12 0
__LABEL_349:
__LABEL_323:
__LABEL_297:
__LABEL_259:
__LABEL_251:
__LABEL_243:
__LABEL_235:
  ret
-- Rule
MATCHER:
  call __prefix
  catch __LABEL_386 -- terms or expression
  opencapture 13
  call ANY
  closecapture 13 0
  commit __LABEL_387
__LABEL_386:
  catch __LABEL_400 -- terms or expression
  opencapture 14
  call SET
  closecapture 14 0
  commit __LABEL_401
__LABEL_400:
  catch __LABEL_414 -- terms or expression
  opencapture 15
  call STRING
  closecapture 15 0
  commit __LABEL_415
__LABEL_414:
  catch __LABEL_428 -- terms or expression
  opencapture 16
  call BITMASK
  closecapture 16 0
  commit __LABEL_429
__LABEL_428:
  catch __LABEL_442 -- terms or expression
  opencapture 17
  call HEXLITERAL
  closecapture 17 0
  commit __LABEL_443
__LABEL_442:
  catch __LABEL_456 -- terms or expression
  opencapture 18
  call VARCAPTURE
  closecapture 18 0
  commit __LABEL_457
__LABEL_456:
  catch __LABEL_470 -- terms or expression
  opencapture 19
  call CAPTURE
  closecapture 19 0
  commit __LABEL_471
__LABEL_470:
  catch __LABEL_484 -- terms or expression
  opencapture 20
  call GROUP
  closecapture 20 0
  commit __LABEL_485
__LABEL_484:
  catch __LABEL_498 -- terms or expression
  opencapture 21
  call MACRO
  closecapture 21 0
  commit __LABEL_499
__LABEL_498:
  catch __LABEL_512 -- terms or expression
  opencapture 22
  call VARREFERENCE
  closecapture 22 0
  commit __LABEL_513
__LABEL_512:
  opencapture 23
  call REFERENCE
  closecapture 23 0
__LABEL_513:
__LABEL_499:
__LABEL_485:
__LABEL_471:
__LABEL_457:
__LABEL_443:
__LABEL_429:
__LABEL_415:
__LABEL_401:
__LABEL_387:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__LABEL_546:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __LABEL_546
  char 7c
  counter 1 2
__LABEL_558:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __LABEL_558
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
  catch __LABEL_595 -- 4
  call SEMICOLON
  opencapture 25
  call TYPE
  closecapture 25 0
  partialcommit __LABEL_596
__LABEL_596:
  commit __LABEL_595
__LABEL_595:
  call COLON
  call EXPRESSION
  catch __LABEL_631 -- 4
  call COLON
  partialcommit __LABEL_632
__LABEL_632:
  commit __LABEL_631
__LABEL_631:
  opencapture 26
  call CBCLOSE
  closecapture 26 0
  catch __LABEL_649 -- 4
  catch __LABEL_652 -- terms or expression
  call REPLACE
  commit __LABEL_653
__LABEL_652:
  call RECYCLE
__LABEL_653:
  partialcommit __LABEL_650
__LABEL_650:
  commit __LABEL_649
__LABEL_649:
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  opencapture 27
  call CBCLOSE
  closecapture 27 0
  catch __LABEL_693 -- 4
  catch __LABEL_696 -- terms or expression
  call REPLACE
  commit __LABEL_697
__LABEL_696:
  call RECYCLE
__LABEL_697:
  partialcommit __LABEL_694
__LABEL_694:
  commit __LABEL_693
__LABEL_693:
  ret
-- Rule
GROUP:
  call __prefix
  call BOPEN
  call EXPRESSION
  opencapture 28
  call BCLOSE
  closecapture 28 0
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 29
  catch __LABEL_749 -- 4
  call SETNOT
  partialcommit __LABEL_750
__LABEL_750:
  commit __LABEL_749
__LABEL_749:
  closecapture 29 0
  catch __LABEL_758 -- terms or expression
  opencapture 30
  catch __LABEL_766 -- terms or expression
  char 5c
  catch __LABEL_780 -- terms or expression
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __LABEL_781
__LABEL_780:
  counter 2 3
__LABEL_790:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __LABEL_790
__LABEL_781:
  commit __LABEL_767
__LABEL_766:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LABEL_767:
  closecapture 30 0
  char 2d
  opencapture 31
  catch __LABEL_812 -- terms or expression
  char 5c
  catch __LABEL_826 -- terms or expression
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __LABEL_827
__LABEL_826:
  counter 2 3
__LABEL_836:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __LABEL_836
__LABEL_827:
  commit __LABEL_813
__LABEL_812:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LABEL_813:
  closecapture 31 0
  commit __LABEL_759
__LABEL_758:
  opencapture 32
  catch __LABEL_852 -- terms or expression
  char 5c
  catch __LABEL_866 -- terms or expression
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __LABEL_867
__LABEL_866:
  counter 2 3
__LABEL_876:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __LABEL_876
__LABEL_867:
  commit __LABEL_853
__LABEL_852:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LABEL_853:
  closecapture 32 0
__LABEL_759:
  catch __LABEL_756 -- 2
__LABEL_755:
  catch __LABEL_886 -- terms or expression
  opencapture 30
  catch __LABEL_894 -- terms or expression
  char 5c
  catch __LABEL_908 -- terms or expression
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __LABEL_909
__LABEL_908:
  counter 2 3
__LABEL_918:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __LABEL_918
__LABEL_909:
  commit __LABEL_895
__LABEL_894:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LABEL_895:
  closecapture 30 0
  char 2d
  opencapture 31
  catch __LABEL_940 -- terms or expression
  char 5c
  catch __LABEL_954 -- terms or expression
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __LABEL_955
__LABEL_954:
  counter 2 3
__LABEL_964:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __LABEL_964
__LABEL_955:
  commit __LABEL_941
__LABEL_940:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LABEL_941:
  closecapture 31 0
  commit __LABEL_887
__LABEL_886:
  opencapture 32
  catch __LABEL_980 -- terms or expression
  char 5c
  catch __LABEL_994 -- terms or expression
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __LABEL_995
__LABEL_994:
  counter 2 3
__LABEL_1004:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __LABEL_1004
__LABEL_995:
  commit __LABEL_981
__LABEL_980:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LABEL_981:
  closecapture 32 0
__LABEL_887:
  partialcommit __LABEL_755
__LABEL_756:
  opencapture 33
  call ABCLOSE
  closecapture 33 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __LABEL_1038 -- terms or expression
  opencapture 34
  call IDENT
  closecapture 34 0
  commit __LABEL_1039
__LABEL_1038:
  opencapture 35
  call NUMBER
  closecapture 35 0
__LABEL_1039:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __LABEL_1070  -- 1
  call OPTARGS
  call LEFTARROW
  failtwice
__LABEL_1070:
  ret
-- Rule
TYPE:
  call __prefix
  catch __LABEL_1088 -- terms or expression
  char 75
  char 69
  char 6e
  char 74
  char 33
  char 32
  commit __LABEL_1089
__LABEL_1088:
  catch __LABEL_1096 -- terms or expression
  char 69
  char 6e
  char 74
  char 33
  char 32
  commit __LABEL_1097
__LABEL_1096:
  catch __LABEL_1104 -- terms or expression
  char 75
  char 6e
  char 65
  char 74
  char 33
  char 32
  commit __LABEL_1105
__LABEL_1104:
  catch __LABEL_1112 -- terms or expression
  char 6e
  char 65
  char 74
  char 33
  char 32
  commit __LABEL_1113
__LABEL_1112:
  catch __LABEL_1120 -- terms or expression
  char 64
  char 65
  char 63
  char 69
  char 6d
  char 61
  char 6c
  commit __LABEL_1121
__LABEL_1120:
  call IDENT
__LABEL_1121:
__LABEL_1113:
__LABEL_1105:
__LABEL_1097:
__LABEL_1089:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 36
  call REPLACETERMS
  closecapture 36 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __LABEL_1156 -- 2
__LABEL_1155:
  call REPLACETERM
  partialcommit __LABEL_1155
__LABEL_1156:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __LABEL_1158 -- terms or expression
  opencapture 37
  call STRINGLITERAL
  closecapture 37 0
  commit __LABEL_1159
__LABEL_1158:
  catch __LABEL_1172 -- terms or expression
  opencapture 38
  call HEXLITERAL
  closecapture 38 0
  commit __LABEL_1173
__LABEL_1172:
  opencapture 39
  call VARREFERENCE
  closecapture 39 0
__LABEL_1173:
__LABEL_1159:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 40
  call IDENT
  closecapture 40 0
  ret
-- Rule
IDENT:
  call __prefix
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __LABEL_1225 -- 3
  counter 2 63
__LABEL_1226:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __LABEL_1227
__LABEL_1227:
  condjump 2 __LABEL_1226
  commit __LABEL_1225
__LABEL_1225:
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
  catch __LABEL_1274 -- 2
__LABEL_1273:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __LABEL_1273
__LABEL_1274:
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 3 2
__LABEL_1284:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 3 __LABEL_1284
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __LABEL_1292 -- 2
__LABEL_1291:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __LABEL_1291
__LABEL_1292:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  catch __LABEL_1304 -- 2
__LABEL_1303:
  catch __LABEL_1306 -- terms or expression
  char 5c
  catch __LABEL_1320 -- terms or expression
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LABEL_1321
__LABEL_1320:
  counter 4 3
__LABEL_1330:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 4 __LABEL_1330
__LABEL_1321:
  commit __LABEL_1307
__LABEL_1306:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LABEL_1307:
  partialcommit __LABEL_1303
__LABEL_1304:
  char 27
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __LABEL_1355 -- 4
  char 69
  partialcommit __LABEL_1356
__LABEL_1356:
  commit __LABEL_1355
__LABEL_1355:
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
CBOPEN:
  call __prefix
  char 7b
  ret
-- Rule
COLON:
  call __prefix
  char 3a
  ret
-- Rule
CBCLOSE:
  call __prefix
  char 7d
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
SETNOT:
  call __prefix
  char 5e
  ret
-- Rule
SEMICOLON:
  call __prefix
  char 3b
  ret
-- Rule
COMMA:
  call __prefix
  char 2c
  ret
-- Rule
LT:
  call __prefix
  char 3c
  ret
-- Rule
GT:
  call __prefix
  char 3e
  ret
-- Rule
OPTARGS:
  call __prefix
  catch __LABEL_1451 -- 4
  opencapture 41
  call ARGS
  closecapture 41 0
  partialcommit __LABEL_1452
__LABEL_1452:
  commit __LABEL_1451
__LABEL_1451:
  ret
-- Rule
ARGS:
  call __prefix
  call BOPEN
  opencapture 42
  call IDENT
  closecapture 42 0
  catch __LABEL_1482 -- 2
__LABEL_1481:
  call COMMA
  opencapture 43
  call IDENT
  closecapture 43 0
  partialcommit __LABEL_1481
__LABEL_1482:
  call BCLOSE
  ret
-- Rule
CALL:
  call __prefix
  call LT
  opencapture 44
  call IDENT
  closecapture 44 0
  opencapture 45
  call ARGS
  closecapture 45 0
  call GT
  ret

  end 0

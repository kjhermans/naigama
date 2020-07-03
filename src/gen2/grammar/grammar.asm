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
__prefix:
  catch __TERM_30
__TERM_29:
  catch __RIGHTHAND_32
  char 2d
  char 2d
  catch __TERM_44
__TERM_43:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_43
__TERM_44:
  char 0a
  commit __LEFTHAND_33
__RIGHTHAND_32:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __TERM_56
__TERM_55:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_55
__TERM_56:
__LEFTHAND_33:
  partialcommit __TERM_29
__TERM_30:
  ret
-- Rule
END:
  call __prefix
  catch __TERM_58
  any
  failtwice
__TERM_58:
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
  catch __RIGHTHAND_106
  opencapture 1
  call TERMS
  closecapture 1 0
  call OR
  call NOTHING
  commit __LEFTHAND_107
__RIGHTHAND_106:
  catch __RIGHTHAND_132
  opencapture 2
  call TERMS
  closecapture 2 0
  call OR
  call EXPRESSION
  commit __LEFTHAND_133
__RIGHTHAND_132:
  catch __RIGHTHAND_158
  opencapture 3
  call TERMS
  closecapture 3 0
  commit __LEFTHAND_159
__RIGHTHAND_158:
  call CALL
__LEFTHAND_159:
__LEFTHAND_133:
__LEFTHAND_107:
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 4
  call TERM
  closecapture 4 0
  catch __TERM_182
__TERM_181:
  opencapture 4
  call TERM
  closecapture 4 0
  partialcommit __TERM_181
__TERM_182:
  ret
-- Rule
TERM:
  call __prefix
  catch __RIGHTHAND_196
  opencapture 5
  call NAMESPACE
  closecapture 5 0
  commit __LEFTHAND_197
__RIGHTHAND_196:
  opencapture 6
  call ENDOWEDMATCHER
  closecapture 6 0
__LEFTHAND_197:
  ret
-- Rule
NAMESPACE:
  call __prefix
  call NSOPEN
  call EXPRESSION
  call NSCLOSE
  ret
-- Rule
ENDOWEDMATCHER:
  call __prefix
  catch __TERM_243
  opencapture 7
  catch __RIGHTHAND_246
  call NOT
  commit __LEFTHAND_247
__RIGHTHAND_246:
  call AND
__LEFTHAND_247:
  closecapture 7 0
  commit __TERM_243
__TERM_243:
  call MATCHER
  catch __TERM_269
  opencapture 8
  call QUANTIFIER
  closecapture 8 0
  commit __TERM_269
__TERM_269:
  ret
-- Rule
QUANTIFIER:
  call __prefix
  catch __RIGHTHAND_278
  char 3f
  commit __LEFTHAND_279
__RIGHTHAND_278:
  catch __RIGHTHAND_286
  char 2b
  commit __LEFTHAND_287
__RIGHTHAND_286:
  catch __RIGHTHAND_294
  char 2a
  commit __LEFTHAND_295
__RIGHTHAND_294:
  catch __RIGHTHAND_302
  char 5e
  opencapture 9
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_320
__TERM_319:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_319
__TERM_320:
  closecapture 9 0
  char 2d
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_338
__TERM_337:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_337
__TERM_338:
  closecapture 10 0
  commit __LEFTHAND_303
__RIGHTHAND_302:
  catch __RIGHTHAND_340
  char 5e
  char 2d
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_364
__TERM_363:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_363
__TERM_364:
  closecapture 11 0
  commit __LEFTHAND_341
__RIGHTHAND_340:
  catch __RIGHTHAND_366
  char 5e
  opencapture 12
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_384
__TERM_383:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_383
__TERM_384:
  closecapture 12 0
  char 2d
  commit __LEFTHAND_367
__RIGHTHAND_366:
  catch __RIGHTHAND_392
  char 5e
  opencapture 13
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_410
__TERM_409:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_409
__TERM_410:
  closecapture 13 0
  commit __LEFTHAND_393
__RIGHTHAND_392:
  char 5e
  char 24
  opencapture 14
  call IDENT
  closecapture 14 0
__LEFTHAND_393:
__LEFTHAND_367:
__LEFTHAND_341:
__LEFTHAND_303:
__LEFTHAND_295:
__LEFTHAND_287:
__LEFTHAND_279:
  ret
-- Rule
MATCHER:
  call __prefix
  catch __RIGHTHAND_430
  opencapture 15
  call ANY
  closecapture 15 0
  commit __LEFTHAND_431
__RIGHTHAND_430:
  catch __RIGHTHAND_444
  opencapture 16
  call SET
  closecapture 16 0
  commit __LEFTHAND_445
__RIGHTHAND_444:
  catch __RIGHTHAND_458
  opencapture 17
  call STRING
  closecapture 17 0
  commit __LEFTHAND_459
__RIGHTHAND_458:
  catch __RIGHTHAND_472
  opencapture 18
  call BITMASK
  closecapture 18 0
  commit __LEFTHAND_473
__RIGHTHAND_472:
  catch __RIGHTHAND_486
  opencapture 19
  call HEXLITERAL
  closecapture 19 0
  commit __LEFTHAND_487
__RIGHTHAND_486:
  catch __RIGHTHAND_500
  opencapture 20
  call VARCAPTURE
  closecapture 20 0
  commit __LEFTHAND_501
__RIGHTHAND_500:
  catch __RIGHTHAND_514
  opencapture 21
  call CAPTURE
  closecapture 21 0
  commit __LEFTHAND_515
__RIGHTHAND_514:
  catch __RIGHTHAND_528
  opencapture 22
  call GROUP
  closecapture 22 0
  commit __LEFTHAND_529
__RIGHTHAND_528:
  catch __RIGHTHAND_542
  opencapture 23
  call MACRO
  closecapture 23 0
  commit __LEFTHAND_543
__RIGHTHAND_542:
  catch __RIGHTHAND_556
  opencapture 24
  call VARREFERENCE
  closecapture 24 0
  commit __LEFTHAND_557
__RIGHTHAND_556:
  opencapture 25
  call REFERENCE
  closecapture 25 0
__LEFTHAND_557:
__LEFTHAND_543:
__LEFTHAND_529:
__LEFTHAND_515:
__LEFTHAND_501:
__LEFTHAND_487:
__LEFTHAND_473:
__LEFTHAND_459:
__LEFTHAND_445:
__LEFTHAND_431:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__TERM_590:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_590
  char 7c
  counter 1 2
__TERM_602:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __TERM_602
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
  catch __TERM_639
  call SEMICOLON
  opencapture 27
  call TYPE
  closecapture 27 0
  commit __TERM_639
__TERM_639:
  call COLON
  call EXPRESSION
  opencapture 28
  call CBCLOSE
  closecapture 28 0
  call CAPTUREEND
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
  catch __RIGHTHAND_758
  call RECYCLE
  commit __LEFTHAND_759
__RIGHTHAND_758:
  call NSRANGE
__LEFTHAND_759:
__LEFTHAND_751:
  commit __TERM_747
__TERM_747:
  ret
-- Rule
NSRANGE:
  call __prefix
  catch __RIGHTHAND_772
  char 23
  opencapture 31
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_790
__TERM_789:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_789
__TERM_790:
  closecapture 31 0
  char 2d
  opencapture 32
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_808
__TERM_807:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_807
__TERM_808:
  closecapture 32 0
  commit __LEFTHAND_773
__RIGHTHAND_772:
  char 23
  char 2d
  opencapture 33
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_832
__TERM_831:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_831
__TERM_832:
  closecapture 33 0
  char 23
  opencapture 34
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_850
__TERM_849:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_849
__TERM_850:
  closecapture 34 0
__LEFTHAND_773:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 35
  catch __TERM_867
  call SETNOT
  commit __TERM_867
__TERM_867:
  closecapture 35 0
  catch __RIGHTHAND_876
  opencapture 36
  catch __RIGHTHAND_884
  char 5c
  catch __RIGHTHAND_898
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_899
__RIGHTHAND_898:
  counter 2 3
__TERM_908:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_908
__LEFTHAND_899:
  commit __LEFTHAND_885
__RIGHTHAND_884:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_885:
  closecapture 36 0
  char 2d
  opencapture 37
  catch __RIGHTHAND_930
  char 5c
  catch __RIGHTHAND_944
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_945
__RIGHTHAND_944:
  counter 2 3
__TERM_954:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_954
__LEFTHAND_945:
  commit __LEFTHAND_931
__RIGHTHAND_930:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_931:
  closecapture 37 0
  commit __LEFTHAND_877
__RIGHTHAND_876:
  opencapture 38
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
  closecapture 38 0
__LEFTHAND_877:
  catch __TERM_874
__TERM_873:
  catch __RIGHTHAND_1004
  opencapture 36
  catch __RIGHTHAND_1012
  char 5c
  catch __RIGHTHAND_1026
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1027
__RIGHTHAND_1026:
  counter 2 3
__TERM_1036:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_1036
__LEFTHAND_1027:
  commit __LEFTHAND_1013
__RIGHTHAND_1012:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1013:
  closecapture 36 0
  char 2d
  opencapture 37
  catch __RIGHTHAND_1058
  char 5c
  catch __RIGHTHAND_1072
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1073
__RIGHTHAND_1072:
  counter 2 3
__TERM_1082:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_1082
__LEFTHAND_1073:
  commit __LEFTHAND_1059
__RIGHTHAND_1058:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1059:
  closecapture 37 0
  commit __LEFTHAND_1005
__RIGHTHAND_1004:
  opencapture 38
  catch __RIGHTHAND_1098
  char 5c
  catch __RIGHTHAND_1112
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1113
__RIGHTHAND_1112:
  counter 2 3
__TERM_1122:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_1122
__LEFTHAND_1113:
  commit __LEFTHAND_1099
__RIGHTHAND_1098:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1099:
  closecapture 38 0
__LEFTHAND_1005:
  partialcommit __TERM_873
__TERM_874:
  opencapture 39
  call ABCLOSE
  closecapture 39 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1156
  opencapture 40
  call IDENT
  closecapture 40 0
  commit __LEFTHAND_1157
__RIGHTHAND_1156:
  opencapture 41
  call NUMBER
  closecapture 41 0
__LEFTHAND_1157:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1188
  call OPTARGS
  call LEFTARROW
  failtwice
__TERM_1188:
  ret
-- Rule
TYPE:
  call __prefix
  catch __RIGHTHAND_1206
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_1207
__RIGHTHAND_1206:
  catch __RIGHTHAND_1214
  quad 696e7433
  char 32
  commit __LEFTHAND_1215
__RIGHTHAND_1214:
  catch __RIGHTHAND_1222
  quad 756e6574
  char 33
  char 32
  commit __LEFTHAND_1223
__RIGHTHAND_1222:
  catch __RIGHTHAND_1230
  quad 6e657433
  char 32
  commit __LEFTHAND_1231
__RIGHTHAND_1230:
  catch __RIGHTHAND_1238
  quad 64656369
  char 6d
  char 61
  char 6c
  commit __LEFTHAND_1239
__RIGHTHAND_1238:
  call IDENT
__LEFTHAND_1239:
__LEFTHAND_1231:
__LEFTHAND_1223:
__LEFTHAND_1215:
__LEFTHAND_1207:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 42
  call REPLACETERMS
  closecapture 42 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __TERM_1274
__TERM_1273:
  call REPLACETERM
  partialcommit __TERM_1273
__TERM_1274:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1276
  opencapture 43
  call STRINGLITERAL
  closecapture 43 0
  commit __LEFTHAND_1277
__RIGHTHAND_1276:
  catch __RIGHTHAND_1290
  opencapture 44
  call HEXLITERAL
  closecapture 44 0
  commit __LEFTHAND_1291
__RIGHTHAND_1290:
  opencapture 45
  call VARREFERENCE
  closecapture 45 0
__LEFTHAND_1291:
__LEFTHAND_1277:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 46
  call IDENT
  closecapture 46 0
  ret
-- Rule
IDENT:
  call __prefix
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_1343
  counter 2 63
__TERM_1344:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1345
__TERM_1345:
  condjump 2 __TERM_1344
  commit __TERM_1343
__TERM_1343:
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
  catch __TERM_1392
__TERM_1391:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1391
__TERM_1392:
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 3 2
__TERM_1402:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 3 __TERM_1402
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1410
__TERM_1409:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1409
__TERM_1410:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  catch __TERM_1422
__TERM_1421:
  catch __RIGHTHAND_1424
  char 5c
  catch __RIGHTHAND_1438
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1439
__RIGHTHAND_1438:
  counter 4 3
__TERM_1448:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 4 __TERM_1448
__LEFTHAND_1439:
  commit __LEFTHAND_1425
__RIGHTHAND_1424:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1425:
  partialcommit __TERM_1421
__TERM_1422:
  char 27
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1473
  char 69
  commit __TERM_1473
__TERM_1473:
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
NSOPEN:
  call __prefix
  char 5b
  char 5b
  ret
-- Rule
NSCLOSE:
  call __prefix
  char 5d
  char 5d
  ret
-- Rule
OPTARGS:
  call __prefix
  catch __TERM_1581
  opencapture 47
  call ARGS
  closecapture 47 0
  commit __TERM_1581
__TERM_1581:
  ret
-- Rule
ARGS:
  call __prefix
  call BOPEN
  opencapture 48
  call IDENT
  closecapture 48 0
  catch __TERM_1612
__TERM_1611:
  call COMMA
  opencapture 49
  call IDENT
  closecapture 49 0
  partialcommit __TERM_1611
__TERM_1612:
  call BCLOSE
  ret
-- Rule
CALL:
  call __prefix
  call LT
  opencapture 50
  call IDENT
  closecapture 50 0
  opencapture 51
  call ARGS
  closecapture 51 0
  call GT
  ret

  end 0

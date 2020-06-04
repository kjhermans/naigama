  call __RULE_GRAMMAR
  end 0
__RULE_GRAMMAR:
  catch __RIGHTHAND_7
  call __RULE_DEFINITION
  catch __FORGIVE_12
__ENDLESS_11:
  call __RULE_DEFINITION
  partialcommit __ENDLESS_11
__FORGIVE_12:
  commit __SUCCESS_7
__RIGHTHAND_7:
  call __RULE_SINGLE_EXPRESSION
__SUCCESS_7:
  call __RULE_END
  ret
__RULE___prefix:
  catch __FORGIVE_33
__ENDLESS_32:
  catch __RIGHTHAND_36
  char 2d
  char 2d
  catch __FORGIVE_48
__ENDLESS_47:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __ENDLESS_47
__FORGIVE_48:
  char 0a
  commit __SUCCESS_36
__RIGHTHAND_36:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __FORGIVE_62
__ENDLESS_61:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_61
__FORGIVE_62:
__SUCCESS_36:
  partialcommit __ENDLESS_32
__FORGIVE_33:
  ret
__RULE_END:
  call __RULE___prefix
  catch __PREFIX_65
  any
  failtwice
__PREFIX_65:
  ret
__RULE_DEFINITION:
  call __RULE___prefix
  call __RULE_RULE
  ret
__RULE_SINGLE_EXPRESSION:
  call __RULE___prefix
  call __RULE_EXPRESSION
  ret
__RULE_RULE:
  call __RULE___prefix
  opencapture 0
  call __RULE_IDENT
  closecapture 0
  call __RULE_OPTARGS
  call __RULE_LEFTARROW
  call __RULE_EXPRESSION
  ret
__RULE_EXPRESSION:
  call __RULE___prefix
  catch __RIGHTHAND_121
  opencapture 1
  call __RULE_TERMS
  closecapture 1
  call __RULE_OR
  call __RULE_NOTHING
  commit __SUCCESS_121
__RIGHTHAND_121:
  catch __RIGHTHAND_150
  opencapture 2
  call __RULE_TERMS
  closecapture 2
  call __RULE_OR
  call __RULE_EXPRESSION
  commit __SUCCESS_150
__RIGHTHAND_150:
  catch __RIGHTHAND_179
  opencapture 3
  call __RULE_TERMS
  closecapture 3
  commit __SUCCESS_179
__RIGHTHAND_179:
  call __RULE_CALL
__SUCCESS_179:
__SUCCESS_150:
__SUCCESS_121:
  ret
__RULE_TERMS:
  call __RULE___prefix
  opencapture 4
  call __RULE_TERM
  closecapture 4
  catch __FORGIVE_205
__ENDLESS_204:
  opencapture 4
  call __RULE_TERM
  closecapture 4
  partialcommit __ENDLESS_204
__FORGIVE_205:
  ret
__RULE_TERM:
  call __RULE___prefix
  catch __RIGHTHAND_222
  opencapture 5
  call __RULE_NAMESPACE
  closecapture 5
  commit __SUCCESS_222
__RIGHTHAND_222:
  opencapture 6
  call __RULE_ENDOWEDMATCHER
  closecapture 6
__SUCCESS_222:
  ret
__RULE_NAMESPACE:
  call __RULE___prefix
  call __RULE_NSOPEN
  call __RULE_EXPRESSION
  call __RULE_NSCLOSE
  ret
__RULE_ENDOWEDMATCHER:
  call __RULE___prefix
  catch __FORGIVE_276
  opencapture 7
  catch __RIGHTHAND_279
  call __RULE_NOT
  commit __SUCCESS_279
__RIGHTHAND_279:
  call __RULE_AND
__SUCCESS_279:
  closecapture 7
  commit __FORGIVE_276
__FORGIVE_276:
  call __RULE_MATCHER
  catch __FORGIVE_305
  opencapture 8
  call __RULE_QUANTIFIER
  closecapture 8
  commit __FORGIVE_305
__FORGIVE_305:
  ret
__RULE_QUANTIFIER:
  call __RULE___prefix
  catch __RIGHTHAND_315
  char 3f
  commit __SUCCESS_315
__RIGHTHAND_315:
  catch __RIGHTHAND_323
  char 2b
  commit __SUCCESS_323
__RIGHTHAND_323:
  catch __RIGHTHAND_331
  char 2a
  commit __SUCCESS_331
__RIGHTHAND_331:
  catch __RIGHTHAND_339
  char 5e
  opencapture 9
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_358
__ENDLESS_357:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_357
__FORGIVE_358:
  closecapture 9
  char 2d
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_379
__ENDLESS_378:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_378
__FORGIVE_379:
  closecapture 10
  commit __SUCCESS_339
__RIGHTHAND_339:
  catch __RIGHTHAND_382
  char 5e
  char 2d
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_408
__ENDLESS_407:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_407
__FORGIVE_408:
  closecapture 11
  commit __SUCCESS_382
__RIGHTHAND_382:
  catch __RIGHTHAND_411
  char 5e
  opencapture 12
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_430
__ENDLESS_429:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_429
__FORGIVE_430:
  closecapture 12
  char 2d
  commit __SUCCESS_411
__RIGHTHAND_411:
  catch __RIGHTHAND_440
  char 5e
  opencapture 13
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_459
__ENDLESS_458:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_458
__FORGIVE_459:
  closecapture 13
  commit __SUCCESS_440
__RIGHTHAND_440:
  char 5e
  char 24
  opencapture 14
  call __RULE_IDENT
  closecapture 14
__SUCCESS_440:
__SUCCESS_411:
__SUCCESS_382:
__SUCCESS_339:
__SUCCESS_331:
__SUCCESS_323:
__SUCCESS_315:
  ret
__RULE_MATCHER:
  call __RULE___prefix
  catch __RIGHTHAND_483
  opencapture 15
  call __RULE_ANY
  closecapture 15
  commit __SUCCESS_483
__RIGHTHAND_483:
  catch __RIGHTHAND_498
  opencapture 16
  call __RULE_SET
  closecapture 16
  commit __SUCCESS_498
__RIGHTHAND_498:
  catch __RIGHTHAND_513
  opencapture 17
  call __RULE_STRING
  closecapture 17
  commit __SUCCESS_513
__RIGHTHAND_513:
  catch __RIGHTHAND_528
  opencapture 18
  call __RULE_BITMASK
  closecapture 18
  commit __SUCCESS_528
__RIGHTHAND_528:
  catch __RIGHTHAND_543
  opencapture 19
  call __RULE_HEXLITERAL
  closecapture 19
  commit __SUCCESS_543
__RIGHTHAND_543:
  catch __RIGHTHAND_558
  opencapture 20
  call __RULE_VARCAPTURE
  closecapture 20
  commit __SUCCESS_558
__RIGHTHAND_558:
  catch __RIGHTHAND_573
  opencapture 21
  call __RULE_CAPTURE
  closecapture 21
  commit __SUCCESS_573
__RIGHTHAND_573:
  catch __RIGHTHAND_588
  opencapture 22
  call __RULE_GROUP
  closecapture 22
  commit __SUCCESS_588
__RIGHTHAND_588:
  catch __RIGHTHAND_603
  opencapture 23
  call __RULE_MACRO
  closecapture 23
  commit __SUCCESS_603
__RIGHTHAND_603:
  catch __RIGHTHAND_618
  opencapture 24
  call __RULE_VARREFERENCE
  closecapture 24
  commit __SUCCESS_618
__RIGHTHAND_618:
  opencapture 25
  call __RULE_REFERENCE
  closecapture 25
__SUCCESS_618:
__SUCCESS_603:
__SUCCESS_588:
__SUCCESS_573:
__SUCCESS_558:
__SUCCESS_543:
__SUCCESS_528:
__SUCCESS_513:
__SUCCESS_498:
__SUCCESS_483:
  ret
__RULE_BITMASK:
  call __RULE___prefix
  char 7c
  counter 0 2
__COUNTER_655:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __COUNTER_655
  char 7c
  counter 1 2
__COUNTER_669:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __COUNTER_669
  char 7c
  ret
__RULE_VARCAPTURE:
  call __RULE___prefix
  call __RULE_CBOPEN
  call __RULE_COLON
  opencapture 26
  call __RULE_IDENT
  closecapture 26
  catch __FORGIVE_714
  call __RULE_SEMICOLON
  opencapture 27
  call __RULE_TYPE
  closecapture 27
  commit __FORGIVE_714
__FORGIVE_714:
  call __RULE_COLON
  call __RULE_EXPRESSION
  opencapture 28
  call __RULE_CBCLOSE
  closecapture 28
  call __RULE_CAPTUREEND
  ret
__RULE_CAPTURE:
  call __RULE___prefix
  call __RULE_CBOPEN
  call __RULE_EXPRESSION
  opencapture 29
  call __RULE_CBCLOSE
  closecapture 29
  call __RULE_CAPTUREEND
  ret
__RULE_GROUP:
  call __RULE___prefix
  call __RULE_BOPEN
  call __RULE_EXPRESSION
  opencapture 30
  call __RULE_BCLOSE
  closecapture 30
  ret
__RULE_CAPTUREEND:
  call __RULE___prefix
  catch __FORGIVE_840
  catch __RIGHTHAND_843
  call __RULE_REPLACE
  commit __SUCCESS_843
__RIGHTHAND_843:
  catch __RIGHTHAND_851
  call __RULE_RECYCLE
  commit __SUCCESS_851
__RIGHTHAND_851:
  call __RULE_NSRANGE
__SUCCESS_851:
__SUCCESS_843:
  commit __FORGIVE_840
__FORGIVE_840:
  ret
__RULE_NSRANGE:
  call __RULE___prefix
  catch __RIGHTHAND_866
  char 23
  opencapture 31
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_885
__ENDLESS_884:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_884
__FORGIVE_885:
  closecapture 31
  char 2d
  opencapture 32
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_906
__ENDLESS_905:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_905
__FORGIVE_906:
  closecapture 32
  commit __SUCCESS_866
__RIGHTHAND_866:
  char 23
  char 2d
  opencapture 33
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_934
__ENDLESS_933:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_933
__FORGIVE_934:
  closecapture 33
  char 23
  opencapture 34
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_955
__ENDLESS_954:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_954
__FORGIVE_955:
  closecapture 34
__SUCCESS_866:
  ret
__RULE_SET:
  call __RULE___prefix
  call __RULE_ABOPEN
  opencapture 35
  catch __FORGIVE_976
  call __RULE_SETNOT
  commit __FORGIVE_976
__FORGIVE_976:
  closecapture 35
  catch __RIGHTHAND_986
  opencapture 36
  catch __RIGHTHAND_994
  char 5c
  catch __RIGHTHAND_1009
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1009
__RIGHTHAND_1009:
  counter 2 3
__COUNTER_1018:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __COUNTER_1018
__SUCCESS_1009:
  commit __SUCCESS_994
__RIGHTHAND_994:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_994:
  closecapture 36
  char 2d
  opencapture 37
  catch __RIGHTHAND_1045
  char 5c
  catch __RIGHTHAND_1060
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1060
__RIGHTHAND_1060:
  counter 3 3
__COUNTER_1069:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __COUNTER_1069
__SUCCESS_1060:
  commit __SUCCESS_1045
__RIGHTHAND_1045:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1045:
  closecapture 37
  commit __SUCCESS_986
__RIGHTHAND_986:
  opencapture 38
  catch __RIGHTHAND_1089
  char 5c
  catch __RIGHTHAND_1104
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1104
__RIGHTHAND_1104:
  counter 4 3
__COUNTER_1113:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 4 __COUNTER_1113
__SUCCESS_1104:
  commit __SUCCESS_1089
__RIGHTHAND_1089:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1089:
  closecapture 38
__SUCCESS_986:
  catch __FORGIVE_983
__ENDLESS_982:
  catch __RIGHTHAND_1126
  opencapture 36
  catch __RIGHTHAND_1134
  char 5c
  catch __RIGHTHAND_1149
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1149
__RIGHTHAND_1149:
  counter 5 3
__COUNTER_1158:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 5 __COUNTER_1158
__SUCCESS_1149:
  commit __SUCCESS_1134
__RIGHTHAND_1134:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1134:
  closecapture 36
  char 2d
  opencapture 37
  catch __RIGHTHAND_1185
  char 5c
  catch __RIGHTHAND_1200
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1200
__RIGHTHAND_1200:
  counter 6 3
__COUNTER_1209:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 6 __COUNTER_1209
__SUCCESS_1200:
  commit __SUCCESS_1185
__RIGHTHAND_1185:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1185:
  closecapture 37
  commit __SUCCESS_1126
__RIGHTHAND_1126:
  opencapture 38
  catch __RIGHTHAND_1229
  char 5c
  catch __RIGHTHAND_1244
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1244
__RIGHTHAND_1244:
  counter 7 3
__COUNTER_1253:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 7 __COUNTER_1253
__SUCCESS_1244:
  commit __SUCCESS_1229
__RIGHTHAND_1229:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1229:
  closecapture 38
__SUCCESS_1126:
  partialcommit __ENDLESS_982
__FORGIVE_983:
  opencapture 39
  call __RULE_ABCLOSE
  closecapture 39
  ret
__RULE_VARREFERENCE:
  call __RULE___prefix
  char 24
  catch __RIGHTHAND_1294
  opencapture 40
  call __RULE_IDENT
  closecapture 40
  commit __SUCCESS_1294
__RIGHTHAND_1294:
  opencapture 41
  call __RULE_NUMBER
  closecapture 41
__SUCCESS_1294:
  ret
__RULE_REFERENCE:
  call __RULE___prefix
  call __RULE_IDENT
  catch __PREFIX_1330
  call __RULE_OPTARGS
  call __RULE_LEFTARROW
  failtwice
__PREFIX_1330:
  ret
__RULE_TYPE:
  call __RULE___prefix
  catch __RIGHTHAND_1351
  quad 75696e74
  char 33
  char 32
  commit __SUCCESS_1351
__RIGHTHAND_1351:
  catch __RIGHTHAND_1359
  quad 696e7433
  char 32
  commit __SUCCESS_1359
__RIGHTHAND_1359:
  catch __RIGHTHAND_1367
  quad 756e6574
  char 33
  char 32
  commit __SUCCESS_1367
__RIGHTHAND_1367:
  catch __RIGHTHAND_1375
  quad 6e657433
  char 32
  commit __SUCCESS_1375
__RIGHTHAND_1375:
  catch __RIGHTHAND_1383
  quad 64656369
  char 6d
  char 61
  char 6c
  commit __SUCCESS_1383
__RIGHTHAND_1383:
  call __RULE_IDENT
__SUCCESS_1383:
__SUCCESS_1375:
__SUCCESS_1367:
__SUCCESS_1359:
__SUCCESS_1351:
  ret
__RULE_REPLACE:
  call __RULE___prefix
  call __RULE_RIGHTARROW
  opencapture 42
  call __RULE_REPLACETERMS
  closecapture 42
  ret
__RULE_REPLACETERMS:
  call __RULE___prefix
  call __RULE_REPLACETERM
  catch __FORGIVE_1423
__ENDLESS_1422:
  call __RULE_REPLACETERM
  partialcommit __ENDLESS_1422
__FORGIVE_1423:
  ret
__RULE_REPLACETERM:
  call __RULE___prefix
  catch __RIGHTHAND_1426
  opencapture 43
  call __RULE_STRINGLITERAL
  closecapture 43
  commit __SUCCESS_1426
__RIGHTHAND_1426:
  catch __RIGHTHAND_1441
  opencapture 44
  call __RULE_HEXLITERAL
  closecapture 44
  commit __SUCCESS_1441
__RIGHTHAND_1441:
  opencapture 45
  call __RULE_VARREFERENCE
  closecapture 45
__SUCCESS_1441:
__SUCCESS_1426:
  ret
__RULE_RECYCLE:
  call __RULE___prefix
  call __RULE_FATARROW
  opencapture 46
  call __RULE_IDENT
  closecapture 46
  ret
__RULE_IDENT:
  call __RULE___prefix
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_1502
  counter 8 63
__COUNTER_1500:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __USELESS_1504
__USELESS_1504:
  condjump 8 __COUNTER_1500
  commit __FORGIVE_1502
__FORGIVE_1502:
  ret
__RULE_LEFTARROW:
  call __RULE___prefix
  char 3c
  char 2d
  ret
__RULE_RIGHTARROW:
  call __RULE___prefix
  char 2d
  char 3e
  ret
__RULE_FATARROW:
  call __RULE___prefix
  char 3d
  char 3e
  ret
__RULE_NOT:
  call __RULE___prefix
  char 21
  ret
__RULE_AND:
  call __RULE___prefix
  char 26
  ret
__RULE_MACRO:
  call __RULE___prefix
  char 25
  set 0000000000000000feffff07feffff0700000000000000000000000000000000
  catch __FORGIVE_1558
__ENDLESS_1557:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __ENDLESS_1557
__FORGIVE_1558:
  ret
__RULE_HEXLITERAL:
  call __RULE___prefix
  char 30
  char 78
  counter 8 2
__COUNTER_1569:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 8 __COUNTER_1569
  ret
__RULE_NUMBER:
  call __RULE___prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1579
__ENDLESS_1578:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1578
__FORGIVE_1579:
  ret
__RULE_STRINGLITERAL:
  call __RULE___prefix
  char 27
  catch __FORGIVE_1593
__ENDLESS_1592:
  catch __RIGHTHAND_1596
  char 5c
  catch __RIGHTHAND_1611
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_1611
__RIGHTHAND_1611:
  counter 9 3
__COUNTER_1620:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 9 __COUNTER_1620
__SUCCESS_1611:
  commit __SUCCESS_1596
__RIGHTHAND_1596:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1596:
  partialcommit __ENDLESS_1592
__FORGIVE_1593:
  char 27
  ret
__RULE_STRING:
  call __RULE___prefix
  call __RULE_STRINGLITERAL
  catch __FORGIVE_1651
  char 69
  commit __FORGIVE_1651
__FORGIVE_1651:
  ret
__RULE_OR:
  call __RULE___prefix
  char 2f
  ret
__RULE_ANY:
  call __RULE___prefix
  char 2e
  ret
__RULE_NOTHING:
  call __RULE___prefix
  char 2e
  char 2e
  char 2e
  ret
__RULE_CBOPEN:
  call __RULE___prefix
  char 7b
  ret
__RULE_COLON:
  call __RULE___prefix
  char 3a
  ret
__RULE_CBCLOSE:
  call __RULE___prefix
  char 7d
  ret
__RULE_BOPEN:
  call __RULE___prefix
  char 28
  ret
__RULE_BCLOSE:
  call __RULE___prefix
  char 29
  ret
__RULE_ABOPEN:
  call __RULE___prefix
  char 5b
  ret
__RULE_ABCLOSE:
  call __RULE___prefix
  char 5d
  ret
__RULE_SETNOT:
  call __RULE___prefix
  char 5e
  ret
__RULE_SEMICOLON:
  call __RULE___prefix
  char 3b
  ret
__RULE_COMMA:
  call __RULE___prefix
  char 2c
  ret
__RULE_LT:
  call __RULE___prefix
  char 3c
  ret
__RULE_GT:
  call __RULE___prefix
  char 3e
  ret
__RULE_NSOPEN:
  call __RULE___prefix
  char 5b
  char 5b
  ret
__RULE_NSCLOSE:
  call __RULE___prefix
  char 5d
  char 5d
  ret
__RULE_OPTARGS:
  call __RULE___prefix
  catch __FORGIVE_1777
  opencapture 47
  call __RULE_ARGS
  closecapture 47
  commit __FORGIVE_1777
__FORGIVE_1777:
  ret
__RULE_ARGS:
  call __RULE___prefix
  call __RULE_BOPEN
  opencapture 48
  call __RULE_IDENT
  closecapture 48
  catch __FORGIVE_1812
__ENDLESS_1811:
  call __RULE_COMMA
  opencapture 49
  call __RULE_IDENT
  closecapture 49
  partialcommit __ENDLESS_1811
__FORGIVE_1812:
  call __RULE_BCLOSE
  ret
__RULE_CALL:
  call __RULE___prefix
  call __RULE_LT
  opencapture 50
  call __RULE_IDENT
  closecapture 50
  opencapture 51
  call __RULE_ARGS
  closecapture 51
  call __RULE_GT
  ret

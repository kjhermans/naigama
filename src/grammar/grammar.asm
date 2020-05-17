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
  set 0026000001000000000000000000000000000000000000000000000000000000
  catch __FORGIVE_62
__ENDLESS_61:
  set 0026000001000000000000000000000000000000000000000000000000000000
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
  catch __FORGIVE_226
  opencapture 5
  catch __RIGHTHAND_229
  call __RULE_NOT
  commit __SUCCESS_229
__RIGHTHAND_229:
  call __RULE_AND
__SUCCESS_229:
  closecapture 5
  commit __FORGIVE_226
__FORGIVE_226:
  call __RULE_MATCHER
  catch __FORGIVE_255
  opencapture 6
  call __RULE_QUANTIFIER
  closecapture 6
  commit __FORGIVE_255
__FORGIVE_255:
  ret
__RULE_QUANTIFIER:
  call __RULE___prefix
  catch __RIGHTHAND_265
  char 3f
  commit __SUCCESS_265
__RIGHTHAND_265:
  catch __RIGHTHAND_273
  char 2b
  commit __SUCCESS_273
__RIGHTHAND_273:
  catch __RIGHTHAND_281
  char 2a
  commit __SUCCESS_281
__RIGHTHAND_281:
  catch __RIGHTHAND_289
  char 5e
  opencapture 7
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_308
__ENDLESS_307:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_307
__FORGIVE_308:
  closecapture 7
  char 2d
  opencapture 8
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_329
__ENDLESS_328:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_328
__FORGIVE_329:
  closecapture 8
  commit __SUCCESS_289
__RIGHTHAND_289:
  catch __RIGHTHAND_332
  char 5e
  char 2d
  opencapture 9
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_358
__ENDLESS_357:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_357
__FORGIVE_358:
  closecapture 9
  commit __SUCCESS_332
__RIGHTHAND_332:
  catch __RIGHTHAND_361
  char 5e
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_380
__ENDLESS_379:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_379
__FORGIVE_380:
  closecapture 10
  char 2d
  commit __SUCCESS_361
__RIGHTHAND_361:
  catch __RIGHTHAND_390
  char 5e
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_409
__ENDLESS_408:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_408
__FORGIVE_409:
  closecapture 11
  commit __SUCCESS_390
__RIGHTHAND_390:
  char 5e
  char 24
  opencapture 12
  call __RULE_IDENT
  closecapture 12
__SUCCESS_390:
__SUCCESS_361:
__SUCCESS_332:
__SUCCESS_289:
__SUCCESS_281:
__SUCCESS_273:
__SUCCESS_265:
  ret
__RULE_MATCHER:
  call __RULE___prefix
  catch __RIGHTHAND_433
  opencapture 13
  call __RULE_ANY
  closecapture 13
  commit __SUCCESS_433
__RIGHTHAND_433:
  catch __RIGHTHAND_448
  opencapture 14
  call __RULE_SET
  closecapture 14
  commit __SUCCESS_448
__RIGHTHAND_448:
  catch __RIGHTHAND_463
  opencapture 15
  call __RULE_STRING
  closecapture 15
  commit __SUCCESS_463
__RIGHTHAND_463:
  catch __RIGHTHAND_478
  opencapture 16
  call __RULE_BITMASK
  closecapture 16
  commit __SUCCESS_478
__RIGHTHAND_478:
  catch __RIGHTHAND_493
  opencapture 17
  call __RULE_HEXLITERAL
  closecapture 17
  commit __SUCCESS_493
__RIGHTHAND_493:
  catch __RIGHTHAND_508
  opencapture 18
  call __RULE_VARCAPTURE
  closecapture 18
  commit __SUCCESS_508
__RIGHTHAND_508:
  catch __RIGHTHAND_523
  opencapture 19
  call __RULE_CAPTURE
  closecapture 19
  commit __SUCCESS_523
__RIGHTHAND_523:
  catch __RIGHTHAND_538
  opencapture 20
  call __RULE_GROUP
  closecapture 20
  commit __SUCCESS_538
__RIGHTHAND_538:
  catch __RIGHTHAND_553
  opencapture 21
  call __RULE_MACRO
  closecapture 21
  commit __SUCCESS_553
__RIGHTHAND_553:
  catch __RIGHTHAND_568
  opencapture 22
  call __RULE_VARREFERENCE
  closecapture 22
  commit __SUCCESS_568
__RIGHTHAND_568:
  opencapture 23
  call __RULE_REFERENCE
  closecapture 23
__SUCCESS_568:
__SUCCESS_553:
__SUCCESS_538:
__SUCCESS_523:
__SUCCESS_508:
__SUCCESS_493:
__SUCCESS_478:
__SUCCESS_463:
__SUCCESS_448:
__SUCCESS_433:
  ret
__RULE_BITMASK:
  call __RULE___prefix
  char 7c
  counter 0 2
__COUNTER_605:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __COUNTER_605
  char 7c
  counter 1 2
__COUNTER_619:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __COUNTER_619
  char 7c
  ret
__RULE_VARCAPTURE:
  call __RULE___prefix
  call __RULE_CBOPEN
  call __RULE_COLON
  opencapture 24
  call __RULE_IDENT
  closecapture 24
  catch __FORGIVE_664
  call __RULE_SEMICOLON
  opencapture 25
  call __RULE_TYPE
  closecapture 25
  commit __FORGIVE_664
__FORGIVE_664:
  call __RULE_COLON
  call __RULE_EXPRESSION
  catch __FORGIVE_706
  call __RULE_COLON
  commit __FORGIVE_706
__FORGIVE_706:
  opencapture 26
  call __RULE_CBCLOSE
  closecapture 26
  catch __FORGIVE_727
  catch __RIGHTHAND_730
  call __RULE_REPLACE
  commit __SUCCESS_730
__RIGHTHAND_730:
  call __RULE_RECYCLE
__SUCCESS_730:
  commit __FORGIVE_727
__FORGIVE_727:
  ret
__RULE_CAPTURE:
  call __RULE___prefix
  call __RULE_CBOPEN
  call __RULE_EXPRESSION
  opencapture 27
  call __RULE_CBCLOSE
  closecapture 27
  catch __FORGIVE_777
  catch __RIGHTHAND_780
  call __RULE_REPLACE
  commit __SUCCESS_780
__RIGHTHAND_780:
  call __RULE_RECYCLE
__SUCCESS_780:
  commit __FORGIVE_777
__FORGIVE_777:
  ret
__RULE_GROUP:
  call __RULE___prefix
  call __RULE_BOPEN
  call __RULE_EXPRESSION
  opencapture 28
  call __RULE_BCLOSE
  closecapture 28
  ret
__RULE_SET:
  call __RULE___prefix
  call __RULE_ABOPEN
  opencapture 29
  catch __FORGIVE_841
  call __RULE_SETNOT
  commit __FORGIVE_841
__FORGIVE_841:
  closecapture 29
  catch __RIGHTHAND_851
  opencapture 30
  catch __RIGHTHAND_859
  char 5c
  catch __RIGHTHAND_874
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __SUCCESS_874
__RIGHTHAND_874:
  counter 2 3
__COUNTER_883:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __COUNTER_883
__SUCCESS_874:
  commit __SUCCESS_859
__RIGHTHAND_859:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_859:
  closecapture 30
  char 2d
  opencapture 31
  catch __RIGHTHAND_910
  char 5c
  catch __RIGHTHAND_925
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __SUCCESS_925
__RIGHTHAND_925:
  counter 3 3
__COUNTER_934:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __COUNTER_934
__SUCCESS_925:
  commit __SUCCESS_910
__RIGHTHAND_910:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_910:
  closecapture 31
  commit __SUCCESS_851
__RIGHTHAND_851:
  opencapture 32
  catch __RIGHTHAND_954
  char 5c
  catch __RIGHTHAND_969
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __SUCCESS_969
__RIGHTHAND_969:
  counter 4 3
__COUNTER_978:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 4 __COUNTER_978
__SUCCESS_969:
  commit __SUCCESS_954
__RIGHTHAND_954:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_954:
  closecapture 32
__SUCCESS_851:
  catch __FORGIVE_848
__ENDLESS_847:
  catch __RIGHTHAND_991
  opencapture 30
  catch __RIGHTHAND_999
  char 5c
  catch __RIGHTHAND_1014
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1014
__RIGHTHAND_1014:
  counter 5 3
__COUNTER_1023:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 5 __COUNTER_1023
__SUCCESS_1014:
  commit __SUCCESS_999
__RIGHTHAND_999:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_999:
  closecapture 30
  char 2d
  opencapture 31
  catch __RIGHTHAND_1050
  char 5c
  catch __RIGHTHAND_1065
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1065
__RIGHTHAND_1065:
  counter 6 3
__COUNTER_1074:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 6 __COUNTER_1074
__SUCCESS_1065:
  commit __SUCCESS_1050
__RIGHTHAND_1050:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1050:
  closecapture 31
  commit __SUCCESS_991
__RIGHTHAND_991:
  opencapture 32
  catch __RIGHTHAND_1094
  char 5c
  catch __RIGHTHAND_1109
  set 0000000000000000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1109
__RIGHTHAND_1109:
  counter 7 3
__COUNTER_1118:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 7 __COUNTER_1118
__SUCCESS_1109:
  commit __SUCCESS_1094
__RIGHTHAND_1094:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1094:
  closecapture 32
__SUCCESS_991:
  partialcommit __ENDLESS_847
__FORGIVE_848:
  opencapture 33
  call __RULE_ABCLOSE
  closecapture 33
  ret
__RULE_VARREFERENCE:
  call __RULE___prefix
  char 24
  catch __RIGHTHAND_1159
  opencapture 34
  call __RULE_IDENT
  closecapture 34
  commit __SUCCESS_1159
__RIGHTHAND_1159:
  opencapture 35
  call __RULE_NUMBER
  closecapture 35
__SUCCESS_1159:
  ret
__RULE_REFERENCE:
  call __RULE___prefix
  call __RULE_IDENT
  catch __PREFIX_1195
  call __RULE_OPTARGS
  call __RULE_LEFTARROW
  failtwice
__PREFIX_1195:
  ret
__RULE_TYPE:
  call __RULE___prefix
  catch __RIGHTHAND_1216
  quad 75696e74
  char 33
  char 32
  commit __SUCCESS_1216
__RIGHTHAND_1216:
  catch __RIGHTHAND_1224
  quad 696e7433
  char 32
  commit __SUCCESS_1224
__RIGHTHAND_1224:
  catch __RIGHTHAND_1232
  quad 756e6574
  char 33
  char 32
  commit __SUCCESS_1232
__RIGHTHAND_1232:
  catch __RIGHTHAND_1240
  quad 6e657433
  char 32
  commit __SUCCESS_1240
__RIGHTHAND_1240:
  catch __RIGHTHAND_1248
  quad 64656369
  char 6d
  char 61
  char 6c
  commit __SUCCESS_1248
__RIGHTHAND_1248:
  call __RULE_IDENT
__SUCCESS_1248:
__SUCCESS_1240:
__SUCCESS_1232:
__SUCCESS_1224:
__SUCCESS_1216:
  ret
__RULE_REPLACE:
  call __RULE___prefix
  call __RULE_RIGHTARROW
  opencapture 36
  call __RULE_REPLACETERMS
  closecapture 36
  ret
__RULE_REPLACETERMS:
  call __RULE___prefix
  call __RULE_REPLACETERM
  catch __FORGIVE_1288
__ENDLESS_1287:
  call __RULE_REPLACETERM
  partialcommit __ENDLESS_1287
__FORGIVE_1288:
  ret
__RULE_REPLACETERM:
  call __RULE___prefix
  catch __RIGHTHAND_1291
  opencapture 37
  call __RULE_STRINGLITERAL
  closecapture 37
  commit __SUCCESS_1291
__RIGHTHAND_1291:
  catch __RIGHTHAND_1306
  opencapture 38
  call __RULE_HEXLITERAL
  closecapture 38
  commit __SUCCESS_1306
__RIGHTHAND_1306:
  opencapture 39
  call __RULE_VARREFERENCE
  closecapture 39
__SUCCESS_1306:
__SUCCESS_1291:
  ret
__RULE_RECYCLE:
  call __RULE___prefix
  call __RULE_FATARROW
  opencapture 40
  call __RULE_IDENT
  closecapture 40
  ret
__RULE_IDENT:
  call __RULE___prefix
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_1367
  counter 8 63
__COUNTER_1365:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __USELESS_1369
__USELESS_1369:
  condjump 8 __COUNTER_1365
  commit __FORGIVE_1367
__FORGIVE_1367:
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
  catch __FORGIVE_1423
__ENDLESS_1422:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __ENDLESS_1422
__FORGIVE_1423:
  ret
__RULE_HEXLITERAL:
  call __RULE___prefix
  char 30
  char 78
  counter 8 2
__COUNTER_1434:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 8 __COUNTER_1434
  ret
__RULE_NUMBER:
  call __RULE___prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1444
__ENDLESS_1443:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1443
__FORGIVE_1444:
  ret
__RULE_STRINGLITERAL:
  call __RULE___prefix
  char 27
  catch __FORGIVE_1458
__ENDLESS_1457:
  catch __RIGHTHAND_1461
  char 5c
  catch __RIGHTHAND_1476
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_1476
__RIGHTHAND_1476:
  counter 9 3
__COUNTER_1485:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 9 __COUNTER_1485
__SUCCESS_1476:
  commit __SUCCESS_1461
__RIGHTHAND_1461:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1461:
  partialcommit __ENDLESS_1457
__FORGIVE_1458:
  char 27
  ret
__RULE_STRING:
  call __RULE___prefix
  call __RULE_STRINGLITERAL
  catch __FORGIVE_1516
  char 69
  commit __FORGIVE_1516
__FORGIVE_1516:
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
__RULE_OPTARGS:
  call __RULE___prefix
  catch __FORGIVE_1628
  opencapture 41
  call __RULE_ARGS
  closecapture 41
  commit __FORGIVE_1628
__FORGIVE_1628:
  ret
__RULE_ARGS:
  call __RULE___prefix
  call __RULE_BOPEN
  opencapture 42
  call __RULE_IDENT
  closecapture 42
  catch __FORGIVE_1663
__ENDLESS_1662:
  call __RULE_COMMA
  opencapture 43
  call __RULE_IDENT
  closecapture 43
  partialcommit __ENDLESS_1662
__FORGIVE_1663:
  call __RULE_BCLOSE
  ret
__RULE_CALL:
  call __RULE___prefix
  call __RULE_LT
  opencapture 44
  call __RULE_IDENT
  closecapture 44
  opencapture 45
  call __RULE_ARGS
  closecapture 45
  call __RULE_GT
  ret

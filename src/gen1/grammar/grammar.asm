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
__RULE_S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __FORGIVE_33
__ENDLESS_32:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_32
__FORGIVE_33:
  ret
__RULE_COMMENT:
  char 2d
  char 2d
  catch __FORGIVE_47
__ENDLESS_46:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __ENDLESS_46
__FORGIVE_47:
  char 0a
  ret
__RULE___prefix:
  catch __FORGIVE_61
__ENDLESS_60:
  catch __RIGHTHAND_64
  call __RULE_COMMENT
  commit __SUCCESS_64
__RIGHTHAND_64:
  call __RULE_S
__SUCCESS_64:
  partialcommit __ENDLESS_60
__FORGIVE_61:
  ret
__RULE_END:
  call __RULE___prefix
  catch __PREFIX_79
  any
  failtwice
__PREFIX_79:
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
  call __RULE_LEFTARROW
  call __RULE_EXPRESSION
  ret
__RULE_EXPRESSION:
  call __RULE___prefix
  catch __RIGHTHAND_128
  opencapture 1
  call __RULE_TERMS
  closecapture 1
  call __RULE_OR
  call __RULE_NOTHING
  commit __SUCCESS_128
__RIGHTHAND_128:
  catch __RIGHTHAND_157
  opencapture 2
  call __RULE_TERMS
  closecapture 2
  call __RULE_OR
  call __RULE_EXPRESSION
  commit __SUCCESS_157
__RIGHTHAND_157:
  opencapture 3
  call __RULE_TERMS
  closecapture 3
__SUCCESS_157:
__SUCCESS_128:
  ret
__RULE_TERMS:
  call __RULE___prefix
  opencapture 4
  call __RULE_TERM
  closecapture 4
  catch __FORGIVE_204
__ENDLESS_203:
  opencapture 4
  call __RULE_TERM
  closecapture 4
  partialcommit __ENDLESS_203
__FORGIVE_204:
  ret
__RULE_TERM:
  call __RULE___prefix
  opencapture 5
  call __RULE_ENDOWEDMATCHER
  closecapture 5
  ret
__RULE_ENDOWEDMATCHER:
  call __RULE___prefix
  catch __FORGIVE_239
  opencapture 6
  catch __RIGHTHAND_242
  call __RULE_NOT
  commit __SUCCESS_242
__RIGHTHAND_242:
  call __RULE_AND
__SUCCESS_242:
  closecapture 6
  commit __FORGIVE_239
__FORGIVE_239:
  call __RULE_MATCHER
  catch __FORGIVE_268
  opencapture 7
  call __RULE_QUANTIFIER
  closecapture 7
  commit __FORGIVE_268
__FORGIVE_268:
  ret
__RULE_QUANTIFIER:
  call __RULE___prefix
  catch __RIGHTHAND_278
  char 3f
  commit __SUCCESS_278
__RIGHTHAND_278:
  catch __RIGHTHAND_286
  char 2b
  commit __SUCCESS_286
__RIGHTHAND_286:
  catch __RIGHTHAND_294
  char 2a
  commit __SUCCESS_294
__RIGHTHAND_294:
  catch __RIGHTHAND_302
  char 5e
  opencapture 8
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_321
__ENDLESS_320:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_320
__FORGIVE_321:
  closecapture 8
  char 2d
  opencapture 9
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_342
__ENDLESS_341:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_341
__FORGIVE_342:
  closecapture 9
  commit __SUCCESS_302
__RIGHTHAND_302:
  catch __RIGHTHAND_345
  char 5e
  char 2d
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_371
__ENDLESS_370:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_370
__FORGIVE_371:
  closecapture 10
  commit __SUCCESS_345
__RIGHTHAND_345:
  catch __RIGHTHAND_374
  char 5e
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_393
__ENDLESS_392:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_392
__FORGIVE_393:
  closecapture 11
  char 2d
  commit __SUCCESS_374
__RIGHTHAND_374:
  catch __RIGHTHAND_403
  char 5e
  opencapture 12
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_422
__ENDLESS_421:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_421
__FORGIVE_422:
  closecapture 12
  commit __SUCCESS_403
__RIGHTHAND_403:
  char 5e
  char 24
  opencapture 13
  call __RULE_IDENT
  closecapture 13
__SUCCESS_403:
__SUCCESS_374:
__SUCCESS_345:
__SUCCESS_302:
__SUCCESS_294:
__SUCCESS_286:
__SUCCESS_278:
  ret
__RULE_MATCHER:
  call __RULE___prefix
  catch __RIGHTHAND_446
  opencapture 14
  call __RULE_ANY
  closecapture 14
  commit __SUCCESS_446
__RIGHTHAND_446:
  catch __RIGHTHAND_461
  opencapture 15
  call __RULE_SET
  closecapture 15
  commit __SUCCESS_461
__RIGHTHAND_461:
  catch __RIGHTHAND_476
  opencapture 16
  call __RULE_STRING
  closecapture 16
  commit __SUCCESS_476
__RIGHTHAND_476:
  catch __RIGHTHAND_491
  opencapture 17
  call __RULE_BITMASK
  closecapture 17
  commit __SUCCESS_491
__RIGHTHAND_491:
  catch __RIGHTHAND_506
  opencapture 18
  call __RULE_HEXLITERAL
  closecapture 18
  commit __SUCCESS_506
__RIGHTHAND_506:
  catch __RIGHTHAND_521
  opencapture 19
  call __RULE_VARCAPTURE
  closecapture 19
  commit __SUCCESS_521
__RIGHTHAND_521:
  catch __RIGHTHAND_536
  opencapture 20
  call __RULE_CAPTURE
  closecapture 20
  commit __SUCCESS_536
__RIGHTHAND_536:
  catch __RIGHTHAND_551
  opencapture 21
  call __RULE_GROUP
  closecapture 21
  commit __SUCCESS_551
__RIGHTHAND_551:
  catch __RIGHTHAND_566
  opencapture 22
  call __RULE_MACRO
  closecapture 22
  commit __SUCCESS_566
__RIGHTHAND_566:
  catch __RIGHTHAND_581
  opencapture 23
  call __RULE_VARREFERENCE
  closecapture 23
  commit __SUCCESS_581
__RIGHTHAND_581:
  opencapture 24
  call __RULE_REFERENCE
  closecapture 24
__SUCCESS_581:
__SUCCESS_566:
__SUCCESS_551:
__SUCCESS_536:
__SUCCESS_521:
__SUCCESS_506:
__SUCCESS_491:
__SUCCESS_476:
__SUCCESS_461:
__SUCCESS_446:
  ret
__RULE_BITMASK:
  call __RULE___prefix
  char 7c
  counter 0 2
__COUNTER_618:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __COUNTER_618
  char 7c
  counter 1 2
__COUNTER_632:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __COUNTER_632
  char 7c
  ret
__RULE_VARCAPTURE:
  call __RULE___prefix
  call __RULE_CBOPEN
  call __RULE_COLON
  opencapture 25
  call __RULE_IDENT
  closecapture 25
  call __RULE_COLON
  call __RULE_EXPRESSION
  opencapture 26
  call __RULE_CBCLOSE
  closecapture 26
  call __RULE_CAPTUREEND
  ret
__RULE_CAPTURE:
  call __RULE___prefix
  call __RULE_CBOPEN
  call __RULE_EXPRESSION
  opencapture 27
  call __RULE_CBCLOSE
  closecapture 27
  call __RULE_CAPTUREEND
  ret
__RULE_GROUP:
  call __RULE___prefix
  call __RULE_BOPEN
  call __RULE_EXPRESSION
  opencapture 28
  call __RULE_BCLOSE
  closecapture 28
  ret
__RULE_CAPTUREEND:
  call __RULE___prefix
  catch __FORGIVE_775
  catch __RIGHTHAND_778
  call __RULE_REPLACE
  commit __SUCCESS_778
__RIGHTHAND_778:
  call __RULE_RECYCLE
__SUCCESS_778:
  commit __FORGIVE_775
__FORGIVE_775:
  ret
__RULE_SET:
  call __RULE___prefix
  call __RULE_ABOPEN
  opencapture 29
  catch __FORGIVE_811
  call __RULE_SETNOT
  commit __FORGIVE_811
__FORGIVE_811:
  closecapture 29
  catch __RIGHTHAND_821
  opencapture 30
  catch __RIGHTHAND_829
  char 5c
  catch __RIGHTHAND_844
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_844
__RIGHTHAND_844:
  counter 2 3
__COUNTER_853:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __COUNTER_853
__SUCCESS_844:
  commit __SUCCESS_829
__RIGHTHAND_829:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_829:
  closecapture 30
  char 2d
  opencapture 31
  catch __RIGHTHAND_880
  char 5c
  catch __RIGHTHAND_895
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_895
__RIGHTHAND_895:
  counter 3 3
__COUNTER_904:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __COUNTER_904
__SUCCESS_895:
  commit __SUCCESS_880
__RIGHTHAND_880:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_880:
  closecapture 31
  commit __SUCCESS_821
__RIGHTHAND_821:
  opencapture 32
  catch __RIGHTHAND_924
  char 5c
  catch __RIGHTHAND_939
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_939
__RIGHTHAND_939:
  counter 4 3
__COUNTER_948:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 4 __COUNTER_948
__SUCCESS_939:
  commit __SUCCESS_924
__RIGHTHAND_924:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_924:
  closecapture 32
__SUCCESS_821:
  catch __FORGIVE_818
__ENDLESS_817:
  catch __RIGHTHAND_961
  opencapture 30
  catch __RIGHTHAND_969
  char 5c
  catch __RIGHTHAND_984
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_984
__RIGHTHAND_984:
  counter 5 3
__COUNTER_993:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 5 __COUNTER_993
__SUCCESS_984:
  commit __SUCCESS_969
__RIGHTHAND_969:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_969:
  closecapture 30
  char 2d
  opencapture 31
  catch __RIGHTHAND_1020
  char 5c
  catch __RIGHTHAND_1035
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1035
__RIGHTHAND_1035:
  counter 6 3
__COUNTER_1044:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 6 __COUNTER_1044
__SUCCESS_1035:
  commit __SUCCESS_1020
__RIGHTHAND_1020:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1020:
  closecapture 31
  commit __SUCCESS_961
__RIGHTHAND_961:
  opencapture 32
  catch __RIGHTHAND_1064
  char 5c
  catch __RIGHTHAND_1079
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1079
__RIGHTHAND_1079:
  counter 7 3
__COUNTER_1088:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 7 __COUNTER_1088
__SUCCESS_1079:
  commit __SUCCESS_1064
__RIGHTHAND_1064:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1064:
  closecapture 32
__SUCCESS_961:
  partialcommit __ENDLESS_817
__FORGIVE_818:
  opencapture 33
  call __RULE_ABCLOSE
  closecapture 33
  ret
__RULE_VARREFERENCE:
  call __RULE___prefix
  char 24
  catch __RIGHTHAND_1129
  opencapture 34
  call __RULE_IDENT
  closecapture 34
  commit __SUCCESS_1129
__RIGHTHAND_1129:
  opencapture 35
  call __RULE_NUMBER
  closecapture 35
__SUCCESS_1129:
  ret
__RULE_REFERENCE:
  call __RULE___prefix
  call __RULE_IDENT
  catch __PREFIX_1165
  call __RULE_LEFTARROW
  failtwice
__PREFIX_1165:
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
  catch __FORGIVE_1204
__ENDLESS_1203:
  call __RULE_REPLACETERM
  partialcommit __ENDLESS_1203
__FORGIVE_1204:
  ret
__RULE_REPLACETERM:
  call __RULE___prefix
  catch __RIGHTHAND_1207
  opencapture 37
  call __RULE_STRINGLITERAL
  closecapture 37
  commit __SUCCESS_1207
__RIGHTHAND_1207:
  catch __RIGHTHAND_1222
  opencapture 38
  call __RULE_HEXLITERAL
  closecapture 38
  commit __SUCCESS_1222
__RIGHTHAND_1222:
  opencapture 39
  call __RULE_VARREFERENCE
  closecapture 39
__SUCCESS_1222:
__SUCCESS_1207:
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
  catch __FORGIVE_1283
  counter 8 63
__COUNTER_1281:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __USELESS_1285
__USELESS_1285:
  condjump 8 __COUNTER_1281
  commit __FORGIVE_1283
__FORGIVE_1283:
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
  catch __FORGIVE_1339
__ENDLESS_1338:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __ENDLESS_1338
__FORGIVE_1339:
  ret
__RULE_HEXLITERAL:
  call __RULE___prefix
  char 30
  char 78
  counter 8 2
__COUNTER_1350:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 8 __COUNTER_1350
  ret
__RULE_NUMBER:
  call __RULE___prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1360
__ENDLESS_1359:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1359
__FORGIVE_1360:
  ret
__RULE_STRINGLITERAL:
  call __RULE___prefix
  char 27
  catch __FORGIVE_1374
__ENDLESS_1373:
  catch __RIGHTHAND_1377
  char 5c
  catch __RIGHTHAND_1392
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_1392
__RIGHTHAND_1392:
  counter 9 3
__COUNTER_1401:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 9 __COUNTER_1401
__SUCCESS_1392:
  commit __SUCCESS_1377
__RIGHTHAND_1377:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1377:
  partialcommit __ENDLESS_1373
__FORGIVE_1374:
  char 27
  ret
__RULE_STRING:
  call __RULE___prefix
  call __RULE_STRINGLITERAL
  catch __FORGIVE_1432
  char 69
  commit __FORGIVE_1432
__FORGIVE_1432:
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

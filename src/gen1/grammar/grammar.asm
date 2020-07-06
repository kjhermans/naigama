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
  char 5e
  opencapture 12
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_421
__ENDLESS_420:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_420
__FORGIVE_421:
  closecapture 12
__SUCCESS_374:
__SUCCESS_345:
__SUCCESS_302:
__SUCCESS_294:
__SUCCESS_286:
__SUCCESS_278:
  ret
__RULE_MATCHER:
  call __RULE___prefix
  catch __RIGHTHAND_424
  opencapture 13
  call __RULE_ANY
  closecapture 13
  commit __SUCCESS_424
__RIGHTHAND_424:
  catch __RIGHTHAND_439
  opencapture 14
  call __RULE_SET
  closecapture 14
  commit __SUCCESS_439
__RIGHTHAND_439:
  catch __RIGHTHAND_454
  opencapture 15
  call __RULE_STRING
  closecapture 15
  commit __SUCCESS_454
__RIGHTHAND_454:
  catch __RIGHTHAND_469
  opencapture 16
  call __RULE_BITMASK
  closecapture 16
  commit __SUCCESS_469
__RIGHTHAND_469:
  catch __RIGHTHAND_484
  opencapture 17
  call __RULE_HEXLITERAL
  closecapture 17
  commit __SUCCESS_484
__RIGHTHAND_484:
  catch __RIGHTHAND_499
  opencapture 18
  call __RULE_VARCAPTURE
  closecapture 18
  commit __SUCCESS_499
__RIGHTHAND_499:
  catch __RIGHTHAND_514
  opencapture 19
  call __RULE_CAPTURE
  closecapture 19
  commit __SUCCESS_514
__RIGHTHAND_514:
  catch __RIGHTHAND_529
  opencapture 20
  call __RULE_GROUP
  closecapture 20
  commit __SUCCESS_529
__RIGHTHAND_529:
  catch __RIGHTHAND_544
  opencapture 21
  call __RULE_MACRO
  closecapture 21
  commit __SUCCESS_544
__RIGHTHAND_544:
  catch __RIGHTHAND_559
  opencapture 22
  call __RULE_VARREFERENCE
  closecapture 22
  commit __SUCCESS_559
__RIGHTHAND_559:
  opencapture 23
  call __RULE_REFERENCE
  closecapture 23
__SUCCESS_559:
__SUCCESS_544:
__SUCCESS_529:
__SUCCESS_514:
__SUCCESS_499:
__SUCCESS_484:
__SUCCESS_469:
__SUCCESS_454:
__SUCCESS_439:
__SUCCESS_424:
  ret
__RULE_BITMASK:
  call __RULE___prefix
  char 7c
  counter 0 2
__COUNTER_596:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __COUNTER_596
  char 7c
  counter 1 2
__COUNTER_610:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __COUNTER_610
  char 7c
  ret
__RULE_VARCAPTURE:
  call __RULE___prefix
  call __RULE_CBOPEN
  call __RULE_COLON
  opencapture 24
  call __RULE_IDENT
  closecapture 24
  call __RULE_COLON
  call __RULE_EXPRESSION
  opencapture 25
  call __RULE_CBCLOSE
  closecapture 25
  call __RULE_CAPTUREEND
  ret
__RULE_CAPTURE:
  call __RULE___prefix
  call __RULE_CBOPEN
  call __RULE_EXPRESSION
  opencapture 26
  call __RULE_CBCLOSE
  closecapture 26
  call __RULE_CAPTUREEND
  ret
__RULE_GROUP:
  call __RULE___prefix
  call __RULE_BOPEN
  call __RULE_EXPRESSION
  opencapture 27
  call __RULE_BCLOSE
  closecapture 27
  ret
__RULE_CAPTUREEND:
  call __RULE___prefix
  catch __FORGIVE_753
  catch __RIGHTHAND_756
  call __RULE_REPLACE
  commit __SUCCESS_756
__RIGHTHAND_756:
  call __RULE_RECYCLE
__SUCCESS_756:
  commit __FORGIVE_753
__FORGIVE_753:
  ret
__RULE_SET:
  call __RULE___prefix
  call __RULE_ABOPEN
  opencapture 28
  catch __FORGIVE_789
  call __RULE_SETNOT
  commit __FORGIVE_789
__FORGIVE_789:
  closecapture 28
  catch __RIGHTHAND_799
  opencapture 29
  catch __RIGHTHAND_807
  char 5c
  catch __RIGHTHAND_822
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_822
__RIGHTHAND_822:
  counter 2 3
__COUNTER_831:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __COUNTER_831
__SUCCESS_822:
  commit __SUCCESS_807
__RIGHTHAND_807:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_807:
  closecapture 29
  char 2d
  opencapture 30
  catch __RIGHTHAND_858
  char 5c
  catch __RIGHTHAND_873
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_873
__RIGHTHAND_873:
  counter 3 3
__COUNTER_882:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __COUNTER_882
__SUCCESS_873:
  commit __SUCCESS_858
__RIGHTHAND_858:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_858:
  closecapture 30
  commit __SUCCESS_799
__RIGHTHAND_799:
  opencapture 31
  catch __RIGHTHAND_902
  char 5c
  catch __RIGHTHAND_917
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_917
__RIGHTHAND_917:
  counter 4 3
__COUNTER_926:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 4 __COUNTER_926
__SUCCESS_917:
  commit __SUCCESS_902
__RIGHTHAND_902:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_902:
  closecapture 31
__SUCCESS_799:
  catch __FORGIVE_796
__ENDLESS_795:
  catch __RIGHTHAND_939
  opencapture 29
  catch __RIGHTHAND_947
  char 5c
  catch __RIGHTHAND_962
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_962
__RIGHTHAND_962:
  counter 5 3
__COUNTER_971:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 5 __COUNTER_971
__SUCCESS_962:
  commit __SUCCESS_947
__RIGHTHAND_947:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_947:
  closecapture 29
  char 2d
  opencapture 30
  catch __RIGHTHAND_998
  char 5c
  catch __RIGHTHAND_1013
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1013
__RIGHTHAND_1013:
  counter 6 3
__COUNTER_1022:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 6 __COUNTER_1022
__SUCCESS_1013:
  commit __SUCCESS_998
__RIGHTHAND_998:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_998:
  closecapture 30
  commit __SUCCESS_939
__RIGHTHAND_939:
  opencapture 31
  catch __RIGHTHAND_1042
  char 5c
  catch __RIGHTHAND_1057
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_1057
__RIGHTHAND_1057:
  counter 7 3
__COUNTER_1066:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 7 __COUNTER_1066
__SUCCESS_1057:
  commit __SUCCESS_1042
__RIGHTHAND_1042:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1042:
  closecapture 31
__SUCCESS_939:
  partialcommit __ENDLESS_795
__FORGIVE_796:
  opencapture 32
  call __RULE_ABCLOSE
  closecapture 32
  ret
__RULE_VARREFERENCE:
  call __RULE___prefix
  char 24
  catch __RIGHTHAND_1107
  opencapture 33
  call __RULE_IDENT
  closecapture 33
  commit __SUCCESS_1107
__RIGHTHAND_1107:
  opencapture 34
  call __RULE_NUMBER
  closecapture 34
__SUCCESS_1107:
  ret
__RULE_REFERENCE:
  call __RULE___prefix
  call __RULE_IDENT
  catch __PREFIX_1143
  call __RULE_LEFTARROW
  failtwice
__PREFIX_1143:
  ret
__RULE_REPLACE:
  call __RULE___prefix
  call __RULE_RIGHTARROW
  opencapture 35
  call __RULE_REPLACETERMS
  closecapture 35
  ret
__RULE_REPLACETERMS:
  call __RULE___prefix
  call __RULE_REPLACETERM
  catch __FORGIVE_1182
__ENDLESS_1181:
  call __RULE_REPLACETERM
  partialcommit __ENDLESS_1181
__FORGIVE_1182:
  ret
__RULE_REPLACETERM:
  call __RULE___prefix
  catch __RIGHTHAND_1185
  opencapture 36
  call __RULE_STRINGLITERAL
  closecapture 36
  commit __SUCCESS_1185
__RIGHTHAND_1185:
  catch __RIGHTHAND_1200
  opencapture 37
  call __RULE_HEXLITERAL
  closecapture 37
  commit __SUCCESS_1200
__RIGHTHAND_1200:
  opencapture 38
  call __RULE_VARREFERENCE
  closecapture 38
__SUCCESS_1200:
__SUCCESS_1185:
  ret
__RULE_RECYCLE:
  call __RULE___prefix
  call __RULE_FATARROW
  opencapture 39
  call __RULE_IDENT
  closecapture 39
  ret
__RULE_IDENT:
  call __RULE___prefix
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_1261
  counter 8 63
__COUNTER_1259:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __USELESS_1263
__USELESS_1263:
  condjump 8 __COUNTER_1259
  commit __FORGIVE_1261
__FORGIVE_1261:
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
  catch __FORGIVE_1317
__ENDLESS_1316:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __ENDLESS_1316
__FORGIVE_1317:
  ret
__RULE_HEXLITERAL:
  call __RULE___prefix
  char 30
  char 78
  counter 8 2
__COUNTER_1328:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 8 __COUNTER_1328
  ret
__RULE_NUMBER:
  call __RULE___prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1338
__ENDLESS_1337:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1337
__FORGIVE_1338:
  ret
__RULE_STRINGLITERAL:
  call __RULE___prefix
  char 27
  catch __FORGIVE_1352
__ENDLESS_1351:
  catch __RIGHTHAND_1355
  char 5c
  catch __RIGHTHAND_1370
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_1370
__RIGHTHAND_1370:
  counter 9 3
__COUNTER_1379:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 9 __COUNTER_1379
__SUCCESS_1370:
  commit __SUCCESS_1355
__RIGHTHAND_1355:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1355:
  partialcommit __ENDLESS_1351
__FORGIVE_1352:
  char 27
  ret
__RULE_STRING:
  call __RULE___prefix
  call __RULE_STRINGLITERAL
  catch __FORGIVE_1410
  char 69
  commit __FORGIVE_1410
__FORGIVE_1410:
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

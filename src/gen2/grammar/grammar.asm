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
  call LEFTARROW
  call EXPRESSION
  ret
-- Rule
EXPRESSION:
  call __prefix
  catch __RIGHTHAND_112
  opencapture 1
  call TERMS
  closecapture 1 0
  call OR
  call NOTHING
  commit __LEFTHAND_113
__RIGHTHAND_112:
  catch __RIGHTHAND_138
  opencapture 2
  call TERMS
  closecapture 2 0
  call OR
  call EXPRESSION
  commit __LEFTHAND_139
__RIGHTHAND_138:
  opencapture 3
  call TERMS
  closecapture 3 0
__LEFTHAND_139:
__LEFTHAND_113:
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 4
  call TERM
  closecapture 4 0
  catch __TERM_180
__TERM_179:
  opencapture 4
  call TERM
  closecapture 4 0
  partialcommit __TERM_179
__TERM_180:
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
  catch __TERM_209
  opencapture 6
  catch __RIGHTHAND_212
  call NOT
  commit __LEFTHAND_213
__RIGHTHAND_212:
  call AND
__LEFTHAND_213:
  closecapture 6 0
  commit __TERM_209
__TERM_209:
  call MATCHER
  catch __TERM_235
  opencapture 7
  call QUANTIFIER
  closecapture 7 0
  commit __TERM_235
__TERM_235:
  ret
-- Rule
QUANTIFIER:
  call __prefix
  catch __RIGHTHAND_244
  char 3f
  commit __LEFTHAND_245
__RIGHTHAND_244:
  catch __RIGHTHAND_252
  char 2b
  commit __LEFTHAND_253
__RIGHTHAND_252:
  catch __RIGHTHAND_260
  char 2a
  commit __LEFTHAND_261
__RIGHTHAND_260:
  catch __RIGHTHAND_268
  char 5e
  opencapture 8
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_286
__TERM_285:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_285
__TERM_286:
  closecapture 8 0
  char 2d
  opencapture 9
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_304
__TERM_303:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_303
__TERM_304:
  closecapture 9 0
  commit __LEFTHAND_269
__RIGHTHAND_268:
  catch __RIGHTHAND_306
  char 5e
  char 2d
  opencapture 10
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_330
__TERM_329:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_329
__TERM_330:
  closecapture 10 0
  commit __LEFTHAND_307
__RIGHTHAND_306:
  catch __RIGHTHAND_332
  char 5e
  opencapture 11
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_350
__TERM_349:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_349
__TERM_350:
  closecapture 11 0
  char 2d
  commit __LEFTHAND_333
__RIGHTHAND_332:
  catch __RIGHTHAND_358
  char 5e
  opencapture 12
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_376
__TERM_375:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_375
__TERM_376:
  closecapture 12 0
  commit __LEFTHAND_359
__RIGHTHAND_358:
  char 5e
  char 24
  opencapture 13
  call IDENT
  closecapture 13 0
__LEFTHAND_359:
__LEFTHAND_333:
__LEFTHAND_307:
__LEFTHAND_269:
__LEFTHAND_261:
__LEFTHAND_253:
__LEFTHAND_245:
  ret
-- Rule
MATCHER:
  call __prefix
  catch __RIGHTHAND_396
  opencapture 14
  call ANY
  closecapture 14 0
  commit __LEFTHAND_397
__RIGHTHAND_396:
  catch __RIGHTHAND_410
  opencapture 15
  call SET
  closecapture 15 0
  commit __LEFTHAND_411
__RIGHTHAND_410:
  catch __RIGHTHAND_424
  opencapture 16
  call STRING
  closecapture 16 0
  commit __LEFTHAND_425
__RIGHTHAND_424:
  catch __RIGHTHAND_438
  opencapture 17
  call BITMASK
  closecapture 17 0
  commit __LEFTHAND_439
__RIGHTHAND_438:
  catch __RIGHTHAND_452
  opencapture 18
  call HEXLITERAL
  closecapture 18 0
  commit __LEFTHAND_453
__RIGHTHAND_452:
  catch __RIGHTHAND_466
  opencapture 19
  call VARCAPTURE
  closecapture 19 0
  commit __LEFTHAND_467
__RIGHTHAND_466:
  catch __RIGHTHAND_480
  opencapture 20
  call CAPTURE
  closecapture 20 0
  commit __LEFTHAND_481
__RIGHTHAND_480:
  catch __RIGHTHAND_494
  opencapture 21
  call GROUP
  closecapture 21 0
  commit __LEFTHAND_495
__RIGHTHAND_494:
  catch __RIGHTHAND_508
  opencapture 22
  call MACRO
  closecapture 22 0
  commit __LEFTHAND_509
__RIGHTHAND_508:
  catch __RIGHTHAND_522
  opencapture 23
  call VARREFERENCE
  closecapture 23 0
  commit __LEFTHAND_523
__RIGHTHAND_522:
  opencapture 24
  call REFERENCE
  closecapture 24 0
__LEFTHAND_523:
__LEFTHAND_509:
__LEFTHAND_495:
__LEFTHAND_481:
__LEFTHAND_467:
__LEFTHAND_453:
__LEFTHAND_439:
__LEFTHAND_425:
__LEFTHAND_411:
__LEFTHAND_397:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__TERM_556:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_556
  char 7c
  counter 1 2
__TERM_568:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __TERM_568
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
  call COLON
  call EXPRESSION
  opencapture 26
  call CBCLOSE
  closecapture 26 0
  call CAPTUREEND
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  opencapture 27
  call CBCLOSE
  closecapture 27 0
  call CAPTUREEND
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
CAPTUREEND:
  call __prefix
  catch __TERM_689
  catch __RIGHTHAND_692
  call REPLACE
  commit __LEFTHAND_693
__RIGHTHAND_692:
  call RECYCLE
__LEFTHAND_693:
  commit __TERM_689
__TERM_689:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 29
  catch __TERM_721
  call SETNOT
  commit __TERM_721
__TERM_721:
  closecapture 29 0
  catch __RIGHTHAND_730
  opencapture 30
  catch __RIGHTHAND_738
  char 5c
  catch __RIGHTHAND_752
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_753
__RIGHTHAND_752:
  counter 2 3
__TERM_762:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_762
__LEFTHAND_753:
  commit __LEFTHAND_739
__RIGHTHAND_738:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_739:
  closecapture 30 0
  char 2d
  opencapture 31
  catch __RIGHTHAND_784
  char 5c
  catch __RIGHTHAND_798
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_799
__RIGHTHAND_798:
  counter 2 3
__TERM_808:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_808
__LEFTHAND_799:
  commit __LEFTHAND_785
__RIGHTHAND_784:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_785:
  closecapture 31 0
  commit __LEFTHAND_731
__RIGHTHAND_730:
  opencapture 32
  catch __RIGHTHAND_824
  char 5c
  catch __RIGHTHAND_838
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_839
__RIGHTHAND_838:
  counter 2 3
__TERM_848:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_848
__LEFTHAND_839:
  commit __LEFTHAND_825
__RIGHTHAND_824:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_825:
  closecapture 32 0
__LEFTHAND_731:
  catch __TERM_728
__TERM_727:
  catch __RIGHTHAND_858
  opencapture 30
  catch __RIGHTHAND_866
  char 5c
  catch __RIGHTHAND_880
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_881
__RIGHTHAND_880:
  counter 2 3
__TERM_890:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_890
__LEFTHAND_881:
  commit __LEFTHAND_867
__RIGHTHAND_866:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_867:
  closecapture 30 0
  char 2d
  opencapture 31
  catch __RIGHTHAND_912
  char 5c
  catch __RIGHTHAND_926
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_927
__RIGHTHAND_926:
  counter 2 3
__TERM_936:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_936
__LEFTHAND_927:
  commit __LEFTHAND_913
__RIGHTHAND_912:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_913:
  closecapture 31 0
  commit __LEFTHAND_859
__RIGHTHAND_858:
  opencapture 32
  catch __RIGHTHAND_952
  char 5c
  catch __RIGHTHAND_966
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_967
__RIGHTHAND_966:
  counter 2 3
__TERM_976:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 2 __TERM_976
__LEFTHAND_967:
  commit __LEFTHAND_953
__RIGHTHAND_952:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_953:
  closecapture 32 0
__LEFTHAND_859:
  partialcommit __TERM_727
__TERM_728:
  opencapture 33
  call ABCLOSE
  closecapture 33 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1010
  opencapture 34
  call IDENT
  closecapture 34 0
  commit __LEFTHAND_1011
__RIGHTHAND_1010:
  opencapture 35
  call NUMBER
  closecapture 35 0
__LEFTHAND_1011:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1042
  call LEFTARROW
  failtwice
__TERM_1042:
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
  catch __TERM_1076
__TERM_1075:
  call REPLACETERM
  partialcommit __TERM_1075
__TERM_1076:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1078
  opencapture 37
  call STRINGLITERAL
  closecapture 37 0
  commit __LEFTHAND_1079
__RIGHTHAND_1078:
  catch __RIGHTHAND_1092
  opencapture 38
  call HEXLITERAL
  closecapture 38 0
  commit __LEFTHAND_1093
__RIGHTHAND_1092:
  opencapture 39
  call VARREFERENCE
  closecapture 39 0
__LEFTHAND_1093:
__LEFTHAND_1079:
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
  catch __TERM_1145
  counter 2 63
__TERM_1146:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1147
__TERM_1147:
  condjump 2 __TERM_1146
  commit __TERM_1145
__TERM_1145:
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
  catch __TERM_1194
__TERM_1193:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1193
__TERM_1194:
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 3 2
__TERM_1204:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 3 __TERM_1204
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1212
__TERM_1211:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1211
__TERM_1212:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  catch __TERM_1224
__TERM_1223:
  catch __RIGHTHAND_1226
  char 5c
  catch __RIGHTHAND_1240
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1241
__RIGHTHAND_1240:
  counter 4 3
__TERM_1250:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 4 __TERM_1250
__LEFTHAND_1241:
  commit __LEFTHAND_1227
__RIGHTHAND_1226:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1227:
  partialcommit __TERM_1223
__TERM_1224:
  char 27
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1275
  char 69
  commit __TERM_1275
__TERM_1275:
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

  end 0

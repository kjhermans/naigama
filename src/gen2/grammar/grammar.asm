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
  char 5e
  opencapture 12
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_374
__TERM_373:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_373
__TERM_374:
  closecapture 12 0
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
  catch __RIGHTHAND_376
  opencapture 13
  call ANY
  closecapture 13 0
  commit __LEFTHAND_377
__RIGHTHAND_376:
  catch __RIGHTHAND_390
  opencapture 14
  call SET
  closecapture 14 0
  commit __LEFTHAND_391
__RIGHTHAND_390:
  catch __RIGHTHAND_404
  opencapture 15
  call STRING
  closecapture 15 0
  commit __LEFTHAND_405
__RIGHTHAND_404:
  catch __RIGHTHAND_418
  opencapture 16
  call BITMASK
  closecapture 16 0
  commit __LEFTHAND_419
__RIGHTHAND_418:
  catch __RIGHTHAND_432
  opencapture 17
  call HEXLITERAL
  closecapture 17 0
  commit __LEFTHAND_433
__RIGHTHAND_432:
  catch __RIGHTHAND_446
  opencapture 18
  call VARCAPTURE
  closecapture 18 0
  commit __LEFTHAND_447
__RIGHTHAND_446:
  catch __RIGHTHAND_460
  opencapture 19
  call CAPTURE
  closecapture 19 0
  commit __LEFTHAND_461
__RIGHTHAND_460:
  catch __RIGHTHAND_474
  opencapture 20
  call GROUP
  closecapture 20 0
  commit __LEFTHAND_475
__RIGHTHAND_474:
  catch __RIGHTHAND_488
  opencapture 21
  call MACRO
  closecapture 21 0
  commit __LEFTHAND_489
__RIGHTHAND_488:
  catch __RIGHTHAND_502
  opencapture 22
  call VARREFERENCE
  closecapture 22 0
  commit __LEFTHAND_503
__RIGHTHAND_502:
  opencapture 23
  call REFERENCE
  closecapture 23 0
__LEFTHAND_503:
__LEFTHAND_489:
__LEFTHAND_475:
__LEFTHAND_461:
__LEFTHAND_447:
__LEFTHAND_433:
__LEFTHAND_419:
__LEFTHAND_405:
__LEFTHAND_391:
__LEFTHAND_377:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__TERM_536:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_536
  char 7c
  counter 0 2
__TERM_548:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_548
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
  catch __TERM_669
  catch __RIGHTHAND_672
  call REPLACE
  commit __LEFTHAND_673
__RIGHTHAND_672:
  call RECYCLE
__LEFTHAND_673:
  commit __TERM_669
__TERM_669:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 28
  catch __TERM_701
  call SETNOT
  commit __TERM_701
__TERM_701:
  closecapture 28 0
  catch __RIGHTHAND_710
  opencapture 29
  catch __RIGHTHAND_718
  char 5c
  catch __RIGHTHAND_732
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_733
__RIGHTHAND_732:
  counter 0 3
__TERM_742:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_742
__LEFTHAND_733:
  commit __LEFTHAND_719
__RIGHTHAND_718:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_719:
  closecapture 29 0
  char 2d
  opencapture 30
  catch __RIGHTHAND_764
  char 5c
  catch __RIGHTHAND_778
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_779
__RIGHTHAND_778:
  counter 0 3
__TERM_788:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_788
__LEFTHAND_779:
  commit __LEFTHAND_765
__RIGHTHAND_764:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_765:
  closecapture 30 0
  commit __LEFTHAND_711
__RIGHTHAND_710:
  opencapture 31
  catch __RIGHTHAND_804
  char 5c
  catch __RIGHTHAND_818
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_819
__RIGHTHAND_818:
  counter 0 3
__TERM_828:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_828
__LEFTHAND_819:
  commit __LEFTHAND_805
__RIGHTHAND_804:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_805:
  closecapture 31 0
__LEFTHAND_711:
  catch __TERM_708
__TERM_707:
  catch __RIGHTHAND_838
  opencapture 29
  catch __RIGHTHAND_846
  char 5c
  catch __RIGHTHAND_860
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_861
__RIGHTHAND_860:
  counter 0 3
__TERM_870:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_870
__LEFTHAND_861:
  commit __LEFTHAND_847
__RIGHTHAND_846:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_847:
  closecapture 29 0
  char 2d
  opencapture 30
  catch __RIGHTHAND_892
  char 5c
  catch __RIGHTHAND_906
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_907
__RIGHTHAND_906:
  counter 0 3
__TERM_916:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_916
__LEFTHAND_907:
  commit __LEFTHAND_893
__RIGHTHAND_892:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_893:
  closecapture 30 0
  commit __LEFTHAND_839
__RIGHTHAND_838:
  opencapture 31
  catch __RIGHTHAND_932
  char 5c
  catch __RIGHTHAND_946
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_947
__RIGHTHAND_946:
  counter 0 3
__TERM_956:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_956
__LEFTHAND_947:
  commit __LEFTHAND_933
__RIGHTHAND_932:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_933:
  closecapture 31 0
__LEFTHAND_839:
  partialcommit __TERM_707
__TERM_708:
  opencapture 32
  call ABCLOSE
  closecapture 32 0
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_990
  opencapture 33
  call IDENT
  closecapture 33 0
  commit __LEFTHAND_991
__RIGHTHAND_990:
  opencapture 34
  call NUMBER
  closecapture 34 0
__LEFTHAND_991:
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1022
  call LEFTARROW
  failtwice
__TERM_1022:
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
  catch __TERM_1056
__TERM_1055:
  call REPLACETERM
  partialcommit __TERM_1055
__TERM_1056:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1058
  opencapture 36
  call STRINGLITERAL
  closecapture 36 0
  commit __LEFTHAND_1059
__RIGHTHAND_1058:
  catch __RIGHTHAND_1072
  opencapture 37
  call HEXLITERAL
  closecapture 37 0
  commit __LEFTHAND_1073
__RIGHTHAND_1072:
  opencapture 38
  call VARREFERENCE
  closecapture 38 0
__LEFTHAND_1073:
__LEFTHAND_1059:
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
IDENT:
  call __prefix
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_1125
  counter 0 63
__TERM_1126:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1127
__TERM_1127:
  condjump 0 __TERM_1126
  commit __TERM_1125
__TERM_1125:
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
  catch __TERM_1174
__TERM_1173:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1173
__TERM_1174:
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 1 2
__TERM_1184:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __TERM_1184
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1192
__TERM_1191:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1191
__TERM_1192:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  catch __TERM_1204
__TERM_1203:
  catch __RIGHTHAND_1206
  char 5c
  catch __RIGHTHAND_1220
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1221
__RIGHTHAND_1220:
  counter 1 3
__TERM_1230:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 1 __TERM_1230
__LEFTHAND_1221:
  commit __LEFTHAND_1207
__RIGHTHAND_1206:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1207:
  partialcommit __TERM_1203
__TERM_1204:
  char 27
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1255
  char 69
  commit __TERM_1255
__TERM_1255:
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

  end 0

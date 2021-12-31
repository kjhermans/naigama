  call GRAMMAR
  end
-- Rule
GRAMMAR:
  opencapture 0
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
  closecapture 0
  ret
-- Rule
S:
  opencapture 1
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __TERM_30
__TERM_29:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_29
__TERM_30:
  closecapture 1
  ret
-- Rule
MULTILINECOMMENT:
  opencapture 2
  quad 2d2d5b5b
  catch __TERM_42
__TERM_41:
  catch __TERM_44
  char 5d
  char 5d
  failtwice
__TERM_44:
  any
  partialcommit __TERM_41
__TERM_42:
  char 5d
  char 5d
  closecapture 2
  ret
-- Rule
COMMENT:
  opencapture 3
  char 2d
  char 2d
  catch __TERM_72
__TERM_71:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_71
__TERM_72:
  char 0a
  closecapture 3
  ret
-- Rule
__prefix:
  catch __TERM_84
__TERM_83:
  catch __RIGHTHAND_86
  call MULTILINECOMMENT
  commit __LEFTHAND_87
__RIGHTHAND_86:
  catch __RIGHTHAND_94
  call COMMENT
  commit __LEFTHAND_95
__RIGHTHAND_94:
  call S
__LEFTHAND_95:
__LEFTHAND_87:
  partialcommit __TERM_83
__TERM_84:
  ret
-- Rule
END:
  call __prefix
  opencapture 4
  catch __TERM_108
  any
  failtwice
__TERM_108:
  closecapture 4
  ret
-- Rule
DEFINITION:
  call __prefix
  opencapture 5
  call RULE
  closecapture 5
  ret
-- Rule
SINGLE_EXPRESSION:
  call __prefix
  opencapture 6
  call EXPRESSION
  closecapture 6
  ret
-- Rule
RULE:
  call __prefix
  opencapture 7
  call IDENT
  call LEFTARROW
  call EXPRESSION
  closecapture 7
  ret
-- Rule
EXPRESSION:
  call __prefix
  opencapture 8
  catch __RIGHTHAND_144
  call ALTERNATIVES
  commit __LEFTHAND_145
__RIGHTHAND_144:
  call TERMS
__LEFTHAND_145:
  closecapture 8
  ret
-- Rule
ALTERNATIVES:
  call __prefix
  opencapture 9
  call TERMS
  call OR
  call EXPRESSION
  closecapture 9
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 10
  call TERM
  catch __TERM_180
__TERM_179:
  call TERM
  partialcommit __TERM_179
__TERM_180:
  closecapture 10
  ret
-- Rule
TERM:
  call __prefix
  opencapture 11
  catch __RIGHTHAND_182
  call SCANMATCHER
  commit __LEFTHAND_183
__RIGHTHAND_182:
  call QUANTIFIEDMATCHER
__LEFTHAND_183:
  closecapture 11
  ret
-- Rule
SCANMATCHER:
  call __prefix
  opencapture 12
  catch __RIGHTHAND_202
  call NOT
  commit __LEFTHAND_203
__RIGHTHAND_202:
  call AND
__LEFTHAND_203:
  call MATCHER
  closecapture 12
  ret
-- Rule
QUANTIFIEDMATCHER:
  call __prefix
  opencapture 13
  call MATCHER
  catch __TERM_231
  call QUANTIFIER
  commit __TERM_231
__TERM_231:
  closecapture 13
  ret
-- Rule
QUANTIFIER:
  call __prefix
  opencapture 14
  catch __RIGHTHAND_234
  call Q_ZEROORONE
  commit __LEFTHAND_235
__RIGHTHAND_234:
  catch __RIGHTHAND_242
  call Q_ONEORMORE
  commit __LEFTHAND_243
__RIGHTHAND_242:
  catch __RIGHTHAND_250
  call Q_ZEROORMORE
  commit __LEFTHAND_251
__RIGHTHAND_250:
  catch __RIGHTHAND_258
  call Q_FROMTO
  commit __LEFTHAND_259
__RIGHTHAND_258:
  catch __RIGHTHAND_266
  call Q_UNTIL
  commit __LEFTHAND_267
__RIGHTHAND_266:
  catch __RIGHTHAND_274
  call Q_FROM
  commit __LEFTHAND_275
__RIGHTHAND_274:
  catch __RIGHTHAND_282
  call Q_SPECIFIC
  commit __LEFTHAND_283
__RIGHTHAND_282:
  call Q_VAR
__LEFTHAND_283:
__LEFTHAND_275:
__LEFTHAND_267:
__LEFTHAND_259:
__LEFTHAND_251:
__LEFTHAND_243:
__LEFTHAND_235:
  closecapture 14
  ret
-- Rule
Q_ZEROORONE:
  call __prefix
  opencapture 15
  char 3f
  closecapture 15
  ret
-- Rule
Q_ONEORMORE:
  call __prefix
  opencapture 16
  char 2b
  closecapture 16
  ret
-- Rule
Q_ZEROORMORE:
  call __prefix
  opencapture 17
  char 2a
  closecapture 17
  ret
-- Rule
Q_FROMTO:
  call __prefix
  opencapture 18
  char 5e
  opencapture 19
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_330
__TERM_329:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_329
__TERM_330:
  closecapture 19 0
  char 2d
  opencapture 20
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_348
__TERM_347:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_347
__TERM_348:
  closecapture 20 0
  closecapture 18
  ret
-- Rule
Q_UNTIL:
  call __prefix
  opencapture 21
  char 5e
  char 2d
  opencapture 22
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_372
__TERM_371:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_371
__TERM_372:
  closecapture 22 0
  closecapture 21
  ret
-- Rule
Q_FROM:
  call __prefix
  opencapture 23
  char 5e
  opencapture 24
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_390
__TERM_389:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_389
__TERM_390:
  closecapture 24 0
  char 2d
  closecapture 23
  ret
-- Rule
Q_SPECIFIC:
  call __prefix
  opencapture 25
  char 5e
  opencapture 26
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_414
__TERM_413:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_413
__TERM_414:
  closecapture 26 0
  closecapture 25
  ret
-- Rule
Q_VAR:
  call __prefix
  opencapture 27
  char 5e
  call BOPEN
  call VARREFERENCE
  call BCLOSE
  closecapture 27
  ret
-- Rule
MATCHER:
  call __prefix
  opencapture 28
  catch __RIGHTHAND_440
  call ANY
  commit __LEFTHAND_441
__RIGHTHAND_440:
  catch __RIGHTHAND_448
  call SET
  commit __LEFTHAND_449
__RIGHTHAND_448:
  catch __RIGHTHAND_456
  call STRING
  commit __LEFTHAND_457
__RIGHTHAND_456:
  catch __RIGHTHAND_464
  call BITMASK
  commit __LEFTHAND_465
__RIGHTHAND_464:
  catch __RIGHTHAND_472
  call HEXLITERAL
  commit __LEFTHAND_473
__RIGHTHAND_472:
  catch __RIGHTHAND_480
  call VARCAPTURE
  commit __LEFTHAND_481
__RIGHTHAND_480:
  catch __RIGHTHAND_488
  call CAPTURE
  commit __LEFTHAND_489
__RIGHTHAND_488:
  catch __RIGHTHAND_496
  call GROUP
  commit __LEFTHAND_497
__RIGHTHAND_496:
  catch __RIGHTHAND_504
  call MACRO
  commit __LEFTHAND_505
__RIGHTHAND_504:
  catch __RIGHTHAND_512
  call ENDFORCE
  commit __LEFTHAND_513
__RIGHTHAND_512:
  catch __RIGHTHAND_520
  call VARREFERENCE
  commit __LEFTHAND_521
__RIGHTHAND_520:
  catch __RIGHTHAND_528
  call REFERENCE
  commit __LEFTHAND_529
__RIGHTHAND_528:
  call LIMITEDCALL
__LEFTHAND_529:
__LEFTHAND_521:
__LEFTHAND_513:
__LEFTHAND_505:
__LEFTHAND_497:
__LEFTHAND_489:
__LEFTHAND_481:
__LEFTHAND_473:
__LEFTHAND_465:
__LEFTHAND_457:
__LEFTHAND_449:
__LEFTHAND_441:
  closecapture 28
  ret
-- Rule
BITMASK:
  call __prefix
  opencapture 29
  char 7c
  counter 0 2
__TERM_550:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_550
  char 7c
  counter 0 2
__TERM_562:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_562
  char 7c
  closecapture 29
  ret
-- Rule
VARCAPTURE:
  call __prefix
  opencapture 30
  call CBOPEN
  call COLON
  call IDENT
  catch __TERM_593
  call CAPTURETYPE
  commit __TERM_593
__TERM_593:
  call COLON
  call EXPRESSION
  call CBCLOSE
  call CAPTUREEND
  closecapture 30
  ret
-- Rule
CAPTURETYPE:
  call __prefix
  opencapture 31
  call SEMICOLON
  call TYPE
  closecapture 31
  ret
-- Rule
TYPE:
  call __prefix
  opencapture 32
  catch __RIGHTHAND_632
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_633
__RIGHTHAND_632:
  quad 696e7433
  char 32
__LEFTHAND_633:
  closecapture 32
  ret
-- Rule
CAPTURE:
  call __prefix
  opencapture 33
  call CBOPEN
  call EXPRESSION
  call CBCLOSE
  call CAPTUREEND
  closecapture 33
  ret
-- Rule
GROUP:
  call __prefix
  opencapture 34
  call BOPEN
  call EXPRESSION
  call BCLOSE
  closecapture 34
  ret
-- Rule
CAPTUREEND:
  call __prefix
  opencapture 35
  catch __TERM_691
  catch __RIGHTHAND_694
  call REPLACE
  commit __LEFTHAND_695
__RIGHTHAND_694:
  call RECYCLE
__LEFTHAND_695:
  commit __TERM_691
__TERM_691:
  closecapture 35
  ret
-- Rule
SET:
  call __prefix
  opencapture 36
  call ABOPEN
  catch __TERM_717
  call SETNOT
  commit __TERM_717
__TERM_717:
  catch __RIGHTHAND_726
  opencapture 37
  catch __RIGHTHAND_734
  char 5c
  catch __RIGHTHAND_748
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_749
__RIGHTHAND_748:
  counter 0 3
__TERM_758:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_758
__LEFTHAND_749:
  commit __LEFTHAND_735
__RIGHTHAND_734:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_735:
  closecapture 37 0
  char 2d
  opencapture 38
  catch __RIGHTHAND_780
  char 5c
  catch __RIGHTHAND_794
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_795
__RIGHTHAND_794:
  counter 0 3
__TERM_804:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_804
__LEFTHAND_795:
  commit __LEFTHAND_781
__RIGHTHAND_780:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_781:
  closecapture 38 0
  commit __LEFTHAND_727
__RIGHTHAND_726:
  opencapture 39
  catch __RIGHTHAND_820
  char 5c
  catch __RIGHTHAND_834
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_835
__RIGHTHAND_834:
  counter 0 3
__TERM_844:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_844
__LEFTHAND_835:
  commit __LEFTHAND_821
__RIGHTHAND_820:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_821:
  closecapture 39 0
__LEFTHAND_727:
  catch __TERM_724
__TERM_723:
  catch __RIGHTHAND_854
  opencapture 37
  catch __RIGHTHAND_862
  char 5c
  catch __RIGHTHAND_876
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_877
__RIGHTHAND_876:
  counter 0 3
__TERM_886:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_886
__LEFTHAND_877:
  commit __LEFTHAND_863
__RIGHTHAND_862:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_863:
  closecapture 37 0
  char 2d
  opencapture 38
  catch __RIGHTHAND_908
  char 5c
  catch __RIGHTHAND_922
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_923
__RIGHTHAND_922:
  counter 0 3
__TERM_932:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_932
__LEFTHAND_923:
  commit __LEFTHAND_909
__RIGHTHAND_908:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_909:
  closecapture 38 0
  commit __LEFTHAND_855
__RIGHTHAND_854:
  opencapture 39
  catch __RIGHTHAND_948
  char 5c
  catch __RIGHTHAND_962
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_963
__RIGHTHAND_962:
  counter 0 3
__TERM_972:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_972
__LEFTHAND_963:
  commit __LEFTHAND_949
__RIGHTHAND_948:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_949:
  closecapture 39 0
__LEFTHAND_855:
  partialcommit __TERM_723
__TERM_724:
  call ABCLOSE
  closecapture 36
  ret
-- Rule
VARREFERENCE:
  call __prefix
  opencapture 40
  char 24
  catch __RIGHTHAND_1000
  call IDENT
  commit __LEFTHAND_1001
__RIGHTHAND_1000:
  call NUMBER
__LEFTHAND_1001:
  catch __TERM_1017
  call MASK
  commit __TERM_1017
__TERM_1017:
  closecapture 40
  ret
-- Rule
MASK:
  call __prefix
  opencapture 41
  char 7c
  opencapture 42
  counter 0 2
__TERM_1034:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1034
  closecapture 42 0
  closecapture 41
  ret
-- Rule
REFERENCE:
  call __prefix
  opencapture 43
  catch __TERM_1038
  call KW_IMPORT
  failtwice
__TERM_1038:
  call IDENT
  catch __TERM_1056
  call LEFTARROW
  failtwice
__TERM_1056:
  closecapture 43
  ret
-- Rule
LIMITEDCALL:
  call __prefix
  opencapture 44
  char 3c
  char 3c
  catch __TERM_1072
__TERM_1071:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1071
__TERM_1072:
  call LCMODES
  catch __TERM_1084
__TERM_1083:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1083
__TERM_1084:
  char 3a
  catch __TERM_1096
__TERM_1095:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1095
__TERM_1096:
  call LCPARAM
  catch __TERM_1108
__TERM_1107:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1107
__TERM_1108:
  char 3a
  catch __TERM_1120
__TERM_1119:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1119
__TERM_1120:
  call IDENT
  catch __TERM_1132
__TERM_1131:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1131
__TERM_1132:
  char 3e
  char 3e
  closecapture 44
  ret
-- Rule
LCMODES:
  call __prefix
  opencapture 45
  quad 7275696e
  char 74
  char 33
  char 32
  closecapture 45
  ret
-- Rule
LCPARAM:
  call __prefix
  opencapture 46
  catch __TERM_1150
__TERM_1149:
  set ffd1fffffefffffbffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_1149
__TERM_1150:
  closecapture 46
  ret
-- Rule
REPLACE:
  call __prefix
  opencapture 47
  call RIGHTARROW
  call REPLACETERMS
  closecapture 47
  ret
-- Rule
REPLACETERMS:
  call __prefix
  opencapture 48
  call REPLACETERM
  catch __TERM_1168
__TERM_1167:
  call REPLACETERM
  partialcommit __TERM_1167
__TERM_1168:
  closecapture 48
  ret
-- Rule
REPLACETERM:
  call __prefix
  opencapture 49
  catch __RIGHTHAND_1170
  call STRINGLITERAL
  commit __LEFTHAND_1171
__RIGHTHAND_1170:
  catch __RIGHTHAND_1178
  call HEXLITERAL
  commit __LEFTHAND_1179
__RIGHTHAND_1178:
  call VARREFERENCE
__LEFTHAND_1179:
__LEFTHAND_1171:
  closecapture 49
  ret
-- Rule
RECYCLE:
  call __prefix
  opencapture 50
  call FATARROW
  call IDENT
  closecapture 50
  ret
-- Rule
LEFTARROW:
  call __prefix
  opencapture 51
  char 3c
  char 2d
  closecapture 51
  ret
-- Rule
RIGHTARROW:
  call __prefix
  opencapture 52
  char 2d
  char 3e
  closecapture 52
  ret
-- Rule
FATARROW:
  call __prefix
  opencapture 53
  char 3d
  char 3e
  closecapture 53
  ret
-- Rule
NOT:
  call __prefix
  opencapture 54
  char 21
  closecapture 54
  ret
-- Rule
AND:
  call __prefix
  opencapture 55
  char 26
  closecapture 55
  ret
-- Rule
MACRO:
  call __prefix
  opencapture 56
  char 25
  set 0000000000000000feffff07feffff0700000000000000000000000000000000
  catch __TERM_1250
__TERM_1249:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1249
__TERM_1250:
  closecapture 56
  ret
-- Rule
ENDFORCE:
  call __prefix
  opencapture 57
  quad 5f5f656e
  char 64
  call S
  call NUMBER
  closecapture 57
  ret
-- Rule
HEXLITERAL:
  call __prefix
  opencapture 58
  char 30
  char 78
  counter 0 2
__TERM_1278:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1278
  closecapture 58
  ret
-- Rule
NUMBER:
  call __prefix
  opencapture 59
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1286
__TERM_1285:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1285
__TERM_1286:
  closecapture 59
  ret
-- Rule
STRING:
  call __prefix
  opencapture 60
  call STRINGLITERAL
  catch __TERM_1297
  char 69
  commit __TERM_1297
__TERM_1297:
  closecapture 60
  ret
-- Rule
OR:
  call __prefix
  opencapture 61
  char 2f
  closecapture 61
  ret
-- Rule
ANY:
  call __prefix
  opencapture 62
  char 2e
  closecapture 62
  ret
-- Rule
SETNOT:
  call __prefix
  opencapture 63
  char 5e
  closecapture 63
  ret
-- Rule
IMPORTDECL:
  call __prefix
  opencapture 64
  call KW_IMPORT
  call STRING
  call SEMICOLON
  closecapture 64
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  opencapture 65
  char 27
  opencapture 66
  catch __TERM_1352
__TERM_1351:
  catch __RIGHTHAND_1354
  char 5c
  catch __RIGHTHAND_1368
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1369
__RIGHTHAND_1368:
  counter 0 3
__TERM_1378:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1378
__LEFTHAND_1369:
  commit __LEFTHAND_1355
__RIGHTHAND_1354:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1355:
  partialcommit __TERM_1351
__TERM_1352:
  closecapture 66 0
  char 27
  closecapture 65
  ret
-- Rule
KW_IMPORT:
  call __prefix
  opencapture 67
  quad 696d706f
  char 72
  char 74
  closecapture 67
  ret
-- Rule
IDENT:
  call __prefix
  opencapture 68
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_1409
  counter 0 63
__TERM_1410:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1411
__TERM_1411:
  condjump 0 __TERM_1410
  commit __TERM_1409
__TERM_1409:
  closecapture 68
  ret
-- Rule
BOPEN:
  call __prefix
  opencapture 69
  char 28
  closecapture 69
  ret
-- Rule
BCLOSE:
  call __prefix
  opencapture 70
  char 29
  closecapture 70
  ret
-- Rule
CBOPEN:
  call __prefix
  opencapture 71
  char 7b
  closecapture 71
  ret
-- Rule
CBCLOSE:
  call __prefix
  opencapture 72
  char 7d
  closecapture 72
  ret
-- Rule
ABOPEN:
  call __prefix
  opencapture 73
  char 5b
  closecapture 73
  ret
-- Rule
ABCLOSE:
  call __prefix
  opencapture 74
  char 5d
  closecapture 74
  ret
-- Rule
COLON:
  call __prefix
  opencapture 75
  char 3a
  closecapture 75
  ret
-- Rule
SEMICOLON:
  call __prefix
  opencapture 76
  char 3b
  closecapture 76
  ret

  end 0

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
  catch __RIGHTHAND_114
  call RULE
  commit __LEFTHAND_115
__RIGHTHAND_114:
  call IMPORTDECL
__LEFTHAND_115:
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
  catch __RIGHTHAND_152
  call ALTERNATIVES
  commit __LEFTHAND_153
__RIGHTHAND_152:
  call TERMS
__LEFTHAND_153:
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
  catch __TERM_188
__TERM_187:
  call TERM
  partialcommit __TERM_187
__TERM_188:
  closecapture 10
  ret
-- Rule
TERM:
  call __prefix
  opencapture 11
  catch __RIGHTHAND_190
  call SCANMATCHER
  commit __LEFTHAND_191
__RIGHTHAND_190:
  call QUANTIFIEDMATCHER
__LEFTHAND_191:
  closecapture 11
  ret
-- Rule
SCANMATCHER:
  call __prefix
  opencapture 12
  catch __RIGHTHAND_210
  call NOT
  commit __LEFTHAND_211
__RIGHTHAND_210:
  call AND
__LEFTHAND_211:
  call MATCHER
  closecapture 12
  ret
-- Rule
QUANTIFIEDMATCHER:
  call __prefix
  opencapture 13
  call MATCHER
  catch __TERM_239
  call QUANTIFIER
  commit __TERM_239
__TERM_239:
  closecapture 13
  ret
-- Rule
QUANTIFIER:
  call __prefix
  opencapture 14
  catch __RIGHTHAND_242
  call Q_ZEROORONE
  commit __LEFTHAND_243
__RIGHTHAND_242:
  catch __RIGHTHAND_250
  call Q_ONEORMORE
  commit __LEFTHAND_251
__RIGHTHAND_250:
  catch __RIGHTHAND_258
  call Q_ZEROORMORE
  commit __LEFTHAND_259
__RIGHTHAND_258:
  catch __RIGHTHAND_266
  call Q_FROMTO
  commit __LEFTHAND_267
__RIGHTHAND_266:
  catch __RIGHTHAND_274
  call Q_UNTIL
  commit __LEFTHAND_275
__RIGHTHAND_274:
  catch __RIGHTHAND_282
  call Q_FROM
  commit __LEFTHAND_283
__RIGHTHAND_282:
  catch __RIGHTHAND_290
  call Q_SPECIFIC
  commit __LEFTHAND_291
__RIGHTHAND_290:
  call Q_VAR
__LEFTHAND_291:
__LEFTHAND_283:
__LEFTHAND_275:
__LEFTHAND_267:
__LEFTHAND_259:
__LEFTHAND_251:
__LEFTHAND_243:
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
  catch __TERM_338
__TERM_337:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_337
__TERM_338:
  closecapture 19 0
  char 2d
  opencapture 20
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_356
__TERM_355:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_355
__TERM_356:
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
  catch __TERM_380
__TERM_379:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_379
__TERM_380:
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
  catch __TERM_398
__TERM_397:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_397
__TERM_398:
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
  catch __TERM_422
__TERM_421:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_421
__TERM_422:
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
  catch __RIGHTHAND_448
  call ANY
  commit __LEFTHAND_449
__RIGHTHAND_448:
  catch __RIGHTHAND_456
  call SET
  commit __LEFTHAND_457
__RIGHTHAND_456:
  catch __RIGHTHAND_464
  call STRING
  commit __LEFTHAND_465
__RIGHTHAND_464:
  catch __RIGHTHAND_472
  call BITMASK
  commit __LEFTHAND_473
__RIGHTHAND_472:
  catch __RIGHTHAND_480
  call HEXLITERAL
  commit __LEFTHAND_481
__RIGHTHAND_480:
  catch __RIGHTHAND_488
  call VARCAPTURE
  commit __LEFTHAND_489
__RIGHTHAND_488:
  catch __RIGHTHAND_496
  call CAPTURE
  commit __LEFTHAND_497
__RIGHTHAND_496:
  catch __RIGHTHAND_504
  call GROUP
  commit __LEFTHAND_505
__RIGHTHAND_504:
  catch __RIGHTHAND_512
  call MACRO
  commit __LEFTHAND_513
__RIGHTHAND_512:
  catch __RIGHTHAND_520
  call ENDFORCE
  commit __LEFTHAND_521
__RIGHTHAND_520:
  catch __RIGHTHAND_528
  call VARREFERENCE
  commit __LEFTHAND_529
__RIGHTHAND_528:
  catch __RIGHTHAND_536
  call REFERENCE
  commit __LEFTHAND_537
__RIGHTHAND_536:
  call LIMITEDCALL
__LEFTHAND_537:
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
  closecapture 28
  ret
-- Rule
BITMASK:
  call __prefix
  opencapture 29
  char 7c
  counter 0 2
__TERM_558:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_558
  char 7c
  counter 0 2
__TERM_570:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_570
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
  catch __TERM_601
  call CAPTURETYPE
  commit __TERM_601
__TERM_601:
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
  catch __RIGHTHAND_640
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_641
__RIGHTHAND_640:
  quad 696e7433
  char 32
__LEFTHAND_641:
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
  catch __TERM_699
  catch __RIGHTHAND_702
  call REPLACE
  commit __LEFTHAND_703
__RIGHTHAND_702:
  call RECYCLE
__LEFTHAND_703:
  commit __TERM_699
__TERM_699:
  closecapture 35
  ret
-- Rule
SET:
  call __prefix
  opencapture 36
  call ABOPEN
  catch __TERM_725
  call SETNOT
  commit __TERM_725
__TERM_725:
  catch __RIGHTHAND_734
  opencapture 37
  catch __RIGHTHAND_742
  char 5c
  catch __RIGHTHAND_756
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_757
__RIGHTHAND_756:
  counter 0 3
__TERM_766:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_766
__LEFTHAND_757:
  commit __LEFTHAND_743
__RIGHTHAND_742:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_743:
  closecapture 37 0
  char 2d
  opencapture 38
  catch __RIGHTHAND_788
  char 5c
  catch __RIGHTHAND_802
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_803
__RIGHTHAND_802:
  counter 0 3
__TERM_812:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_812
__LEFTHAND_803:
  commit __LEFTHAND_789
__RIGHTHAND_788:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_789:
  closecapture 38 0
  commit __LEFTHAND_735
__RIGHTHAND_734:
  opencapture 39
  catch __RIGHTHAND_828
  char 5c
  catch __RIGHTHAND_842
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_843
__RIGHTHAND_842:
  counter 0 3
__TERM_852:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_852
__LEFTHAND_843:
  commit __LEFTHAND_829
__RIGHTHAND_828:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_829:
  closecapture 39 0
__LEFTHAND_735:
  catch __TERM_732
__TERM_731:
  catch __RIGHTHAND_862
  opencapture 37
  catch __RIGHTHAND_870
  char 5c
  catch __RIGHTHAND_884
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_885
__RIGHTHAND_884:
  counter 0 3
__TERM_894:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_894
__LEFTHAND_885:
  commit __LEFTHAND_871
__RIGHTHAND_870:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_871:
  closecapture 37 0
  char 2d
  opencapture 38
  catch __RIGHTHAND_916
  char 5c
  catch __RIGHTHAND_930
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_931
__RIGHTHAND_930:
  counter 0 3
__TERM_940:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_940
__LEFTHAND_931:
  commit __LEFTHAND_917
__RIGHTHAND_916:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_917:
  closecapture 38 0
  commit __LEFTHAND_863
__RIGHTHAND_862:
  opencapture 39
  catch __RIGHTHAND_956
  char 5c
  catch __RIGHTHAND_970
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_971
__RIGHTHAND_970:
  counter 0 3
__TERM_980:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_980
__LEFTHAND_971:
  commit __LEFTHAND_957
__RIGHTHAND_956:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_957:
  closecapture 39 0
__LEFTHAND_863:
  partialcommit __TERM_731
__TERM_732:
  call ABCLOSE
  closecapture 36
  ret
-- Rule
VARREFERENCE:
  call __prefix
  opencapture 40
  char 24
  catch __RIGHTHAND_1008
  call IDENT
  commit __LEFTHAND_1009
__RIGHTHAND_1008:
  call NUMBER
__LEFTHAND_1009:
  catch __TERM_1025
  call MASK
  commit __TERM_1025
__TERM_1025:
  closecapture 40
  ret
-- Rule
MASK:
  call __prefix
  opencapture 41
  char 7c
  opencapture 42
  counter 0 2
__TERM_1042:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1042
  closecapture 42 0
  closecapture 41
  ret
-- Rule
REFERENCE:
  call __prefix
  opencapture 43
  catch __TERM_1046
  call KW_IMPORT
  failtwice
__TERM_1046:
  call IDENT
  catch __TERM_1064
  call LEFTARROW
  failtwice
__TERM_1064:
  closecapture 43
  ret
-- Rule
LIMITEDCALL:
  call __prefix
  opencapture 44
  char 3c
  char 3c
  catch __TERM_1080
__TERM_1079:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1079
__TERM_1080:
  call LCMODES
  catch __TERM_1092
__TERM_1091:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1091
__TERM_1092:
  char 3a
  catch __TERM_1104
__TERM_1103:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1103
__TERM_1104:
  call LCPARAM
  catch __TERM_1116
__TERM_1115:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1115
__TERM_1116:
  char 3a
  catch __TERM_1128
__TERM_1127:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1127
__TERM_1128:
  call IDENT
  catch __TERM_1140
__TERM_1139:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1139
__TERM_1140:
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
  catch __TERM_1158
__TERM_1157:
  set ffd1fffffefffffbffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_1157
__TERM_1158:
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
  catch __TERM_1176
__TERM_1175:
  call REPLACETERM
  partialcommit __TERM_1175
__TERM_1176:
  closecapture 48
  ret
-- Rule
REPLACETERM:
  call __prefix
  opencapture 49
  catch __RIGHTHAND_1178
  call STRINGLITERAL
  commit __LEFTHAND_1179
__RIGHTHAND_1178:
  catch __RIGHTHAND_1186
  call HEXLITERAL
  commit __LEFTHAND_1187
__RIGHTHAND_1186:
  call VARREFERENCE
__LEFTHAND_1187:
__LEFTHAND_1179:
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
  catch __TERM_1258
__TERM_1257:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1257
__TERM_1258:
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
__TERM_1286:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1286
  closecapture 58
  ret
-- Rule
NUMBER:
  call __prefix
  opencapture 59
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1294
__TERM_1293:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1293
__TERM_1294:
  closecapture 59
  ret
-- Rule
STRING:
  call __prefix
  opencapture 60
  call STRINGLITERAL
  catch __TERM_1305
  char 69
  commit __TERM_1305
__TERM_1305:
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
  call STRINGLITERAL
  call OPTNAMESPACE
  call SEMICOLON
  closecapture 64
  ret
-- Rule
KW_IMPORT:
  call __prefix
  opencapture 65
  quad 696d706f
  char 72
  char 74
  closecapture 65
  ret
-- Rule
OPTNAMESPACE:
  call __prefix
  opencapture 66
  catch __TERM_1359
  call KW_AS
  call IDENT
  commit __TERM_1359
__TERM_1359:
  closecapture 66
  ret
-- Rule
KW_AS:
  call __prefix
  opencapture 67
  char 61
  char 73
  closecapture 67
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  opencapture 68
  char 27
  opencapture 69
  catch __TERM_1396
__TERM_1395:
  catch __RIGHTHAND_1398
  char 5c
  catch __RIGHTHAND_1412
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1413
__RIGHTHAND_1412:
  counter 0 3
__TERM_1422:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1422
__LEFTHAND_1413:
  commit __LEFTHAND_1399
__RIGHTHAND_1398:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1399:
  partialcommit __TERM_1395
__TERM_1396:
  closecapture 69 0
  char 27
  closecapture 68
  ret
-- Rule
IDENT:
  call __prefix
  opencapture 70
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_1447
  counter 0 63
__TERM_1448:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1449
__TERM_1449:
  condjump 0 __TERM_1448
  commit __TERM_1447
__TERM_1447:
  closecapture 70
  ret
-- Rule
BOPEN:
  call __prefix
  opencapture 71
  char 28
  closecapture 71
  ret
-- Rule
BCLOSE:
  call __prefix
  opencapture 72
  char 29
  closecapture 72
  ret
-- Rule
CBOPEN:
  call __prefix
  opencapture 73
  char 7b
  closecapture 73
  ret
-- Rule
CBCLOSE:
  call __prefix
  opencapture 74
  char 7d
  closecapture 74
  ret
-- Rule
ABOPEN:
  call __prefix
  opencapture 75
  char 5b
  closecapture 75
  ret
-- Rule
ABCLOSE:
  call __prefix
  opencapture 76
  char 5d
  closecapture 76
  ret
-- Rule
COLON:
  call __prefix
  opencapture 77
  char 3a
  closecapture 77
  ret
-- Rule
SEMICOLON:
  call __prefix
  opencapture 78
  char 3b
  closecapture 78
  ret

  end 0

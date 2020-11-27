  call TOP
  end
-- Rule
TOP:
  call INSTRUCTIONS
  ret
-- Rule
S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __TERM_10
__TERM_9:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_9
__TERM_10:
  ret
-- Rule
__prefix:
  catch __TERM_16
__TERM_15:
  catch __RIGHTHAND_18
  char 2d
  char 2d
  catch __TERM_30
__TERM_29:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_29
__TERM_30:
  char 0a
  commit __LEFTHAND_19
__RIGHTHAND_18:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __TERM_42
__TERM_41:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_41
__TERM_42:
__LEFTHAND_19:
  partialcommit __TERM_15
__TERM_16:
  ret
-- Rule
INSTRUCTIONS:
  call __prefix
  call INSTRUCTION
  catch __TERM_48
__TERM_47:
  call INSTRUCTION
  partialcommit __TERM_47
__TERM_48:
  call END
  ret
-- Rule
INSTRUCTION:
  call __prefix
  opencapture 0
  catch __RIGHTHAND_62
  call ANYINSTR
  commit __LEFTHAND_63
__RIGHTHAND_62:
  catch __RIGHTHAND_70
  call BACKCOMMITINSTR
  commit __LEFTHAND_71
__RIGHTHAND_70:
  catch __RIGHTHAND_78
  call CALLINSTR
  commit __LEFTHAND_79
__RIGHTHAND_78:
  catch __RIGHTHAND_86
  call CATCHINSTR
  commit __LEFTHAND_87
__RIGHTHAND_86:
  catch __RIGHTHAND_94
  call CHARINSTR
  commit __LEFTHAND_95
__RIGHTHAND_94:
  catch __RIGHTHAND_102
  call MASKEDCHARINSTR
  commit __LEFTHAND_103
__RIGHTHAND_102:
  catch __RIGHTHAND_110
  call CLOSECAPTUREINSTR
  commit __LEFTHAND_111
__RIGHTHAND_110:
  catch __RIGHTHAND_118
  call COMMITINSTR
  commit __LEFTHAND_119
__RIGHTHAND_118:
  catch __RIGHTHAND_126
  call ENDREPLACEINSTR
  commit __LEFTHAND_127
__RIGHTHAND_126:
  catch __RIGHTHAND_134
  call REPLACEINSTR
  commit __LEFTHAND_135
__RIGHTHAND_134:
  catch __RIGHTHAND_142
  call ISOLATEINSTR
  commit __LEFTHAND_143
__RIGHTHAND_142:
  catch __RIGHTHAND_150
  call ENDISOLATEINSTR
  commit __LEFTHAND_151
__RIGHTHAND_150:
  catch __RIGHTHAND_158
  call ENDINSTR
  commit __LEFTHAND_159
__RIGHTHAND_158:
  catch __RIGHTHAND_166
  call FAILTWICEINSTR
  commit __LEFTHAND_167
__RIGHTHAND_166:
  catch __RIGHTHAND_174
  call FAILINSTR
  commit __LEFTHAND_175
__RIGHTHAND_174:
  catch __RIGHTHAND_182
  call JUMPINSTR
  commit __LEFTHAND_183
__RIGHTHAND_182:
  catch __RIGHTHAND_190
  call NOOPINSTR
  commit __LEFTHAND_191
__RIGHTHAND_190:
  catch __RIGHTHAND_198
  call TRAPINSTR
  commit __LEFTHAND_199
__RIGHTHAND_198:
  catch __RIGHTHAND_206
  call OPENCAPTUREINSTR
  commit __LEFTHAND_207
__RIGHTHAND_206:
  catch __RIGHTHAND_214
  call PARTIALCOMMITINSTR
  commit __LEFTHAND_215
__RIGHTHAND_214:
  catch __RIGHTHAND_222
  call QUADINSTR
  commit __LEFTHAND_223
__RIGHTHAND_222:
  catch __RIGHTHAND_230
  call RETINSTR
  commit __LEFTHAND_231
__RIGHTHAND_230:
  catch __RIGHTHAND_238
  call SETINSTR
  commit __LEFTHAND_239
__RIGHTHAND_238:
  catch __RIGHTHAND_246
  call RANGEINSTR
  commit __LEFTHAND_247
__RIGHTHAND_246:
  catch __RIGHTHAND_254
  call SKIPINSTR
  commit __LEFTHAND_255
__RIGHTHAND_254:
  catch __RIGHTHAND_262
  call SPANINSTR
  commit __LEFTHAND_263
__RIGHTHAND_262:
  catch __RIGHTHAND_270
  call TESTANYINSTR
  commit __LEFTHAND_271
__RIGHTHAND_270:
  catch __RIGHTHAND_278
  call TESTCHARINSTR
  commit __LEFTHAND_279
__RIGHTHAND_278:
  catch __RIGHTHAND_286
  call TESTQUADINSTR
  commit __LEFTHAND_287
__RIGHTHAND_286:
  catch __RIGHTHAND_294
  call TESTSETINSTR
  commit __LEFTHAND_295
__RIGHTHAND_294:
  catch __RIGHTHAND_302
  call VARINSTR
  commit __LEFTHAND_303
__RIGHTHAND_302:
  catch __RIGHTHAND_310
  call COUNTERINSTR
  commit __LEFTHAND_311
__RIGHTHAND_310:
  catch __RIGHTHAND_318
  call CONDJUMPINSTR
  commit __LEFTHAND_319
__RIGHTHAND_318:
  catch __RIGHTHAND_326
  call SCR_INSTRUCTION
  commit __LEFTHAND_327
__RIGHTHAND_326:
  call LABELDEF
__LEFTHAND_327:
__LEFTHAND_319:
__LEFTHAND_311:
__LEFTHAND_303:
__LEFTHAND_295:
__LEFTHAND_287:
__LEFTHAND_279:
__LEFTHAND_271:
__LEFTHAND_263:
__LEFTHAND_255:
__LEFTHAND_247:
__LEFTHAND_239:
__LEFTHAND_231:
__LEFTHAND_223:
__LEFTHAND_215:
__LEFTHAND_207:
__LEFTHAND_199:
__LEFTHAND_191:
__LEFTHAND_183:
__LEFTHAND_175:
__LEFTHAND_167:
__LEFTHAND_159:
__LEFTHAND_151:
__LEFTHAND_143:
__LEFTHAND_135:
__LEFTHAND_127:
__LEFTHAND_119:
__LEFTHAND_111:
__LEFTHAND_103:
__LEFTHAND_95:
__LEFTHAND_87:
__LEFTHAND_79:
__LEFTHAND_71:
__LEFTHAND_63:
  closecapture 0 0
  ret
-- Rule
END:
  call __prefix
  catch __TERM_340
  any
  failtwice
__TERM_340:
  ret
-- Rule
ANYINSTR:
  call __prefix
  opencapture 1
  char 61
  char 6e
  char 79
  closecapture 1 0
  ret
-- Rule
BACKCOMMITINSTR:
  call __prefix
  opencapture 2
  quad 6261636b
  quad 636f6d6d
  char 69
  char 74
  closecapture 2 0
  call S
  call LABEL
  ret
-- Rule
CALLINSTR:
  call __prefix
  opencapture 3
  quad 63616c6c
  closecapture 3 0
  call S
  call LABEL
  ret
-- Rule
CATCHINSTR:
  call __prefix
  opencapture 4
  quad 63617463
  char 68
  closecapture 4 0
  call S
  call LABEL
  ret
-- Rule
CHARINSTR:
  call __prefix
  opencapture 5
  quad 63686172
  closecapture 5 0
  call S
  call HEXBYTE
  ret
-- Rule
MASKEDCHARINSTR:
  call __prefix
  opencapture 6
  quad 6d61736b
  quad 65646368
  char 61
  char 72
  closecapture 6 0
  call S
  call HEXBYTE
  call S
  call HEXBYTE
  ret
-- Rule
CLOSECAPTUREINSTR:
  call __prefix
  opencapture 7
  quad 636c6f73
  quad 65636170
  quad 74757265
  closecapture 7 0
  call S
  call SLOT
  catch __TERM_517
  call S
  call TYPE
  commit __TERM_517
__TERM_517:
  ret
-- Rule
COMMITINSTR:
  call __prefix
  opencapture 8
  quad 636f6d6d
  char 69
  char 74
  closecapture 8 0
  catch __TERM_547
  call S
  call LABEL
  commit __TERM_547
__TERM_547:
  ret
-- Rule
ENDINSTR:
  call __prefix
  opencapture 9
  char 65
  char 6e
  char 64
  closecapture 9 0
  catch __TERM_577
  call S
  call CODE
  commit __TERM_577
__TERM_577:
  ret
-- Rule
FAILINSTR:
  call __prefix
  opencapture 10
  quad 6661696c
  closecapture 10 0
  ret
-- Rule
FAILTWICEINSTR:
  call __prefix
  opencapture 11
  quad 6661696c
  quad 74776963
  char 65
  closecapture 11 0
  ret
-- Rule
JUMPINSTR:
  call __prefix
  opencapture 12
  quad 6a756d70
  closecapture 12 0
  call S
  call LABEL
  ret
-- Rule
NOOPINSTR:
  call __prefix
  opencapture 13
  quad 6e6f6f70
  closecapture 13 0
  ret
-- Rule
TRAPINSTR:
  call __prefix
  opencapture 14
  quad 74726170
  closecapture 14 0
  ret
-- Rule
OPENCAPTUREINSTR:
  call __prefix
  opencapture 15
  quad 6f70656e
  quad 63617074
  char 75
  char 72
  char 65
  closecapture 15 0
  call S
  call SLOT
  ret
-- Rule
PARTIALCOMMITINSTR:
  call __prefix
  opencapture 16
  quad 70617274
  quad 69616c63
  quad 6f6d6d69
  char 74
  closecapture 16 0
  catch __TERM_703
  call S
  call LABEL
  commit __TERM_703
__TERM_703:
  ret
-- Rule
QUADINSTR:
  call __prefix
  opencapture 17
  quad 71756164
  closecapture 17 0
  call S
  call QUAD
  ret
-- Rule
REPLACEINSTR:
  call __prefix
  opencapture 18
  quad 7265706c
  char 61
  char 63
  char 65
  closecapture 18 0
  call S
  call LABEL
  call S
  call LABEL
  ret
-- Rule
ENDREPLACEINSTR:
  call __prefix
  opencapture 19
  quad 656e6472
  quad 65706c61
  char 63
  char 65
  closecapture 19 0
  ret
-- Rule
RETINSTR:
  call __prefix
  opencapture 20
  char 72
  char 65
  char 74
  closecapture 20 0
  ret
-- Rule
SETINSTR:
  call __prefix
  opencapture 21
  char 73
  char 65
  char 74
  closecapture 21 0
  call S
  call SET
  ret
-- Rule
RANGEINSTR:
  call __prefix
  opencapture 22
  quad 72616e67
  char 65
  closecapture 22 0
  call S
  call NUMBER
  call S
  call NUMBER
  ret
-- Rule
SKIPINSTR:
  call __prefix
  opencapture 23
  quad 736b6970
  closecapture 23 0
  call S
  call NUMBER
  ret
-- Rule
SPANINSTR:
  call __prefix
  opencapture 24
  quad 7370616e
  closecapture 24 0
  call S
  call SET
  ret
-- Rule
TESTANYINSTR:
  call __prefix
  opencapture 25
  quad 74657374
  char 61
  char 6e
  char 79
  closecapture 25 0
  call S
  call LABEL
  ret
-- Rule
TESTCHARINSTR:
  call __prefix
  opencapture 26
  quad 74657374
  quad 63686172
  closecapture 26 0
  call S
  call HEXBYTE
  call S
  call LABEL
  catch __TERM_973
  call S
  call AMPERSAND
  call HEXBYTE
  commit __TERM_973
__TERM_973:
  ret
-- Rule
TESTQUADINSTR:
  call __prefix
  opencapture 27
  quad 74657374
  quad 71756164
  closecapture 27 0
  call S
  call QUAD
  call S
  call LABEL
  ret
-- Rule
TESTSETINSTR:
  call __prefix
  opencapture 28
  quad 74657374
  char 73
  char 65
  char 74
  closecapture 28 0
  call S
  call SET
  call S
  call LABEL
  ret
-- Rule
VARINSTR:
  call __prefix
  opencapture 29
  char 76
  char 61
  char 72
  closecapture 29 0
  call S
  call SLOT
  ret
-- Rule
COUNTERINSTR:
  call __prefix
  opencapture 30
  quad 636f756e
  char 74
  char 65
  char 72
  closecapture 30 0
  call S
  call REGISTER
  call S
  call NUMBER
  ret
-- Rule
CONDJUMPINSTR:
  call __prefix
  opencapture 31
  quad 636f6e64
  quad 6a756d70
  closecapture 31 0
  call S
  call REGISTER
  call S
  call LABEL
  ret
-- Rule
ISOLATEINSTR:
  call __prefix
  opencapture 32
  quad 69736f6c
  char 61
  char 74
  char 65
  closecapture 32 0
  call S
  call SLOT
  ret
-- Rule
ENDISOLATEINSTR:
  call __prefix
  opencapture 33
  quad 656e6469
  quad 736f6c61
  char 74
  char 65
  closecapture 33 0
  ret
-- Rule
LABELDEF:
  call __prefix
  opencapture 34
  call LABEL
  closecapture 34 0
  call COLON
  ret
-- Rule
SCR_INSTRUCTION:
  call __prefix
  catch __RIGHTHAND_1216
  call SCR_ADD
  commit __LEFTHAND_1217
__RIGHTHAND_1216:
  catch __RIGHTHAND_1224
  call SCR_CALL
  commit __LEFTHAND_1225
__RIGHTHAND_1224:
  catch __RIGHTHAND_1232
  call SCR_PUSH
  commit __LEFTHAND_1233
__RIGHTHAND_1232:
  call SCR_RET
__LEFTHAND_1233:
__LEFTHAND_1225:
__LEFTHAND_1217:
  ret
-- Rule
SCR_ADD:
  call __prefix
  opencapture 35
  quad 5f5f733a
  char 61
  char 64
  char 64
  closecapture 35 0
  ret
-- Rule
SCR_CALL:
  call __prefix
  opencapture 36
  quad 5f5f733a
  quad 63616c6c
  closecapture 36 0
  call S
  call LABEL
  ret
-- Rule
SCR_PUSH:
  call __prefix
  opencapture 37
  quad 5f5f733a
  quad 70757368
  closecapture 37 0
  call S
  opencapture 38
  catch __RIGHTHAND_1306
  call LITERAL
  commit __LEFTHAND_1307
__RIGHTHAND_1306:
  call FUNCTIONBARRIER
__LEFTHAND_1307:
  closecapture 38 0
  ret
-- Rule
SCR_RET:
  call __prefix
  opencapture 39
  quad 5f5f733a
  char 72
  char 65
  char 74
  closecapture 39 0
  catch __TERM_1335
  call S
  commit __TERM_1335
__TERM_1335:
  ret
-- Rule
CODE:
  call __prefix
  call NUMBER
  ret
-- Rule
HEXBYTE:
  call __prefix
  opencapture 40
  counter 0 2
__TERM_1352:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1352
  closecapture 40 0
  ret
-- Rule
LABEL:
  call __prefix
  opencapture 41
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  catch __TERM_1365
  counter 0 63
__TERM_1366:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1367
__TERM_1367:
  condjump 0 __TERM_1366
  commit __TERM_1365
__TERM_1365:
  closecapture 41 0
  ret
-- Rule
NUMBER:
  call __prefix
  opencapture 42
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1378
__TERM_1377:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1377
__TERM_1378:
  closecapture 42 0
  ret
-- Rule
QUAD:
  call __prefix
  opencapture 43
  counter 0 8
__TERM_1388:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1388
  closecapture 43 0
  ret
-- Rule
SET:
  call __prefix
  opencapture 44
  counter 0 64
__TERM_1400:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1400
  closecapture 44 0
  ret
-- Rule
SLOT:
  call __prefix
  call NUMBER
  ret
-- Rule
REGISTER:
  call __prefix
  call NUMBER
  ret
-- Rule
TYPE:
  call __prefix
  call NUMBER
  ret
-- Rule
COLON:
  call __prefix
  char 3a
  ret
-- Rule
AMPERSAND:
  call __prefix
  char 26
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_1434
  call STRINGLITERAL
  commit __LEFTHAND_1435
__RIGHTHAND_1434:
  catch __RIGHTHAND_1442
  call REGISTERREF
  commit __LEFTHAND_1443
__RIGHTHAND_1442:
  catch __RIGHTHAND_1450
  call FLOATLITERAL
  commit __LEFTHAND_1451
__RIGHTHAND_1450:
  catch __RIGHTHAND_1458
  call INTLITERAL
  commit __LEFTHAND_1459
__RIGHTHAND_1458:
  catch __RIGHTHAND_1466
  call BOOLEANLITERAL
  commit __LEFTHAND_1467
__RIGHTHAND_1466:
  call VOIDLITERAL
__LEFTHAND_1467:
__LEFTHAND_1459:
__LEFTHAND_1451:
__LEFTHAND_1443:
__LEFTHAND_1435:
  ret
-- Rule
FUNCTIONBARRIER:
  call __prefix
  quad 5f5f6675
  quad 6e637469
  char 6f
  char 6e
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 45
  catch __TERM_1502
__TERM_1501:
  catch __RIGHTHAND_1504
  char 5c
  catch __RIGHTHAND_1518
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1519
__RIGHTHAND_1518:
  counter 0 3
__TERM_1528:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1528
__LEFTHAND_1519:
  commit __LEFTHAND_1505
__RIGHTHAND_1504:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1505:
  partialcommit __TERM_1501
__TERM_1502:
  closecapture 45 0
  char 27
  ret
-- Rule
REGISTERREF:
  call __prefix
  char 7b
  catch __TERM_1553
  call S
  commit __TERM_1553
__TERM_1553:
  opencapture 46
  call NUMBER
  closecapture 46 0
  catch __TERM_1571
  call S
  commit __TERM_1571
__TERM_1571:
  char 7d
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 47
  catch __TERM_1590
__TERM_1589:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1589
__TERM_1590:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1602
__TERM_1601:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1601
__TERM_1602:
  closecapture 47 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 48
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1614
__TERM_1613:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1613
__TERM_1614:
  closecapture 48 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 49
  catch __RIGHTHAND_1622
  quad 74727565
  commit __LEFTHAND_1623
__RIGHTHAND_1622:
  quad 66616c73
  char 65
__LEFTHAND_1623:
  closecapture 49 0
  ret
-- Rule
VOIDLITERAL:
  call __prefix
  quad 5f5f766f
  char 69
  char 64
  ret

  end 0

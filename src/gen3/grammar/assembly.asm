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
MULTILINECOMMENT:
  quad 2d2d5b5b
  catch __TERM_22
__TERM_21:
  catch __TERM_24
  char 5d
  char 5d
  failtwice
__TERM_24:
  any
  partialcommit __TERM_21
__TERM_22:
  char 5d
  char 5d
  ret
-- Rule
COMMENT:
  char 2d
  char 2d
  catch __TERM_52
__TERM_51:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_51
__TERM_52:
  char 0a
  ret
-- Rule
__prefix:
  catch __TERM_64
__TERM_63:
  catch __RIGHTHAND_66
  call MULTILINECOMMENT
  commit __LEFTHAND_67
__RIGHTHAND_66:
  catch __RIGHTHAND_74
  call COMMENT
  commit __LEFTHAND_75
__RIGHTHAND_74:
  call S
__LEFTHAND_75:
__LEFTHAND_67:
  partialcommit __TERM_63
__TERM_64:
  ret
-- Rule
INSTRUCTIONS:
  call __prefix
  call INSTRUCTION
  catch __TERM_92
__TERM_91:
  call INSTRUCTION
  partialcommit __TERM_91
__TERM_92:
  call END
  ret
-- Rule
INSTRUCTION:
  call __prefix
  catch __RIGHTHAND_100
  opencapture 0
  call RULEINSTR
  closecapture 0 0
  commit __LEFTHAND_101
__RIGHTHAND_100:
  catch __RIGHTHAND_114
  opencapture 1
  call LABELDEF
  closecapture 1 0
  commit __LEFTHAND_115
__RIGHTHAND_114:
  opencapture 2
  call NAMESPACEDEF
  closecapture 2 0
__LEFTHAND_115:
__LEFTHAND_101:
  ret
-- Rule
RULEINSTR:
  call __prefix
  catch __RIGHTHAND_140
  call ANYINSTR
  commit __LEFTHAND_141
__RIGHTHAND_140:
  catch __RIGHTHAND_148
  call BACKCOMMITINSTR
  commit __LEFTHAND_149
__RIGHTHAND_148:
  catch __RIGHTHAND_156
  call CALLINSTR
  commit __LEFTHAND_157
__RIGHTHAND_156:
  catch __RIGHTHAND_164
  call CATCHINSTR
  commit __LEFTHAND_165
__RIGHTHAND_164:
  catch __RIGHTHAND_172
  call CHARINSTR
  commit __LEFTHAND_173
__RIGHTHAND_172:
  catch __RIGHTHAND_180
  call MASKEDCHARINSTR
  commit __LEFTHAND_181
__RIGHTHAND_180:
  catch __RIGHTHAND_188
  call CLOSECAPTUREINSTR
  commit __LEFTHAND_189
__RIGHTHAND_188:
  catch __RIGHTHAND_196
  call COMMITINSTR
  commit __LEFTHAND_197
__RIGHTHAND_196:
  catch __RIGHTHAND_204
  call ENDREPLACEINSTR
  commit __LEFTHAND_205
__RIGHTHAND_204:
  catch __RIGHTHAND_212
  call REPLACEINSTR
  commit __LEFTHAND_213
__RIGHTHAND_212:
  catch __RIGHTHAND_220
  call INTRPCAPTUREINSTR
  commit __LEFTHAND_221
__RIGHTHAND_220:
  catch __RIGHTHAND_228
  call ISOLATEINSTR
  commit __LEFTHAND_229
__RIGHTHAND_228:
  catch __RIGHTHAND_236
  call ENDISOLATEINSTR
  commit __LEFTHAND_237
__RIGHTHAND_236:
  catch __RIGHTHAND_244
  call ENDINSTR
  commit __LEFTHAND_245
__RIGHTHAND_244:
  catch __RIGHTHAND_252
  call FAILTWICEINSTR
  commit __LEFTHAND_253
__RIGHTHAND_252:
  catch __RIGHTHAND_260
  call FAILINSTR
  commit __LEFTHAND_261
__RIGHTHAND_260:
  catch __RIGHTHAND_268
  call JUMPINSTR
  commit __LEFTHAND_269
__RIGHTHAND_268:
  catch __RIGHTHAND_276
  call NOOPINSTR
  commit __LEFTHAND_277
__RIGHTHAND_276:
  catch __RIGHTHAND_284
  call TRAPINSTR
  commit __LEFTHAND_285
__RIGHTHAND_284:
  catch __RIGHTHAND_292
  call OPENCAPTUREINSTR
  commit __LEFTHAND_293
__RIGHTHAND_292:
  catch __RIGHTHAND_300
  call PARTIALCOMMITINSTR
  commit __LEFTHAND_301
__RIGHTHAND_300:
  catch __RIGHTHAND_308
  call QUADINSTR
  commit __LEFTHAND_309
__RIGHTHAND_308:
  catch __RIGHTHAND_316
  call RETINSTR
  commit __LEFTHAND_317
__RIGHTHAND_316:
  catch __RIGHTHAND_324
  call SETINSTR
  commit __LEFTHAND_325
__RIGHTHAND_324:
  catch __RIGHTHAND_332
  call RANGEINSTR
  commit __LEFTHAND_333
__RIGHTHAND_332:
  catch __RIGHTHAND_340
  call SKIPINSTR
  commit __LEFTHAND_341
__RIGHTHAND_340:
  catch __RIGHTHAND_348
  call SPANINSTR
  commit __LEFTHAND_349
__RIGHTHAND_348:
  catch __RIGHTHAND_356
  call TESTANYINSTR
  commit __LEFTHAND_357
__RIGHTHAND_356:
  catch __RIGHTHAND_364
  call TESTCHARINSTR
  commit __LEFTHAND_365
__RIGHTHAND_364:
  catch __RIGHTHAND_372
  call TESTQUADINSTR
  commit __LEFTHAND_373
__RIGHTHAND_372:
  catch __RIGHTHAND_380
  call TESTSETINSTR
  commit __LEFTHAND_381
__RIGHTHAND_380:
  catch __RIGHTHAND_388
  call VARINSTR
  commit __LEFTHAND_389
__RIGHTHAND_388:
  catch __RIGHTHAND_396
  call COUNTERINSTR
  commit __LEFTHAND_397
__RIGHTHAND_396:
  catch __RIGHTHAND_404
  call CONDJUMPINSTR
  commit __LEFTHAND_405
__RIGHTHAND_404:
  call MODEINSTR
__LEFTHAND_405:
__LEFTHAND_397:
__LEFTHAND_389:
__LEFTHAND_381:
__LEFTHAND_373:
__LEFTHAND_365:
__LEFTHAND_357:
__LEFTHAND_349:
__LEFTHAND_341:
__LEFTHAND_333:
__LEFTHAND_325:
__LEFTHAND_317:
__LEFTHAND_309:
__LEFTHAND_301:
__LEFTHAND_293:
__LEFTHAND_285:
__LEFTHAND_277:
__LEFTHAND_269:
__LEFTHAND_261:
__LEFTHAND_253:
__LEFTHAND_245:
__LEFTHAND_237:
__LEFTHAND_229:
__LEFTHAND_221:
__LEFTHAND_213:
__LEFTHAND_205:
__LEFTHAND_197:
__LEFTHAND_189:
__LEFTHAND_181:
__LEFTHAND_173:
__LEFTHAND_165:
__LEFTHAND_157:
__LEFTHAND_149:
__LEFTHAND_141:
  ret
-- Rule
END:
  call __prefix
  catch __TERM_418
  any
  failtwice
__TERM_418:
  ret
-- Rule
ANYINSTR:
  call __prefix
  opencapture 3
  char 61
  char 6e
  char 79
  closecapture 3 0
  ret
-- Rule
BACKCOMMITINSTR:
  call __prefix
  opencapture 4
  quad 6261636b
  quad 636f6d6d
  char 69
  char 74
  closecapture 4 0
  call S
  call LABEL
  ret
-- Rule
CALLINSTR:
  call __prefix
  opencapture 5
  quad 63616c6c
  closecapture 5 0
  call S
  call LABEL
  ret
-- Rule
CATCHINSTR:
  call __prefix
  opencapture 6
  quad 63617463
  char 68
  closecapture 6 0
  call S
  call LABEL
  ret
-- Rule
CHARINSTR:
  call __prefix
  opencapture 7
  quad 63686172
  closecapture 7 0
  call S
  call HEXBYTE
  ret
-- Rule
MASKEDCHARINSTR:
  call __prefix
  opencapture 8
  quad 6d61736b
  quad 65646368
  char 61
  char 72
  closecapture 8 0
  call S
  call HEXBYTE
  call S
  call HEXBYTE
  ret
-- Rule
CLOSECAPTUREINSTR:
  call __prefix
  opencapture 9
  quad 636c6f73
  quad 65636170
  quad 74757265
  closecapture 9 0
  call S
  call SLOT
  ret
-- Rule
COMMITINSTR:
  call __prefix
  opencapture 10
  quad 636f6d6d
  char 69
  char 74
  closecapture 10 0
  call S
  call LABEL
  ret
-- Rule
ENDINSTR:
  call __prefix
  opencapture 11
  char 65
  char 6e
  char 64
  closecapture 11 0
  call S
  call CODE
  ret
-- Rule
FAILINSTR:
  call __prefix
  opencapture 12
  quad 6661696c
  closecapture 12 0
  ret
-- Rule
FAILTWICEINSTR:
  call __prefix
  opencapture 13
  quad 6661696c
  quad 74776963
  char 65
  closecapture 13 0
  ret
-- Rule
INTRPCAPTUREINSTR:
  call __prefix
  opencapture 14
  quad 696e7472
  quad 70636170
  quad 74757265
  closecapture 14 0
  call S
  call INTRPCAPTURETYPES
  call S
  catch __RIGHTHAND_700
  call SLOT
  commit __LEFTHAND_701
__RIGHTHAND_700:
  opencapture 15
  quad 64656661
  char 75
  char 6c
  char 74
  closecapture 15 0
__LEFTHAND_701:
  ret
-- Rule
JUMPINSTR:
  call __prefix
  opencapture 16
  quad 6a756d70
  closecapture 16 0
  call S
  call LABEL
  ret
-- Rule
NOOPINSTR:
  call __prefix
  opencapture 17
  quad 6e6f6f70
  closecapture 17 0
  ret
-- Rule
TRAPINSTR:
  call __prefix
  opencapture 18
  quad 74726170
  closecapture 18 0
  ret
-- Rule
OPENCAPTUREINSTR:
  call __prefix
  opencapture 19
  quad 6f70656e
  quad 63617074
  char 75
  char 72
  char 65
  closecapture 19 0
  call S
  call SLOT
  ret
-- Rule
PARTIALCOMMITINSTR:
  call __prefix
  opencapture 20
  quad 70617274
  quad 69616c63
  quad 6f6d6d69
  char 74
  closecapture 20 0
  call S
  call LABEL
  ret
-- Rule
QUADINSTR:
  call __prefix
  opencapture 21
  quad 71756164
  closecapture 21 0
  call S
  call QUAD
  ret
-- Rule
REPLACEINSTR:
  call __prefix
  opencapture 22
  quad 7265706c
  char 61
  char 63
  char 65
  closecapture 22 0
  call S
  call SLOT
  call S
  call LABEL
  ret
-- Rule
ENDREPLACEINSTR:
  call __prefix
  opencapture 23
  quad 656e6472
  quad 65706c61
  char 63
  char 65
  closecapture 23 0
  ret
-- Rule
RETINSTR:
  call __prefix
  opencapture 24
  char 72
  char 65
  char 74
  closecapture 24 0
  ret
-- Rule
SETINSTR:
  call __prefix
  opencapture 25
  char 73
  char 65
  char 74
  closecapture 25 0
  call S
  call SET
  ret
-- Rule
RANGEINSTR:
  call __prefix
  opencapture 26
  quad 72616e67
  char 65
  closecapture 26 0
  call S
  call UNSIGNED
  call S
  call UNSIGNED
  ret
-- Rule
SKIPINSTR:
  call __prefix
  opencapture 27
  quad 736b6970
  closecapture 27 0
  call S
  call UNSIGNED
  ret
-- Rule
SPANINSTR:
  call __prefix
  opencapture 28
  quad 7370616e
  closecapture 28 0
  call S
  call SET
  ret
-- Rule
TESTANYINSTR:
  call __prefix
  opencapture 29
  quad 74657374
  char 61
  char 6e
  char 79
  closecapture 29 0
  call S
  call LABEL
  ret
-- Rule
TESTCHARINSTR:
  call __prefix
  opencapture 30
  quad 74657374
  quad 63686172
  closecapture 30 0
  call S
  call HEXBYTE
  call S
  call LABEL
  ret
-- Rule
TESTQUADINSTR:
  call __prefix
  opencapture 31
  quad 74657374
  quad 71756164
  closecapture 31 0
  call S
  call QUAD
  call S
  call LABEL
  ret
-- Rule
TESTSETINSTR:
  call __prefix
  opencapture 32
  quad 74657374
  char 73
  char 65
  char 74
  closecapture 32 0
  call S
  call SET
  call S
  call LABEL
  ret
-- Rule
VARINSTR:
  call __prefix
  opencapture 33
  char 76
  char 61
  char 72
  closecapture 33 0
  call S
  call SLOT
  ret
-- Rule
COUNTERINSTR:
  call __prefix
  opencapture 34
  quad 636f756e
  char 74
  char 65
  char 72
  closecapture 34 0
  call S
  call REGISTER
  call S
  call UNSIGNED
  ret
-- Rule
CONDJUMPINSTR:
  call __prefix
  opencapture 35
  quad 636f6e64
  quad 6a756d70
  closecapture 35 0
  call S
  call REGISTER
  call S
  call LABEL
  ret
-- Rule
ISOLATEINSTR:
  call __prefix
  opencapture 36
  quad 69736f6c
  char 61
  char 74
  char 65
  closecapture 36 0
  call S
  call SLOT
  ret
-- Rule
ENDISOLATEINSTR:
  call __prefix
  opencapture 37
  quad 656e6469
  quad 736f6c61
  char 74
  char 65
  closecapture 37 0
  ret
-- Rule
MODEINSTR:
  call __prefix
  opencapture 38
  quad 6d6f6465
  closecapture 38 0
  call S
  call NUMBER
  ret
-- Rule
LABELDEF:
  call __prefix
  call LABEL
  call COLON
  ret
-- Rule
NAMESPACEDEF:
  call __prefix
  catch __RIGHTHAND_1308
  call NAMESPACESTART
  commit __LEFTHAND_1309
__RIGHTHAND_1308:
  call NAMESPACESTOP
__LEFTHAND_1309:
  ret
-- Rule
NAMESPACESTART:
  call __prefix
  opencapture 39
  quad 6e616d65
  quad 73706163
  quad 655f7374
  char 61
  char 72
  char 74
  closecapture 39 0
  call S
  call LABEL
  ret
-- Rule
NAMESPACESTOP:
  call __prefix
  opencapture 40
  quad 6e616d65
  quad 73706163
  quad 655f7374
  char 6f
  char 70
  closecapture 40 0
  call S
  call LABEL
  ret
-- Rule
CODE:
  call __prefix
  call UNSIGNED
  ret
-- Rule
HEXBYTE:
  call __prefix
  opencapture 41
  counter 0 2
__TERM_1384:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1384
  closecapture 41 0
  ret
-- Rule
LABEL:
  call __prefix
  opencapture 42
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  catch __TERM_1397
  counter 0 63
__TERM_1398:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1399
__TERM_1399:
  condjump 0 __TERM_1398
  commit __TERM_1397
__TERM_1397:
  closecapture 42 0
  ret
-- Rule
UNSIGNED:
  call __prefix
  opencapture 43
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1410
__TERM_1409:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1409
__TERM_1410:
  closecapture 43 0
  ret
-- Rule
NUMBER:
  call __prefix
  opencapture 44
  catch __TERM_1421
  char 2d
  commit __TERM_1421
__TERM_1421:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1428
__TERM_1427:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1427
__TERM_1428:
  closecapture 44 0
  ret
-- Rule
QUAD:
  call __prefix
  opencapture 45
  counter 0 8
__TERM_1438:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1438
  closecapture 45 0
  ret
-- Rule
SET:
  call __prefix
  opencapture 46
  counter 0 64
__TERM_1450:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1450
  closecapture 46 0
  ret
-- Rule
SLOT:
  call __prefix
  call UNSIGNED
  ret
-- Rule
REGISTER:
  call __prefix
  call UNSIGNED
  ret
-- Rule
TYPE:
  call __prefix
  call UNSIGNED
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
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 47
  catch __TERM_1500
__TERM_1499:
  catch __RIGHTHAND_1502
  char 5c
  catch __RIGHTHAND_1516
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1517
__RIGHTHAND_1516:
  counter 0 3
__TERM_1526:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1526
__LEFTHAND_1517:
  commit __LEFTHAND_1503
__RIGHTHAND_1502:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1503:
  partialcommit __TERM_1499
__TERM_1500:
  closecapture 47 0
  char 27
  ret
-- Rule
INTRPCAPTURETYPES:
  call __prefix
  opencapture 48
  quad 7275696e
  char 74
  char 33
  char 32
  closecapture 48 0
  ret

  end 0

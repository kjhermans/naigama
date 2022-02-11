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
  opencapture 1
  call LABELDEF
  closecapture 1 0
__LEFTHAND_101:
  ret
-- Rule
RULEINSTR:
  call __prefix
  catch __RIGHTHAND_126
  call ANYINSTR
  commit __LEFTHAND_127
__RIGHTHAND_126:
  catch __RIGHTHAND_134
  call BACKCOMMITINSTR
  commit __LEFTHAND_135
__RIGHTHAND_134:
  catch __RIGHTHAND_142
  call CALLINSTR
  commit __LEFTHAND_143
__RIGHTHAND_142:
  catch __RIGHTHAND_150
  call CATCHINSTR
  commit __LEFTHAND_151
__RIGHTHAND_150:
  catch __RIGHTHAND_158
  call CHARINSTR
  commit __LEFTHAND_159
__RIGHTHAND_158:
  catch __RIGHTHAND_166
  call MASKEDCHARINSTR
  commit __LEFTHAND_167
__RIGHTHAND_166:
  catch __RIGHTHAND_174
  call CLOSECAPTUREINSTR
  commit __LEFTHAND_175
__RIGHTHAND_174:
  catch __RIGHTHAND_182
  call COMMITINSTR
  commit __LEFTHAND_183
__RIGHTHAND_182:
  catch __RIGHTHAND_190
  call ENDREPLACEINSTR
  commit __LEFTHAND_191
__RIGHTHAND_190:
  catch __RIGHTHAND_198
  call REPLACEINSTR
  commit __LEFTHAND_199
__RIGHTHAND_198:
  catch __RIGHTHAND_206
  call INTRPCAPTUREINSTR
  commit __LEFTHAND_207
__RIGHTHAND_206:
  catch __RIGHTHAND_214
  call ISOLATEINSTR
  commit __LEFTHAND_215
__RIGHTHAND_214:
  catch __RIGHTHAND_222
  call ENDISOLATEINSTR
  commit __LEFTHAND_223
__RIGHTHAND_222:
  catch __RIGHTHAND_230
  call ENDINSTR
  commit __LEFTHAND_231
__RIGHTHAND_230:
  catch __RIGHTHAND_238
  call FAILTWICEINSTR
  commit __LEFTHAND_239
__RIGHTHAND_238:
  catch __RIGHTHAND_246
  call FAILINSTR
  commit __LEFTHAND_247
__RIGHTHAND_246:
  catch __RIGHTHAND_254
  call JUMPINSTR
  commit __LEFTHAND_255
__RIGHTHAND_254:
  catch __RIGHTHAND_262
  call NOOPINSTR
  commit __LEFTHAND_263
__RIGHTHAND_262:
  catch __RIGHTHAND_270
  call TRAPINSTR
  commit __LEFTHAND_271
__RIGHTHAND_270:
  catch __RIGHTHAND_278
  call OPENCAPTUREINSTR
  commit __LEFTHAND_279
__RIGHTHAND_278:
  catch __RIGHTHAND_286
  call PARTIALCOMMITINSTR
  commit __LEFTHAND_287
__RIGHTHAND_286:
  catch __RIGHTHAND_294
  call QUADINSTR
  commit __LEFTHAND_295
__RIGHTHAND_294:
  catch __RIGHTHAND_302
  call RETINSTR
  commit __LEFTHAND_303
__RIGHTHAND_302:
  catch __RIGHTHAND_310
  call SETINSTR
  commit __LEFTHAND_311
__RIGHTHAND_310:
  catch __RIGHTHAND_318
  call RANGEINSTR
  commit __LEFTHAND_319
__RIGHTHAND_318:
  catch __RIGHTHAND_326
  call SKIPINSTR
  commit __LEFTHAND_327
__RIGHTHAND_326:
  catch __RIGHTHAND_334
  call SPANINSTR
  commit __LEFTHAND_335
__RIGHTHAND_334:
  catch __RIGHTHAND_342
  call TESTANYINSTR
  commit __LEFTHAND_343
__RIGHTHAND_342:
  catch __RIGHTHAND_350
  call TESTCHARINSTR
  commit __LEFTHAND_351
__RIGHTHAND_350:
  catch __RIGHTHAND_358
  call TESTQUADINSTR
  commit __LEFTHAND_359
__RIGHTHAND_358:
  catch __RIGHTHAND_366
  call TESTSETINSTR
  commit __LEFTHAND_367
__RIGHTHAND_366:
  catch __RIGHTHAND_374
  call VARINSTR
  commit __LEFTHAND_375
__RIGHTHAND_374:
  catch __RIGHTHAND_382
  call COUNTERINSTR
  commit __LEFTHAND_383
__RIGHTHAND_382:
  catch __RIGHTHAND_390
  call CONDJUMPINSTR
  commit __LEFTHAND_391
__RIGHTHAND_390:
  call MODEINSTR
__LEFTHAND_391:
__LEFTHAND_383:
__LEFTHAND_375:
__LEFTHAND_367:
__LEFTHAND_359:
__LEFTHAND_351:
__LEFTHAND_343:
__LEFTHAND_335:
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
  ret
-- Rule
END:
  call __prefix
  catch __TERM_404
  any
  failtwice
__TERM_404:
  ret
-- Rule
ANYINSTR:
  call __prefix
  opencapture 2
  char 61
  char 6e
  char 79
  closecapture 2 0
  ret
-- Rule
BACKCOMMITINSTR:
  call __prefix
  opencapture 3
  quad 6261636b
  quad 636f6d6d
  char 69
  char 74
  closecapture 3 0
  call S
  call LABEL
  ret
-- Rule
CALLINSTR:
  call __prefix
  opencapture 4
  quad 63616c6c
  closecapture 4 0
  call S
  call LABEL
  ret
-- Rule
CATCHINSTR:
  call __prefix
  opencapture 5
  quad 63617463
  char 68
  closecapture 5 0
  call S
  call LABEL
  ret
-- Rule
CHARINSTR:
  call __prefix
  opencapture 6
  quad 63686172
  closecapture 6 0
  call S
  call HEXBYTE
  ret
-- Rule
MASKEDCHARINSTR:
  call __prefix
  opencapture 7
  quad 6d61736b
  quad 65646368
  char 61
  char 72
  closecapture 7 0
  call S
  call HEXBYTE
  call S
  call HEXBYTE
  ret
-- Rule
CLOSECAPTUREINSTR:
  call __prefix
  opencapture 8
  quad 636c6f73
  quad 65636170
  quad 74757265
  closecapture 8 0
  call S
  call SLOT
  ret
-- Rule
COMMITINSTR:
  call __prefix
  opencapture 9
  quad 636f6d6d
  char 69
  char 74
  closecapture 9 0
  call S
  call LABEL
  ret
-- Rule
ENDINSTR:
  call __prefix
  opencapture 10
  char 65
  char 6e
  char 64
  closecapture 10 0
  call S
  call CODE
  ret
-- Rule
FAILINSTR:
  call __prefix
  opencapture 11
  quad 6661696c
  closecapture 11 0
  ret
-- Rule
FAILTWICEINSTR:
  call __prefix
  opencapture 12
  quad 6661696c
  quad 74776963
  char 65
  closecapture 12 0
  ret
-- Rule
INTRPCAPTUREINSTR:
  call __prefix
  opencapture 13
  quad 696e7472
  quad 70636170
  quad 74757265
  closecapture 13 0
  call S
  call INTRPCAPTURETYPES
  call S
  catch __RIGHTHAND_686
  call SLOT
  commit __LEFTHAND_687
__RIGHTHAND_686:
  opencapture 14
  quad 64656661
  char 75
  char 6c
  char 74
  closecapture 14 0
__LEFTHAND_687:
  ret
-- Rule
JUMPINSTR:
  call __prefix
  opencapture 15
  quad 6a756d70
  closecapture 15 0
  call S
  call LABEL
  ret
-- Rule
NOOPINSTR:
  call __prefix
  opencapture 16
  quad 6e6f6f70
  closecapture 16 0
  ret
-- Rule
TRAPINSTR:
  call __prefix
  opencapture 17
  quad 74726170
  closecapture 17 0
  ret
-- Rule
OPENCAPTUREINSTR:
  call __prefix
  opencapture 18
  quad 6f70656e
  quad 63617074
  char 75
  char 72
  char 65
  closecapture 18 0
  call S
  call SLOT
  ret
-- Rule
PARTIALCOMMITINSTR:
  call __prefix
  opencapture 19
  quad 70617274
  quad 69616c63
  quad 6f6d6d69
  char 74
  closecapture 19 0
  call S
  call LABEL
  ret
-- Rule
QUADINSTR:
  call __prefix
  opencapture 20
  quad 71756164
  closecapture 20 0
  call S
  call QUAD
  ret
-- Rule
REPLACEINSTR:
  call __prefix
  opencapture 21
  quad 7265706c
  char 61
  char 63
  char 65
  closecapture 21 0
  call S
  call SLOT
  call S
  call LABEL
  ret
-- Rule
ENDREPLACEINSTR:
  call __prefix
  opencapture 22
  quad 656e6472
  quad 65706c61
  char 63
  char 65
  closecapture 22 0
  ret
-- Rule
RETINSTR:
  call __prefix
  opencapture 23
  char 72
  char 65
  char 74
  closecapture 23 0
  ret
-- Rule
SETINSTR:
  call __prefix
  opencapture 24
  char 73
  char 65
  char 74
  closecapture 24 0
  call S
  call SET
  ret
-- Rule
RANGEINSTR:
  call __prefix
  opencapture 25
  quad 72616e67
  char 65
  closecapture 25 0
  call S
  call UNSIGNED
  call S
  call UNSIGNED
  ret
-- Rule
SKIPINSTR:
  call __prefix
  opencapture 26
  quad 736b6970
  closecapture 26 0
  call S
  call UNSIGNED
  ret
-- Rule
SPANINSTR:
  call __prefix
  opencapture 27
  quad 7370616e
  closecapture 27 0
  call S
  call SET
  ret
-- Rule
TESTANYINSTR:
  call __prefix
  opencapture 28
  quad 74657374
  char 61
  char 6e
  char 79
  closecapture 28 0
  call S
  call LABEL
  ret
-- Rule
TESTCHARINSTR:
  call __prefix
  opencapture 29
  quad 74657374
  quad 63686172
  closecapture 29 0
  call S
  call HEXBYTE
  call S
  call LABEL
  ret
-- Rule
TESTQUADINSTR:
  call __prefix
  opencapture 30
  quad 74657374
  quad 71756164
  closecapture 30 0
  call S
  call QUAD
  call S
  call LABEL
  ret
-- Rule
TESTSETINSTR:
  call __prefix
  opencapture 31
  quad 74657374
  char 73
  char 65
  char 74
  closecapture 31 0
  call S
  call SET
  call S
  call LABEL
  ret
-- Rule
VARINSTR:
  call __prefix
  opencapture 32
  char 76
  char 61
  char 72
  closecapture 32 0
  call S
  call SLOT
  ret
-- Rule
COUNTERINSTR:
  call __prefix
  opencapture 33
  quad 636f756e
  char 74
  char 65
  char 72
  closecapture 33 0
  call S
  call REGISTER
  call S
  call UNSIGNED
  ret
-- Rule
CONDJUMPINSTR:
  call __prefix
  opencapture 34
  quad 636f6e64
  quad 6a756d70
  closecapture 34 0
  call S
  call REGISTER
  call S
  call LABEL
  ret
-- Rule
ISOLATEINSTR:
  call __prefix
  opencapture 35
  quad 69736f6c
  char 61
  char 74
  char 65
  closecapture 35 0
  call S
  call SLOT
  ret
-- Rule
ENDISOLATEINSTR:
  call __prefix
  opencapture 36
  quad 656e6469
  quad 736f6c61
  char 74
  char 65
  closecapture 36 0
  ret
-- Rule
MODEINSTR:
  call __prefix
  opencapture 37
  quad 6d6f6465
  closecapture 37 0
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
CODE:
  call __prefix
  call UNSIGNED
  ret
-- Rule
HEXBYTE:
  call __prefix
  opencapture 38
  counter 0 2
__TERM_1308:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1308
  closecapture 38 0
  ret
-- Rule
LABEL:
  call __prefix
  opencapture 39
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  catch __TERM_1321
  counter 0 63
__TERM_1322:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1323
__TERM_1323:
  condjump 0 __TERM_1322
  commit __TERM_1321
__TERM_1321:
  closecapture 39 0
  ret
-- Rule
UNSIGNED:
  call __prefix
  opencapture 40
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1334
__TERM_1333:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1333
__TERM_1334:
  closecapture 40 0
  ret
-- Rule
NUMBER:
  call __prefix
  opencapture 41
  catch __TERM_1345
  char 2d
  commit __TERM_1345
__TERM_1345:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1352
__TERM_1351:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1351
__TERM_1352:
  closecapture 41 0
  ret
-- Rule
QUAD:
  call __prefix
  opencapture 42
  counter 0 8
__TERM_1362:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1362
  closecapture 42 0
  ret
-- Rule
SET:
  call __prefix
  opencapture 43
  counter 0 64
__TERM_1374:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1374
  closecapture 43 0
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
  opencapture 44
  catch __TERM_1424
__TERM_1423:
  catch __RIGHTHAND_1426
  char 5c
  catch __RIGHTHAND_1440
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1441
__RIGHTHAND_1440:
  counter 0 3
__TERM_1450:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1450
__LEFTHAND_1441:
  commit __LEFTHAND_1427
__RIGHTHAND_1426:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1427:
  partialcommit __TERM_1423
__TERM_1424:
  closecapture 44 0
  char 27
  ret
-- Rule
INTRPCAPTURETYPES:
  call __prefix
  opencapture 45
  quad 7275696e
  char 74
  char 33
  char 32
  closecapture 45 0
  ret

  end 0

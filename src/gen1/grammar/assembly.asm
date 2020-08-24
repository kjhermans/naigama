-- Generated at Mon Aug 24 14:21:19 2020 by the gen0 compiler.
  call __RULE_TOP
  end 0
__RULE_TOP:
  call __RULE_INSTRUCTIONS
  ret
__RULE_S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __FORGIVE_11
__ENDLESS_10:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_10
__FORGIVE_11:
  ret
__RULE___prefix:
  catch __FORGIVE_18
__ENDLESS_17:
  catch __RIGHTHAND_21
  char 2d
  char 2d
  catch __FORGIVE_33
__ENDLESS_32:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __ENDLESS_32
__FORGIVE_33:
  char 0a
  commit __SUCCESS_21
__RIGHTHAND_21:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __FORGIVE_47
__ENDLESS_46:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_46
__FORGIVE_47:
__SUCCESS_21:
  partialcommit __ENDLESS_17
__FORGIVE_18:
  ret
__RULE_INSTRUCTIONS:
  call __RULE___prefix
  call __RULE_INSTRUCTION
  catch __FORGIVE_54
__ENDLESS_53:
  call __RULE_INSTRUCTION
  partialcommit __ENDLESS_53
__FORGIVE_54:
  call __RULE_END
  ret
__RULE_INSTRUCTION:
  call __RULE___prefix
  opencapture 0
  catch __RIGHTHAND_71
  call __RULE_ANYINSTR
  commit __SUCCESS_71
__RIGHTHAND_71:
  catch __RIGHTHAND_79
  call __RULE_BACKCOMMITINSTR
  commit __SUCCESS_79
__RIGHTHAND_79:
  catch __RIGHTHAND_87
  call __RULE_CALLINSTR
  commit __SUCCESS_87
__RIGHTHAND_87:
  catch __RIGHTHAND_95
  call __RULE_CATCHINSTR
  commit __SUCCESS_95
__RIGHTHAND_95:
  catch __RIGHTHAND_103
  call __RULE_CHARINSTR
  commit __SUCCESS_103
__RIGHTHAND_103:
  catch __RIGHTHAND_111
  call __RULE_MASKEDCHARINSTR
  commit __SUCCESS_111
__RIGHTHAND_111:
  catch __RIGHTHAND_119
  call __RULE_CLOSECAPTUREINSTR
  commit __SUCCESS_119
__RIGHTHAND_119:
  catch __RIGHTHAND_127
  call __RULE_COMMITINSTR
  commit __SUCCESS_127
__RIGHTHAND_127:
  catch __RIGHTHAND_135
  call __RULE_ENDREPLACEINSTR
  commit __SUCCESS_135
__RIGHTHAND_135:
  catch __RIGHTHAND_143
  call __RULE_REPLACEINSTR
  commit __SUCCESS_143
__RIGHTHAND_143:
  catch __RIGHTHAND_151
  call __RULE_ENDINSTR
  commit __SUCCESS_151
__RIGHTHAND_151:
  catch __RIGHTHAND_159
  call __RULE_FAILTWICEINSTR
  commit __SUCCESS_159
__RIGHTHAND_159:
  catch __RIGHTHAND_167
  call __RULE_FAILINSTR
  commit __SUCCESS_167
__RIGHTHAND_167:
  catch __RIGHTHAND_175
  call __RULE_JUMPINSTR
  commit __SUCCESS_175
__RIGHTHAND_175:
  catch __RIGHTHAND_183
  call __RULE_NOOPINSTR
  commit __SUCCESS_183
__RIGHTHAND_183:
  catch __RIGHTHAND_191
  call __RULE_TRAPINSTR
  commit __SUCCESS_191
__RIGHTHAND_191:
  catch __RIGHTHAND_199
  call __RULE_OPENCAPTUREINSTR
  commit __SUCCESS_199
__RIGHTHAND_199:
  catch __RIGHTHAND_207
  call __RULE_PARTIALCOMMITINSTR
  commit __SUCCESS_207
__RIGHTHAND_207:
  catch __RIGHTHAND_215
  call __RULE_QUADINSTR
  commit __SUCCESS_215
__RIGHTHAND_215:
  catch __RIGHTHAND_223
  call __RULE_RETINSTR
  commit __SUCCESS_223
__RIGHTHAND_223:
  catch __RIGHTHAND_231
  call __RULE_SETINSTR
  commit __SUCCESS_231
__RIGHTHAND_231:
  catch __RIGHTHAND_239
  call __RULE_RANGEINSTR
  commit __SUCCESS_239
__RIGHTHAND_239:
  catch __RIGHTHAND_247
  call __RULE_SKIPINSTR
  commit __SUCCESS_247
__RIGHTHAND_247:
  catch __RIGHTHAND_255
  call __RULE_SPANINSTR
  commit __SUCCESS_255
__RIGHTHAND_255:
  catch __RIGHTHAND_263
  call __RULE_TESTANYINSTR
  commit __SUCCESS_263
__RIGHTHAND_263:
  catch __RIGHTHAND_271
  call __RULE_TESTCHARINSTR
  commit __SUCCESS_271
__RIGHTHAND_271:
  catch __RIGHTHAND_279
  call __RULE_TESTQUADINSTR
  commit __SUCCESS_279
__RIGHTHAND_279:
  catch __RIGHTHAND_287
  call __RULE_TESTSETINSTR
  commit __SUCCESS_287
__RIGHTHAND_287:
  catch __RIGHTHAND_295
  call __RULE_VARINSTR
  commit __SUCCESS_295
__RIGHTHAND_295:
  catch __RIGHTHAND_303
  call __RULE_COUNTERINSTR
  commit __SUCCESS_303
__RIGHTHAND_303:
  catch __RIGHTHAND_311
  call __RULE_CONDJUMPINSTR
  commit __SUCCESS_311
__RIGHTHAND_311:
  call __RULE_LABELDEF
__SUCCESS_311:
__SUCCESS_303:
__SUCCESS_295:
__SUCCESS_287:
__SUCCESS_279:
__SUCCESS_271:
__SUCCESS_263:
__SUCCESS_255:
__SUCCESS_247:
__SUCCESS_239:
__SUCCESS_231:
__SUCCESS_223:
__SUCCESS_215:
__SUCCESS_207:
__SUCCESS_199:
__SUCCESS_191:
__SUCCESS_183:
__SUCCESS_175:
__SUCCESS_167:
__SUCCESS_159:
__SUCCESS_151:
__SUCCESS_143:
__SUCCESS_135:
__SUCCESS_127:
__SUCCESS_119:
__SUCCESS_111:
__SUCCESS_103:
__SUCCESS_95:
__SUCCESS_87:
__SUCCESS_79:
__SUCCESS_71:
  closecapture 0
  ret
__RULE_END:
  call __RULE___prefix
  catch __PREFIX_326
  any
  failtwice
__PREFIX_326:
  ret
__RULE_ANYINSTR:
  call __RULE___prefix
  opencapture 1
  char 61
  char 6e
  char 79
  closecapture 1
  ret
__RULE_BACKCOMMITINSTR:
  call __RULE___prefix
  opencapture 2
  quad 6261636b
  quad 636f6d6d
  char 69
  char 74
  closecapture 2
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_CALLINSTR:
  call __RULE___prefix
  opencapture 3
  quad 63616c6c
  closecapture 3
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_CATCHINSTR:
  call __RULE___prefix
  opencapture 4
  quad 63617463
  char 68
  closecapture 4
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_CHARINSTR:
  call __RULE___prefix
  opencapture 5
  quad 63686172
  closecapture 5
  call __RULE_S
  call __RULE_HEXBYTE
  ret
__RULE_MASKEDCHARINSTR:
  call __RULE___prefix
  opencapture 6
  quad 6d61736b
  quad 65646368
  char 61
  char 72
  closecapture 6
  call __RULE_S
  call __RULE_HEXBYTE
  call __RULE_S
  call __RULE_HEXBYTE
  ret
__RULE_CLOSECAPTUREINSTR:
  call __RULE___prefix
  opencapture 7
  quad 636c6f73
  quad 65636170
  quad 74757265
  closecapture 7
  call __RULE_S
  call __RULE_SLOT
  catch __FORGIVE_533
  call __RULE_S
  call __RULE_TYPE
  commit __FORGIVE_533
__FORGIVE_533:
  ret
__RULE_COMMITINSTR:
  call __RULE___prefix
  opencapture 8
  quad 636f6d6d
  char 69
  char 74
  closecapture 8
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_ENDINSTR:
  call __RULE___prefix
  opencapture 9
  char 65
  char 6e
  char 64
  closecapture 9
  catch __FORGIVE_596
  call __RULE_S
  call __RULE_CODE
  commit __FORGIVE_596
__FORGIVE_596:
  ret
__RULE_FAILINSTR:
  call __RULE___prefix
  opencapture 10
  quad 6661696c
  closecapture 10
  ret
__RULE_FAILTWICEINSTR:
  call __RULE___prefix
  opencapture 11
  quad 6661696c
  quad 74776963
  char 65
  closecapture 11
  ret
__RULE_JUMPINSTR:
  call __RULE___prefix
  opencapture 12
  quad 6a756d70
  closecapture 12
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_NOOPINSTR:
  call __RULE___prefix
  opencapture 13
  quad 6e6f6f70
  closecapture 13
  ret
__RULE_TRAPINSTR:
  call __RULE___prefix
  opencapture 14
  quad 74726170
  closecapture 14
  ret
__RULE_OPENCAPTUREINSTR:
  call __RULE___prefix
  opencapture 15
  quad 6f70656e
  quad 63617074
  char 75
  char 72
  char 65
  closecapture 15
  call __RULE_S
  call __RULE_SLOT
  ret
__RULE_PARTIALCOMMITINSTR:
  call __RULE___prefix
  opencapture 16
  quad 70617274
  quad 69616c63
  quad 6f6d6d69
  char 74
  closecapture 16
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_QUADINSTR:
  call __RULE___prefix
  opencapture 17
  quad 71756164
  closecapture 17
  call __RULE_S
  call __RULE_QUAD
  ret
__RULE_REPLACEINSTR:
  call __RULE___prefix
  opencapture 18
  quad 7265706c
  char 61
  char 63
  char 65
  closecapture 18
  call __RULE_S
  call __RULE_LABEL
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_ENDREPLACEINSTR:
  call __RULE___prefix
  opencapture 19
  quad 656e6472
  quad 65706c61
  char 63
  char 65
  closecapture 19
  ret
__RULE_RETINSTR:
  call __RULE___prefix
  opencapture 20
  char 72
  char 65
  char 74
  closecapture 20
  ret
__RULE_SETINSTR:
  call __RULE___prefix
  opencapture 21
  char 73
  char 65
  char 74
  closecapture 21
  call __RULE_S
  call __RULE_SET
  ret
__RULE_RANGEINSTR:
  call __RULE___prefix
  opencapture 22
  quad 72616e67
  char 65
  closecapture 22
  call __RULE_S
  call __RULE_NUMBER
  call __RULE_S
  call __RULE_NUMBER
  ret
__RULE_SKIPINSTR:
  call __RULE___prefix
  opencapture 23
  quad 736b6970
  closecapture 23
  call __RULE_S
  call __RULE_NUMBER
  ret
__RULE_SPANINSTR:
  call __RULE___prefix
  opencapture 24
  quad 7370616e
  closecapture 24
  call __RULE_S
  call __RULE_SET
  ret
__RULE_TESTANYINSTR:
  call __RULE___prefix
  opencapture 25
  quad 74657374
  char 61
  char 6e
  char 79
  closecapture 25
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_TESTCHARINSTR:
  call __RULE___prefix
  opencapture 26
  quad 74657374
  quad 63686172
  closecapture 26
  call __RULE_S
  call __RULE_HEXBYTE
  call __RULE_S
  call __RULE_LABEL
  catch __FORGIVE_1051
  call __RULE_S
  call __RULE_AMPERSAND
  call __RULE_HEXBYTE
  commit __FORGIVE_1051
__FORGIVE_1051:
  ret
__RULE_TESTQUADINSTR:
  call __RULE___prefix
  opencapture 27
  quad 74657374
  quad 71756164
  closecapture 27
  call __RULE_S
  call __RULE_QUAD
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_TESTSETINSTR:
  call __RULE___prefix
  opencapture 28
  quad 74657374
  char 73
  char 65
  char 74
  closecapture 28
  call __RULE_S
  call __RULE_SET
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_VARINSTR:
  call __RULE___prefix
  opencapture 29
  char 76
  char 61
  char 72
  closecapture 29
  call __RULE_S
  call __RULE_SLOT
  ret
__RULE_COUNTERINSTR:
  call __RULE___prefix
  opencapture 30
  quad 636f756e
  char 74
  char 65
  char 72
  closecapture 30
  call __RULE_S
  call __RULE_REGISTER
  call __RULE_S
  call __RULE_NUMBER
  ret
__RULE_CONDJUMPINSTR:
  call __RULE___prefix
  opencapture 31
  quad 636f6e64
  quad 6a756d70
  closecapture 31
  call __RULE_S
  call __RULE_REGISTER
  call __RULE_S
  call __RULE_LABEL
  ret
__RULE_LABELDEF:
  call __RULE___prefix
  opencapture 32
  call __RULE_LABEL
  closecapture 32
  call __RULE_COLON
  ret
__RULE_CODE:
  call __RULE___prefix
  call __RULE_NUMBER
  ret
__RULE_HEXBYTE:
  call __RULE___prefix
  opencapture 33
  counter 0 2
__COUNTER_1307:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __COUNTER_1307
  closecapture 33
  ret
__RULE_LABEL:
  call __RULE___prefix
  opencapture 34
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_1324
  counter 1 63
__COUNTER_1322:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __USELESS_1326
__USELESS_1326:
  condjump 1 __COUNTER_1322
  commit __FORGIVE_1324
__FORGIVE_1324:
  closecapture 34
  ret
__RULE_NUMBER:
  call __RULE___prefix
  opencapture 35
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1338
__ENDLESS_1337:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1337
__FORGIVE_1338:
  closecapture 35
  ret
__RULE_QUAD:
  call __RULE___prefix
  opencapture 36
  counter 1 8
__COUNTER_1349:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __COUNTER_1349
  closecapture 36
  ret
__RULE_SET:
  call __RULE___prefix
  opencapture 37
  counter 2 64
__COUNTER_1363:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 2 __COUNTER_1363
  closecapture 37
  ret
__RULE_SLOT:
  call __RULE___prefix
  call __RULE_NUMBER
  ret
__RULE_REGISTER:
  call __RULE___prefix
  call __RULE_NUMBER
  ret
__RULE_TYPE:
  call __RULE___prefix
  call __RULE_NUMBER
  ret
__RULE_COLON:
  call __RULE___prefix
  char 3a
  ret
__RULE_AMPERSAND:
  call __RULE___prefix
  char 26
  ret

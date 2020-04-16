  call TOP
  end
-- Rule
TOP:
  call INSTRUCTIONS
  ret
-- Rule
S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __LABEL_10 -- 2
__LABEL_9:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __LABEL_9
__LABEL_10:
  ret
-- Rule
__prefix:
  catch __LABEL_16 -- 2
__LABEL_15:
  catch __LABEL_18 -- terms or expression
  char 2d
  char 2d
  catch __LABEL_30 -- 2
__LABEL_29:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __LABEL_29
__LABEL_30:
  char 0a
  commit __LABEL_19
__LABEL_18:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __LABEL_42 -- 2
__LABEL_41:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __LABEL_41
__LABEL_42:
__LABEL_19:
  partialcommit __LABEL_15
__LABEL_16:
  ret
-- Rule
INSTRUCTIONS:
  call __prefix
  call INSTRUCTION
  catch __LABEL_48 -- 2
__LABEL_47:
  call INSTRUCTION
  partialcommit __LABEL_47
__LABEL_48:
  call END
  ret
-- Rule
INSTRUCTION:
  call __prefix
  opencapture 0
  catch __LABEL_62 -- terms or expression
  call ANYINSTR
  commit __LABEL_63
__LABEL_62:
  catch __LABEL_70 -- terms or expression
  call BACKCOMMITINSTR
  commit __LABEL_71
__LABEL_70:
  catch __LABEL_78 -- terms or expression
  call CALLINSTR
  commit __LABEL_79
__LABEL_78:
  catch __LABEL_86 -- terms or expression
  call CATCHINSTR
  commit __LABEL_87
__LABEL_86:
  catch __LABEL_94 -- terms or expression
  call CHARINSTR
  commit __LABEL_95
__LABEL_94:
  catch __LABEL_102 -- terms or expression
  call MASKEDCHARINSTR
  commit __LABEL_103
__LABEL_102:
  catch __LABEL_110 -- terms or expression
  call CLOSECAPTUREINSTR
  commit __LABEL_111
__LABEL_110:
  catch __LABEL_118 -- terms or expression
  call COMMITINSTR
  commit __LABEL_119
__LABEL_118:
  catch __LABEL_126 -- terms or expression
  call ENDINSTR
  commit __LABEL_127
__LABEL_126:
  catch __LABEL_134 -- terms or expression
  call FAILTWICEINSTR
  commit __LABEL_135
__LABEL_134:
  catch __LABEL_142 -- terms or expression
  call FAILINSTR
  commit __LABEL_143
__LABEL_142:
  catch __LABEL_150 -- terms or expression
  call JUMPINSTR
  commit __LABEL_151
__LABEL_150:
  catch __LABEL_158 -- terms or expression
  call NOOPINSTR
  commit __LABEL_159
__LABEL_158:
  catch __LABEL_166 -- terms or expression
  call TRAPINSTR
  commit __LABEL_167
__LABEL_166:
  catch __LABEL_174 -- terms or expression
  call OPENCAPTUREINSTR
  commit __LABEL_175
__LABEL_174:
  catch __LABEL_182 -- terms or expression
  call PARTIALCOMMITINSTR
  commit __LABEL_183
__LABEL_182:
  catch __LABEL_190 -- terms or expression
  call QUADINSTR
  commit __LABEL_191
__LABEL_190:
  catch __LABEL_198 -- terms or expression
  call REPLACEINSTR
  commit __LABEL_199
__LABEL_198:
  catch __LABEL_206 -- terms or expression
  call REPLACESTRINGINSTR
  commit __LABEL_207
__LABEL_206:
  catch __LABEL_214 -- terms or expression
  call RETINSTR
  commit __LABEL_215
__LABEL_214:
  catch __LABEL_222 -- terms or expression
  call SETINSTR
  commit __LABEL_223
__LABEL_222:
  catch __LABEL_230 -- terms or expression
  call RANGEINSTR
  commit __LABEL_231
__LABEL_230:
  catch __LABEL_238 -- terms or expression
  call SKIPINSTR
  commit __LABEL_239
__LABEL_238:
  catch __LABEL_246 -- terms or expression
  call SPANINSTR
  commit __LABEL_247
__LABEL_246:
  catch __LABEL_254 -- terms or expression
  call TESTANYINSTR
  commit __LABEL_255
__LABEL_254:
  catch __LABEL_262 -- terms or expression
  call TESTCHARINSTR
  commit __LABEL_263
__LABEL_262:
  catch __LABEL_270 -- terms or expression
  call TESTQUADINSTR
  commit __LABEL_271
__LABEL_270:
  catch __LABEL_278 -- terms or expression
  call TESTSETINSTR
  commit __LABEL_279
__LABEL_278:
  catch __LABEL_286 -- terms or expression
  call VARINSTR
  commit __LABEL_287
__LABEL_286:
  catch __LABEL_294 -- terms or expression
  call COUNTERINSTR
  commit __LABEL_295
__LABEL_294:
  catch __LABEL_302 -- terms or expression
  call CONDJUMPINSTR
  commit __LABEL_303
__LABEL_302:
  call LABELDEF
__LABEL_303:
__LABEL_295:
__LABEL_287:
__LABEL_279:
__LABEL_271:
__LABEL_263:
__LABEL_255:
__LABEL_247:
__LABEL_239:
__LABEL_231:
__LABEL_223:
__LABEL_215:
__LABEL_207:
__LABEL_199:
__LABEL_191:
__LABEL_183:
__LABEL_175:
__LABEL_167:
__LABEL_159:
__LABEL_151:
__LABEL_143:
__LABEL_135:
__LABEL_127:
__LABEL_119:
__LABEL_111:
__LABEL_103:
__LABEL_95:
__LABEL_87:
__LABEL_79:
__LABEL_71:
__LABEL_63:
  closecapture 0 0
  ret
-- Rule
END:
  call __prefix
  catch __LABEL_316  -- 1
  any
  failtwice
__LABEL_316:
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
  char 62
  char 61
  char 63
  char 6b
  char 63
  char 6f
  char 6d
  char 6d
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
  char 63
  char 61
  char 6c
  char 6c
  closecapture 3 0
  call S
  call LABEL
  ret
-- Rule
CATCHINSTR:
  call __prefix
  opencapture 4
  char 63
  char 61
  char 74
  char 63
  char 68
  closecapture 4 0
  call S
  call LABEL
  ret
-- Rule
CHARINSTR:
  call __prefix
  opencapture 5
  char 63
  char 68
  char 61
  char 72
  closecapture 5 0
  call S
  call HEXBYTE
  ret
-- Rule
MASKEDCHARINSTR:
  call __prefix
  opencapture 6
  char 6d
  char 61
  char 73
  char 6b
  char 65
  char 64
  char 63
  char 68
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
  char 63
  char 6c
  char 6f
  char 73
  char 65
  char 63
  char 61
  char 70
  char 74
  char 75
  char 72
  char 65
  closecapture 7 0
  call S
  call SLOT
  catch __LABEL_493 -- 4
  call S
  call TYPE
  partialcommit __LABEL_494
__LABEL_494:
  commit __LABEL_493
__LABEL_493:
  ret
-- Rule
COMMITINSTR:
  call __prefix
  opencapture 8
  char 63
  char 6f
  char 6d
  char 6d
  char 69
  char 74
  closecapture 8 0
  call S
  call LABEL
  ret
-- Rule
ENDINSTR:
  call __prefix
  opencapture 9
  char 65
  char 6e
  char 64
  closecapture 9 0
  catch __LABEL_547 -- 4
  call S
  call CODE
  partialcommit __LABEL_548
__LABEL_548:
  commit __LABEL_547
__LABEL_547:
  ret
-- Rule
FAILINSTR:
  call __prefix
  opencapture 10
  char 66
  char 61
  char 69
  char 6c
  closecapture 10 0
  ret
-- Rule
FAILTWICEINSTR:
  call __prefix
  opencapture 11
  char 66
  char 61
  char 69
  char 6c
  char 74
  char 77
  char 69
  char 63
  char 65
  closecapture 11 0
  ret
-- Rule
JUMPINSTR:
  call __prefix
  opencapture 12
  char 6a
  char 75
  char 6d
  char 70
  closecapture 12 0
  call S
  call LABEL
  ret
-- Rule
NOOPINSTR:
  call __prefix
  opencapture 13
  char 6e
  char 6f
  char 6f
  char 70
  closecapture 13 0
  ret
-- Rule
TRAPINSTR:
  call __prefix
  opencapture 14
  char 74
  char 72
  char 61
  char 70
  closecapture 14 0
  ret
-- Rule
OPENCAPTUREINSTR:
  call __prefix
  opencapture 15
  char 6f
  char 70
  char 65
  char 6e
  char 63
  char 61
  char 70
  char 74
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
  char 70
  char 61
  char 72
  char 74
  char 69
  char 61
  char 6c
  char 63
  char 6f
  char 6d
  char 6d
  char 69
  char 74
  closecapture 16 0
  call S
  call LABEL
  ret
-- Rule
QUADINSTR:
  call __prefix
  opencapture 17
  char 71
  char 75
  char 61
  char 64
  closecapture 17 0
  call S
  call QUAD
  ret
-- Rule
REPLACEINSTR:
  call __prefix
  opencapture 18
  char 72
  char 65
  char 70
  char 6c
  char 61
  char 63
  char 65
  closecapture 18 0
  call S
  call LABEL
  ret
-- Rule
REPLACESTRINGINSTR:
  call __prefix
  opencapture 19
  char 72
  char 65
  char 70
  char 6c
  char 61
  char 63
  char 65
  char 73
  char 74
  char 72
  char 69
  char 6e
  char 67
  closecapture 19 0
  call S
  call STRING
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
  char 72
  char 61
  char 6e
  char 67
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
  char 73
  char 6b
  char 69
  char 70
  closecapture 23 0
  call S
  call NUMBER
  ret
-- Rule
SPANINSTR:
  call __prefix
  opencapture 24
  char 73
  char 70
  char 61
  char 6e
  closecapture 24 0
  call S
  call SET
  ret
-- Rule
TESTANYINSTR:
  call __prefix
  opencapture 25
  char 74
  char 65
  char 73
  char 74
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
  char 74
  char 65
  char 73
  char 74
  char 63
  char 68
  char 61
  char 72
  closecapture 26 0
  call S
  call HEXBYTE
  call S
  call LABEL
  catch __LABEL_937 -- 4
  call S
  call AMPERSAND
  call HEXBYTE
  partialcommit __LABEL_938
__LABEL_938:
  commit __LABEL_937
__LABEL_937:
  ret
-- Rule
TESTQUADINSTR:
  call __prefix
  opencapture 27
  char 74
  char 65
  char 73
  char 74
  char 71
  char 75
  char 61
  char 64
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
  char 74
  char 65
  char 73
  char 74
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
  char 63
  char 6f
  char 75
  char 6e
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
  char 63
  char 6f
  char 6e
  char 64
  char 6a
  char 75
  char 6d
  char 70
  closecapture 31 0
  call S
  call REGISTER
  call S
  call LABEL
  ret
-- Rule
LABELDEF:
  call __prefix
  opencapture 32
  call LABEL
  closecapture 32 0
  call COLON
  ret
-- Rule
CODE:
  call __prefix
  call NUMBER
  ret
-- Rule
HEXBYTE:
  call __prefix
  opencapture 33
  counter 0 2
__LABEL_1158:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __LABEL_1158
  closecapture 33 0
  ret
-- Rule
LABEL:
  call __prefix
  opencapture 34
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  catch __LABEL_1171 -- 3
  counter 0 63
__LABEL_1172:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __LABEL_1173
__LABEL_1173:
  condjump 0 __LABEL_1172
  commit __LABEL_1171
__LABEL_1171:
  closecapture 34 0
  ret
-- Rule
NUMBER:
  call __prefix
  opencapture 35
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __LABEL_1184 -- 2
__LABEL_1183:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __LABEL_1183
__LABEL_1184:
  closecapture 35 0
  ret
-- Rule
QUAD:
  call __prefix
  opencapture 36
  counter 0 8
__LABEL_1194:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __LABEL_1194
  closecapture 36 0
  ret
-- Rule
SET:
  call __prefix
  opencapture 37
  counter 0 64
__LABEL_1206:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __LABEL_1206
  closecapture 37 0
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
STRING:
  call __prefix
  opencapture 38
  char 27
  catch __LABEL_1256 -- 2
__LABEL_1255:
  catch __LABEL_1258 -- terms or expression
  char 5c
  any
  commit __LABEL_1259
__LABEL_1258:
  set ffffffff7fffffffffffffffffffffffffffffffffffffffffffffffffffffff
__LABEL_1259:
  partialcommit __LABEL_1255
__LABEL_1256:
  char 27
  closecapture 38 0
  ret

  end 0

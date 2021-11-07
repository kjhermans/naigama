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
  catch __RIGHTHAND_56
  opencapture 0
  call RULEINSTR
  closecapture 0 0
  commit __LEFTHAND_57
__RIGHTHAND_56:
  catch __RIGHTHAND_70
  opencapture 1
  call SCR_INSTRUCTION
  closecapture 1 0
  commit __LEFTHAND_71
__RIGHTHAND_70:
  opencapture 2
  call LABELDEF
  closecapture 2 0
__LEFTHAND_71:
__LEFTHAND_57:
  ret
-- Rule
RULEINSTR:
  call __prefix
  catch __RIGHTHAND_96
  call ANYINSTR
  commit __LEFTHAND_97
__RIGHTHAND_96:
  catch __RIGHTHAND_104
  call BACKCOMMITINSTR
  commit __LEFTHAND_105
__RIGHTHAND_104:
  catch __RIGHTHAND_112
  call CALLINSTR
  commit __LEFTHAND_113
__RIGHTHAND_112:
  catch __RIGHTHAND_120
  call CATCHINSTR
  commit __LEFTHAND_121
__RIGHTHAND_120:
  catch __RIGHTHAND_128
  call CHARINSTR
  commit __LEFTHAND_129
__RIGHTHAND_128:
  catch __RIGHTHAND_136
  call MASKEDCHARINSTR
  commit __LEFTHAND_137
__RIGHTHAND_136:
  catch __RIGHTHAND_144
  call CLOSECAPTUREINSTR
  commit __LEFTHAND_145
__RIGHTHAND_144:
  catch __RIGHTHAND_152
  call COMMITINSTR
  commit __LEFTHAND_153
__RIGHTHAND_152:
  catch __RIGHTHAND_160
  call ENDREPLACEINSTR
  commit __LEFTHAND_161
__RIGHTHAND_160:
  catch __RIGHTHAND_168
  call REPLACEINSTR
  commit __LEFTHAND_169
__RIGHTHAND_168:
  catch __RIGHTHAND_176
  call INTRPCAPTUREINSTR
  commit __LEFTHAND_177
__RIGHTHAND_176:
  catch __RIGHTHAND_184
  call ISOLATEINSTR
  commit __LEFTHAND_185
__RIGHTHAND_184:
  catch __RIGHTHAND_192
  call ENDISOLATEINSTR
  commit __LEFTHAND_193
__RIGHTHAND_192:
  catch __RIGHTHAND_200
  call ENDINSTR
  commit __LEFTHAND_201
__RIGHTHAND_200:
  catch __RIGHTHAND_208
  call FAILTWICEINSTR
  commit __LEFTHAND_209
__RIGHTHAND_208:
  catch __RIGHTHAND_216
  call FAILINSTR
  commit __LEFTHAND_217
__RIGHTHAND_216:
  catch __RIGHTHAND_224
  call JUMPINSTR
  commit __LEFTHAND_225
__RIGHTHAND_224:
  catch __RIGHTHAND_232
  call NOOPINSTR
  commit __LEFTHAND_233
__RIGHTHAND_232:
  catch __RIGHTHAND_240
  call TRAPINSTR
  commit __LEFTHAND_241
__RIGHTHAND_240:
  catch __RIGHTHAND_248
  call OPENCAPTUREINSTR
  commit __LEFTHAND_249
__RIGHTHAND_248:
  catch __RIGHTHAND_256
  call PARTIALCOMMITINSTR
  commit __LEFTHAND_257
__RIGHTHAND_256:
  catch __RIGHTHAND_264
  call QUADINSTR
  commit __LEFTHAND_265
__RIGHTHAND_264:
  catch __RIGHTHAND_272
  call RETINSTR
  commit __LEFTHAND_273
__RIGHTHAND_272:
  catch __RIGHTHAND_280
  call SETINSTR
  commit __LEFTHAND_281
__RIGHTHAND_280:
  catch __RIGHTHAND_288
  call RANGEINSTR
  commit __LEFTHAND_289
__RIGHTHAND_288:
  catch __RIGHTHAND_296
  call SKIPINSTR
  commit __LEFTHAND_297
__RIGHTHAND_296:
  catch __RIGHTHAND_304
  call SPANINSTR
  commit __LEFTHAND_305
__RIGHTHAND_304:
  catch __RIGHTHAND_312
  call TESTANYINSTR
  commit __LEFTHAND_313
__RIGHTHAND_312:
  catch __RIGHTHAND_320
  call TESTCHARINSTR
  commit __LEFTHAND_321
__RIGHTHAND_320:
  catch __RIGHTHAND_328
  call TESTQUADINSTR
  commit __LEFTHAND_329
__RIGHTHAND_328:
  catch __RIGHTHAND_336
  call TESTSETINSTR
  commit __LEFTHAND_337
__RIGHTHAND_336:
  catch __RIGHTHAND_344
  call VARINSTR
  commit __LEFTHAND_345
__RIGHTHAND_344:
  catch __RIGHTHAND_352
  call COUNTERINSTR
  commit __LEFTHAND_353
__RIGHTHAND_352:
  catch __RIGHTHAND_360
  call CONDJUMPINSTR
  commit __LEFTHAND_361
__RIGHTHAND_360:
  call MODEINSTR
__LEFTHAND_361:
__LEFTHAND_353:
__LEFTHAND_345:
__LEFTHAND_337:
__LEFTHAND_329:
__LEFTHAND_321:
__LEFTHAND_313:
__LEFTHAND_305:
__LEFTHAND_297:
__LEFTHAND_289:
__LEFTHAND_281:
__LEFTHAND_273:
__LEFTHAND_265:
__LEFTHAND_257:
__LEFTHAND_249:
__LEFTHAND_241:
__LEFTHAND_233:
__LEFTHAND_225:
__LEFTHAND_217:
__LEFTHAND_209:
__LEFTHAND_201:
__LEFTHAND_193:
__LEFTHAND_185:
__LEFTHAND_177:
__LEFTHAND_169:
__LEFTHAND_161:
__LEFTHAND_153:
__LEFTHAND_145:
__LEFTHAND_137:
__LEFTHAND_129:
__LEFTHAND_121:
__LEFTHAND_113:
__LEFTHAND_105:
__LEFTHAND_97:
  ret
-- Rule
END:
  call __prefix
  catch __TERM_374
  any
  failtwice
__TERM_374:
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
  catch __RIGHTHAND_656
  call SLOT
  commit __LEFTHAND_657
__RIGHTHAND_656:
  opencapture 15
  quad 64656661
  char 75
  char 6c
  char 74
  closecapture 15 0
__LEFTHAND_657:
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
  call LABEL
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
SCR_INSTRUCTION:
  call __prefix
  catch __RIGHTHAND_1264
  call SCR_CALL
  commit __LEFTHAND_1265
__RIGHTHAND_1264:
  catch __RIGHTHAND_1272
  call SCR_BUILTIN
  commit __LEFTHAND_1273
__RIGHTHAND_1272:
  catch __RIGHTHAND_1280
  call SCR_RET
  commit __LEFTHAND_1281
__RIGHTHAND_1280:
  catch __RIGHTHAND_1288
  call SCR_CONDJUMP
  commit __LEFTHAND_1289
__RIGHTHAND_1288:
  catch __RIGHTHAND_1296
  call SCR_SHIFT
  commit __LEFTHAND_1297
__RIGHTHAND_1296:
  catch __RIGHTHAND_1304
  call SCR_PUSH
  commit __LEFTHAND_1305
__RIGHTHAND_1304:
  catch __RIGHTHAND_1312
  call SCR_POP
  commit __LEFTHAND_1313
__RIGHTHAND_1312:
  catch __RIGHTHAND_1320
  call SCR_ARRAY
  commit __LEFTHAND_1321
__RIGHTHAND_1320:
  catch __RIGHTHAND_1328
  call SCR_INDEX
  commit __LEFTHAND_1329
__RIGHTHAND_1328:
  catch __RIGHTHAND_1336
  call SCR_ADD
  commit __LEFTHAND_1337
__RIGHTHAND_1336:
  catch __RIGHTHAND_1344
  call SCR_MUL
  commit __LEFTHAND_1345
__RIGHTHAND_1344:
  catch __RIGHTHAND_1352
  call SCR_LT
  commit __LEFTHAND_1353
__RIGHTHAND_1352:
  catch __RIGHTHAND_1360
  call SCR_EQUALS
  commit __LEFTHAND_1361
__RIGHTHAND_1360:
  catch __RIGHTHAND_1368
  call SCR_ASSIGN
  commit __LEFTHAND_1369
__RIGHTHAND_1368:
  call SCR_STRING
__LEFTHAND_1369:
__LEFTHAND_1361:
__LEFTHAND_1353:
__LEFTHAND_1345:
__LEFTHAND_1337:
__LEFTHAND_1329:
__LEFTHAND_1321:
__LEFTHAND_1313:
__LEFTHAND_1305:
__LEFTHAND_1297:
__LEFTHAND_1289:
__LEFTHAND_1281:
__LEFTHAND_1273:
__LEFTHAND_1265:
  ret
-- Rule
SCR_ADD:
  call __prefix
  opencapture 39
  quad 7363725f
  char 61
  char 64
  char 64
  closecapture 39 0
  ret
-- Rule
SCR_CALL:
  call __prefix
  opencapture 40
  quad 7363725f
  quad 63616c6c
  closecapture 40 0
  call S
  call LABEL
  ret
-- Rule
SCR_SHIFT:
  call __prefix
  opencapture 41
  quad 7363725f
  quad 73686966
  char 74
  closecapture 41 0
  call S
  call UNSIGNED
  ret
-- Rule
SCR_PUSH:
  call __prefix
  opencapture 42
  quad 7363725f
  quad 70757368
  closecapture 42 0
  call S
  call LITERAL
  ret
-- Rule
SCR_POP:
  call __prefix
  opencapture 43
  quad 7363725f
  char 70
  char 6f
  char 70
  closecapture 43 0
  ret
-- Rule
SCR_RET:
  call __prefix
  opencapture 44
  quad 7363725f
  char 72
  char 65
  char 74
  closecapture 44 0
  ret
-- Rule
SCR_CONDJUMP:
  call __prefix
  opencapture 45
  quad 7363725f
  quad 636f6e64
  quad 6a756d70
  closecapture 45 0
  call S
  call LABEL
  ret
-- Rule
SCR_BUILTIN:
  call __prefix
  opencapture 46
  quad 7363725f
  quad 6275696c
  char 74
  char 69
  char 6e
  closecapture 46 0
  call S
  call UNSIGNED
  ret
-- Rule
SCR_STRING:
  call __prefix
  opencapture 47
  quad 7363725f
  quad 73747269
  char 6e
  char 67
  closecapture 47 0
  call S
  call STRINGLITERAL
  ret
-- Rule
SCR_ARRAY:
  call __prefix
  opencapture 48
  quad 7363725f
  quad 61727261
  char 79
  closecapture 48 0
  call S
  call UNSIGNED
  ret
-- Rule
SCR_INDEX:
  call __prefix
  opencapture 49
  quad 7363725f
  quad 696e6465
  char 78
  closecapture 49 0
  ret
-- Rule
SCR_MUL:
  call __prefix
  opencapture 50
  quad 7363725f
  char 6d
  char 75
  char 6c
  closecapture 50 0
  ret
-- Rule
SCR_ASSIGN:
  call __prefix
  opencapture 51
  quad 7363725f
  quad 61737369
  char 67
  char 6e
  closecapture 51 0
  ret
-- Rule
SCR_EQUALS:
  call __prefix
  opencapture 52
  quad 7363725f
  quad 65717561
  char 6c
  char 73
  closecapture 52 0
  ret
-- Rule
SCR_LT:
  call __prefix
  opencapture 53
  quad 7363725f
  char 6c
  char 74
  closecapture 53 0
  ret
-- Rule
CODE:
  call __prefix
  call UNSIGNED
  ret
-- Rule
HEXBYTE:
  call __prefix
  opencapture 54
  counter 0 2
__TERM_1660:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1660
  closecapture 54 0
  ret
-- Rule
LABEL:
  call __prefix
  opencapture 55
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  catch __TERM_1673
  counter 0 63
__TERM_1674:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1675
__TERM_1675:
  condjump 0 __TERM_1674
  commit __TERM_1673
__TERM_1673:
  closecapture 55 0
  ret
-- Rule
UNSIGNED:
  call __prefix
  opencapture 56
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1686
__TERM_1685:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1685
__TERM_1686:
  closecapture 56 0
  ret
-- Rule
NUMBER:
  call __prefix
  opencapture 57
  catch __TERM_1697
  char 2d
  commit __TERM_1697
__TERM_1697:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1704
__TERM_1703:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1703
__TERM_1704:
  closecapture 57 0
  ret
-- Rule
QUAD:
  call __prefix
  opencapture 58
  counter 0 8
__TERM_1714:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1714
  closecapture 58 0
  ret
-- Rule
SET:
  call __prefix
  opencapture 59
  counter 0 64
__TERM_1726:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1726
  closecapture 59 0
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
LITERAL:
  call __prefix
  catch __RIGHTHAND_1760
  call REGISTERREF
  commit __LEFTHAND_1761
__RIGHTHAND_1760:
  catch __RIGHTHAND_1768
  call STRINGREF
  commit __LEFTHAND_1769
__RIGHTHAND_1768:
  catch __RIGHTHAND_1776
  call FLOATLITERAL
  commit __LEFTHAND_1777
__RIGHTHAND_1776:
  catch __RIGHTHAND_1784
  call INTLITERAL
  commit __LEFTHAND_1785
__RIGHTHAND_1784:
  catch __RIGHTHAND_1792
  call BOOLEANLITERAL
  commit __LEFTHAND_1793
__RIGHTHAND_1792:
  catch __RIGHTHAND_1800
  call VOIDLITERAL
  commit __LEFTHAND_1801
__RIGHTHAND_1800:
  call CAPTURELITERAL
__LEFTHAND_1801:
__LEFTHAND_1793:
__LEFTHAND_1785:
__LEFTHAND_1777:
__LEFTHAND_1769:
__LEFTHAND_1761:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 60
  catch __TERM_1830
__TERM_1829:
  catch __RIGHTHAND_1832
  char 5c
  catch __RIGHTHAND_1846
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1847
__RIGHTHAND_1846:
  counter 0 3
__TERM_1856:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1856
__LEFTHAND_1847:
  commit __LEFTHAND_1833
__RIGHTHAND_1832:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1833:
  partialcommit __TERM_1829
__TERM_1830:
  closecapture 60 0
  char 27
  ret
-- Rule
REGISTERREF:
  call __prefix
  char 7b
  catch __TERM_1881
  call S
  commit __TERM_1881
__TERM_1881:
  opencapture 61
  call NUMBER
  closecapture 61 0
  catch __TERM_1899
  call S
  commit __TERM_1899
__TERM_1899:
  char 7d
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 62
  catch __TERM_1917
  char 2d
  commit __TERM_1917
__TERM_1917:
  catch __TERM_1924
__TERM_1923:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1923
__TERM_1924:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1936
__TERM_1935:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1935
__TERM_1936:
  closecapture 62 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 63
  catch __TERM_1947
  char 2d
  commit __TERM_1947
__TERM_1947:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1954
__TERM_1953:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1953
__TERM_1954:
  closecapture 63 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 64
  catch __RIGHTHAND_1962
  quad 74727565
  commit __LEFTHAND_1963
__RIGHTHAND_1962:
  quad 66616c73
  char 65
__LEFTHAND_1963:
  closecapture 64 0
  ret
-- Rule
VOIDLITERAL:
  call __prefix
  opencapture 65
  quad 766f6964
  closecapture 65 0
  ret
-- Rule
STRINGREF:
  call __prefix
  opencapture 66
  quad 73747269
  char 6e
  char 67
  call S
  call LABEL
  closecapture 66 0
  ret
-- Rule
CAPTURELITERAL:
  call __prefix
  opencapture 67
  quad 63617074
  char 75
  char 72
  char 65
  call S
  call UNSIGNED
  closecapture 67 0
  ret
-- Rule
INTRPCAPTURETYPES:
  call __prefix
  opencapture 68
  quad 7275696e
  char 74
  char 33
  char 32
  closecapture 68 0
  ret

  end 0

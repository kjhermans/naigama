--
-- Naigama compiler library; gen 3; release 0.4.11
-- At Fri, 29 Dec 2023 18:04:02 +0100
--

  call GRAMMAR
  end 0

GRAMMAR:
  opencapture 0
  catch __ALT_3
  call DEFINITION
  catch __FORGIVE_4
__FOREVER_5:
  call DEFINITION
  partialcommit __FOREVER_5
__FORGIVE_4:
  commit __SUCCESS_2
__ALT_3:
  call SINGLE_EXPRESSION
__SUCCESS_2:
  call END
__SUCCESS_1:
  closecapture 0
  ret -- GRAMMAR

S:
  opencapture 1
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __FORGIVE_7
__FOREVER_8:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_8
__FORGIVE_7:
__SUCCESS_6:
  closecapture 1
  ret -- S

MULTILINECOMMENT:
  opencapture 2
  char 2d
  char 2d
  char 5b
  char 5b
  catch __FORGIVE_10
__FOREVER_11:
  catch __SCANNER_13
  char 5d
  char 5d
  failtwice
__SCANNER_13:
  any
__SUCCESS_12:
  partialcommit __FOREVER_11
__FORGIVE_10:
  char 5d
  char 5d
__SUCCESS_9:
  closecapture 2
  ret -- MULTILINECOMMENT

COMMENT:
  opencapture 3
  char 2d
  char 2d
  catch __FORGIVE_15
__FOREVER_16:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __FOREVER_16
__FORGIVE_15:
  char 0a
__SUCCESS_14:
  closecapture 3
  ret -- COMMENT

__prefix:
  opencapture 4
  catch __FORGIVE_18
__FOREVER_19:
  catch __ALT_21
  call MULTILINECOMMENT
  commit __SUCCESS_20
__ALT_21:
  catch __ALT_22
  call COMMENT
  commit __SUCCESS_20
__ALT_22:
  call S
__SUCCESS_20:
  partialcommit __FOREVER_19
__FORGIVE_18:
__SUCCESS_17:
  closecapture 4
  ret -- __prefix

END:
  call __prefix
  opencapture 5
  catch __SCANNER_24
  any
  failtwice
__SCANNER_24:
__SUCCESS_23:
  closecapture 5
  ret -- END

DEFINITION:
  call __prefix
  opencapture 6
  catch __ALT_26
  call RULE
  commit __SUCCESS_25
__ALT_26:
  call IMPORTDECL
__SUCCESS_25:
  closecapture 6
  ret -- DEFINITION

SINGLE_EXPRESSION:
  call __prefix
  opencapture 7
  call EXPRESSION
__SUCCESS_27:
  closecapture 7
  ret -- SINGLE_EXPRESSION

RULE:
  call __prefix
  opencapture 8
  call IDENT
  call LEFTARROW
  call EXPRESSION
__SUCCESS_28:
  closecapture 8
  ret -- RULE

EXPRESSION:
  call __prefix
  opencapture 9
  catch __ALT_30
  call ALTERNATIVES
  commit __SUCCESS_29
__ALT_30:
  call TERMS
__SUCCESS_29:
  closecapture 9
  ret -- EXPRESSION

ALTERNATIVES:
  call __prefix
  opencapture 10
  call TERMS
  call OR
  call EXPRESSION
__SUCCESS_31:
  closecapture 10
  ret -- ALTERNATIVES

TERMS:
  call __prefix
  opencapture 11
  call TERM
  catch __FORGIVE_33
__FOREVER_34:
  call TERM
  partialcommit __FOREVER_34
__FORGIVE_33:
__SUCCESS_32:
  closecapture 11
  ret -- TERMS

TERM:
  call __prefix
  opencapture 12
  catch __ALT_36
  call SCANMATCHER
  commit __SUCCESS_35
__ALT_36:
  call QUANTIFIEDMATCHER
__SUCCESS_35:
  closecapture 12
  ret -- TERM

SCANMATCHER:
  call __prefix
  opencapture 13
  catch __ALT_39
  call NOT
  commit __SUCCESS_38
__ALT_39:
  call AND
__SUCCESS_38:
  call MATCHER
__SUCCESS_37:
  closecapture 13
  ret -- SCANMATCHER

QUANTIFIEDMATCHER:
  call __prefix
  opencapture 14
  call MATCHER
  catch __FORGIVE_41
  call QUANTIFIER
  commit __NEXT__
__FORGIVE_41:
__SUCCESS_40:
  closecapture 14
  ret -- QUANTIFIEDMATCHER

QUANTIFIER:
  call __prefix
  opencapture 15
  catch __ALT_44
  call Q_ZEROORONE
  commit __SUCCESS_43
__ALT_44:
  catch __ALT_45
  call Q_ONEORMORE
  commit __SUCCESS_43
__ALT_45:
  catch __ALT_46
  call Q_ZEROORMORE
  commit __SUCCESS_43
__ALT_46:
  catch __ALT_47
  call Q_FROMTO
  commit __SUCCESS_43
__ALT_47:
  catch __ALT_48
  call Q_UNTIL
  commit __SUCCESS_43
__ALT_48:
  catch __ALT_49
  call Q_FROM
  commit __SUCCESS_43
__ALT_49:
  catch __ALT_50
  call Q_SPECIFIC
  commit __SUCCESS_43
__ALT_50:
  call Q_VAR
__SUCCESS_43:
  closecapture 15
  ret -- QUANTIFIER

Q_ZEROORONE:
  call __prefix
  opencapture 16
  char 3f
__SUCCESS_51:
  closecapture 16
  ret -- Q_ZEROORONE

Q_ONEORMORE:
  call __prefix
  opencapture 17
  char 2b
__SUCCESS_52:
  closecapture 17
  ret -- Q_ONEORMORE

Q_ZEROORMORE:
  call __prefix
  opencapture 18
  char 2a
__SUCCESS_53:
  closecapture 18
  ret -- Q_ZEROORMORE

Q_FROMTO:
  call __prefix
  opencapture 19
  char 5e
  opencapture 20
  range 48 57
  catch __FORGIVE_56
__FOREVER_57:
  range 48 57
  partialcommit __FOREVER_57
__FORGIVE_56:
__SUCCESS_55:
  closecapture 20
  char 2d
  opencapture 21
  range 48 57
  catch __FORGIVE_59
__FOREVER_60:
  range 48 57
  partialcommit __FOREVER_60
__FORGIVE_59:
__SUCCESS_58:
  closecapture 21
__SUCCESS_54:
  closecapture 19
  ret -- Q_FROMTO

Q_UNTIL:
  call __prefix
  opencapture 22
  char 5e
  char 2d
  opencapture 23
  range 48 57
  catch __FORGIVE_63
__FOREVER_64:
  range 48 57
  partialcommit __FOREVER_64
__FORGIVE_63:
__SUCCESS_62:
  closecapture 23
__SUCCESS_61:
  closecapture 22
  ret -- Q_UNTIL

Q_FROM:
  call __prefix
  opencapture 24
  char 5e
  opencapture 25
  range 48 57
  catch __FORGIVE_67
__FOREVER_68:
  range 48 57
  partialcommit __FOREVER_68
__FORGIVE_67:
__SUCCESS_66:
  closecapture 25
  char 2d
__SUCCESS_65:
  closecapture 24
  ret -- Q_FROM

Q_SPECIFIC:
  call __prefix
  opencapture 26
  char 5e
  opencapture 27
  range 48 57
  catch __FORGIVE_71
__FOREVER_72:
  range 48 57
  partialcommit __FOREVER_72
__FORGIVE_71:
__SUCCESS_70:
  closecapture 27
__SUCCESS_69:
  closecapture 26
  ret -- Q_SPECIFIC

Q_VAR:
  call __prefix
  opencapture 28
  char 5e
  call BOPEN
  call VARREFERENCE
  call BCLOSE
__SUCCESS_73:
  closecapture 28
  ret -- Q_VAR

MATCHER:
  call __prefix
  opencapture 29
  catch __ALT_75
  call ANY
  commit __SUCCESS_74
__ALT_75:
  catch __ALT_76
  call SET
  commit __SUCCESS_74
__ALT_76:
  catch __ALT_77
  call STRING
  commit __SUCCESS_74
__ALT_77:
  catch __ALT_78
  call BITMASK
  commit __SUCCESS_74
__ALT_78:
  catch __ALT_79
  call HEXLITERAL
  commit __SUCCESS_74
__ALT_79:
  catch __ALT_80
  call VARCAPTURE
  commit __SUCCESS_74
__ALT_80:
  catch __ALT_81
  call CAPTURE
  commit __SUCCESS_74
__ALT_81:
  catch __ALT_82
  call GROUP
  commit __SUCCESS_74
__ALT_82:
  catch __ALT_83
  call MACRO
  commit __SUCCESS_74
__ALT_83:
  catch __ALT_84
  call ENDFORCE
  commit __SUCCESS_74
__ALT_84:
  catch __ALT_85
  call VARREFERENCE
  commit __SUCCESS_74
__ALT_85:
  catch __ALT_86
  call REFERENCE
  commit __SUCCESS_74
__ALT_86:
  call LIMITEDCALL
__SUCCESS_74:
  closecapture 29
  ret -- MATCHER

BITMASK:
  call __prefix
  opencapture 30
  char 7c
  counter 0 2
__COUNTER_90:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __COUNTER_90
  char 7c
  counter 1 2
__COUNTER_93:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 1 __COUNTER_93
  char 7c
__SUCCESS_87:
  closecapture 30
  ret -- BITMASK

VARCAPTURE:
  call __prefix
  opencapture 31
  call CBOPEN
  call COLON
  call IDENT
  catch __FORGIVE_95
  call CAPTURETYPE
  commit __NEXT__
__FORGIVE_95:
  call COLON
  call EXPRESSION
  call CBCLOSE
  call CAPTUREEND
__SUCCESS_94:
  closecapture 31
  ret -- VARCAPTURE

CAPTURETYPE:
  call __prefix
  opencapture 32
  call SEMICOLON
  call TYPE
__SUCCESS_97:
  closecapture 32
  ret -- CAPTURETYPE

TYPE:
  call __prefix
  opencapture 33
  catch __ALT_99
  char 75
  char 69
  char 6e
  char 74
  char 33
  char 32
  commit __SUCCESS_98
__ALT_99:
  char 69
  char 6e
  char 74
  char 33
  char 32
__SUCCESS_98:
  closecapture 33
  ret -- TYPE

CAPTURE:
  call __prefix
  opencapture 34
  call CBOPEN
  call EXPRESSION
  call CBCLOSE
  call CAPTUREEND
__SUCCESS_100:
  closecapture 34
  ret -- CAPTURE

GROUP:
  call __prefix
  opencapture 35
  call BOPEN
  call EXPRESSION
  call BCLOSE
__SUCCESS_101:
  closecapture 35
  ret -- GROUP

CAPTUREEND:
  call __prefix
  opencapture 36
  catch __FORGIVE_103
  catch __ALT_106
  call REPLACE
  commit __SUCCESS_105
__ALT_106:
  call RECYCLE
__SUCCESS_105:
  commit __NEXT__
__FORGIVE_103:
__SUCCESS_102:
  closecapture 36
  ret -- CAPTUREEND

SET:
  call __prefix
  opencapture 37
  call ABOPEN
  catch __FORGIVE_108
  call SETNOT
  commit __NEXT__
__FORGIVE_108:
  catch __ALT_113
  opencapture 38
  catch __ALT_115
  char 5c
  catch __ALT_117
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_116
__ALT_117:
  counter 2 3
__COUNTER_120:
  range 48 57
  condjump 2 __COUNTER_120
__SUCCESS_116:
  commit __SUCCESS_114
__ALT_115:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_114:
  closecapture 38
  char 2d
  opencapture 39
  catch __ALT_122
  char 5c
  catch __ALT_124
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_123
__ALT_124:
  counter 3 3
__COUNTER_127:
  range 48 57
  condjump 3 __COUNTER_127
__SUCCESS_123:
  commit __SUCCESS_121
__ALT_122:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_121:
  closecapture 39
  commit __SUCCESS_112
__ALT_113:
  opencapture 40
  catch __ALT_129
  char 5c
  catch __ALT_131
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_130
__ALT_131:
  counter 4 3
__COUNTER_134:
  range 48 57
  condjump 4 __COUNTER_134
__SUCCESS_130:
  commit __SUCCESS_128
__ALT_129:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_128:
  closecapture 40
__SUCCESS_112:
  catch __FORGIVE_110
__FOREVER_111:
  catch __ALT_136
  opencapture 38
  catch __ALT_138
  char 5c
  catch __ALT_140
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_139
__ALT_140:
  counter 5 3
__COUNTER_143:
  range 48 57
  condjump 5 __COUNTER_143
__SUCCESS_139:
  commit __SUCCESS_137
__ALT_138:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_137:
  closecapture 38
  char 2d
  opencapture 39
  catch __ALT_145
  char 5c
  catch __ALT_147
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_146
__ALT_147:
  counter 6 3
__COUNTER_150:
  range 48 57
  condjump 6 __COUNTER_150
__SUCCESS_146:
  commit __SUCCESS_144
__ALT_145:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_144:
  closecapture 39
  commit __SUCCESS_135
__ALT_136:
  opencapture 40
  catch __ALT_152
  char 5c
  catch __ALT_154
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __SUCCESS_153
__ALT_154:
  counter 7 3
__COUNTER_157:
  range 48 57
  condjump 7 __COUNTER_157
__SUCCESS_153:
  commit __SUCCESS_151
__ALT_152:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__SUCCESS_151:
  closecapture 40
__SUCCESS_135:
  partialcommit __FOREVER_111
__FORGIVE_110:
  call ABCLOSE
__SUCCESS_107:
  closecapture 37
  ret -- SET

VARREFERENCE:
  call __prefix
  opencapture 41
  char 24
  catch __ALT_160
  call IDENT
  commit __SUCCESS_159
__ALT_160:
  call NUMBER
__SUCCESS_159:
  catch __FORGIVE_161
  call MASK
  commit __NEXT__
__FORGIVE_161:
__SUCCESS_158:
  closecapture 41
  ret -- VARREFERENCE

MASK:
  call __prefix
  opencapture 42
  char 7c
  opencapture 43
  counter 8 2
__COUNTER_167:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 8 __COUNTER_167
__SUCCESS_164:
  closecapture 43
__SUCCESS_163:
  closecapture 42
  ret -- MASK

REFERENCE:
  call __prefix
  opencapture 44
  catch __SCANNER_169
  call KW_IMPORT
__SUCCESS_170:
  failtwice
__SCANNER_169:
  call IDENT
  catch __SCANNER_171
  call LEFTARROW
  failtwice
__SCANNER_171:
__SUCCESS_168:
  closecapture 44
  ret -- REFERENCE

LIMITEDCALL:
  call __prefix
  opencapture 45
  char 3c
  char 3c
  catch __FORGIVE_173
__FOREVER_174:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_174
__FORGIVE_173:
  call LCMODES
  catch __FORGIVE_175
__FOREVER_176:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_176
__FORGIVE_175:
  char 3a
  catch __FORGIVE_177
__FOREVER_178:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_178
__FORGIVE_177:
  call LCPARAM
  catch __FORGIVE_179
__FOREVER_180:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_180
__FORGIVE_179:
  char 3a
  catch __FORGIVE_181
__FOREVER_182:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_182
__FORGIVE_181:
  call IDENT
  catch __FORGIVE_183
__FOREVER_184:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_184
__FORGIVE_183:
  char 3e
  char 3e
__SUCCESS_172:
  closecapture 45
  ret -- LIMITEDCALL

LCMODES:
  call __prefix
  opencapture 46
  char 72
  char 75
  char 69
  char 6e
  char 74
  char 33
  char 32
__SUCCESS_185:
  closecapture 46
  ret -- LCMODES

LCPARAM:
  call __prefix
  opencapture 47
  catch __FORGIVE_187
__FOREVER_188:
  set ffd1fffffefffffbffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __FOREVER_188
__FORGIVE_187:
__SUCCESS_186:
  closecapture 47
  ret -- LCPARAM

REPLACE:
  call __prefix
  opencapture 48
  call RIGHTARROW
  call REPLACETERMS
__SUCCESS_189:
  closecapture 48
  ret -- REPLACE

REPLACETERMS:
  call __prefix
  opencapture 49
  call REPLACETERM
  catch __FORGIVE_191
__FOREVER_192:
  call REPLACETERM
  partialcommit __FOREVER_192
__FORGIVE_191:
__SUCCESS_190:
  closecapture 49
  ret -- REPLACETERMS

REPLACETERM:
  call __prefix
  opencapture 50
  catch __ALT_194
  call STRINGLITERAL
  commit __SUCCESS_193
__ALT_194:
  catch __ALT_195
  call HEXLITERAL
  commit __SUCCESS_193
__ALT_195:
  call VARREFERENCE
__SUCCESS_193:
  closecapture 50
  ret -- REPLACETERM

RECYCLE:
  call __prefix
  opencapture 51
  call FATARROW
  call IDENT
__SUCCESS_196:
  closecapture 51
  ret -- RECYCLE

LEFTARROW:
  call __prefix
  opencapture 52
  char 3c
  char 2d
__SUCCESS_197:
  closecapture 52
  ret -- LEFTARROW

RIGHTARROW:
  call __prefix
  opencapture 53
  char 2d
  char 3e
__SUCCESS_198:
  closecapture 53
  ret -- RIGHTARROW

FATARROW:
  call __prefix
  opencapture 54
  char 3d
  char 3e
__SUCCESS_199:
  closecapture 54
  ret -- FATARROW

NOT:
  call __prefix
  opencapture 55
  char 21
__SUCCESS_200:
  closecapture 55
  ret -- NOT

AND:
  call __prefix
  opencapture 56
  char 26
__SUCCESS_201:
  closecapture 56
  ret -- AND

MACRO:
  call __prefix
  opencapture 57
  char 25
  set 0000000000000000feffff07feffff0700000000000000000000000000000000
  catch __FORGIVE_203
__FOREVER_204:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __FOREVER_204
__FORGIVE_203:
__SUCCESS_202:
  closecapture 57
  ret -- MACRO

ENDFORCE:
  call __prefix
  opencapture 58
  char 5f
  char 5f
  char 65
  char 6e
  char 64
  call S
  call NUMBER
__SUCCESS_205:
  closecapture 58
  ret -- ENDFORCE

HEXLITERAL:
  call __prefix
  opencapture 59
  char 30
  char 78
  counter 9 2
__COUNTER_209:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 9 __COUNTER_209
__SUCCESS_206:
  closecapture 59
  ret -- HEXLITERAL

NUMBER:
  call __prefix
  opencapture 60
  range 48 57
  catch __FORGIVE_211
__FOREVER_212:
  range 48 57
  partialcommit __FOREVER_212
__FORGIVE_211:
__SUCCESS_210:
  closecapture 60
  ret -- NUMBER

STRING:
  call __prefix
  opencapture 61
  call STRINGLITERAL
  catch __FORGIVE_214
  char 69
  commit __NEXT__
__FORGIVE_214:
__SUCCESS_213:
  closecapture 61
  ret -- STRING

OR:
  call __prefix
  opencapture 62
  char 2f
__SUCCESS_216:
  closecapture 62
  ret -- OR

ANY:
  call __prefix
  opencapture 63
  char 2e
__SUCCESS_217:
  closecapture 63
  ret -- ANY

SETNOT:
  call __prefix
  opencapture 64
  char 5e
__SUCCESS_218:
  closecapture 64
  ret -- SETNOT

IMPORTDECL:
  call __prefix
  opencapture 65
  call KW_IMPORT
  call STRINGLITERAL
  call OPTNAMESPACE
  call SEMICOLON
__SUCCESS_219:
  closecapture 65
  ret -- IMPORTDECL

KW_IMPORT:
  call __prefix
  opencapture 66
  char 69
  char 6d
  char 70
  char 6f
  char 72
  char 74
__SUCCESS_220:
  closecapture 66
  ret -- KW_IMPORT

OPTNAMESPACE:
  call __prefix
  opencapture 67
  catch __FORGIVE_222
  call KW_AS
  call IDENT
__SUCCESS_224:
  commit __NEXT__
__FORGIVE_222:
__SUCCESS_221:
  closecapture 67
  ret -- OPTNAMESPACE

KW_AS:
  call __prefix
  opencapture 68
  char 61
  char 73
__SUCCESS_225:
  closecapture 68
  ret -- KW_AS

STRINGLITERAL:
  call __prefix
  opencapture 69
  char 27
  opencapture 70
  catch __FORGIVE_228
__FOREVER_229:
  catch __ALT_231
  char 5c
  catch __ALT_233
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_232
__ALT_233:
  counter 10 3
__COUNTER_236:
  range 48 57
  condjump 10 __COUNTER_236
__SUCCESS_232:
  commit __SUCCESS_230
__ALT_231:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_230:
  partialcommit __FOREVER_229
__FORGIVE_228:
__SUCCESS_227:
  closecapture 70
  char 27
__SUCCESS_226:
  closecapture 69
  ret -- STRINGLITERAL

IDENT:
  call __prefix
  opencapture 71
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_238
  counter 11 63
__COUNTER_240:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __NEXT__
  condjump 11 __COUNTER_240
  commit __NEXT__
__FORGIVE_238:
__SUCCESS_237:
  closecapture 71
  ret -- IDENT

BOPEN:
  call __prefix
  opencapture 72
  char 28
__SUCCESS_241:
  closecapture 72
  ret -- BOPEN

BCLOSE:
  call __prefix
  opencapture 73
  char 29
__SUCCESS_242:
  closecapture 73
  ret -- BCLOSE

CBOPEN:
  call __prefix
  opencapture 74
  char 7b
__SUCCESS_243:
  closecapture 74
  ret -- CBOPEN

CBCLOSE:
  call __prefix
  opencapture 75
  char 7d
__SUCCESS_244:
  closecapture 75
  ret -- CBCLOSE

ABOPEN:
  call __prefix
  opencapture 76
  char 5b
__SUCCESS_245:
  closecapture 76
  ret -- ABOPEN

ABCLOSE:
  call __prefix
  opencapture 77
  char 5d
__SUCCESS_246:
  closecapture 77
  ret -- ABCLOSE

COLON:
  call __prefix
  opencapture 78
  char 3a
__SUCCESS_247:
  closecapture 78
  ret -- COLON

SEMICOLON:
  call __prefix
  opencapture 79
  char 3b
__SUCCESS_248:
  closecapture 79
  ret -- SEMICOLON

  end 0

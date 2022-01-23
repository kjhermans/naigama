--
-- Naigama compiler library; gen 3; release 0.3.3
-- At Sat, 22 Jan 2022 23:51:10 +0100
--

  call TOP
  end 0

__RULE_TOP:
  opencapture 0
  call SQL
  call __prefix
  catch __SCANNER_2
  any
  failtwice
__SCANNER_2:
__SUCCESS_1:
  closecapture 0
  ret -- TOP

__RULE___prefix:
  opencapture 1
  catch __FORGIVE_4
__FOREVER_5:
  catch __ALT_7
  char 2d
  char 2d
  catch __FORGIVE_8
__FOREVER_9:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __FOREVER_9
__FORGIVE_8:
  char 0a
  commit __SUCCESS_6
__ALT_7:
  counter 0 1
__COUNTER_12:
  set 002e000001000000000000000000000000000000000000000000000000000000
  condjump 0 __COUNTER_12
  catch __FORGIVE_10
__FOREVER_11:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_11
__FORGIVE_10:
__SUCCESS_6:
  partialcommit __FOREVER_5
__FORGIVE_4:
__SUCCESS_3:
  closecapture 1
  ret -- __prefix

__RULE_SQL:
  call __prefix
  opencapture 2
  counter 1 1
__COUNTER_16:
  call STMT
  condjump 1 __COUNTER_16
  catch __FORGIVE_14
__FOREVER_15:
  call STMT
  partialcommit __FOREVER_15
__FORGIVE_14:
__SUCCESS_13:
  closecapture 2
  ret -- SQL

__RULE_STMT:
  call __prefix
  opencapture 3
  catch __ALT_19
  call SELECT
  commit __SUCCESS_18
__ALT_19:
  catch __ALT_20
  call INSERT
  commit __SUCCESS_18
__ALT_20:
  catch __ALT_21
  call UPDATE
  commit __SUCCESS_18
__ALT_21:
  catch __ALT_22
  call DELETE
  commit __SUCCESS_18
__ALT_22:
  catch __ALT_23
  call CREATETABLE
  commit __SUCCESS_18
__ALT_23:
  catch __ALT_24
  call DROPTABLE
  commit __SUCCESS_18
__ALT_24:
  catch __ALT_25
  call CREATESEQUENCE
  commit __SUCCESS_18
__ALT_25:
  catch __ALT_26
  call DROPSEQUENCE
  commit __SUCCESS_18
__ALT_26:
  call GRANT
__SUCCESS_18:
  call SEMICOLON
__SUCCESS_17:
  closecapture 3
  ret -- STMT

__RULE_SELECT:
  call __prefix
  opencapture 4
  call KW_SELECT
  call SELECTFIELDLIST
  call KW_FROM
  call SET
  catch __FORGIVE_28
  call KW_WHERE
  call CONDITION
__SUCCESS_30:
  commit __NEXT__
__FORGIVE_28:
__SUCCESS_27:
  closecapture 4
  ret -- SELECT

__RULE_INSERT:
  call __prefix
  opencapture 5
  call KW_INSERT
  call KW_INTO
  call TABLENAME
  catch __FORGIVE_32
  call BOPEN
  call INSERTFIELDLIST
  call BCLOSE
  call KW_VALUES
__SUCCESS_34:
  commit __NEXT__
__FORGIVE_32:
  call BOPEN
  call INSERTVALUELIST
  call BCLOSE
__SUCCESS_31:
  closecapture 5
  ret -- INSERT

__RULE_UPDATE:
  call __prefix
  opencapture 6
  call KW_UPDATE
  call TABLENAME
  call KW_SET
  call UPDATEFIELDLIST
  catch __FORGIVE_36
  call KW_WHERE
  call CONDITION
__SUCCESS_38:
  commit __NEXT__
__FORGIVE_36:
__SUCCESS_35:
  closecapture 6
  ret -- UPDATE

__RULE_DELETE:
  call __prefix
  opencapture 7
  call KW_DELETE
  call KW_FROM
  call TABLENAME
  catch __FORGIVE_40
  call KW_WHERE
  call CONDITION
__SUCCESS_42:
  commit __NEXT__
__FORGIVE_40:
__SUCCESS_39:
  closecapture 7
  ret -- DELETE

__RULE_CREATETABLE:
  call __prefix
  opencapture 8
  call KW_CREATE
  call KW_TABLE
  call TABLENAME
  call BOPEN
  call CREATEFIELDLIST
  call BCLOSE
__SUCCESS_43:
  closecapture 8
  ret -- CREATETABLE

__RULE_DROPTABLE:
  call __prefix
  opencapture 9
  call KW_DROP
  call KW_TABLE
  call TABLENAME
__SUCCESS_44:
  closecapture 9
  ret -- DROPTABLE

__RULE_GRANT:
  call __prefix
  opencapture 10
  call KW_GRANT
  call PRIVLIST
  call KW_ON
  call KW_TABLE
  call TABLENAME
  call KW_TO
  call USERNAME
__SUCCESS_45:
  closecapture 10
  ret -- GRANT

__RULE_CREATESEQUENCE:
  call __prefix
  opencapture 11
  call KW_CREATE
  call KW_SEQUENCE
  call SEQNAME
__SUCCESS_46:
  closecapture 11
  ret -- CREATESEQUENCE

__RULE_DROPSEQUENCE:
  call __prefix
  opencapture 12
  call KW_DROP
  call KW_SEQUENCE
  call SEQNAME
__SUCCESS_47:
  closecapture 12
  ret -- DROPSEQUENCE

__RULE_SELECTFIELDLIST:
  call __prefix
  opencapture 13
  call SELECTFIELD
  catch __FORGIVE_49
__FOREVER_50:
  call COMMA
  call SELECTFIELD
__SUCCESS_51:
  partialcommit __FOREVER_50
__FORGIVE_49:
__SUCCESS_48:
  closecapture 13
  ret -- SELECTFIELDLIST

__RULE_SELECTFIELD:
  call __prefix
  opencapture 14
  catch __ALT_53
  call STAR
  commit __SUCCESS_52
__ALT_53:
  catch __ALT_54
  call FIELDNAME
  call KW_AS
  call IDENT
  commit __SUCCESS_52
__ALT_54:
  call FIELDNAME
__SUCCESS_52:
  closecapture 14
  ret -- SELECTFIELD

__RULE_INSERTFIELDLIST:
  call __prefix
  opencapture 15
  call INSERTFIELD
  catch __FORGIVE_56
__FOREVER_57:
  call COMMA
  call INSERTFIELD
__SUCCESS_58:
  partialcommit __FOREVER_57
__FORGIVE_56:
__SUCCESS_55:
  closecapture 15
  ret -- INSERTFIELDLIST

__RULE_INSERTFIELD:
  call __prefix
  opencapture 16
  call FIELDNAME
__SUCCESS_59:
  closecapture 16
  ret -- INSERTFIELD

__RULE_FIELDNAME:
  call __prefix
  opencapture 17
  call IDENT
__SUCCESS_60:
  closecapture 17
  ret -- FIELDNAME

__RULE_INSERTVALUELIST:
  call __prefix
  opencapture 18
  call INSERTVALUE
  catch __FORGIVE_62
__FOREVER_63:
  call COMMA
  call INSERTVALUE
__SUCCESS_64:
  partialcommit __FOREVER_63
__FORGIVE_62:
__SUCCESS_61:
  closecapture 18
  ret -- INSERTVALUELIST

__RULE_INSERTVALUE:
  call __prefix
  opencapture 19
  call EXPRESSION
__SUCCESS_65:
  closecapture 19
  ret -- INSERTVALUE

__RULE_UPDATEFIELDLIST:
  call __prefix
  opencapture 20
  call UPDATEFIELD
  catch __FORGIVE_67
__FOREVER_68:
  call COMMA
  call UPDATEFIELD
__SUCCESS_69:
  partialcommit __FOREVER_68
__FORGIVE_67:
__SUCCESS_66:
  closecapture 20
  ret -- UPDATEFIELDLIST

__RULE_UPDATEFIELD:
  call __prefix
  opencapture 21
  call FIELDNAME
  call EQUALS
  call EXPRESSION
__SUCCESS_70:
  closecapture 21
  ret -- UPDATEFIELD

__RULE_CREATEFIELDLIST:
  call __prefix
  opencapture 22
  call CREATEFIELD
  catch __FORGIVE_72
__FOREVER_73:
  call COMMA
  call CREATEFIELD
__SUCCESS_74:
  partialcommit __FOREVER_73
__FORGIVE_72:
__SUCCESS_71:
  closecapture 22
  ret -- CREATEFIELDLIST

__RULE_CREATEFIELD:
  call __prefix
  opencapture 23
  call FIELDNAME
  call FIELDTYPE
  catch __FORGIVE_76
  call FIELDCONSTRAINTS
  commit __NEXT__
__FORGIVE_76:
__SUCCESS_75:
  closecapture 23
  ret -- CREATEFIELD

__RULE_FIELDCONSTRAINTS:
  call __prefix
  opencapture 24
  catch __FORGIVE_79
__FOREVER_80:
  call FIELDCONSTRAINT
  partialcommit __FOREVER_80
__FORGIVE_79:
__SUCCESS_78:
  closecapture 24
  ret -- FIELDCONSTRAINTS

__RULE_FIELDCONSTRAINT:
  call __prefix
  opencapture 25
  catch __ALT_82
  call PRIMARYKEY
  commit __SUCCESS_81
__ALT_82:
  catch __ALT_83
  call NOTNULL
  commit __SUCCESS_81
__ALT_83:
  catch __ALT_84
  call REFERENCES
  commit __SUCCESS_81
__ALT_84:
  call DEFAULT
__SUCCESS_81:
  closecapture 25
  ret -- FIELDCONSTRAINT

__RULE_PRIMARYKEY:
  call __prefix
  opencapture 26
  call KW_PRIMARY
  call KW_KEY
__SUCCESS_85:
  closecapture 26
  ret -- PRIMARYKEY

__RULE_NOTNULL:
  call __prefix
  opencapture 27
  call KW_NOT
  call KW_NULL
__SUCCESS_86:
  closecapture 27
  ret -- NOTNULL

__RULE_REFERENCES:
  call __prefix
  opencapture 28
  call KW_REFERENCES
  call TABLENAME
  call BOPEN
  call FIELDNAME
  call BCLOSE
__SUCCESS_87:
  closecapture 28
  ret -- REFERENCES

__RULE_DEFAULT:
  call __prefix
  opencapture 29
  call KW_DEFAULT
  call EXPRESSION
__SUCCESS_88:
  closecapture 29
  ret -- DEFAULT

__RULE_PRIVLIST:
  call __prefix
  opencapture 30
  call PRIV
  catch __FORGIVE_90
__FOREVER_91:
  call COMMA
  call PRIV
__SUCCESS_92:
  partialcommit __FOREVER_91
__FORGIVE_90:
__SUCCESS_89:
  closecapture 30
  ret -- PRIVLIST

__RULE_PRIV:
  call __prefix
  opencapture 31
  catch __ALT_94
  call KW_INSERT
  commit __SUCCESS_93
__ALT_94:
  catch __ALT_95
  call KW_SELECT
  commit __SUCCESS_93
__ALT_95:
  catch __ALT_96
  call KW_UPDATE
  commit __SUCCESS_93
__ALT_96:
  call KW_DELETE
__SUCCESS_93:
  closecapture 31
  ret -- PRIV

__RULE_SET:
  call __prefix
  opencapture 32
  call SETELT
  catch __FORGIVE_98
__FOREVER_99:
  call COMMA
  call SETELT
__SUCCESS_100:
  partialcommit __FOREVER_99
__FORGIVE_98:
__SUCCESS_97:
  closecapture 32
  ret -- SET

__RULE_SETELT:
  call __prefix
  opencapture 33
  catch __ALT_102
  call BOPEN
  call SELECT
  call BCLOSE
  commit __SUCCESS_101
__ALT_102:
  call TABLENAME
__SUCCESS_101:
  closecapture 33
  ret -- SETELT

__RULE_TABLENAME:
  call __prefix
  opencapture 34
  call IDENT
__SUCCESS_103:
  closecapture 34
  ret -- TABLENAME

__RULE_USERNAME:
  call __prefix
  opencapture 35
  call IDENT
__SUCCESS_104:
  closecapture 35
  ret -- USERNAME

__RULE_SEQNAME:
  call __prefix
  opencapture 36
  call IDENT
__SUCCESS_105:
  closecapture 36
  ret -- SEQNAME

__RULE_CONDITION:
  call __prefix
  opencapture 37
  call EXPRESSION
__SUCCESS_106:
  closecapture 37
  ret -- CONDITION

__RULE_EXPRESSION:
  call __prefix
  opencapture 38
  call EXPR2
  catch __FORGIVE_108
__FOREVER_109:
  catch __ALT_112
  call AND
  commit __SUCCESS_111
__ALT_112:
  call OR
__SUCCESS_111:
  call EXPR2
__SUCCESS_110:
  partialcommit __FOREVER_109
__FORGIVE_108:
__SUCCESS_107:
  closecapture 38
  ret -- EXPRESSION

__RULE_EXPR2:
  call __prefix
  opencapture 39
  call EXPR3
  catch __FORGIVE_114
__FOREVER_115:
  catch __ALT_118
  call BITAND
  commit __SUCCESS_117
__ALT_118:
  catch __ALT_119
  call BITOR
  commit __SUCCESS_117
__ALT_119:
  call BITXOR
__SUCCESS_117:
  call EXPR3
__SUCCESS_116:
  partialcommit __FOREVER_115
__FORGIVE_114:
__SUCCESS_113:
  closecapture 39
  ret -- EXPR2

__RULE_EXPR3:
  call __prefix
  opencapture 40
  call EXPR4
  catch __FORGIVE_121
__FOREVER_122:
  catch __ALT_125
  call EQUALS
  commit __SUCCESS_124
__ALT_125:
  catch __ALT_126
  call NEQUALS
  commit __SUCCESS_124
__ALT_126:
  catch __ALT_127
  call LTEQ
  commit __SUCCESS_124
__ALT_127:
  catch __ALT_128
  call LT
  commit __SUCCESS_124
__ALT_128:
  catch __ALT_129
  call GTEQ
  commit __SUCCESS_124
__ALT_129:
  call GT
__SUCCESS_124:
  call EXPR4
__SUCCESS_123:
  partialcommit __FOREVER_122
__FORGIVE_121:
__SUCCESS_120:
  closecapture 40
  ret -- EXPR3

__RULE_EXPR4:
  call __prefix
  opencapture 41
  call EXPR5
  catch __FORGIVE_131
__FOREVER_132:
  catch __ALT_135
  call POW
  commit __SUCCESS_134
__ALT_135:
  catch __ALT_136
  call MUL
  commit __SUCCESS_134
__ALT_136:
  call DIV
__SUCCESS_134:
  call EXPR5
__SUCCESS_133:
  partialcommit __FOREVER_132
__FORGIVE_131:
__SUCCESS_130:
  closecapture 41
  ret -- EXPR4

__RULE_EXPR5:
  call __prefix
  opencapture 42
  call EXPR6
  catch __FORGIVE_138
__FOREVER_139:
  catch __ALT_142
  call ADD
  commit __SUCCESS_141
__ALT_142:
  call SUB
__SUCCESS_141:
  call EXPR6
__SUCCESS_140:
  partialcommit __FOREVER_139
__FORGIVE_138:
__SUCCESS_137:
  closecapture 42
  ret -- EXPR5

__RULE_EXPR6:
  call __prefix
  opencapture 43
  catch __FORGIVE_144
__FOREVER_145:
  call UNARY
__SUCCESS_146:
  partialcommit __FOREVER_145
__FORGIVE_144:
  call TERM
__SUCCESS_143:
  closecapture 43
  ret -- EXPR6

__RULE_UNARY:
  call __prefix
  opencapture 44
  catch __ALT_149
  call NOT
  commit __SUCCESS_148
__ALT_149:
  catch __ALT_150
  call INC
  commit __SUCCESS_148
__ALT_150:
  call DEC
__SUCCESS_148:
__SUCCESS_147:
  closecapture 44
  ret -- UNARY

__RULE_TERM:
  call __prefix
  opencapture 45
  catch __ALT_152
  call LITERAL
  commit __SUCCESS_151
__ALT_152:
  catch __ALT_153
  call FUNCTIONCALL
  commit __SUCCESS_151
__ALT_153:
  catch __ALT_154
  call VARREF
  commit __SUCCESS_151
__ALT_154:
  catch __ALT_155
  call BOPEN
  call EXPRESSION
__SUCCESS_156:
  call BCLOSE
  commit __SUCCESS_151
__ALT_155:
  call SELECT
__SUCCESS_151:
  closecapture 45
  ret -- TERM

__RULE_FUNCTIONCALL:
  call __prefix
  opencapture 46
  call IDENT
  call BOPEN
  catch __FORGIVE_158
  call EXPRESSION
  catch __FORGIVE_161
__FOREVER_162:
  call COMMA
  call EXPRESSION
__SUCCESS_163:
  partialcommit __FOREVER_162
__FORGIVE_161:
__SUCCESS_160:
  commit __NEXT__
__FORGIVE_158:
  call BCLOSE
__SUCCESS_157:
  closecapture 46
  ret -- FUNCTIONCALL

__RULE_VARREF:
  call __prefix
  opencapture 47
  call IDENT
__SUCCESS_164:
  closecapture 47
  ret -- VARREF

__RULE_KW_SELECT:
  call __prefix
  opencapture 48
  catch __CI_ALT_167
  char 73
  commit __CI_CHR_166
__CI_ALT_167:
  char 53
__CI_CHR_166:
  catch __CI_ALT_169
  char 65
  commit __CI_CHR_168
__CI_ALT_169:
  char 45
__CI_CHR_168:
  catch __CI_ALT_171
  char 6c
  commit __CI_CHR_170
__CI_ALT_171:
  char 4c
__CI_CHR_170:
  catch __CI_ALT_173
  char 65
  commit __CI_CHR_172
__CI_ALT_173:
  char 45
__CI_CHR_172:
  catch __CI_ALT_175
  char 63
  commit __CI_CHR_174
__CI_ALT_175:
  char 43
__CI_CHR_174:
  catch __CI_ALT_177
  char 74
  commit __CI_CHR_176
__CI_ALT_177:
  char 54
__CI_CHR_176:
__SUCCESS_165:
  closecapture 48
  ret -- KW_SELECT

__RULE_KW_INSERT:
  call __prefix
  opencapture 49
  catch __CI_ALT_180
  char 69
  commit __CI_CHR_179
__CI_ALT_180:
  char 49
__CI_CHR_179:
  catch __CI_ALT_182
  char 6e
  commit __CI_CHR_181
__CI_ALT_182:
  char 4e
__CI_CHR_181:
  catch __CI_ALT_184
  char 73
  commit __CI_CHR_183
__CI_ALT_184:
  char 53
__CI_CHR_183:
  catch __CI_ALT_186
  char 65
  commit __CI_CHR_185
__CI_ALT_186:
  char 45
__CI_CHR_185:
  catch __CI_ALT_188
  char 72
  commit __CI_CHR_187
__CI_ALT_188:
  char 52
__CI_CHR_187:
  catch __CI_ALT_190
  char 74
  commit __CI_CHR_189
__CI_ALT_190:
  char 54
__CI_CHR_189:
__SUCCESS_178:
  closecapture 49
  ret -- KW_INSERT

__RULE_KW_INTO:
  call __prefix
  opencapture 50
  catch __CI_ALT_193
  char 69
  commit __CI_CHR_192
__CI_ALT_193:
  char 49
__CI_CHR_192:
  catch __CI_ALT_195
  char 6e
  commit __CI_CHR_194
__CI_ALT_195:
  char 4e
__CI_CHR_194:
  catch __CI_ALT_197
  char 74
  commit __CI_CHR_196
__CI_ALT_197:
  char 54
__CI_CHR_196:
  catch __CI_ALT_199
  char 6f
  commit __CI_CHR_198
__CI_ALT_199:
  char 4f
__CI_CHR_198:
__SUCCESS_191:
  closecapture 50
  ret -- KW_INTO

__RULE_KW_VALUES:
  call __prefix
  opencapture 51
  catch __CI_ALT_202
  char 76
  commit __CI_CHR_201
__CI_ALT_202:
  char 56
__CI_CHR_201:
  catch __CI_ALT_204
  char 61
  commit __CI_CHR_203
__CI_ALT_204:
  char 41
__CI_CHR_203:
  catch __CI_ALT_206
  char 6c
  commit __CI_CHR_205
__CI_ALT_206:
  char 4c
__CI_CHR_205:
  catch __CI_ALT_208
  char 75
  commit __CI_CHR_207
__CI_ALT_208:
  char 55
__CI_CHR_207:
  catch __CI_ALT_210
  char 65
  commit __CI_CHR_209
__CI_ALT_210:
  char 45
__CI_CHR_209:
  catch __CI_ALT_212
  char 73
  commit __CI_CHR_211
__CI_ALT_212:
  char 53
__CI_CHR_211:
__SUCCESS_200:
  closecapture 51
  ret -- KW_VALUES

__RULE_KW_UPDATE:
  call __prefix
  opencapture 52
  catch __CI_ALT_215
  char 75
  commit __CI_CHR_214
__CI_ALT_215:
  char 55
__CI_CHR_214:
  catch __CI_ALT_217
  char 70
  commit __CI_CHR_216
__CI_ALT_217:
  char 50
__CI_CHR_216:
  catch __CI_ALT_219
  char 64
  commit __CI_CHR_218
__CI_ALT_219:
  char 44
__CI_CHR_218:
  catch __CI_ALT_221
  char 61
  commit __CI_CHR_220
__CI_ALT_221:
  char 41
__CI_CHR_220:
  catch __CI_ALT_223
  char 74
  commit __CI_CHR_222
__CI_ALT_223:
  char 54
__CI_CHR_222:
  catch __CI_ALT_225
  char 65
  commit __CI_CHR_224
__CI_ALT_225:
  char 45
__CI_CHR_224:
__SUCCESS_213:
  closecapture 52
  ret -- KW_UPDATE

__RULE_KW_DELETE:
  call __prefix
  opencapture 53
  catch __CI_ALT_228
  char 64
  commit __CI_CHR_227
__CI_ALT_228:
  char 44
__CI_CHR_227:
  catch __CI_ALT_230
  char 65
  commit __CI_CHR_229
__CI_ALT_230:
  char 45
__CI_CHR_229:
  catch __CI_ALT_232
  char 6c
  commit __CI_CHR_231
__CI_ALT_232:
  char 4c
__CI_CHR_231:
  catch __CI_ALT_234
  char 65
  commit __CI_CHR_233
__CI_ALT_234:
  char 45
__CI_CHR_233:
  catch __CI_ALT_236
  char 74
  commit __CI_CHR_235
__CI_ALT_236:
  char 54
__CI_CHR_235:
  catch __CI_ALT_238
  char 65
  commit __CI_CHR_237
__CI_ALT_238:
  char 45
__CI_CHR_237:
__SUCCESS_226:
  closecapture 53
  ret -- KW_DELETE

__RULE_KW_CREATE:
  call __prefix
  opencapture 54
  catch __CI_ALT_241
  char 63
  commit __CI_CHR_240
__CI_ALT_241:
  char 43
__CI_CHR_240:
  catch __CI_ALT_243
  char 72
  commit __CI_CHR_242
__CI_ALT_243:
  char 52
__CI_CHR_242:
  catch __CI_ALT_245
  char 65
  commit __CI_CHR_244
__CI_ALT_245:
  char 45
__CI_CHR_244:
  catch __CI_ALT_247
  char 61
  commit __CI_CHR_246
__CI_ALT_247:
  char 41
__CI_CHR_246:
  catch __CI_ALT_249
  char 74
  commit __CI_CHR_248
__CI_ALT_249:
  char 54
__CI_CHR_248:
  catch __CI_ALT_251
  char 65
  commit __CI_CHR_250
__CI_ALT_251:
  char 45
__CI_CHR_250:
__SUCCESS_239:
  closecapture 54
  ret -- KW_CREATE

__RULE_KW_DROP:
  call __prefix
  opencapture 55
  catch __CI_ALT_254
  char 64
  commit __CI_CHR_253
__CI_ALT_254:
  char 44
__CI_CHR_253:
  catch __CI_ALT_256
  char 72
  commit __CI_CHR_255
__CI_ALT_256:
  char 52
__CI_CHR_255:
  catch __CI_ALT_258
  char 6f
  commit __CI_CHR_257
__CI_ALT_258:
  char 4f
__CI_CHR_257:
  catch __CI_ALT_260
  char 70
  commit __CI_CHR_259
__CI_ALT_260:
  char 50
__CI_CHR_259:
__SUCCESS_252:
  closecapture 55
  ret -- KW_DROP

__RULE_KW_FROM:
  call __prefix
  opencapture 56
  catch __CI_ALT_263
  char 66
  commit __CI_CHR_262
__CI_ALT_263:
  char 46
__CI_CHR_262:
  catch __CI_ALT_265
  char 72
  commit __CI_CHR_264
__CI_ALT_265:
  char 52
__CI_CHR_264:
  catch __CI_ALT_267
  char 6f
  commit __CI_CHR_266
__CI_ALT_267:
  char 4f
__CI_CHR_266:
  catch __CI_ALT_269
  char 6d
  commit __CI_CHR_268
__CI_ALT_269:
  char 4d
__CI_CHR_268:
__SUCCESS_261:
  closecapture 56
  ret -- KW_FROM

__RULE_KW_WHERE:
  call __prefix
  opencapture 57
  catch __CI_ALT_272
  char 77
  commit __CI_CHR_271
__CI_ALT_272:
  char 57
__CI_CHR_271:
  catch __CI_ALT_274
  char 68
  commit __CI_CHR_273
__CI_ALT_274:
  char 48
__CI_CHR_273:
  catch __CI_ALT_276
  char 65
  commit __CI_CHR_275
__CI_ALT_276:
  char 45
__CI_CHR_275:
  catch __CI_ALT_278
  char 72
  commit __CI_CHR_277
__CI_ALT_278:
  char 52
__CI_CHR_277:
  catch __CI_ALT_280
  char 65
  commit __CI_CHR_279
__CI_ALT_280:
  char 45
__CI_CHR_279:
__SUCCESS_270:
  closecapture 57
  ret -- KW_WHERE

__RULE_KW_AS:
  call __prefix
  opencapture 58
  catch __CI_ALT_283
  char 61
  commit __CI_CHR_282
__CI_ALT_283:
  char 41
__CI_CHR_282:
  catch __CI_ALT_285
  char 73
  commit __CI_CHR_284
__CI_ALT_285:
  char 53
__CI_CHR_284:
__SUCCESS_281:
  closecapture 58
  ret -- KW_AS

__RULE_KW_SET:
  call __prefix
  opencapture 59
  catch __CI_ALT_288
  char 73
  commit __CI_CHR_287
__CI_ALT_288:
  char 53
__CI_CHR_287:
  catch __CI_ALT_290
  char 65
  commit __CI_CHR_289
__CI_ALT_290:
  char 45
__CI_CHR_289:
  catch __CI_ALT_292
  char 74
  commit __CI_CHR_291
__CI_ALT_292:
  char 54
__CI_CHR_291:
__SUCCESS_286:
  closecapture 59
  ret -- KW_SET

__RULE_KW_TABLE:
  call __prefix
  opencapture 60
  catch __CI_ALT_295
  char 74
  commit __CI_CHR_294
__CI_ALT_295:
  char 54
__CI_CHR_294:
  catch __CI_ALT_297
  char 61
  commit __CI_CHR_296
__CI_ALT_297:
  char 41
__CI_CHR_296:
  catch __CI_ALT_299
  char 62
  commit __CI_CHR_298
__CI_ALT_299:
  char 42
__CI_CHR_298:
  catch __CI_ALT_301
  char 6c
  commit __CI_CHR_300
__CI_ALT_301:
  char 4c
__CI_CHR_300:
  catch __CI_ALT_303
  char 65
  commit __CI_CHR_302
__CI_ALT_303:
  char 45
__CI_CHR_302:
__SUCCESS_293:
  closecapture 60
  ret -- KW_TABLE

__RULE_KW_SEQUENCE:
  call __prefix
  opencapture 61
  catch __CI_ALT_306
  char 73
  commit __CI_CHR_305
__CI_ALT_306:
  char 53
__CI_CHR_305:
  catch __CI_ALT_308
  char 65
  commit __CI_CHR_307
__CI_ALT_308:
  char 45
__CI_CHR_307:
  catch __CI_ALT_310
  char 71
  commit __CI_CHR_309
__CI_ALT_310:
  char 51
__CI_CHR_309:
  catch __CI_ALT_312
  char 75
  commit __CI_CHR_311
__CI_ALT_312:
  char 55
__CI_CHR_311:
  catch __CI_ALT_314
  char 65
  commit __CI_CHR_313
__CI_ALT_314:
  char 45
__CI_CHR_313:
  catch __CI_ALT_316
  char 6e
  commit __CI_CHR_315
__CI_ALT_316:
  char 4e
__CI_CHR_315:
  catch __CI_ALT_318
  char 63
  commit __CI_CHR_317
__CI_ALT_318:
  char 43
__CI_CHR_317:
  catch __CI_ALT_320
  char 65
  commit __CI_CHR_319
__CI_ALT_320:
  char 45
__CI_CHR_319:
__SUCCESS_304:
  closecapture 61
  ret -- KW_SEQUENCE

__RULE_KW_NOT:
  call __prefix
  opencapture 62
  catch __CI_ALT_323
  char 6e
  commit __CI_CHR_322
__CI_ALT_323:
  char 4e
__CI_CHR_322:
  catch __CI_ALT_325
  char 6f
  commit __CI_CHR_324
__CI_ALT_325:
  char 4f
__CI_CHR_324:
  catch __CI_ALT_327
  char 74
  commit __CI_CHR_326
__CI_ALT_327:
  char 54
__CI_CHR_326:
__SUCCESS_321:
  closecapture 62
  ret -- KW_NOT

__RULE_KW_NULL:
  call __prefix
  opencapture 63
  catch __CI_ALT_330
  char 6e
  commit __CI_CHR_329
__CI_ALT_330:
  char 4e
__CI_CHR_329:
  catch __CI_ALT_332
  char 75
  commit __CI_CHR_331
__CI_ALT_332:
  char 55
__CI_CHR_331:
  catch __CI_ALT_334
  char 6c
  commit __CI_CHR_333
__CI_ALT_334:
  char 4c
__CI_CHR_333:
  catch __CI_ALT_336
  char 6c
  commit __CI_CHR_335
__CI_ALT_336:
  char 4c
__CI_CHR_335:
__SUCCESS_328:
  closecapture 63
  ret -- KW_NULL

__RULE_KW_PRIMARY:
  call __prefix
  opencapture 64
  catch __CI_ALT_339
  char 70
  commit __CI_CHR_338
__CI_ALT_339:
  char 50
__CI_CHR_338:
  catch __CI_ALT_341
  char 72
  commit __CI_CHR_340
__CI_ALT_341:
  char 52
__CI_CHR_340:
  catch __CI_ALT_343
  char 69
  commit __CI_CHR_342
__CI_ALT_343:
  char 49
__CI_CHR_342:
  catch __CI_ALT_345
  char 6d
  commit __CI_CHR_344
__CI_ALT_345:
  char 4d
__CI_CHR_344:
  catch __CI_ALT_347
  char 61
  commit __CI_CHR_346
__CI_ALT_347:
  char 41
__CI_CHR_346:
  catch __CI_ALT_349
  char 72
  commit __CI_CHR_348
__CI_ALT_349:
  char 52
__CI_CHR_348:
  catch __CI_ALT_351
  char 79
  commit __CI_CHR_350
__CI_ALT_351:
  char 59
__CI_CHR_350:
__SUCCESS_337:
  closecapture 64
  ret -- KW_PRIMARY

__RULE_KW_KEY:
  call __prefix
  opencapture 65
  catch __CI_ALT_354
  char 6b
  commit __CI_CHR_353
__CI_ALT_354:
  char 4b
__CI_CHR_353:
  catch __CI_ALT_356
  char 65
  commit __CI_CHR_355
__CI_ALT_356:
  char 45
__CI_CHR_355:
  catch __CI_ALT_358
  char 79
  commit __CI_CHR_357
__CI_ALT_358:
  char 59
__CI_CHR_357:
__SUCCESS_352:
  closecapture 65
  ret -- KW_KEY

__RULE_KW_REFERENCES:
  call __prefix
  opencapture 66
  catch __CI_ALT_361
  char 72
  commit __CI_CHR_360
__CI_ALT_361:
  char 52
__CI_CHR_360:
  catch __CI_ALT_363
  char 65
  commit __CI_CHR_362
__CI_ALT_363:
  char 45
__CI_CHR_362:
  catch __CI_ALT_365
  char 66
  commit __CI_CHR_364
__CI_ALT_365:
  char 46
__CI_CHR_364:
  catch __CI_ALT_367
  char 65
  commit __CI_CHR_366
__CI_ALT_367:
  char 45
__CI_CHR_366:
  catch __CI_ALT_369
  char 72
  commit __CI_CHR_368
__CI_ALT_369:
  char 52
__CI_CHR_368:
  catch __CI_ALT_371
  char 65
  commit __CI_CHR_370
__CI_ALT_371:
  char 45
__CI_CHR_370:
  catch __CI_ALT_373
  char 6e
  commit __CI_CHR_372
__CI_ALT_373:
  char 4e
__CI_CHR_372:
  catch __CI_ALT_375
  char 63
  commit __CI_CHR_374
__CI_ALT_375:
  char 43
__CI_CHR_374:
  catch __CI_ALT_377
  char 65
  commit __CI_CHR_376
__CI_ALT_377:
  char 45
__CI_CHR_376:
  catch __CI_ALT_379
  char 73
  commit __CI_CHR_378
__CI_ALT_379:
  char 53
__CI_CHR_378:
__SUCCESS_359:
  closecapture 66
  ret -- KW_REFERENCES

__RULE_KW_DEFAULT:
  call __prefix
  opencapture 67
  catch __CI_ALT_382
  char 64
  commit __CI_CHR_381
__CI_ALT_382:
  char 44
__CI_CHR_381:
  catch __CI_ALT_384
  char 65
  commit __CI_CHR_383
__CI_ALT_384:
  char 45
__CI_CHR_383:
  catch __CI_ALT_386
  char 66
  commit __CI_CHR_385
__CI_ALT_386:
  char 46
__CI_CHR_385:
  catch __CI_ALT_388
  char 61
  commit __CI_CHR_387
__CI_ALT_388:
  char 41
__CI_CHR_387:
  catch __CI_ALT_390
  char 75
  commit __CI_CHR_389
__CI_ALT_390:
  char 55
__CI_CHR_389:
  catch __CI_ALT_392
  char 6c
  commit __CI_CHR_391
__CI_ALT_392:
  char 4c
__CI_CHR_391:
  catch __CI_ALT_394
  char 74
  commit __CI_CHR_393
__CI_ALT_394:
  char 54
__CI_CHR_393:
__SUCCESS_380:
  closecapture 67
  ret -- KW_DEFAULT

__RULE_KW_GRANT:
  call __prefix
  opencapture 68
  catch __CI_ALT_397
  char 67
  commit __CI_CHR_396
__CI_ALT_397:
  char 47
__CI_CHR_396:
  catch __CI_ALT_399
  char 72
  commit __CI_CHR_398
__CI_ALT_399:
  char 52
__CI_CHR_398:
  catch __CI_ALT_401
  char 61
  commit __CI_CHR_400
__CI_ALT_401:
  char 41
__CI_CHR_400:
  catch __CI_ALT_403
  char 6e
  commit __CI_CHR_402
__CI_ALT_403:
  char 4e
__CI_CHR_402:
  catch __CI_ALT_405
  char 74
  commit __CI_CHR_404
__CI_ALT_405:
  char 54
__CI_CHR_404:
__SUCCESS_395:
  closecapture 68
  ret -- KW_GRANT

__RULE_KW_ON:
  call __prefix
  opencapture 69
  catch __CI_ALT_408
  char 6f
  commit __CI_CHR_407
__CI_ALT_408:
  char 4f
__CI_CHR_407:
  catch __CI_ALT_410
  char 6e
  commit __CI_CHR_409
__CI_ALT_410:
  char 4e
__CI_CHR_409:
__SUCCESS_406:
  closecapture 69
  ret -- KW_ON

__RULE_KW_TO:
  call __prefix
  opencapture 70
  catch __CI_ALT_413
  char 74
  commit __CI_CHR_412
__CI_ALT_413:
  char 54
__CI_CHR_412:
  catch __CI_ALT_415
  char 6f
  commit __CI_CHR_414
__CI_ALT_415:
  char 4f
__CI_CHR_414:
__SUCCESS_411:
  closecapture 70
  ret -- KW_TO

__RULE_KW_WITH:
  call __prefix
  opencapture 71
  catch __CI_ALT_418
  char 77
  commit __CI_CHR_417
__CI_ALT_418:
  char 57
__CI_CHR_417:
  catch __CI_ALT_420
  char 69
  commit __CI_CHR_419
__CI_ALT_420:
  char 49
__CI_CHR_419:
  catch __CI_ALT_422
  char 74
  commit __CI_CHR_421
__CI_ALT_422:
  char 54
__CI_CHR_421:
  catch __CI_ALT_424
  char 68
  commit __CI_CHR_423
__CI_ALT_424:
  char 48
__CI_CHR_423:
__SUCCESS_416:
  closecapture 71
  ret -- KW_WITH

__RULE_KW_TIME:
  call __prefix
  opencapture 72
  catch __CI_ALT_427
  char 74
  commit __CI_CHR_426
__CI_ALT_427:
  char 54
__CI_CHR_426:
  catch __CI_ALT_429
  char 69
  commit __CI_CHR_428
__CI_ALT_429:
  char 49
__CI_CHR_428:
  catch __CI_ALT_431
  char 6d
  commit __CI_CHR_430
__CI_ALT_431:
  char 4d
__CI_CHR_430:
  catch __CI_ALT_433
  char 65
  commit __CI_CHR_432
__CI_ALT_433:
  char 45
__CI_CHR_432:
__SUCCESS_425:
  closecapture 72
  ret -- KW_TIME

__RULE_KW_ZONE:
  call __prefix
  opencapture 73
  catch __CI_ALT_436
  char 7a
  commit __CI_CHR_435
__CI_ALT_436:
  char 5a
__CI_CHR_435:
  catch __CI_ALT_438
  char 6f
  commit __CI_CHR_437
__CI_ALT_438:
  char 4f
__CI_CHR_437:
  catch __CI_ALT_440
  char 6e
  commit __CI_CHR_439
__CI_ALT_440:
  char 4e
__CI_CHR_439:
  catch __CI_ALT_442
  char 65
  commit __CI_CHR_441
__CI_ALT_442:
  char 45
__CI_CHR_441:
__SUCCESS_434:
  closecapture 73
  ret -- KW_ZONE

__RULE_KW_VARCHAR:
  call __prefix
  opencapture 74
  catch __CI_ALT_445
  char 76
  commit __CI_CHR_444
__CI_ALT_445:
  char 56
__CI_CHR_444:
  catch __CI_ALT_447
  char 61
  commit __CI_CHR_446
__CI_ALT_447:
  char 41
__CI_CHR_446:
  catch __CI_ALT_449
  char 72
  commit __CI_CHR_448
__CI_ALT_449:
  char 52
__CI_CHR_448:
  catch __CI_ALT_451
  char 63
  commit __CI_CHR_450
__CI_ALT_451:
  char 43
__CI_CHR_450:
  catch __CI_ALT_453
  char 68
  commit __CI_CHR_452
__CI_ALT_453:
  char 48
__CI_CHR_452:
  catch __CI_ALT_455
  char 61
  commit __CI_CHR_454
__CI_ALT_455:
  char 41
__CI_CHR_454:
  catch __CI_ALT_457
  char 72
  commit __CI_CHR_456
__CI_ALT_457:
  char 52
__CI_CHR_456:
__SUCCESS_443:
  closecapture 74
  ret -- KW_VARCHAR

__RULE_KW_CHAR:
  call __prefix
  opencapture 75
  catch __CI_ALT_460
  char 63
  commit __CI_CHR_459
__CI_ALT_460:
  char 43
__CI_CHR_459:
  catch __CI_ALT_462
  char 68
  commit __CI_CHR_461
__CI_ALT_462:
  char 48
__CI_CHR_461:
  catch __CI_ALT_464
  char 61
  commit __CI_CHR_463
__CI_ALT_464:
  char 41
__CI_CHR_463:
  catch __CI_ALT_466
  char 72
  commit __CI_CHR_465
__CI_ALT_466:
  char 52
__CI_CHR_465:
__SUCCESS_458:
  closecapture 75
  ret -- KW_CHAR

__RULE_KW_INTEGER:
  call __prefix
  opencapture 76
  catch __CI_ALT_469
  char 69
  commit __CI_CHR_468
__CI_ALT_469:
  char 49
__CI_CHR_468:
  catch __CI_ALT_471
  char 6e
  commit __CI_CHR_470
__CI_ALT_471:
  char 4e
__CI_CHR_470:
  catch __CI_ALT_473
  char 74
  commit __CI_CHR_472
__CI_ALT_473:
  char 54
__CI_CHR_472:
  catch __CI_ALT_475
  char 65
  commit __CI_CHR_474
__CI_ALT_475:
  char 45
__CI_CHR_474:
  catch __CI_ALT_477
  char 67
  commit __CI_CHR_476
__CI_ALT_477:
  char 47
__CI_CHR_476:
  catch __CI_ALT_479
  char 65
  commit __CI_CHR_478
__CI_ALT_479:
  char 45
__CI_CHR_478:
  catch __CI_ALT_481
  char 72
  commit __CI_CHR_480
__CI_ALT_481:
  char 52
__CI_CHR_480:
__SUCCESS_467:
  closecapture 76
  ret -- KW_INTEGER

__RULE_KW_BOOLEAN:
  call __prefix
  opencapture 77
  catch __CI_ALT_484
  char 62
  commit __CI_CHR_483
__CI_ALT_484:
  char 42
__CI_CHR_483:
  catch __CI_ALT_486
  char 6f
  commit __CI_CHR_485
__CI_ALT_486:
  char 4f
__CI_CHR_485:
  catch __CI_ALT_488
  char 6f
  commit __CI_CHR_487
__CI_ALT_488:
  char 4f
__CI_CHR_487:
  catch __CI_ALT_490
  char 6c
  commit __CI_CHR_489
__CI_ALT_490:
  char 4c
__CI_CHR_489:
  catch __CI_ALT_492
  char 65
  commit __CI_CHR_491
__CI_ALT_492:
  char 45
__CI_CHR_491:
  catch __CI_ALT_494
  char 61
  commit __CI_CHR_493
__CI_ALT_494:
  char 41
__CI_CHR_493:
  catch __CI_ALT_496
  char 6e
  commit __CI_CHR_495
__CI_ALT_496:
  char 4e
__CI_CHR_495:
__SUCCESS_482:
  closecapture 77
  ret -- KW_BOOLEAN

__RULE_KW_TIMESTAMP:
  call __prefix
  opencapture 78
  catch __CI_ALT_499
  char 74
  commit __CI_CHR_498
__CI_ALT_499:
  char 54
__CI_CHR_498:
  catch __CI_ALT_501
  char 69
  commit __CI_CHR_500
__CI_ALT_501:
  char 49
__CI_CHR_500:
  catch __CI_ALT_503
  char 6d
  commit __CI_CHR_502
__CI_ALT_503:
  char 4d
__CI_CHR_502:
  catch __CI_ALT_505
  char 65
  commit __CI_CHR_504
__CI_ALT_505:
  char 45
__CI_CHR_504:
  catch __CI_ALT_507
  char 73
  commit __CI_CHR_506
__CI_ALT_507:
  char 53
__CI_CHR_506:
  catch __CI_ALT_509
  char 74
  commit __CI_CHR_508
__CI_ALT_509:
  char 54
__CI_CHR_508:
  catch __CI_ALT_511
  char 61
  commit __CI_CHR_510
__CI_ALT_511:
  char 41
__CI_CHR_510:
  catch __CI_ALT_513
  char 6d
  commit __CI_CHR_512
__CI_ALT_513:
  char 4d
__CI_CHR_512:
  catch __CI_ALT_515
  char 70
  commit __CI_CHR_514
__CI_ALT_515:
  char 50
__CI_CHR_514:
__SUCCESS_497:
  closecapture 78
  ret -- KW_TIMESTAMP

__RULE_TIMESTAMPWTZ:
  call __prefix
  opencapture 79
  call KW_TIMESTAMP
  call KW_WITH
  call KW_TIME
  call KW_ZONE
__SUCCESS_516:
  closecapture 79
  ret -- TIMESTAMPWTZ

__RULE_FIELDTYPE:
  call __prefix
  opencapture 80
  catch __ALT_519
  call KW_VARCHAR
  commit __SUCCESS_518
__ALT_519:
  catch __ALT_520
  call KW_CHAR
  commit __SUCCESS_518
__ALT_520:
  catch __ALT_521
  call KW_INTEGER
  commit __SUCCESS_518
__ALT_521:
  catch __ALT_522
  call KW_BOOLEAN
  commit __SUCCESS_518
__ALT_522:
  catch __ALT_523
  call TIMESTAMPWTZ
  commit __SUCCESS_518
__ALT_523:
  call KW_TIMESTAMP
__SUCCESS_518:
  catch __FORGIVE_524
  call FIELDNUMBER
  commit __NEXT__
__FORGIVE_524:
__SUCCESS_517:
  closecapture 80
  ret -- FIELDTYPE

__RULE_FIELDNUMBER:
  call __prefix
  opencapture 81
  call BOPEN
  call INTLITERAL
  call BCLOSE
__SUCCESS_526:
  closecapture 81
  ret -- FIELDNUMBER

__RULE_IDENT:
  call __prefix
  opencapture 82
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_528
  counter 2 63
__COUNTER_530:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __NEXT__
  condjump 2 __COUNTER_530
  commit __NEXT__
__FORGIVE_528:
__SUCCESS_527:
  closecapture 82
  ret -- IDENT

__RULE_BOPEN:
  call __prefix
  opencapture 83
  char 28
__SUCCESS_531:
  closecapture 83
  ret -- BOPEN

__RULE_BCLOSE:
  call __prefix
  opencapture 84
  char 29
__SUCCESS_532:
  closecapture 84
  ret -- BCLOSE

__RULE_ABOPEN:
  call __prefix
  opencapture 85
  char 5b
__SUCCESS_533:
  closecapture 85
  ret -- ABOPEN

__RULE_ABCLOSE:
  call __prefix
  opencapture 86
  char 5d
__SUCCESS_534:
  closecapture 86
  ret -- ABCLOSE

__RULE_CBOPEN:
  call __prefix
  opencapture 87
  char 7b
__SUCCESS_535:
  closecapture 87
  ret -- CBOPEN

__RULE_CBCLOSE:
  call __prefix
  opencapture 88
  char 7d
__SUCCESS_536:
  closecapture 88
  ret -- CBCLOSE

__RULE_AND:
  call __prefix
  opencapture 89
  catch __ALT_538
  catch __CI_ALT_540
  char 61
  commit __CI_CHR_539
__CI_ALT_540:
  char 41
__CI_CHR_539:
  catch __CI_ALT_542
  char 6e
  commit __CI_CHR_541
__CI_ALT_542:
  char 4e
__CI_CHR_541:
  catch __CI_ALT_544
  char 64
  commit __CI_CHR_543
__CI_ALT_544:
  char 44
__CI_CHR_543:
  commit __SUCCESS_537
__ALT_538:
  char 26
  char 26
__SUCCESS_537:
  closecapture 89
  ret -- AND

__RULE_OR:
  call __prefix
  opencapture 90
  catch __ALT_546
  catch __CI_ALT_548
  char 6f
  commit __CI_CHR_547
__CI_ALT_548:
  char 4f
__CI_CHR_547:
  catch __CI_ALT_550
  char 72
  commit __CI_CHR_549
__CI_ALT_550:
  char 52
__CI_CHR_549:
  commit __SUCCESS_545
__ALT_546:
  char 7c
  char 7c
__SUCCESS_545:
  closecapture 90
  ret -- OR

__RULE_BITAND:
  call __prefix
  opencapture 91
  char 26
__SUCCESS_551:
  closecapture 91
  ret -- BITAND

__RULE_BITOR:
  call __prefix
  opencapture 92
  char 7c
__SUCCESS_552:
  closecapture 92
  ret -- BITOR

__RULE_BITXOR:
  call __prefix
  opencapture 93
  char 5e
__SUCCESS_553:
  closecapture 93
  ret -- BITXOR

__RULE_EQUALS:
  call __prefix
  opencapture 94
  catch __ALT_555
  char 3d
  commit __SUCCESS_554
__ALT_555:
  catch __CI_ALT_557
  char 69
  commit __CI_CHR_556
__CI_ALT_557:
  char 49
__CI_CHR_556:
  catch __CI_ALT_559
  char 73
  commit __CI_CHR_558
__CI_ALT_559:
  char 53
__CI_CHR_558:
__SUCCESS_554:
  closecapture 94
  ret -- EQUALS

__RULE_NEQUALS:
  call __prefix
  opencapture 95
  char 21
  char 3d
__SUCCESS_560:
  closecapture 95
  ret -- NEQUALS

__RULE_LTEQ:
  call __prefix
  opencapture 96
  char 3c
  char 3d
__SUCCESS_561:
  closecapture 96
  ret -- LTEQ

__RULE_LT:
  call __prefix
  opencapture 97
  char 3c
__SUCCESS_562:
  closecapture 97
  ret -- LT

__RULE_GTEQ:
  call __prefix
  opencapture 98
  char 3e
  char 3d
__SUCCESS_563:
  closecapture 98
  ret -- GTEQ

__RULE_GT:
  call __prefix
  opencapture 99
  char 3e
__SUCCESS_564:
  closecapture 99
  ret -- GT

__RULE_POW:
  call __prefix
  opencapture 100
  char 2a
  char 2a
__SUCCESS_565:
  closecapture 100
  ret -- POW

__RULE_MUL:
  call __prefix
  opencapture 101
  char 2a
__SUCCESS_566:
  closecapture 101
  ret -- MUL

__RULE_DIV:
  call __prefix
  opencapture 102
  char 2f
__SUCCESS_567:
  closecapture 102
  ret -- DIV

__RULE_ADD:
  call __prefix
  opencapture 103
  char 2b
__SUCCESS_568:
  closecapture 103
  ret -- ADD

__RULE_SUB:
  call __prefix
  opencapture 104
  char 2d
__SUCCESS_569:
  closecapture 104
  ret -- SUB

__RULE_NOT:
  call __prefix
  opencapture 105
  catch __ALT_571
  char 21
  commit __SUCCESS_570
__ALT_571:
  catch __CI_ALT_573
  char 6e
  commit __CI_CHR_572
__CI_ALT_573:
  char 4e
__CI_CHR_572:
  catch __CI_ALT_575
  char 6f
  commit __CI_CHR_574
__CI_ALT_575:
  char 4f
__CI_CHR_574:
  catch __CI_ALT_577
  char 74
  commit __CI_CHR_576
__CI_ALT_577:
  char 54
__CI_CHR_576:
__SUCCESS_570:
  closecapture 105
  ret -- NOT

__RULE_INC:
  call __prefix
  opencapture 106
  char 2b
  char 2b
__SUCCESS_578:
  closecapture 106
  ret -- INC

__RULE_DEC:
  call __prefix
  opencapture 107
  char 2d
  char 2d
__SUCCESS_579:
  closecapture 107
  ret -- DEC

__RULE_LITERAL:
  call __prefix
  opencapture 108
  catch __ALT_581
  call STRINGLITERAL
  commit __SUCCESS_580
__ALT_581:
  catch __ALT_582
  call HASHLITERAL
  commit __SUCCESS_580
__ALT_582:
  catch __ALT_583
  call LISTLITERAL
  commit __SUCCESS_580
__ALT_583:
  catch __ALT_584
  call FLOATLITERAL
  commit __SUCCESS_580
__ALT_584:
  catch __ALT_585
  call INTLITERAL
  commit __SUCCESS_580
__ALT_585:
  call BOOLEANLITERAL
__SUCCESS_580:
  closecapture 108
  ret -- LITERAL

__RULE_STRINGLITERAL:
  call __prefix
  opencapture 109
  char 27
  catch __FORGIVE_587
__FOREVER_588:
  catch __ALT_590
  char 5c
  catch __ALT_592
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_591
__ALT_592:
  counter 3 3
__COUNTER_595:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 3 __COUNTER_595
__SUCCESS_591:
  commit __SUCCESS_589
__ALT_590:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_589:
  partialcommit __FOREVER_588
__FORGIVE_587:
  char 27
__SUCCESS_586:
  closecapture 109
  ret -- STRINGLITERAL

__RULE_HASHLITERAL:
  call __prefix
  opencapture 110
  call CBOPEN
  catch __FORGIVE_597
  call HASHELT
  catch __FORGIVE_600
__FOREVER_601:
  call COMMA
  call HASHELT
__SUCCESS_602:
  partialcommit __FOREVER_601
__FORGIVE_600:
__SUCCESS_599:
  commit __NEXT__
__FORGIVE_597:
  call CBCLOSE
__SUCCESS_596:
  closecapture 110
  ret -- HASHLITERAL

__RULE_HASHELT:
  call __prefix
  opencapture 111
  call HASHKEY
  call COLON
  call HASHVALUE
__SUCCESS_603:
  closecapture 111
  ret -- HASHELT

__RULE_HASHKEY:
  call __prefix
  opencapture 112
  call TERM
__SUCCESS_604:
  closecapture 112
  ret -- HASHKEY

__RULE_HASHVALUE:
  call __prefix
  opencapture 113
  call TERM
__SUCCESS_605:
  closecapture 113
  ret -- HASHVALUE

__RULE_LISTLITERAL:
  call __prefix
  opencapture 114
  call ABOPEN
  catch __FORGIVE_607
  call LISTELT
  catch __FORGIVE_610
__FOREVER_611:
  call COMMA
  call LISTELT
__SUCCESS_612:
  partialcommit __FOREVER_611
__FORGIVE_610:
__SUCCESS_609:
  commit __NEXT__
__FORGIVE_607:
  call ABCLOSE
__SUCCESS_606:
  closecapture 114
  ret -- LISTLITERAL

__RULE_LISTELT:
  call __prefix
  opencapture 115
  call TERM
__SUCCESS_613:
  closecapture 115
  ret -- LISTELT

__RULE_FLOATLITERAL:
  call __prefix
  opencapture 116
  catch __FORGIVE_615
__FOREVER_616:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_616
__FORGIVE_615:
  char 2e
  counter 4 1
__COUNTER_619:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 4 __COUNTER_619
  catch __FORGIVE_617
__FOREVER_618:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_618
__FORGIVE_617:
__SUCCESS_614:
  closecapture 116
  ret -- FLOATLITERAL

__RULE_INTLITERAL:
  call __prefix
  opencapture 117
  counter 5 1
__COUNTER_623:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 5 __COUNTER_623
  catch __FORGIVE_621
__FOREVER_622:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_622
__FORGIVE_621:
__SUCCESS_620:
  closecapture 117
  ret -- INTLITERAL

__RULE_BOOLEANLITERAL:
  call __prefix
  opencapture 118
  catch __ALT_625
  char 74
  char 72
  char 75
  char 65
  commit __SUCCESS_624
__ALT_625:
  char 66
  char 61
  char 6c
  char 73
  char 65
__SUCCESS_624:
  closecapture 118
  ret -- BOOLEANLITERAL

__RULE_COLON:
  call __prefix
  opencapture 119
  char 3a
__SUCCESS_626:
  closecapture 119
  ret -- COLON

__RULE_SEMICOLON:
  call __prefix
  opencapture 120
  char 3b
__SUCCESS_627:
  closecapture 120
  ret -- SEMICOLON

__RULE_COMMA:
  call __prefix
  opencapture 121
  char 2c
__SUCCESS_628:
  closecapture 121
  ret -- COMMA

__RULE_STAR:
  call __prefix
  opencapture 122
  char 2a
__SUCCESS_629:
  closecapture 122
  ret -- STAR

  end 0

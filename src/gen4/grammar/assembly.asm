--
-- Naigama compiler library; gen 3; release 0.4.11
-- At Fri, 29 Dec 2023 18:04:02 +0100
--

  call TOP
  end 0

TOP:
  call INSTRUCTIONS
__SUCCESS_1:
  ret -- TOP

S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __FORGIVE_3
__FOREVER_4:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __FOREVER_4
__FORGIVE_3:
__SUCCESS_2:
  ret -- S

MULTILINECOMMENT:
  char 2d
  char 2d
  char 5b
  char 5b
  catch __FORGIVE_6
__FOREVER_7:
  catch __SCANNER_9
  char 5d
  char 5d
  failtwice
__SCANNER_9:
  any
__SUCCESS_8:
  partialcommit __FOREVER_7
__FORGIVE_6:
  char 5d
  char 5d
__SUCCESS_5:
  ret -- MULTILINECOMMENT

COMMENT:
  char 2d
  char 2d
  catch __FORGIVE_11
__FOREVER_12:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __FOREVER_12
__FORGIVE_11:
  char 0a
__SUCCESS_10:
  ret -- COMMENT

__prefix:
  catch __FORGIVE_14
__FOREVER_15:
  catch __ALT_17
  call MULTILINECOMMENT
  commit __SUCCESS_16
__ALT_17:
  catch __ALT_18
  call COMMENT
  commit __SUCCESS_16
__ALT_18:
  call S
__SUCCESS_16:
  partialcommit __FOREVER_15
__FORGIVE_14:
__SUCCESS_13:
  ret -- __prefix

INSTRUCTIONS:
  call __prefix
  call INSTRUCTION
  catch __FORGIVE_20
__FOREVER_21:
  call INSTRUCTION
  partialcommit __FOREVER_21
__FORGIVE_20:
  call END
__SUCCESS_19:
  ret -- INSTRUCTIONS

INSTRUCTION:
  call __prefix
  catch __ALT_23
  opencapture 0
  call RULEINSTR
__SUCCESS_24:
  closecapture 0
  commit __SUCCESS_22
__ALT_23:
  catch __ALT_25
  opencapture 1
  call LABELDEF
__SUCCESS_26:
  closecapture 1
  commit __SUCCESS_22
__ALT_25:
  opencapture 2
  call NAMESPACEDEF
__SUCCESS_27:
  closecapture 2
__SUCCESS_22:
  ret -- INSTRUCTION

RULEINSTR:
  call __prefix
  catch __ALT_29
  call ANYINSTR
  commit __SUCCESS_28
__ALT_29:
  catch __ALT_30
  call BACKCOMMITINSTR
  commit __SUCCESS_28
__ALT_30:
  catch __ALT_31
  call CALLINSTR
  commit __SUCCESS_28
__ALT_31:
  catch __ALT_32
  call CATCHINSTR
  commit __SUCCESS_28
__ALT_32:
  catch __ALT_33
  call CHARINSTR
  commit __SUCCESS_28
__ALT_33:
  catch __ALT_34
  call MASKEDCHARINSTR
  commit __SUCCESS_28
__ALT_34:
  catch __ALT_35
  call CLOSECAPTUREINSTR
  commit __SUCCESS_28
__ALT_35:
  catch __ALT_36
  call COMMITINSTR
  commit __SUCCESS_28
__ALT_36:
  catch __ALT_37
  call ENDREPLACEINSTR
  commit __SUCCESS_28
__ALT_37:
  catch __ALT_38
  call REPLACEINSTR
  commit __SUCCESS_28
__ALT_38:
  catch __ALT_39
  call INTRPCAPTUREINSTR
  commit __SUCCESS_28
__ALT_39:
  catch __ALT_40
  call ISOLATEINSTR
  commit __SUCCESS_28
__ALT_40:
  catch __ALT_41
  call ENDISOLATEINSTR
  commit __SUCCESS_28
__ALT_41:
  catch __ALT_42
  call ENDINSTR
  commit __SUCCESS_28
__ALT_42:
  catch __ALT_43
  call FAILTWICEINSTR
  commit __SUCCESS_28
__ALT_43:
  catch __ALT_44
  call FAILINSTR
  commit __SUCCESS_28
__ALT_44:
  catch __ALT_45
  call JUMPINSTR
  commit __SUCCESS_28
__ALT_45:
  catch __ALT_46
  call NOOPINSTR
  commit __SUCCESS_28
__ALT_46:
  catch __ALT_47
  call TRAPINSTR
  commit __SUCCESS_28
__ALT_47:
  catch __ALT_48
  call OPENCAPTUREINSTR
  commit __SUCCESS_28
__ALT_48:
  catch __ALT_49
  call PARTIALCOMMITINSTR
  commit __SUCCESS_28
__ALT_49:
  catch __ALT_50
  call QUADINSTR
  commit __SUCCESS_28
__ALT_50:
  catch __ALT_51
  call RETINSTR
  commit __SUCCESS_28
__ALT_51:
  catch __ALT_52
  call SETINSTR
  commit __SUCCESS_28
__ALT_52:
  catch __ALT_53
  call RANGEINSTR
  commit __SUCCESS_28
__ALT_53:
  catch __ALT_54
  call SKIPINSTR
  commit __SUCCESS_28
__ALT_54:
  catch __ALT_55
  call SPANINSTR
  commit __SUCCESS_28
__ALT_55:
  catch __ALT_56
  call TESTANYINSTR
  commit __SUCCESS_28
__ALT_56:
  catch __ALT_57
  call TESTCHARINSTR
  commit __SUCCESS_28
__ALT_57:
  catch __ALT_58
  call TESTQUADINSTR
  commit __SUCCESS_28
__ALT_58:
  catch __ALT_59
  call TESTSETINSTR
  commit __SUCCESS_28
__ALT_59:
  catch __ALT_60
  call VARINSTR
  commit __SUCCESS_28
__ALT_60:
  catch __ALT_61
  call COUNTERINSTR
  commit __SUCCESS_28
__ALT_61:
  catch __ALT_62
  call CONDJUMPINSTR
  commit __SUCCESS_28
__ALT_62:
  call MODEINSTR
__SUCCESS_28:
  ret -- RULEINSTR

END:
  call __prefix
  catch __SCANNER_64
  any
  failtwice
__SCANNER_64:
__SUCCESS_63:
  ret -- END

ANYINSTR:
  call __prefix
  opencapture 3
  char 61
  char 6e
  char 79
__SUCCESS_66:
  closecapture 3
__SUCCESS_65:
  ret -- ANYINSTR

BACKCOMMITINSTR:
  call __prefix
  opencapture 4
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
__SUCCESS_68:
  closecapture 4
  call S
  call LABEL
__SUCCESS_67:
  ret -- BACKCOMMITINSTR

CALLINSTR:
  call __prefix
  opencapture 5
  char 63
  char 61
  char 6c
  char 6c
__SUCCESS_70:
  closecapture 5
  call S
  call LABEL
__SUCCESS_69:
  ret -- CALLINSTR

CATCHINSTR:
  call __prefix
  opencapture 6
  char 63
  char 61
  char 74
  char 63
  char 68
__SUCCESS_72:
  closecapture 6
  call S
  call LABEL
__SUCCESS_71:
  ret -- CATCHINSTR

CHARINSTR:
  call __prefix
  opencapture 7
  char 63
  char 68
  char 61
  char 72
__SUCCESS_74:
  closecapture 7
  call S
  call HEXBYTE
__SUCCESS_73:
  ret -- CHARINSTR

MASKEDCHARINSTR:
  call __prefix
  opencapture 8
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
__SUCCESS_76:
  closecapture 8
  call S
  call HEXBYTE
  call S
  call HEXBYTE
__SUCCESS_75:
  ret -- MASKEDCHARINSTR

CLOSECAPTUREINSTR:
  call __prefix
  opencapture 9
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
__SUCCESS_78:
  closecapture 9
  call S
  call SLOT
__SUCCESS_77:
  ret -- CLOSECAPTUREINSTR

COMMITINSTR:
  call __prefix
  opencapture 10
  char 63
  char 6f
  char 6d
  char 6d
  char 69
  char 74
__SUCCESS_80:
  closecapture 10
  call S
  call LABEL
__SUCCESS_79:
  ret -- COMMITINSTR

ENDINSTR:
  call __prefix
  opencapture 11
  char 65
  char 6e
  char 64
__SUCCESS_82:
  closecapture 11
  call S
  call CODE
__SUCCESS_81:
  ret -- ENDINSTR

FAILINSTR:
  call __prefix
  opencapture 12
  char 66
  char 61
  char 69
  char 6c
__SUCCESS_84:
  closecapture 12
__SUCCESS_83:
  ret -- FAILINSTR

FAILTWICEINSTR:
  call __prefix
  opencapture 13
  char 66
  char 61
  char 69
  char 6c
  char 74
  char 77
  char 69
  char 63
  char 65
__SUCCESS_86:
  closecapture 13
__SUCCESS_85:
  ret -- FAILTWICEINSTR

INTRPCAPTUREINSTR:
  call __prefix
  opencapture 14
  char 69
  char 6e
  char 74
  char 72
  char 70
  char 63
  char 61
  char 70
  char 74
  char 75
  char 72
  char 65
__SUCCESS_88:
  closecapture 14
  call S
  call INTRPCAPTURETYPES
  call S
  catch __ALT_90
  call SLOT
  commit __SUCCESS_89
__ALT_90:
  opencapture 15
  char 64
  char 65
  char 66
  char 61
  char 75
  char 6c
  char 74
__SUCCESS_91:
  closecapture 15
__SUCCESS_89:
__SUCCESS_87:
  ret -- INTRPCAPTUREINSTR

JUMPINSTR:
  call __prefix
  opencapture 16
  char 6a
  char 75
  char 6d
  char 70
__SUCCESS_93:
  closecapture 16
  call S
  call LABEL
__SUCCESS_92:
  ret -- JUMPINSTR

NOOPINSTR:
  call __prefix
  opencapture 17
  char 6e
  char 6f
  char 6f
  char 70
__SUCCESS_95:
  closecapture 17
__SUCCESS_94:
  ret -- NOOPINSTR

TRAPINSTR:
  call __prefix
  opencapture 18
  char 74
  char 72
  char 61
  char 70
__SUCCESS_97:
  closecapture 18
__SUCCESS_96:
  ret -- TRAPINSTR

OPENCAPTUREINSTR:
  call __prefix
  opencapture 19
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
__SUCCESS_99:
  closecapture 19
  call S
  call SLOT
__SUCCESS_98:
  ret -- OPENCAPTUREINSTR

PARTIALCOMMITINSTR:
  call __prefix
  opencapture 20
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
__SUCCESS_101:
  closecapture 20
  call S
  call LABEL
__SUCCESS_100:
  ret -- PARTIALCOMMITINSTR

QUADINSTR:
  call __prefix
  opencapture 21
  char 71
  char 75
  char 61
  char 64
__SUCCESS_103:
  closecapture 21
  call S
  call QUAD
__SUCCESS_102:
  ret -- QUADINSTR

REPLACEINSTR:
  call __prefix
  opencapture 22
  char 72
  char 65
  char 70
  char 6c
  char 61
  char 63
  char 65
__SUCCESS_105:
  closecapture 22
  call S
  call SLOT
  call S
  call LABEL
__SUCCESS_104:
  ret -- REPLACEINSTR

ENDREPLACEINSTR:
  call __prefix
  opencapture 23
  char 65
  char 6e
  char 64
  char 72
  char 65
  char 70
  char 6c
  char 61
  char 63
  char 65
__SUCCESS_107:
  closecapture 23
__SUCCESS_106:
  ret -- ENDREPLACEINSTR

RETINSTR:
  call __prefix
  opencapture 24
  char 72
  char 65
  char 74
__SUCCESS_109:
  closecapture 24
__SUCCESS_108:
  ret -- RETINSTR

SETINSTR:
  call __prefix
  opencapture 25
  char 73
  char 65
  char 74
__SUCCESS_111:
  closecapture 25
  call S
  call SET
__SUCCESS_110:
  ret -- SETINSTR

RANGEINSTR:
  call __prefix
  opencapture 26
  char 72
  char 61
  char 6e
  char 67
  char 65
__SUCCESS_113:
  closecapture 26
  call S
  call UNSIGNED
  call S
  call UNSIGNED
__SUCCESS_112:
  ret -- RANGEINSTR

SKIPINSTR:
  call __prefix
  opencapture 27
  char 73
  char 6b
  char 69
  char 70
__SUCCESS_115:
  closecapture 27
  call S
  call UNSIGNED
__SUCCESS_114:
  ret -- SKIPINSTR

SPANINSTR:
  call __prefix
  opencapture 28
  char 73
  char 70
  char 61
  char 6e
__SUCCESS_117:
  closecapture 28
  call S
  call SET
__SUCCESS_116:
  ret -- SPANINSTR

TESTANYINSTR:
  call __prefix
  opencapture 29
  char 74
  char 65
  char 73
  char 74
  char 61
  char 6e
  char 79
__SUCCESS_119:
  closecapture 29
  call S
  call LABEL
__SUCCESS_118:
  ret -- TESTANYINSTR

TESTCHARINSTR:
  call __prefix
  opencapture 30
  char 74
  char 65
  char 73
  char 74
  char 63
  char 68
  char 61
  char 72
__SUCCESS_121:
  closecapture 30
  call S
  call HEXBYTE
  call S
  call LABEL
__SUCCESS_120:
  ret -- TESTCHARINSTR

TESTQUADINSTR:
  call __prefix
  opencapture 31
  char 74
  char 65
  char 73
  char 74
  char 71
  char 75
  char 61
  char 64
__SUCCESS_123:
  closecapture 31
  call S
  call QUAD
  call S
  call LABEL
__SUCCESS_122:
  ret -- TESTQUADINSTR

TESTSETINSTR:
  call __prefix
  opencapture 32
  char 74
  char 65
  char 73
  char 74
  char 73
  char 65
  char 74
__SUCCESS_125:
  closecapture 32
  call S
  call SET
  call S
  call LABEL
__SUCCESS_124:
  ret -- TESTSETINSTR

VARINSTR:
  call __prefix
  opencapture 33
  char 76
  char 61
  char 72
__SUCCESS_127:
  closecapture 33
  call S
  call SLOT
__SUCCESS_126:
  ret -- VARINSTR

COUNTERINSTR:
  call __prefix
  opencapture 34
  char 63
  char 6f
  char 75
  char 6e
  char 74
  char 65
  char 72
__SUCCESS_129:
  closecapture 34
  call S
  call REGISTER
  call S
  call UNSIGNED
__SUCCESS_128:
  ret -- COUNTERINSTR

CONDJUMPINSTR:
  call __prefix
  opencapture 35
  char 63
  char 6f
  char 6e
  char 64
  char 6a
  char 75
  char 6d
  char 70
__SUCCESS_131:
  closecapture 35
  call S
  call REGISTER
  call S
  call LABEL
__SUCCESS_130:
  ret -- CONDJUMPINSTR

ISOLATEINSTR:
  call __prefix
  opencapture 36
  char 69
  char 73
  char 6f
  char 6c
  char 61
  char 74
  char 65
__SUCCESS_133:
  closecapture 36
  call S
  call SLOT
__SUCCESS_132:
  ret -- ISOLATEINSTR

ENDISOLATEINSTR:
  call __prefix
  opencapture 37
  char 65
  char 6e
  char 64
  char 69
  char 73
  char 6f
  char 6c
  char 61
  char 74
  char 65
__SUCCESS_135:
  closecapture 37
__SUCCESS_134:
  ret -- ENDISOLATEINSTR

MODEINSTR:
  call __prefix
  opencapture 38
  char 6d
  char 6f
  char 64
  char 65
__SUCCESS_137:
  closecapture 38
  call S
  call NUMBER
__SUCCESS_136:
  ret -- MODEINSTR

LABELDEF:
  call __prefix
  call LABEL
  call COLON
__SUCCESS_138:
  ret -- LABELDEF

NAMESPACEDEF:
  call __prefix
  catch __ALT_140
  call NAMESPACESTART
  commit __SUCCESS_139
__ALT_140:
  call NAMESPACESTOP
__SUCCESS_139:
  ret -- NAMESPACEDEF

NAMESPACESTART:
  call __prefix
  opencapture 39
  char 6e
  char 61
  char 6d
  char 65
  char 73
  char 70
  char 61
  char 63
  char 65
  char 5f
  char 73
  char 74
  char 61
  char 72
  char 74
__SUCCESS_142:
  closecapture 39
  call S
  call LABEL
__SUCCESS_141:
  ret -- NAMESPACESTART

NAMESPACESTOP:
  call __prefix
  opencapture 40
  char 6e
  char 61
  char 6d
  char 65
  char 73
  char 70
  char 61
  char 63
  char 65
  char 5f
  char 73
  char 74
  char 6f
  char 70
__SUCCESS_144:
  closecapture 40
  call S
  call LABEL
__SUCCESS_143:
  ret -- NAMESPACESTOP

CODE:
  call __prefix
  call UNSIGNED
__SUCCESS_145:
  ret -- CODE

HEXBYTE:
  call __prefix
  opencapture 41
  counter 0 2
__COUNTER_150:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __COUNTER_150
__SUCCESS_147:
  closecapture 41
__SUCCESS_146:
  ret -- HEXBYTE

LABEL:
  call __prefix
  opencapture 42
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_153
  counter 1 63
__COUNTER_155:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __NEXT__
  condjump 1 __COUNTER_155
  commit __NEXT__
__FORGIVE_153:
__SUCCESS_152:
  closecapture 42
__SUCCESS_151:
  ret -- LABEL

UNSIGNED:
  call __prefix
  opencapture 43
  range 48 57
  catch __FORGIVE_158
__FOREVER_159:
  range 48 57
  partialcommit __FOREVER_159
__FORGIVE_158:
__SUCCESS_157:
  closecapture 43
__SUCCESS_156:
  ret -- UNSIGNED

NUMBER:
  call __prefix
  opencapture 44
  catch __FORGIVE_162
  char 2d
  commit __NEXT__
__FORGIVE_162:
  range 48 57
  catch __FORGIVE_164
__FOREVER_165:
  range 48 57
  partialcommit __FOREVER_165
__FORGIVE_164:
__SUCCESS_161:
  closecapture 44
__SUCCESS_160:
  ret -- NUMBER

QUAD:
  call __prefix
  opencapture 45
  counter 2 8
__COUNTER_170:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 2 __COUNTER_170
__SUCCESS_167:
  closecapture 45
__SUCCESS_166:
  ret -- QUAD

SET:
  call __prefix
  opencapture 46
  counter 3 64
__COUNTER_175:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 3 __COUNTER_175
__SUCCESS_172:
  closecapture 46
__SUCCESS_171:
  ret -- SET

SLOT:
  call __prefix
  call UNSIGNED
__SUCCESS_176:
  ret -- SLOT

REGISTER:
  call __prefix
  call UNSIGNED
__SUCCESS_177:
  ret -- REGISTER

TYPE:
  call __prefix
  call UNSIGNED
__SUCCESS_178:
  ret -- TYPE

COLON:
  call __prefix
  char 3a
__SUCCESS_179:
  ret -- COLON

AMPERSAND:
  call __prefix
  char 26
__SUCCESS_180:
  ret -- AMPERSAND

STRINGLITERAL:
  call __prefix
  char 27
  opencapture 47
  catch __FORGIVE_183
__FOREVER_184:
  catch __ALT_186
  char 5c
  catch __ALT_188
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_187
__ALT_188:
  counter 4 3
__COUNTER_191:
  range 48 57
  condjump 4 __COUNTER_191
__SUCCESS_187:
  commit __SUCCESS_185
__ALT_186:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_185:
  partialcommit __FOREVER_184
__FORGIVE_183:
__SUCCESS_182:
  closecapture 47
  char 27
__SUCCESS_181:
  ret -- STRINGLITERAL

INTRPCAPTURETYPES:
  call __prefix
  opencapture 48
  char 72
  char 75
  char 69
  char 6e
  char 74
  char 33
  char 32
__SUCCESS_193:
  closecapture 48
__SUCCESS_192:
  ret -- INTRPCAPTURETYPES

  end 0

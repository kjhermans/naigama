  call __RULE_TOP
  end 0
__RULE_TOP:
  call __RULE_SCRIPT
  call __RULE_END
  ret
__RULE___prefix:
  catch __FORGIVE_18
__ENDLESS_17:
  catch __RIGHTHAND_21
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __FORGIVE_26
__ENDLESS_25:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_25
__FORGIVE_26:
  commit __SUCCESS_21
__RIGHTHAND_21:
  char 23
  catch __FORGIVE_40
__ENDLESS_39:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __ENDLESS_39
__FORGIVE_40:
  char 0a
__SUCCESS_21:
  partialcommit __ENDLESS_17
__FORGIVE_18:
  ret
__RULE_END:
  call __RULE___prefix
  catch __PREFIX_50
  any
  failtwice
__PREFIX_50:
  ret
__RULE_SCRIPT:
  call __RULE___prefix
  catch __FORGIVE_61
__ENDLESS_60:
  call __RULE_TOPSTMT
  partialcommit __ENDLESS_60
__FORGIVE_61:
  ret
__RULE_TOPSTMT:
  call __RULE___prefix
  catch __RIGHTHAND_71
  opencapture 0
  call __RULE_FUNCDECL
  closecapture 0
  commit __SUCCESS_71
__RIGHTHAND_71:
  opencapture 1
  call __RULE_IMPORTSTMT
  closecapture 1
__SUCCESS_71:
  ret
__RULE_IMPORTSTMT:
  call __RULE___prefix
  call __RULE_KW_IMPORT
  opencapture 2
  call __RULE_STRINGLITERAL
  closecapture 2
  call __RULE_SEMICOLON
  ret
__RULE_LOWSTMT:
  call __RULE___prefix
  catch __RIGHTHAND_128
  opencapture 3
  call __RULE_IFSTMT
  closecapture 3
  commit __SUCCESS_128
__RIGHTHAND_128:
  catch __RIGHTHAND_143
  opencapture 4
  call __RULE_WHILESTMT
  closecapture 4
  commit __SUCCESS_143
__RIGHTHAND_143:
  catch __RIGHTHAND_158
  opencapture 5
  call __RULE_RETURNSTMT
  closecapture 5
  commit __SUCCESS_158
__RIGHTHAND_158:
  catch __RIGHTHAND_173
  opencapture 6
  call __RULE_OTHERSTMT
  closecapture 6
  commit __SUCCESS_173
__RIGHTHAND_173:
  catch __RIGHTHAND_188
  opencapture 7
  call __RULE_VARDECL
  closecapture 7
  commit __SUCCESS_188
__RIGHTHAND_188:
  catch __RIGHTHAND_203
  opencapture 8
  call __RULE_ASSIGNMENT
  closecapture 8
  commit __SUCCESS_203
__RIGHTHAND_203:
  catch __FORGIVE_222
  call __RULE_EXPRESSION
  commit __FORGIVE_222
__FORGIVE_222:
  call __RULE_SEMICOLON
__SUCCESS_203:
__SUCCESS_188:
__SUCCESS_173:
__SUCCESS_158:
__SUCCESS_143:
__SUCCESS_128:
  ret
__RULE_FUNCDECL:
  call __RULE___prefix
  call __RULE_KW_FUNCTION
  opencapture 9
  call __RULE_IDENT
  closecapture 9
  call __RULE_BOPEN
  catch __FORGIVE_271
  call __RULE_IDENT
  catch __FORGIVE_285
__ENDLESS_284:
  call __RULE_COMMA
  call __RULE_IDENT
  partialcommit __ENDLESS_284
__FORGIVE_285:
  commit __FORGIVE_271
__FORGIVE_271:
  call __RULE_BCLOSE
  call __RULE_CBOPEN
  catch __FORGIVE_320
__ENDLESS_319:
  call __RULE_LOWSTMT
  partialcommit __ENDLESS_319
__FORGIVE_320:
  call __RULE_CBCLOSE
  ret
__RULE_IFSTMT:
  call __RULE___prefix
  call __RULE_KW_IF
  call __RULE_BOPEN
  call __RULE_EXPRESSION
  call __RULE_BCLOSE
  call __RULE_CBOPEN
  catch __FORGIVE_376
__ENDLESS_375:
  call __RULE_LOWSTMT
  partialcommit __ENDLESS_375
__FORGIVE_376:
  call __RULE_CBCLOSE
  catch __FORGIVE_397
__ENDLESS_396:
  call __RULE_KW_ELSEIF
  call __RULE_BOPEN
  call __RULE_EXPRESSION
  call __RULE_BCLOSE
  call __RULE_CBOPEN
  catch __FORGIVE_439
__ENDLESS_438:
  call __RULE_LOWSTMT
  partialcommit __ENDLESS_438
__FORGIVE_439:
  call __RULE_CBCLOSE
  partialcommit __ENDLESS_396
__FORGIVE_397:
  catch __FORGIVE_460
  call __RULE_KW_ELSE
  call __RULE_CBOPEN
  catch __FORGIVE_481
__ENDLESS_480:
  call __RULE_LOWSTMT
  partialcommit __ENDLESS_480
__FORGIVE_481:
  call __RULE_CBCLOSE
  commit __FORGIVE_460
__FORGIVE_460:
  ret
__RULE_WHILESTMT:
  call __RULE___prefix
  call __RULE_KW_WHILE
  call __RULE_BOPEN
  call __RULE_EXPRESSION
  call __RULE_BCLOSE
  call __RULE_CBOPEN
  catch __FORGIVE_537
__ENDLESS_536:
  call __RULE_LOWSTMT
  partialcommit __ENDLESS_536
__FORGIVE_537:
  call __RULE_CBCLOSE
  ret
__RULE_RETURNSTMT:
  call __RULE___prefix
  call __RULE_KW_RETURN
  call __RULE_EXPRESSION
  call __RULE_SEMICOLON
  ret
__RULE_OTHERSTMT:
  call __RULE___prefix
  catch __RIGHTHAND_582
  call __RULE_KW_BREAK
  commit __SUCCESS_582
__RIGHTHAND_582:
  call __RULE_KW_CONTINUE
__SUCCESS_582:
  call __RULE_SEMICOLON
  ret
__RULE_VARDECL:
  call __RULE___prefix
  call __RULE_KW_VAR
  call __RULE_IDENT
  catch __FORGIVE_622
  call __RULE_ASSIGN
  call __RULE_EXPRESSION
  commit __FORGIVE_622
__FORGIVE_622:
  call __RULE_SEMICOLON
  ret
__RULE_ASSIGNMENT:
  call __RULE___prefix
  call __RULE_IDENT
  call __RULE_ASSIGNS
  call __RULE_EXPRESSION
  call __RULE_SEMICOLON
  ret
__RULE_EXPRESSION:
  call __RULE___prefix
  call __RULE_EXPR2
  catch __FORGIVE_685
__ENDLESS_684:
  catch __RIGHTHAND_695
  call __RULE_AND
  commit __SUCCESS_695
__RIGHTHAND_695:
  call __RULE_OR
__SUCCESS_695:
  call __RULE_EXPR2
  partialcommit __ENDLESS_684
__FORGIVE_685:
  ret
__RULE_EXPR2:
  call __RULE___prefix
  call __RULE_EXPR3
  catch __FORGIVE_728
__ENDLESS_727:
  catch __RIGHTHAND_738
  call __RULE_BITAND
  commit __SUCCESS_738
__RIGHTHAND_738:
  catch __RIGHTHAND_746
  call __RULE_BITOR
  commit __SUCCESS_746
__RIGHTHAND_746:
  call __RULE_BITXOR
__SUCCESS_746:
__SUCCESS_738:
  call __RULE_EXPR3
  partialcommit __ENDLESS_727
__FORGIVE_728:
  ret
__RULE_EXPR3:
  call __RULE___prefix
  call __RULE_EXPR4
  catch __FORGIVE_779
__ENDLESS_778:
  catch __RIGHTHAND_789
  call __RULE_EQUALS
  commit __SUCCESS_789
__RIGHTHAND_789:
  catch __RIGHTHAND_797
  call __RULE_NEQUALS
  commit __SUCCESS_797
__RIGHTHAND_797:
  catch __RIGHTHAND_805
  call __RULE_LTEQ
  commit __SUCCESS_805
__RIGHTHAND_805:
  catch __RIGHTHAND_813
  call __RULE_LT
  commit __SUCCESS_813
__RIGHTHAND_813:
  catch __RIGHTHAND_821
  call __RULE_GTEQ
  commit __SUCCESS_821
__RIGHTHAND_821:
  call __RULE_GT
__SUCCESS_821:
__SUCCESS_813:
__SUCCESS_805:
__SUCCESS_797:
__SUCCESS_789:
  call __RULE_EXPR4
  partialcommit __ENDLESS_778
__FORGIVE_779:
  ret
__RULE_EXPR4:
  call __RULE___prefix
  call __RULE_EXPR5
  catch __FORGIVE_854
__ENDLESS_853:
  catch __RIGHTHAND_864
  call __RULE_POW
  commit __SUCCESS_864
__RIGHTHAND_864:
  catch __RIGHTHAND_872
  call __RULE_MUL
  commit __SUCCESS_872
__RIGHTHAND_872:
  call __RULE_DIV
__SUCCESS_872:
__SUCCESS_864:
  call __RULE_EXPR5
  partialcommit __ENDLESS_853
__FORGIVE_854:
  ret
__RULE_EXPR5:
  call __RULE___prefix
  call __RULE_EXPR6
  catch __FORGIVE_905
__ENDLESS_904:
  catch __RIGHTHAND_915
  call __RULE_ADD
  commit __SUCCESS_915
__RIGHTHAND_915:
  call __RULE_SUB
__SUCCESS_915:
  call __RULE_EXPR6
  partialcommit __ENDLESS_904
__FORGIVE_905:
  ret
__RULE_EXPR6:
  call __RULE___prefix
  catch __FORGIVE_941
__ENDLESS_940:
  opencapture 10
  call __RULE_UNARY
  closecapture 10
  partialcommit __ENDLESS_940
__FORGIVE_941:
  opencapture 11
  call __RULE_TERM
  closecapture 11
  ret
__RULE_UNARY:
  call __RULE___prefix
  catch __RIGHTHAND_965
  call __RULE_NOT
  commit __SUCCESS_965
__RIGHTHAND_965:
  catch __RIGHTHAND_973
  call __RULE_INC
  commit __SUCCESS_973
__RIGHTHAND_973:
  call __RULE_DEC
__SUCCESS_973:
__SUCCESS_965:
  ret
__RULE_TERM:
  call __RULE___prefix
  catch __RIGHTHAND_988
  opencapture 12
  call __RULE_LITERAL
  closecapture 12
  commit __SUCCESS_988
__RIGHTHAND_988:
  catch __RIGHTHAND_1003
  opencapture 13
  call __RULE_IDENT
  closecapture 13
  call __RULE_BOPEN
  catch __FORGIVE_1029
  call __RULE_EXPRESSION
  catch __FORGIVE_1043
__ENDLESS_1042:
  call __RULE_COMMA
  call __RULE_EXPRESSION
  partialcommit __ENDLESS_1042
__FORGIVE_1043:
  commit __FORGIVE_1029
__FORGIVE_1029:
  call __RULE_BCLOSE
  commit __SUCCESS_1003
__RIGHTHAND_1003:
  catch __RIGHTHAND_1067
  opencapture 14
  call __RULE_IDENT
  closecapture 14
  commit __SUCCESS_1067
__RIGHTHAND_1067:
  call __RULE_BOPEN
  opencapture 15
  call __RULE_EXPRESSION
  closecapture 15
  call __RULE_BCLOSE
__SUCCESS_1067:
__SUCCESS_1003:
__SUCCESS_988:
  ret
__RULE_LITERAL:
  call __RULE___prefix
  catch __RIGHTHAND_1110
  call __RULE_STRINGLITERAL
  commit __SUCCESS_1110
__RIGHTHAND_1110:
  catch __RIGHTHAND_1118
  call __RULE_HASHLITERAL
  commit __SUCCESS_1118
__RIGHTHAND_1118:
  catch __RIGHTHAND_1126
  call __RULE_LISTLITERAL
  commit __SUCCESS_1126
__RIGHTHAND_1126:
  catch __RIGHTHAND_1134
  call __RULE_FLOATLITERAL
  commit __SUCCESS_1134
__RIGHTHAND_1134:
  catch __RIGHTHAND_1142
  call __RULE_INTLITERAL
  commit __SUCCESS_1142
__RIGHTHAND_1142:
  call __RULE_BOOLEANLITERAL
__SUCCESS_1142:
__SUCCESS_1134:
__SUCCESS_1126:
__SUCCESS_1118:
__SUCCESS_1110:
  ret
__RULE_STRINGLITERAL:
  call __RULE___prefix
  opencapture 16
  char 27
  catch __FORGIVE_1175
__ENDLESS_1174:
  catch __RIGHTHAND_1178
  char 5c
  catch __RIGHTHAND_1193
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_1193
__RIGHTHAND_1193:
  counter 0 3
__COUNTER_1202:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __COUNTER_1202
__SUCCESS_1193:
  commit __SUCCESS_1178
__RIGHTHAND_1178:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1178:
  partialcommit __ENDLESS_1174
__FORGIVE_1175:
  char 27
  closecapture 16
  ret
__RULE_HASHLITERAL:
  call __RULE___prefix
  opencapture 17
  call __RULE_CBOPEN
  catch __FORGIVE_1240
  call __RULE_HASHELT
  catch __FORGIVE_1254
__ENDLESS_1253:
  call __RULE_COMMA
  call __RULE_HASHELT
  partialcommit __ENDLESS_1253
__FORGIVE_1254:
  commit __FORGIVE_1240
__FORGIVE_1240:
  call __RULE_CBCLOSE
  closecapture 17
  ret
__RULE_HASHELT:
  call __RULE___prefix
  opencapture 18
  call __RULE_HASHKEY
  call __RULE_COLON
  call __RULE_HASHVALUE
  closecapture 18
  ret
__RULE_HASHKEY:
  call __RULE___prefix
  opencapture 19
  call __RULE_TERM
  closecapture 19
  ret
__RULE_HASHVALUE:
  call __RULE___prefix
  opencapture 20
  call __RULE_TERM
  closecapture 20
  ret
__RULE_LISTLITERAL:
  call __RULE___prefix
  opencapture 21
  call __RULE_ABOPEN
  catch __FORGIVE_1352
  call __RULE_LISTELT
  catch __FORGIVE_1366
__ENDLESS_1365:
  call __RULE_COMMA
  call __RULE_LISTELT
  partialcommit __ENDLESS_1365
__FORGIVE_1366:
  commit __FORGIVE_1352
__FORGIVE_1352:
  call __RULE_ABCLOSE
  closecapture 21
  ret
__RULE_LISTELT:
  call __RULE___prefix
  opencapture 22
  call __RULE_TERM
  closecapture 22
  ret
__RULE_FLOATLITERAL:
  call __RULE___prefix
  opencapture 23
  catch __FORGIVE_1415
__ENDLESS_1414:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1414
__FORGIVE_1415:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1429
__ENDLESS_1428:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1428
__FORGIVE_1429:
  closecapture 23
  ret
__RULE_INTLITERAL:
  call __RULE___prefix
  opencapture 24
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1443
__ENDLESS_1442:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1442
__FORGIVE_1443:
  closecapture 24
  ret
__RULE_BOOLEANLITERAL:
  call __RULE___prefix
  opencapture 25
  catch __RIGHTHAND_1453
  quad 74727565
  commit __SUCCESS_1453
__RIGHTHAND_1453:
  quad 66616c73
  char 65
__SUCCESS_1453:
  closecapture 25
  ret
__RULE_KW_IMPORT:
  call __RULE___prefix
  opencapture 26
  quad 696d706f
  char 72
  char 74
  closecapture 26
  ret
__RULE_KW_FUNCTION:
  call __RULE___prefix
  opencapture 27
  quad 66756e63
  quad 74696f6e
  closecapture 27
  ret
__RULE_KW_VAR:
  call __RULE___prefix
  opencapture 28
  char 76
  char 61
  char 72
  closecapture 28
  ret
__RULE_KW_WHILE:
  call __RULE___prefix
  opencapture 29
  quad 7768696c
  char 65
  closecapture 29
  ret
__RULE_KW_RETURN:
  call __RULE___prefix
  opencapture 30
  quad 72657475
  char 72
  char 6e
  closecapture 30
  ret
__RULE_KW_IF:
  call __RULE___prefix
  opencapture 31
  char 69
  char 66
  closecapture 31
  ret
__RULE_KW_ELSEIF:
  call __RULE___prefix
  opencapture 32
  quad 656c7365
  char 69
  char 66
  closecapture 32
  ret
__RULE_KW_ELSE:
  call __RULE___prefix
  opencapture 33
  quad 656c7365
  closecapture 33
  ret
__RULE_KW_BREAK:
  call __RULE___prefix
  opencapture 34
  quad 62726561
  char 6b
  closecapture 34
  ret
__RULE_KW_CONTINUE:
  call __RULE___prefix
  opencapture 35
  quad 636f6e74
  quad 696e7565
  closecapture 35
  ret
__RULE_IDENT:
  call __RULE___prefix
  opencapture 36
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_1626
  counter 1 63
__COUNTER_1624:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __USELESS_1628
__USELESS_1628:
  condjump 1 __COUNTER_1624
  commit __FORGIVE_1626
__FORGIVE_1626:
  closecapture 36
  ret
__RULE_BOPEN:
  call __RULE___prefix
  opencapture 37
  char 28
  closecapture 37
  ret
__RULE_BCLOSE:
  call __RULE___prefix
  opencapture 38
  char 29
  closecapture 38
  ret
__RULE_CBOPEN:
  call __RULE___prefix
  opencapture 39
  char 7b
  closecapture 39
  ret
__RULE_CBCLOSE:
  call __RULE___prefix
  opencapture 40
  char 7d
  closecapture 40
  ret
__RULE_ABOPEN:
  call __RULE___prefix
  opencapture 41
  char 5b
  closecapture 41
  ret
__RULE_ABCLOSE:
  call __RULE___prefix
  opencapture 42
  char 5d
  closecapture 42
  ret
__RULE_ASSIGNS:
  call __RULE___prefix
  opencapture 43
  catch __RIGHTHAND_1720
  call __RULE_ASSIGN
  commit __SUCCESS_1720
__RIGHTHAND_1720:
  catch __RIGHTHAND_1728
  call __RULE_PLUSIS
  commit __SUCCESS_1728
__RIGHTHAND_1728:
  catch __RIGHTHAND_1736
  call __RULE_MINIS
  commit __SUCCESS_1736
__RIGHTHAND_1736:
  catch __RIGHTHAND_1744
  call __RULE_MULIS
  commit __SUCCESS_1744
__RIGHTHAND_1744:
  call __RULE_DIVIS
__SUCCESS_1744:
__SUCCESS_1736:
__SUCCESS_1728:
__SUCCESS_1720:
  closecapture 43
  ret
__RULE_ASSIGN:
  call __RULE___prefix
  opencapture 44
  char 3d
  closecapture 44
  ret
__RULE_PLUSIS:
  call __RULE___prefix
  opencapture 45
  char 2b
  char 3d
  closecapture 45
  ret
__RULE_MINIS:
  call __RULE___prefix
  opencapture 46
  char 2d
  char 3d
  closecapture 46
  ret
__RULE_MULIS:
  call __RULE___prefix
  opencapture 47
  char 2a
  char 3d
  closecapture 47
  ret
__RULE_DIVIS:
  call __RULE___prefix
  opencapture 48
  char 2f
  char 3d
  closecapture 48
  ret
__RULE_EQUALS:
  call __RULE___prefix
  opencapture 49
  char 3d
  char 3d
  closecapture 49
  ret
__RULE_NEQUALS:
  call __RULE___prefix
  opencapture 50
  char 21
  char 3d
  closecapture 50
  ret
__RULE_LT:
  call __RULE___prefix
  opencapture 51
  char 3c
  catch __PREFIX_1871
  char 3d
  failtwice
__PREFIX_1871:
  closecapture 51
  ret
__RULE_GT:
  call __RULE___prefix
  opencapture 52
  char 3e
  catch __PREFIX_1892
  char 3d
  failtwice
__PREFIX_1892:
  closecapture 52
  ret
__RULE_LTEQ:
  call __RULE___prefix
  opencapture 53
  char 3c
  char 3d
  closecapture 53
  ret
__RULE_GTEQ:
  call __RULE___prefix
  opencapture 54
  char 3e
  char 3d
  closecapture 54
  ret
__RULE_SEMICOLON:
  call __RULE___prefix
  opencapture 55
  char 3b
  closecapture 55
  ret
__RULE_COLON:
  call __RULE___prefix
  opencapture 56
  char 3a
  closecapture 56
  ret
__RULE_POW:
  call __RULE___prefix
  opencapture 57
  char 2a
  char 2a
  closecapture 57
  ret
__RULE_MUL:
  call __RULE___prefix
  opencapture 58
  char 2a
  catch __PREFIX_1983
  char 2a
  failtwice
__PREFIX_1983:
  closecapture 58
  ret
__RULE_DIV:
  call __RULE___prefix
  opencapture 59
  char 2f
  catch __PREFIX_2004
  char 3d
  failtwice
__PREFIX_2004:
  closecapture 59
  ret
__RULE_ADD:
  call __RULE___prefix
  opencapture 60
  char 2b
  catch __PREFIX_2025
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__PREFIX_2025:
  closecapture 60
  ret
__RULE_SUB:
  call __RULE___prefix
  opencapture 61
  char 2d
  catch __PREFIX_2046
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__PREFIX_2046:
  closecapture 61
  ret
__RULE_INC:
  call __RULE___prefix
  opencapture 62
  char 2b
  char 2b
  closecapture 62
  ret
__RULE_DEC:
  call __RULE___prefix
  opencapture 63
  char 2d
  char 2d
  closecapture 63
  ret
__RULE_AND:
  call __RULE___prefix
  opencapture 64
  char 26
  char 26
  closecapture 64
  ret
__RULE_OR:
  call __RULE___prefix
  opencapture 65
  char 7c
  char 7c
  closecapture 65
  ret
__RULE_BITAND:
  call __RULE___prefix
  opencapture 66
  char 26
  catch __PREFIX_2123
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__PREFIX_2123:
  closecapture 66
  ret
__RULE_BITOR:
  call __RULE___prefix
  opencapture 67
  char 7c
  catch __PREFIX_2144
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__PREFIX_2144:
  closecapture 67
  ret
__RULE_BITXOR:
  call __RULE___prefix
  opencapture 68
  char 5e
  catch __PREFIX_2165
  char 3d
  failtwice
__PREFIX_2165:
  closecapture 68
  ret
__RULE_NOT:
  call __RULE___prefix
  opencapture 69
  char 21
  catch __PREFIX_2186
  char 3d
  failtwice
__PREFIX_2186:
  closecapture 69
  ret
__RULE_COMMA:
  call __RULE___prefix
  opencapture 70
  char 2c
  closecapture 70
  ret

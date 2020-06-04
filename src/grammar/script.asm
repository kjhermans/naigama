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
  opencapture 10
  call __RULE_IDENT
  closecapture 10
  catch __FORGIVE_629
  call __RULE_ASSIGN
  call __RULE_EXPRESSION
  commit __FORGIVE_629
__FORGIVE_629:
  call __RULE_SEMICOLON
  ret
__RULE_ASSIGNMENT:
  call __RULE___prefix
  opencapture 11
  call __RULE_IDENT
  closecapture 11
  call __RULE_ASSIGNS
  call __RULE_EXPRESSION
  call __RULE_SEMICOLON
  ret
__RULE_EXPRESSION:
  call __RULE___prefix
  call __RULE_EXPR2
  catch __FORGIVE_699
__ENDLESS_698:
  opencapture 12
  catch __RIGHTHAND_709
  call __RULE_AND
  commit __SUCCESS_709
__RIGHTHAND_709:
  call __RULE_OR
__SUCCESS_709:
  closecapture 12
  call __RULE_EXPR2
  partialcommit __ENDLESS_698
__FORGIVE_699:
  ret
__RULE_EXPR2:
  call __RULE___prefix
  call __RULE_EXPR3
  catch __FORGIVE_742
__ENDLESS_741:
  opencapture 13
  catch __RIGHTHAND_752
  call __RULE_BITAND
  commit __SUCCESS_752
__RIGHTHAND_752:
  catch __RIGHTHAND_760
  call __RULE_BITOR
  commit __SUCCESS_760
__RIGHTHAND_760:
  call __RULE_BITXOR
__SUCCESS_760:
__SUCCESS_752:
  closecapture 13
  call __RULE_EXPR3
  partialcommit __ENDLESS_741
__FORGIVE_742:
  ret
__RULE_EXPR3:
  call __RULE___prefix
  call __RULE_EXPR4
  catch __FORGIVE_793
__ENDLESS_792:
  opencapture 14
  catch __RIGHTHAND_803
  call __RULE_EQUALS
  commit __SUCCESS_803
__RIGHTHAND_803:
  catch __RIGHTHAND_811
  call __RULE_NEQUALS
  commit __SUCCESS_811
__RIGHTHAND_811:
  catch __RIGHTHAND_819
  call __RULE_LTEQ
  commit __SUCCESS_819
__RIGHTHAND_819:
  catch __RIGHTHAND_827
  call __RULE_LT
  commit __SUCCESS_827
__RIGHTHAND_827:
  catch __RIGHTHAND_835
  call __RULE_GTEQ
  commit __SUCCESS_835
__RIGHTHAND_835:
  call __RULE_GT
__SUCCESS_835:
__SUCCESS_827:
__SUCCESS_819:
__SUCCESS_811:
__SUCCESS_803:
  closecapture 14
  call __RULE_EXPR4
  partialcommit __ENDLESS_792
__FORGIVE_793:
  ret
__RULE_EXPR4:
  call __RULE___prefix
  call __RULE_EXPR5
  catch __FORGIVE_868
__ENDLESS_867:
  opencapture 15
  catch __RIGHTHAND_878
  call __RULE_POW
  commit __SUCCESS_878
__RIGHTHAND_878:
  catch __RIGHTHAND_886
  call __RULE_MUL
  commit __SUCCESS_886
__RIGHTHAND_886:
  call __RULE_DIV
__SUCCESS_886:
__SUCCESS_878:
  closecapture 15
  call __RULE_EXPR5
  partialcommit __ENDLESS_867
__FORGIVE_868:
  ret
__RULE_EXPR5:
  call __RULE___prefix
  call __RULE_EXPR6
  catch __FORGIVE_919
__ENDLESS_918:
  opencapture 16
  catch __RIGHTHAND_929
  call __RULE_ADD
  commit __SUCCESS_929
__RIGHTHAND_929:
  call __RULE_SUB
__SUCCESS_929:
  closecapture 16
  call __RULE_EXPR6
  partialcommit __ENDLESS_918
__FORGIVE_919:
  ret
__RULE_EXPR6:
  call __RULE___prefix
  catch __FORGIVE_955
__ENDLESS_954:
  call __RULE_UNARY
  partialcommit __ENDLESS_954
__FORGIVE_955:
  call __RULE_TERM
  ret
__RULE_UNARY:
  call __RULE___prefix
  opencapture 17
  catch __RIGHTHAND_979
  call __RULE_NOT
  commit __SUCCESS_979
__RIGHTHAND_979:
  catch __RIGHTHAND_987
  call __RULE_INC
  commit __SUCCESS_987
__RIGHTHAND_987:
  call __RULE_DEC
__SUCCESS_987:
__SUCCESS_979:
  closecapture 17
  ret
__RULE_TERM:
  call __RULE___prefix
  catch __RIGHTHAND_1002
  opencapture 18
  call __RULE_LITERAL
  closecapture 18
  commit __SUCCESS_1002
__RIGHTHAND_1002:
  catch __RIGHTHAND_1017
  opencapture 19
  call __RULE_IDENT
  closecapture 19
  call __RULE_BOPEN
  catch __FORGIVE_1043
  call __RULE_EXPRESSION
  catch __FORGIVE_1057
__ENDLESS_1056:
  call __RULE_COMMA
  call __RULE_EXPRESSION
  partialcommit __ENDLESS_1056
__FORGIVE_1057:
  commit __FORGIVE_1043
__FORGIVE_1043:
  call __RULE_BCLOSE
  commit __SUCCESS_1017
__RIGHTHAND_1017:
  catch __RIGHTHAND_1081
  opencapture 20
  call __RULE_IDENT
  closecapture 20
  commit __SUCCESS_1081
__RIGHTHAND_1081:
  call __RULE_BOPEN
  opencapture 21
  call __RULE_EXPRESSION
  closecapture 21
  call __RULE_BCLOSE
__SUCCESS_1081:
__SUCCESS_1017:
__SUCCESS_1002:
  ret
__RULE_LITERAL:
  call __RULE___prefix
  catch __RIGHTHAND_1124
  call __RULE_STRINGLITERAL
  commit __SUCCESS_1124
__RIGHTHAND_1124:
  catch __RIGHTHAND_1132
  call __RULE_HASHLITERAL
  commit __SUCCESS_1132
__RIGHTHAND_1132:
  catch __RIGHTHAND_1140
  call __RULE_LISTLITERAL
  commit __SUCCESS_1140
__RIGHTHAND_1140:
  catch __RIGHTHAND_1148
  call __RULE_FLOATLITERAL
  commit __SUCCESS_1148
__RIGHTHAND_1148:
  catch __RIGHTHAND_1156
  call __RULE_INTLITERAL
  commit __SUCCESS_1156
__RIGHTHAND_1156:
  call __RULE_BOOLEANLITERAL
__SUCCESS_1156:
__SUCCESS_1148:
__SUCCESS_1140:
__SUCCESS_1132:
__SUCCESS_1124:
  ret
__RULE_STRINGLITERAL:
  call __RULE___prefix
  char 27
  catch __FORGIVE_1182
__ENDLESS_1181:
  catch __RIGHTHAND_1185
  char 5c
  catch __RIGHTHAND_1200
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __SUCCESS_1200
__RIGHTHAND_1200:
  counter 0 3
__COUNTER_1209:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __COUNTER_1209
__SUCCESS_1200:
  commit __SUCCESS_1185
__RIGHTHAND_1185:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__SUCCESS_1185:
  partialcommit __ENDLESS_1181
__FORGIVE_1182:
  char 27
  ret
__RULE_HASHLITERAL:
  call __RULE___prefix
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
  ret
__RULE_HASHELT:
  call __RULE___prefix
  call __RULE_HASHKEY
  call __RULE_COLON
  call __RULE_HASHVALUE
  ret
__RULE_HASHKEY:
  call __RULE___prefix
  call __RULE_TERM
  ret
__RULE_HASHVALUE:
  call __RULE___prefix
  call __RULE_TERM
  ret
__RULE_LISTLITERAL:
  call __RULE___prefix
  call __RULE_ABOPEN
  catch __FORGIVE_1324
  call __RULE_LISTELT
  catch __FORGIVE_1338
__ENDLESS_1337:
  call __RULE_COMMA
  call __RULE_LISTELT
  partialcommit __ENDLESS_1337
__FORGIVE_1338:
  commit __FORGIVE_1324
__FORGIVE_1324:
  call __RULE_ABCLOSE
  ret
__RULE_LISTELT:
  call __RULE___prefix
  call __RULE_TERM
  ret
__RULE_FLOATLITERAL:
  call __RULE___prefix
  catch __FORGIVE_1373
__ENDLESS_1372:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1372
__FORGIVE_1373:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1387
__ENDLESS_1386:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1386
__FORGIVE_1387:
  ret
__RULE_INTLITERAL:
  call __RULE___prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __FORGIVE_1394
__ENDLESS_1393:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __ENDLESS_1393
__FORGIVE_1394:
  ret
__RULE_BOOLEANLITERAL:
  call __RULE___prefix
  catch __RIGHTHAND_1397
  quad 74727565
  commit __SUCCESS_1397
__RIGHTHAND_1397:
  quad 66616c73
  char 65
__SUCCESS_1397:
  ret
__RULE_KW_IMPORT:
  call __RULE___prefix
  quad 696d706f
  char 72
  char 74
  ret
__RULE_KW_FUNCTION:
  call __RULE___prefix
  quad 66756e63
  quad 74696f6e
  ret
__RULE_KW_VAR:
  call __RULE___prefix
  char 76
  char 61
  char 72
  ret
__RULE_KW_WHILE:
  call __RULE___prefix
  quad 7768696c
  char 65
  ret
__RULE_KW_RETURN:
  call __RULE___prefix
  quad 72657475
  char 72
  char 6e
  ret
__RULE_KW_IF:
  call __RULE___prefix
  char 69
  char 66
  ret
__RULE_KW_ELSEIF:
  call __RULE___prefix
  quad 656c7365
  char 69
  char 66
  ret
__RULE_KW_ELSE:
  call __RULE___prefix
  quad 656c7365
  ret
__RULE_KW_BREAK:
  call __RULE___prefix
  quad 62726561
  char 6b
  ret
__RULE_KW_CONTINUE:
  call __RULE___prefix
  quad 636f6e74
  quad 696e7565
  ret
__RULE_IDENT:
  call __RULE___prefix
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __FORGIVE_1493
  counter 1 63
__COUNTER_1491:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __USELESS_1495
__USELESS_1495:
  condjump 1 __COUNTER_1491
  commit __FORGIVE_1493
__FORGIVE_1493:
  ret
__RULE_BOPEN:
  call __RULE___prefix
  char 28
  ret
__RULE_BCLOSE:
  call __RULE___prefix
  char 29
  ret
__RULE_CBOPEN:
  call __RULE___prefix
  char 7b
  ret
__RULE_CBCLOSE:
  call __RULE___prefix
  char 7d
  ret
__RULE_ABOPEN:
  call __RULE___prefix
  char 5b
  ret
__RULE_ABCLOSE:
  call __RULE___prefix
  char 5d
  ret
__RULE_ASSIGNS:
  call __RULE___prefix
  opencapture 22
  catch __RIGHTHAND_1545
  call __RULE_ASSIGN
  commit __SUCCESS_1545
__RIGHTHAND_1545:
  catch __RIGHTHAND_1553
  call __RULE_PLUSIS
  commit __SUCCESS_1553
__RIGHTHAND_1553:
  catch __RIGHTHAND_1561
  call __RULE_MINIS
  commit __SUCCESS_1561
__RIGHTHAND_1561:
  catch __RIGHTHAND_1569
  call __RULE_MULIS
  commit __SUCCESS_1569
__RIGHTHAND_1569:
  call __RULE_DIVIS
__SUCCESS_1569:
__SUCCESS_1561:
__SUCCESS_1553:
__SUCCESS_1545:
  closecapture 22
  ret
__RULE_ASSIGN:
  call __RULE___prefix
  char 3d
  ret
__RULE_PLUSIS:
  call __RULE___prefix
  char 2b
  char 3d
  ret
__RULE_MINIS:
  call __RULE___prefix
  char 2d
  char 3d
  ret
__RULE_MULIS:
  call __RULE___prefix
  char 2a
  char 3d
  ret
__RULE_DIVIS:
  call __RULE___prefix
  char 2f
  char 3d
  ret
__RULE_EQUALS:
  call __RULE___prefix
  char 3d
  char 3d
  ret
__RULE_NEQUALS:
  call __RULE___prefix
  char 21
  char 3d
  ret
__RULE_LT:
  call __RULE___prefix
  char 3c
  catch __PREFIX_1640
  char 3d
  failtwice
__PREFIX_1640:
  ret
__RULE_GT:
  call __RULE___prefix
  char 3e
  catch __PREFIX_1654
  char 3d
  failtwice
__PREFIX_1654:
  ret
__RULE_LTEQ:
  call __RULE___prefix
  char 3c
  char 3d
  ret
__RULE_GTEQ:
  call __RULE___prefix
  char 3e
  char 3d
  ret
__RULE_SEMICOLON:
  call __RULE___prefix
  char 3b
  ret
__RULE_COLON:
  call __RULE___prefix
  char 3a
  ret
__RULE_POW:
  call __RULE___prefix
  char 2a
  char 2a
  ret
__RULE_MUL:
  call __RULE___prefix
  char 2a
  catch __PREFIX_1703
  char 2a
  failtwice
__PREFIX_1703:
  ret
__RULE_DIV:
  call __RULE___prefix
  char 2f
  catch __PREFIX_1717
  char 3d
  failtwice
__PREFIX_1717:
  ret
__RULE_ADD:
  call __RULE___prefix
  char 2b
  catch __PREFIX_1731
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__PREFIX_1731:
  ret
__RULE_SUB:
  call __RULE___prefix
  char 2d
  catch __PREFIX_1745
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__PREFIX_1745:
  ret
__RULE_INC:
  call __RULE___prefix
  char 2b
  char 2b
  ret
__RULE_DEC:
  call __RULE___prefix
  char 2d
  char 2d
  ret
__RULE_AND:
  call __RULE___prefix
  char 26
  char 26
  ret
__RULE_OR:
  call __RULE___prefix
  char 7c
  char 7c
  ret
__RULE_BITAND:
  call __RULE___prefix
  char 26
  catch __PREFIX_1787
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__PREFIX_1787:
  ret
__RULE_BITOR:
  call __RULE___prefix
  char 7c
  catch __PREFIX_1801
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__PREFIX_1801:
  ret
__RULE_BITXOR:
  call __RULE___prefix
  char 5e
  catch __PREFIX_1815
  char 3d
  failtwice
__PREFIX_1815:
  ret
__RULE_NOT:
  call __RULE___prefix
  char 21
  catch __PREFIX_1829
  char 3d
  failtwice
__PREFIX_1829:
  ret
__RULE_COMMA:
  call __RULE___prefix
  char 2c
  ret

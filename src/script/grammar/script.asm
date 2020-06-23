  call TOP
  end
-- Rule
TOP:
  call SCRIPT
  call END
  ret
-- Rule
S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  ret
-- Rule
COMMENT:
  char 23
  catch __TERM_28
__TERM_27:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_27
__TERM_28:
  char 0a
  ret
-- Rule
__prefix:
  catch __TERM_40
__TERM_39:
  catch __RIGHTHAND_42
  call S
  catch __TERM_48
__TERM_47:
  call S
  partialcommit __TERM_47
__TERM_48:
  commit __LEFTHAND_43
__RIGHTHAND_42:
  call COMMENT
__LEFTHAND_43:
  partialcommit __TERM_39
__TERM_40:
  ret
-- Rule
END:
  call __prefix
  catch __TERM_56
  any
  failtwice
__TERM_56:
  ret
-- Rule
SCRIPT:
  call __prefix
  catch __TERM_66
__TERM_65:
  call TOPSTMT
  partialcommit __TERM_65
__TERM_66:
  ret
-- Rule
TOPSTMT:
  call __prefix
  catch __RIGHTHAND_74
  opencapture 0
  call FUNCDECL
  closecapture 0 0
  commit __LEFTHAND_75
__RIGHTHAND_74:
  opencapture 1
  call IMPORTSTMT
  closecapture 1 0
__LEFTHAND_75:
  ret
-- Rule
IMPORTSTMT:
  call __prefix
  call KW_IMPORT
  opencapture 2
  call STRINGLITERAL
  closecapture 2 0
  call SEMICOLON
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_124
  opencapture 3
  call ST_IF
  closecapture 3 0
  commit __LEFTHAND_125
__RIGHTHAND_124:
  catch __RIGHTHAND_138
  opencapture 4
  call ST_WHILE
  closecapture 4 0
  commit __LEFTHAND_139
__RIGHTHAND_138:
  catch __RIGHTHAND_152
  opencapture 5
  call ST_RETURN
  closecapture 5 0
  commit __LEFTHAND_153
__RIGHTHAND_152:
  catch __RIGHTHAND_166
  opencapture 6
  call ST_OTHER
  closecapture 6 0
  commit __LEFTHAND_167
__RIGHTHAND_166:
  catch __RIGHTHAND_180
  opencapture 7
  call VARDECL
  closecapture 7 0
  commit __LEFTHAND_181
__RIGHTHAND_180:
  catch __RIGHTHAND_194
  opencapture 8
  call ASSIGNMENT
  closecapture 8 0
  commit __LEFTHAND_195
__RIGHTHAND_194:
  catch __TERM_211
  call EXPRESSION
  commit __TERM_211
__TERM_211:
  call SEMICOLON
__LEFTHAND_195:
__LEFTHAND_181:
__LEFTHAND_167:
__LEFTHAND_153:
__LEFTHAND_139:
__LEFTHAND_125:
  ret
-- Rule
FUNCDECL:
  call __prefix
  call KW_FUNCTION
  call S
  catch __TERM_236
__TERM_235:
  call S
  partialcommit __TERM_235
__TERM_236:
  call IDENT
  call FUNCPARAMDECL
  call FUNCBODY
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  opencapture 9
  catch __TERM_271
  call IDENT
  catch __TERM_284
__TERM_283:
  call COMMA
  call IDENT
  partialcommit __TERM_283
__TERM_284:
  commit __TERM_271
__TERM_271:
  closecapture 9 0
  call BCLOSE
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  opencapture 10
  catch __TERM_320
__TERM_319:
  call LOWSTMT
  partialcommit __TERM_319
__TERM_320:
  closecapture 10 0
  call CBCLOSE
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 11
  call EXPRESSION
  closecapture 11 0
  call BCLOSE
  call CBOPEN
  opencapture 12
  catch __TERM_374
__TERM_373:
  call LOWSTMT
  partialcommit __TERM_373
__TERM_374:
  closecapture 12 0
  call CBCLOSE
  opencapture 13
  catch __TERM_392
__TERM_391:
  call IF_ELSEIF
  partialcommit __TERM_391
__TERM_392:
  closecapture 13 0
  opencapture 14
  catch __TERM_403
  call IF_ELSE
  commit __TERM_403
__TERM_403:
  closecapture 14 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 15
  call EXPRESSION
  closecapture 15 0
  call BCLOSE
  call CBOPEN
  opencapture 16
  catch __TERM_452
__TERM_451:
  call LOWSTMT
  partialcommit __TERM_451
__TERM_452:
  closecapture 16 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 17
  catch __TERM_482
__TERM_481:
  call LOWSTMT
  partialcommit __TERM_481
__TERM_482:
  closecapture 17 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 18
  call EXPRESSION
  closecapture 18 0
  call BCLOSE
  call CBOPEN
  opencapture 19
  catch __TERM_536
__TERM_535:
  call LOWSTMT
  partialcommit __TERM_535
__TERM_536:
  closecapture 19 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 20
  catch __TERM_559
  call EXPRESSION
  commit __TERM_559
__TERM_559:
  closecapture 20 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_574
  call KW_BREAK
  commit __LEFTHAND_575
__RIGHTHAND_574:
  call KW_CONTINUE
__LEFTHAND_575:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  catch __TERM_604
__TERM_603:
  call S
  partialcommit __TERM_603
__TERM_604:
  call IDENT
  catch __TERM_615
  call ASSIGN
  call EXPRESSION
  commit __TERM_615
__TERM_615:
  call SEMICOLON
  ret
-- Rule
ASSIGNMENT:
  call __prefix
  call IDENT
  call ASSIGNS
  call EXPRESSION
  call SEMICOLON
  ret
-- Rule
EXPRESSION:
  call __prefix
  call EXPR2
  catch __TERM_670
__TERM_669:
  opencapture 21
  catch __RIGHTHAND_678
  call AND
  commit __LEFTHAND_679
__RIGHTHAND_678:
  call OR
__LEFTHAND_679:
  closecapture 21 0
  call EXPR2
  partialcommit __TERM_669
__TERM_670:
  ret
-- Rule
EXPR2:
  call __prefix
  call EXPR3
  catch __TERM_708
__TERM_707:
  opencapture 22
  catch __RIGHTHAND_716
  call BITAND
  commit __LEFTHAND_717
__RIGHTHAND_716:
  catch __RIGHTHAND_724
  call BITOR
  commit __LEFTHAND_725
__RIGHTHAND_724:
  call BITXOR
__LEFTHAND_725:
__LEFTHAND_717:
  closecapture 22 0
  call EXPR3
  partialcommit __TERM_707
__TERM_708:
  ret
-- Rule
EXPR3:
  call __prefix
  call EXPR4
  catch __TERM_754
__TERM_753:
  opencapture 23
  catch __RIGHTHAND_762
  call EQUALS
  commit __LEFTHAND_763
__RIGHTHAND_762:
  catch __RIGHTHAND_770
  call NEQUALS
  commit __LEFTHAND_771
__RIGHTHAND_770:
  catch __RIGHTHAND_778
  call LTEQ
  commit __LEFTHAND_779
__RIGHTHAND_778:
  catch __RIGHTHAND_786
  call LT
  commit __LEFTHAND_787
__RIGHTHAND_786:
  catch __RIGHTHAND_794
  call GTEQ
  commit __LEFTHAND_795
__RIGHTHAND_794:
  call GT
__LEFTHAND_795:
__LEFTHAND_787:
__LEFTHAND_779:
__LEFTHAND_771:
__LEFTHAND_763:
  closecapture 23 0
  call EXPR4
  partialcommit __TERM_753
__TERM_754:
  ret
-- Rule
EXPR4:
  call __prefix
  call EXPR5
  catch __TERM_824
__TERM_823:
  opencapture 24
  catch __RIGHTHAND_832
  call POW
  commit __LEFTHAND_833
__RIGHTHAND_832:
  catch __RIGHTHAND_840
  call MUL
  commit __LEFTHAND_841
__RIGHTHAND_840:
  call DIV
__LEFTHAND_841:
__LEFTHAND_833:
  closecapture 24 0
  call EXPR5
  partialcommit __TERM_823
__TERM_824:
  ret
-- Rule
EXPR5:
  call __prefix
  call EXPR6
  catch __TERM_870
__TERM_869:
  opencapture 25
  catch __RIGHTHAND_878
  call ADD
  commit __LEFTHAND_879
__RIGHTHAND_878:
  call SUB
__LEFTHAND_879:
  closecapture 25 0
  call EXPR6
  partialcommit __TERM_869
__TERM_870:
  ret
-- Rule
EXPR6:
  call __prefix
  catch __TERM_902
__TERM_901:
  opencapture 26
  call UNARY
  closecapture 26 0
  partialcommit __TERM_901
__TERM_902:
  opencapture 27
  call TERM
  closecapture 27 0
  ret
-- Rule
UNARY:
  call __prefix
  catch __RIGHTHAND_922
  call NOT
  commit __LEFTHAND_923
__RIGHTHAND_922:
  catch __RIGHTHAND_930
  call INC
  commit __LEFTHAND_931
__RIGHTHAND_930:
  call DEC
__LEFTHAND_931:
__LEFTHAND_923:
  ret
-- Rule
TERM:
  call __prefix
  catch __RIGHTHAND_944
  opencapture 28
  call LITERAL
  closecapture 28 0
  commit __LEFTHAND_945
__RIGHTHAND_944:
  catch __RIGHTHAND_958
  opencapture 29
  call IDENT
  closecapture 29 0
  call BOPEN
  catch __TERM_981
  call EXPRESSION
  catch __TERM_994
__TERM_993:
  call COMMA
  call EXPRESSION
  partialcommit __TERM_993
__TERM_994:
  commit __TERM_981
__TERM_981:
  call BCLOSE
  commit __LEFTHAND_959
__RIGHTHAND_958:
  catch __RIGHTHAND_1014
  opencapture 30
  call IDENT
  closecapture 30 0
  commit __LEFTHAND_1015
__RIGHTHAND_1014:
  call BOPEN
  opencapture 31
  call EXPRESSION
  closecapture 31 0
  call BCLOSE
__LEFTHAND_1015:
__LEFTHAND_959:
__LEFTHAND_945:
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_1052
  call STRINGLITERAL
  commit __LEFTHAND_1053
__RIGHTHAND_1052:
  catch __RIGHTHAND_1060
  call HASHLITERAL
  commit __LEFTHAND_1061
__RIGHTHAND_1060:
  catch __RIGHTHAND_1068
  call LISTLITERAL
  commit __LEFTHAND_1069
__RIGHTHAND_1068:
  catch __RIGHTHAND_1076
  call FLOATLITERAL
  commit __LEFTHAND_1077
__RIGHTHAND_1076:
  catch __RIGHTHAND_1084
  call INTLITERAL
  commit __LEFTHAND_1085
__RIGHTHAND_1084:
  call BOOLEANLITERAL
__LEFTHAND_1085:
__LEFTHAND_1077:
__LEFTHAND_1069:
__LEFTHAND_1061:
__LEFTHAND_1053:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 32
  catch __TERM_1114
__TERM_1113:
  catch __RIGHTHAND_1116
  char 5c
  catch __RIGHTHAND_1130
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1131
__RIGHTHAND_1130:
  counter 0 3
__TERM_1140:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1140
__LEFTHAND_1131:
  commit __LEFTHAND_1117
__RIGHTHAND_1116:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1117:
  partialcommit __TERM_1113
__TERM_1114:
  closecapture 32 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 33
  call CBOPEN
  catch __TERM_1171
  call HASHELT
  catch __TERM_1184
__TERM_1183:
  call COMMA
  call HASHELT
  partialcommit __TERM_1183
__TERM_1184:
  commit __TERM_1171
__TERM_1171:
  call CBCLOSE
  closecapture 33 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 34
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 34 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 35
  call TERM
  closecapture 35 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 36
  call TERM
  closecapture 36 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 37
  call ABOPEN
  catch __TERM_1267
  call LISTELT
  catch __TERM_1280
__TERM_1279:
  call COMMA
  call LISTELT
  partialcommit __TERM_1279
__TERM_1280:
  commit __TERM_1267
__TERM_1267:
  call ABCLOSE
  closecapture 37 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 38
  call TERM
  closecapture 38 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 39
  catch __TERM_1322
__TERM_1321:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1321
__TERM_1322:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1334
__TERM_1333:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1333
__TERM_1334:
  closecapture 39 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 40
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1346
__TERM_1345:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1345
__TERM_1346:
  closecapture 40 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 41
  catch __RIGHTHAND_1354
  quad 74727565
  commit __LEFTHAND_1355
__RIGHTHAND_1354:
  quad 66616c73
  char 65
__LEFTHAND_1355:
  closecapture 41 0
  ret
-- Rule
KW_IMPORT:
  call __prefix
  quad 696d706f
  char 72
  char 74
  ret
-- Rule
KW_FUNCTION:
  call __prefix
  quad 66756e63
  quad 74696f6e
  ret
-- Rule
KW_VAR:
  call __prefix
  char 76
  char 61
  char 72
  ret
-- Rule
KW_WHILE:
  call __prefix
  quad 7768696c
  char 65
  ret
-- Rule
KW_RETURN:
  call __prefix
  quad 72657475
  char 72
  char 6e
  ret
-- Rule
KW_IF:
  call __prefix
  char 69
  char 66
  ret
-- Rule
KW_ELSEIF:
  call __prefix
  quad 656c7365
  char 69
  char 66
  ret
-- Rule
KW_ELSE:
  call __prefix
  quad 656c7365
  ret
-- Rule
KW_BREAK:
  call __prefix
  quad 62726561
  char 6b
  ret
-- Rule
KW_CONTINUE:
  call __prefix
  quad 636f6e74
  quad 696e7565
  ret
-- Rule
IDENT:
  call __prefix
  opencapture 42
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_1443
  counter 0 63
__TERM_1444:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1445
__TERM_1445:
  condjump 0 __TERM_1444
  commit __TERM_1443
__TERM_1443:
  closecapture 42 0
  ret
-- Rule
BOPEN:
  call __prefix
  char 28
  ret
-- Rule
BCLOSE:
  call __prefix
  char 29
  ret
-- Rule
CBOPEN:
  call __prefix
  char 7b
  ret
-- Rule
CBCLOSE:
  call __prefix
  char 7d
  ret
-- Rule
ABOPEN:
  call __prefix
  char 5b
  ret
-- Rule
ABCLOSE:
  call __prefix
  char 5d
  ret
-- Rule
ASSIGNS:
  call __prefix
  opencapture 43
  catch __RIGHTHAND_1488
  call ASSIGN
  commit __LEFTHAND_1489
__RIGHTHAND_1488:
  catch __RIGHTHAND_1496
  call PLUSIS
  commit __LEFTHAND_1497
__RIGHTHAND_1496:
  catch __RIGHTHAND_1504
  call MINIS
  commit __LEFTHAND_1505
__RIGHTHAND_1504:
  catch __RIGHTHAND_1512
  call MULIS
  commit __LEFTHAND_1513
__RIGHTHAND_1512:
  call DIVIS
__LEFTHAND_1513:
__LEFTHAND_1505:
__LEFTHAND_1497:
__LEFTHAND_1489:
  closecapture 43 0
  ret
-- Rule
ASSIGN:
  call __prefix
  char 3d
  ret
-- Rule
PLUSIS:
  call __prefix
  char 2b
  char 3d
  ret
-- Rule
MINIS:
  call __prefix
  char 2d
  char 3d
  ret
-- Rule
MULIS:
  call __prefix
  char 2a
  char 3d
  ret
-- Rule
DIVIS:
  call __prefix
  char 2f
  char 3d
  ret
-- Rule
EQUALS:
  call __prefix
  char 3d
  char 3d
  ret
-- Rule
NEQUALS:
  call __prefix
  char 21
  char 3d
  ret
-- Rule
LT:
  call __prefix
  char 3c
  catch __TERM_1574
  char 3d
  failtwice
__TERM_1574:
  ret
-- Rule
GT:
  call __prefix
  char 3e
  catch __TERM_1586
  char 3d
  failtwice
__TERM_1586:
  ret
-- Rule
LTEQ:
  call __prefix
  char 3c
  char 3d
  ret
-- Rule
GTEQ:
  call __prefix
  char 3e
  char 3d
  ret
-- Rule
SEMICOLON:
  call __prefix
  char 3b
  ret
-- Rule
COLON:
  call __prefix
  char 3a
  ret
-- Rule
POW:
  call __prefix
  char 2a
  char 2a
  ret
-- Rule
MUL:
  call __prefix
  char 2a
  catch __TERM_1628
  char 2a
  failtwice
__TERM_1628:
  ret
-- Rule
DIV:
  call __prefix
  char 2f
  catch __TERM_1640
  char 3d
  failtwice
__TERM_1640:
  ret
-- Rule
ADD:
  call __prefix
  char 2b
  catch __TERM_1652
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_1652:
  ret
-- Rule
SUB:
  call __prefix
  char 2d
  catch __TERM_1664
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_1664:
  ret
-- Rule
INC:
  call __prefix
  char 2b
  char 2b
  ret
-- Rule
DEC:
  call __prefix
  char 2d
  char 2d
  ret
-- Rule
AND:
  call __prefix
  char 26
  char 26
  ret
-- Rule
OR:
  call __prefix
  char 7c
  char 7c
  ret
-- Rule
BITAND:
  call __prefix
  char 26
  catch __TERM_1700
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_1700:
  ret
-- Rule
BITOR:
  call __prefix
  char 7c
  catch __TERM_1712
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_1712:
  ret
-- Rule
BITXOR:
  call __prefix
  char 5e
  catch __TERM_1724
  char 3d
  failtwice
__TERM_1724:
  ret
-- Rule
NOT:
  call __prefix
  char 21
  catch __TERM_1736
  char 3d
  failtwice
__TERM_1736:
  ret
-- Rule
COMMA:
  call __prefix
  char 2c
  ret

  end 0

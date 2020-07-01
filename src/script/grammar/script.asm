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
  call STRINGLITERAL
  call SEMICOLON
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_118
  opencapture 2
  call ST_IF
  closecapture 2 0
  commit __LEFTHAND_119
__RIGHTHAND_118:
  catch __RIGHTHAND_132
  opencapture 3
  call ST_WHILE
  closecapture 3 0
  commit __LEFTHAND_133
__RIGHTHAND_132:
  catch __RIGHTHAND_146
  opencapture 4
  call ST_RETURN
  closecapture 4 0
  commit __LEFTHAND_147
__RIGHTHAND_146:
  catch __RIGHTHAND_160
  opencapture 5
  call ST_OTHER
  closecapture 5 0
  commit __LEFTHAND_161
__RIGHTHAND_160:
  catch __RIGHTHAND_174
  opencapture 6
  call VARDECL
  closecapture 6 0
  commit __LEFTHAND_175
__RIGHTHAND_174:
  catch __RIGHTHAND_188
  opencapture 7
  call ASSIGNMENT
  closecapture 7 0
  commit __LEFTHAND_189
__RIGHTHAND_188:
  catch __TERM_205
  call EXPRESSION
  commit __TERM_205
__TERM_205:
  call SEMICOLON
__LEFTHAND_189:
__LEFTHAND_175:
__LEFTHAND_161:
__LEFTHAND_147:
__LEFTHAND_133:
__LEFTHAND_119:
  ret
-- Rule
FUNCDECL:
  call __prefix
  call KW_FUNCTION
  call S
  catch __TERM_230
__TERM_229:
  call S
  partialcommit __TERM_229
__TERM_230:
  call IDENT
  call FUNCPARAMDECL
  call FUNCBODY
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  opencapture 8
  catch __TERM_265
  call IDENT
  catch __TERM_278
__TERM_277:
  call COMMA
  call IDENT
  partialcommit __TERM_277
__TERM_278:
  commit __TERM_265
__TERM_265:
  closecapture 8 0
  call BCLOSE
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  opencapture 9
  catch __TERM_314
__TERM_313:
  call LOWSTMT
  partialcommit __TERM_313
__TERM_314:
  closecapture 9 0
  call CBCLOSE
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 10
  call EXPRESSION
  closecapture 10 0
  call BCLOSE
  call CBOPEN
  opencapture 11
  catch __TERM_368
__TERM_367:
  call LOWSTMT
  partialcommit __TERM_367
__TERM_368:
  closecapture 11 0
  call CBCLOSE
  opencapture 12
  catch __TERM_386
__TERM_385:
  call IF_ELSEIF
  partialcommit __TERM_385
__TERM_386:
  closecapture 12 0
  opencapture 13
  catch __TERM_397
  call IF_ELSE
  commit __TERM_397
__TERM_397:
  closecapture 13 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 14
  call EXPRESSION
  closecapture 14 0
  call BCLOSE
  call CBOPEN
  opencapture 15
  catch __TERM_446
__TERM_445:
  call LOWSTMT
  partialcommit __TERM_445
__TERM_446:
  closecapture 15 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 16
  catch __TERM_476
__TERM_475:
  call LOWSTMT
  partialcommit __TERM_475
__TERM_476:
  closecapture 16 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 17
  call EXPRESSION
  closecapture 17 0
  call BCLOSE
  call CBOPEN
  opencapture 18
  catch __TERM_530
__TERM_529:
  call LOWSTMT
  partialcommit __TERM_529
__TERM_530:
  closecapture 18 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 19
  catch __TERM_553
  call EXPRESSION
  commit __TERM_553
__TERM_553:
  closecapture 19 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_568
  call KW_BREAK
  commit __LEFTHAND_569
__RIGHTHAND_568:
  call KW_CONTINUE
__LEFTHAND_569:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  catch __TERM_598
__TERM_597:
  call S
  partialcommit __TERM_597
__TERM_598:
  call IDENT
  catch __TERM_609
  call ASSIGN
  opencapture 20
  call EXPRESSION
  closecapture 20 0
  commit __TERM_609
__TERM_609:
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
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  opencapture 21
  call BINOP_P11
  closecapture 21 0
  catch __TERM_682
__TERM_681:
  call OR
  call BINOP_P11
  partialcommit __TERM_681
__TERM_682:
  ret
-- Rule
BINOP_P11:
  call __prefix
  opencapture 22
  call BINOP_P10
  closecapture 22 0
  catch __TERM_712
__TERM_711:
  call AND
  call BINOP_P10
  partialcommit __TERM_711
__TERM_712:
  ret
-- Rule
BINOP_P10:
  call __prefix
  opencapture 23
  call BINOP_P09
  closecapture 23 0
  catch __TERM_742
__TERM_741:
  call BITOR
  call BINOP_P09
  partialcommit __TERM_741
__TERM_742:
  ret
-- Rule
BINOP_P09:
  call __prefix
  opencapture 24
  call BINOP_P08
  closecapture 24 0
  catch __TERM_772
__TERM_771:
  call BITXOR
  call BINOP_P08
  partialcommit __TERM_771
__TERM_772:
  ret
-- Rule
BINOP_P08:
  call __prefix
  opencapture 25
  call BINOP_P07
  closecapture 25 0
  catch __TERM_802
__TERM_801:
  call BITAND
  call BINOP_P07
  partialcommit __TERM_801
__TERM_802:
  ret
-- Rule
BINOP_P07:
  call __prefix
  opencapture 26
  call BINOP_P06
  closecapture 26 0
  catch __TERM_832
__TERM_831:
  catch __RIGHTHAND_840
  call EQUALS
  commit __LEFTHAND_841
__RIGHTHAND_840:
  call NEQUALS
__LEFTHAND_841:
  call BINOP_P06
  partialcommit __TERM_831
__TERM_832:
  ret
-- Rule
BINOP_P06:
  call __prefix
  opencapture 27
  call BINOP_P05
  closecapture 27 0
  catch __TERM_876
__TERM_875:
  catch __RIGHTHAND_884
  call LTEQ
  commit __LEFTHAND_885
__RIGHTHAND_884:
  catch __RIGHTHAND_892
  call LT
  commit __LEFTHAND_893
__RIGHTHAND_892:
  catch __RIGHTHAND_900
  call GTEQ
  commit __LEFTHAND_901
__RIGHTHAND_900:
  call GT
__LEFTHAND_901:
__LEFTHAND_893:
__LEFTHAND_885:
  call BINOP_P05
  partialcommit __TERM_875
__TERM_876:
  ret
-- Rule
BINOP_P05:
  call __prefix
  opencapture 28
  call BINOP_P04
  closecapture 28 0
  catch __TERM_936
__TERM_935:
  catch __RIGHTHAND_944
  call LSHIFT
  commit __LEFTHAND_945
__RIGHTHAND_944:
  call RSHIFT
__LEFTHAND_945:
  call BINOP_P04
  partialcommit __TERM_935
__TERM_936:
  ret
-- Rule
BINOP_P04:
  call __prefix
  opencapture 29
  call BINOP_P03
  closecapture 29 0
  catch __TERM_980
__TERM_979:
  catch __RIGHTHAND_988
  call ADD
  commit __LEFTHAND_989
__RIGHTHAND_988:
  call SUB
__LEFTHAND_989:
  call BINOP_P03
  partialcommit __TERM_979
__TERM_980:
  ret
-- Rule
BINOP_P03:
  call __prefix
  opencapture 30
  call UNARIES
  closecapture 30 0
  catch __TERM_1024
__TERM_1023:
  catch __RIGHTHAND_1032
  call MUL
  commit __LEFTHAND_1033
__RIGHTHAND_1032:
  catch __RIGHTHAND_1040
  call DIV
  commit __LEFTHAND_1041
__RIGHTHAND_1040:
  call POW
__LEFTHAND_1041:
__LEFTHAND_1033:
  call UNARIES
  partialcommit __TERM_1023
__TERM_1024:
  ret
-- Rule
UNARIES:
  call __prefix
  catch __TERM_1064
__TERM_1063:
  opencapture 31
  call UNARY
  closecapture 31 0
  partialcommit __TERM_1063
__TERM_1064:
  opencapture 32
  call TERM
  closecapture 32 0
  ret
-- Rule
UNARY:
  call __prefix
  catch __RIGHTHAND_1084
  call NOT
  commit __LEFTHAND_1085
__RIGHTHAND_1084:
  catch __RIGHTHAND_1092
  call INC
  commit __LEFTHAND_1093
__RIGHTHAND_1092:
  call DEC
__LEFTHAND_1093:
__LEFTHAND_1085:
  ret
-- Rule
TERM:
  call __prefix
  catch __RIGHTHAND_1106
  opencapture 33
  call LITERAL
  closecapture 33 0
  commit __LEFTHAND_1107
__RIGHTHAND_1106:
  catch __RIGHTHAND_1120
  opencapture 34
  call FUNCTIONCALL
  closecapture 34 0
  commit __LEFTHAND_1121
__RIGHTHAND_1120:
  catch __RIGHTHAND_1134
  opencapture 35
  call REFERENCE
  closecapture 35 0
  commit __LEFTHAND_1135
__RIGHTHAND_1134:
  opencapture 36
  call BOPEN
  opencapture 37
  call EXPRESSION
  closecapture 37 0
  call BCLOSE
  closecapture 36 0
__LEFTHAND_1135:
__LEFTHAND_1121:
__LEFTHAND_1107:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 38
  call REFERENCE
  closecapture 38 0
  call BOPEN
  catch __TERM_1199
  call EXPRESSION
  catch __TERM_1212
__TERM_1211:
  call COMMA
  call EXPRESSION
  partialcommit __TERM_1211
__TERM_1212:
  commit __TERM_1199
__TERM_1199:
  call BCLOSE
  ret
-- Rule
REFERENCE:
  call __prefix
  call IDENT
  catch __TERM_1242
__TERM_1241:
  call DOT
  call IDENT
  partialcommit __TERM_1241
__TERM_1242:
  catch __TERM_1260
__TERM_1259:
  call INDEX
  partialcommit __TERM_1259
__TERM_1260:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 39
  call EXPRESSION
  closecapture 39 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_1286
  call STRINGLITERAL
  commit __LEFTHAND_1287
__RIGHTHAND_1286:
  catch __RIGHTHAND_1294
  call HASHLITERAL
  commit __LEFTHAND_1295
__RIGHTHAND_1294:
  catch __RIGHTHAND_1302
  call LISTLITERAL
  commit __LEFTHAND_1303
__RIGHTHAND_1302:
  catch __RIGHTHAND_1310
  call FLOATLITERAL
  commit __LEFTHAND_1311
__RIGHTHAND_1310:
  catch __RIGHTHAND_1318
  call INTLITERAL
  commit __LEFTHAND_1319
__RIGHTHAND_1318:
  call BOOLEANLITERAL
__LEFTHAND_1319:
__LEFTHAND_1311:
__LEFTHAND_1303:
__LEFTHAND_1295:
__LEFTHAND_1287:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 40
  catch __TERM_1348
__TERM_1347:
  catch __RIGHTHAND_1350
  char 5c
  catch __RIGHTHAND_1364
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_1365
__RIGHTHAND_1364:
  counter 0 3
__TERM_1374:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1374
__LEFTHAND_1365:
  commit __LEFTHAND_1351
__RIGHTHAND_1350:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1351:
  partialcommit __TERM_1347
__TERM_1348:
  closecapture 40 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 41
  call CBOPEN
  catch __TERM_1405
  call HASHELT
  catch __TERM_1418
__TERM_1417:
  call COMMA
  call HASHELT
  partialcommit __TERM_1417
__TERM_1418:
  commit __TERM_1405
__TERM_1405:
  call CBCLOSE
  closecapture 41 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 42
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 42 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 43
  call TERM
  closecapture 43 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 44
  call TERM
  closecapture 44 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 45
  call ABOPEN
  catch __TERM_1501
  call LISTELT
  catch __TERM_1514
__TERM_1513:
  call COMMA
  call LISTELT
  partialcommit __TERM_1513
__TERM_1514:
  commit __TERM_1501
__TERM_1501:
  call ABCLOSE
  closecapture 45 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 46
  call TERM
  closecapture 46 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 47
  catch __TERM_1556
__TERM_1555:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1555
__TERM_1556:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1568
__TERM_1567:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1567
__TERM_1568:
  closecapture 47 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 48
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1580
__TERM_1579:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1579
__TERM_1580:
  closecapture 48 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 49
  catch __RIGHTHAND_1588
  quad 74727565
  commit __LEFTHAND_1589
__RIGHTHAND_1588:
  quad 66616c73
  char 65
__LEFTHAND_1589:
  closecapture 49 0
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
  opencapture 50
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_1677
  counter 0 63
__TERM_1678:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_1679
__TERM_1679:
  condjump 0 __TERM_1678
  commit __TERM_1677
__TERM_1677:
  closecapture 50 0
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
  opencapture 51
  catch __RIGHTHAND_1722
  call ASSIGN
  commit __LEFTHAND_1723
__RIGHTHAND_1722:
  catch __RIGHTHAND_1730
  call PLUSIS
  commit __LEFTHAND_1731
__RIGHTHAND_1730:
  catch __RIGHTHAND_1738
  call MINIS
  commit __LEFTHAND_1739
__RIGHTHAND_1738:
  catch __RIGHTHAND_1746
  call MULIS
  commit __LEFTHAND_1747
__RIGHTHAND_1746:
  call DIVIS
__LEFTHAND_1747:
__LEFTHAND_1739:
__LEFTHAND_1731:
__LEFTHAND_1723:
  closecapture 51 0
  ret
-- Rule
ASSIGN:
  call __prefix
  opencapture 52
  char 3d
  closecapture 52 0
  ret
-- Rule
PLUSIS:
  call __prefix
  opencapture 53
  char 2b
  char 3d
  closecapture 53 0
  ret
-- Rule
MINIS:
  call __prefix
  opencapture 54
  char 2d
  char 3d
  closecapture 54 0
  ret
-- Rule
MULIS:
  call __prefix
  opencapture 55
  char 2a
  char 3d
  closecapture 55 0
  ret
-- Rule
DIVIS:
  call __prefix
  opencapture 56
  char 2f
  char 3d
  closecapture 56 0
  ret
-- Rule
EQUALS:
  call __prefix
  opencapture 57
  char 3d
  char 3d
  closecapture 57 0
  ret
-- Rule
NEQUALS:
  call __prefix
  opencapture 58
  char 21
  char 3d
  closecapture 58 0
  ret
-- Rule
LT:
  call __prefix
  opencapture 59
  char 3c
  catch __TERM_1856
  char 3d
  failtwice
__TERM_1856:
  closecapture 59 0
  ret
-- Rule
GT:
  call __prefix
  opencapture 60
  char 3e
  catch __TERM_1874
  char 3d
  failtwice
__TERM_1874:
  closecapture 60 0
  ret
-- Rule
LTEQ:
  call __prefix
  opencapture 61
  char 3c
  char 3d
  closecapture 61 0
  ret
-- Rule
GTEQ:
  call __prefix
  opencapture 62
  char 3e
  char 3d
  closecapture 62 0
  ret
-- Rule
SEMICOLON:
  call __prefix
  char 3b
  ret
-- Rule
COLON:
  call __prefix
  opencapture 63
  char 3a
  closecapture 63 0
  ret
-- Rule
POW:
  call __prefix
  opencapture 64
  char 2a
  char 2a
  closecapture 64 0
  ret
-- Rule
MUL:
  call __prefix
  opencapture 65
  char 2a
  catch __TERM_1946
  char 2a
  failtwice
__TERM_1946:
  closecapture 65 0
  ret
-- Rule
DIV:
  call __prefix
  opencapture 66
  char 2f
  catch __TERM_1964
  char 3d
  failtwice
__TERM_1964:
  closecapture 66 0
  ret
-- Rule
ADD:
  call __prefix
  opencapture 67
  char 2b
  catch __TERM_1982
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_1982:
  closecapture 67 0
  ret
-- Rule
SUB:
  call __prefix
  opencapture 68
  char 2d
  catch __TERM_2000
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_2000:
  closecapture 68 0
  ret
-- Rule
INC:
  call __prefix
  opencapture 69
  char 2b
  char 2b
  closecapture 69 0
  ret
-- Rule
DEC:
  call __prefix
  opencapture 70
  char 2d
  char 2d
  closecapture 70 0
  ret
-- Rule
AND:
  call __prefix
  opencapture 71
  char 26
  char 26
  closecapture 71 0
  ret
-- Rule
OR:
  call __prefix
  opencapture 72
  char 7c
  char 7c
  closecapture 72 0
  ret
-- Rule
BITAND:
  call __prefix
  opencapture 73
  char 26
  catch __TERM_2066
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_2066:
  closecapture 73 0
  ret
-- Rule
BITOR:
  call __prefix
  opencapture 74
  char 7c
  catch __TERM_2084
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_2084:
  closecapture 74 0
  ret
-- Rule
BITXOR:
  call __prefix
  opencapture 75
  char 5e
  catch __TERM_2102
  char 3d
  failtwice
__TERM_2102:
  closecapture 75 0
  ret
-- Rule
NOT:
  call __prefix
  opencapture 76
  char 21
  catch __TERM_2120
  char 3d
  failtwice
__TERM_2120:
  closecapture 76 0
  ret
-- Rule
COMMA:
  call __prefix
  opencapture 77
  char 2c
  closecapture 77 0
  ret
-- Rule
DOT:
  call __prefix
  opencapture 78
  char 2e
  closecapture 78 0
  ret
-- Rule
LSHIFT:
  call __prefix
  opencapture 79
  char 3c
  char 3c
  closecapture 79 0
  ret
-- Rule
RSHIFT:
  call __prefix
  opencapture 80
  char 3e
  char 3e
  closecapture 80 0
  ret

  end 0

  call GRAMMAR
  end
-- Rule
GRAMMAR:
  opencapture 0
  catch __RIGHTHAND_6
  call DEFINITION
  catch __TERM_12
__TERM_11:
  call DEFINITION
  partialcommit __TERM_11
__TERM_12:
  commit __LEFTHAND_7
__RIGHTHAND_6:
  call SINGLE_EXPRESSION
__LEFTHAND_7:
  call END
  closecapture 0
  ret
-- Rule
S:
  opencapture 1
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __TERM_30
__TERM_29:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_29
__TERM_30:
  closecapture 1
  ret
-- Rule
MULTILINECOMMENT:
  opencapture 2
  quad 2d2d5b5b
  catch __TERM_42
__TERM_41:
  catch __TERM_44
  char 5d
  char 5d
  failtwice
__TERM_44:
  any
  partialcommit __TERM_41
__TERM_42:
  char 5d
  char 5d
  closecapture 2
  ret
-- Rule
COMMENT:
  opencapture 3
  char 2d
  char 2d
  catch __TERM_72
__TERM_71:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_71
__TERM_72:
  char 0a
  closecapture 3
  ret
-- Rule
__prefix:
  catch __TERM_84
__TERM_83:
  catch __RIGHTHAND_86
  call MULTILINECOMMENT
  commit __LEFTHAND_87
__RIGHTHAND_86:
  catch __RIGHTHAND_94
  call COMMENT
  commit __LEFTHAND_95
__RIGHTHAND_94:
  call S
__LEFTHAND_95:
__LEFTHAND_87:
  partialcommit __TERM_83
__TERM_84:
  ret
-- Rule
END:
  call __prefix
  opencapture 4
  catch __TERM_108
  any
  failtwice
__TERM_108:
  closecapture 4
  ret
-- Rule
DEFINITION:
  call __prefix
  opencapture 5
  catch __RIGHTHAND_114
  call GLOBALVARDECL
  commit __LEFTHAND_115
__RIGHTHAND_114:
  catch __RIGHTHAND_122
  call FUNCDECL
  commit __LEFTHAND_123
__RIGHTHAND_122:
  catch __RIGHTHAND_130
  call TYPEDECL
  commit __LEFTHAND_131
__RIGHTHAND_130:
  call RULE
__LEFTHAND_131:
__LEFTHAND_123:
__LEFTHAND_115:
  closecapture 5
  ret
-- Rule
SINGLE_EXPRESSION:
  call __prefix
  opencapture 6
  call EXPRESSION
  closecapture 6
  ret
-- Rule
RULE:
  call __prefix
  opencapture 7
  call IDENT
  call LEFTARROW
  call EXPRESSION
  closecapture 7
  ret
-- Rule
EXPRESSION:
  call __prefix
  opencapture 8
  catch __RIGHTHAND_168
  call ALTERNATIVES
  commit __LEFTHAND_169
__RIGHTHAND_168:
  call TERMS
__LEFTHAND_169:
  closecapture 8
  ret
-- Rule
ALTERNATIVES:
  call __prefix
  opencapture 9
  call TERMS
  call OR
  call EXPRESSION
  closecapture 9
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 10
  call TERM
  catch __TERM_204
__TERM_203:
  call TERM
  partialcommit __TERM_203
__TERM_204:
  closecapture 10
  ret
-- Rule
TERM:
  call __prefix
  opencapture 11
  catch __RIGHTHAND_206
  call SCANMATCHER
  commit __LEFTHAND_207
__RIGHTHAND_206:
  call QUANTIFIEDMATCHER
__LEFTHAND_207:
  closecapture 11
  ret
-- Rule
SCANMATCHER:
  call __prefix
  opencapture 12
  catch __RIGHTHAND_226
  call NOT
  commit __LEFTHAND_227
__RIGHTHAND_226:
  call AND
__LEFTHAND_227:
  call MATCHER
  closecapture 12
  ret
-- Rule
QUANTIFIEDMATCHER:
  call __prefix
  opencapture 13
  call MATCHER
  catch __TERM_255
  call QUANTIFIER
  commit __TERM_255
__TERM_255:
  closecapture 13
  ret
-- Rule
QUANTIFIER:
  call __prefix
  opencapture 14
  catch __RIGHTHAND_258
  call Q_ZEROORONE
  commit __LEFTHAND_259
__RIGHTHAND_258:
  catch __RIGHTHAND_266
  call Q_ONEORMORE
  commit __LEFTHAND_267
__RIGHTHAND_266:
  catch __RIGHTHAND_274
  call Q_ZEROORMORE
  commit __LEFTHAND_275
__RIGHTHAND_274:
  catch __RIGHTHAND_282
  call Q_FROMTO
  commit __LEFTHAND_283
__RIGHTHAND_282:
  catch __RIGHTHAND_290
  call Q_UNTIL
  commit __LEFTHAND_291
__RIGHTHAND_290:
  catch __RIGHTHAND_298
  call Q_FROM
  commit __LEFTHAND_299
__RIGHTHAND_298:
  catch __RIGHTHAND_306
  call Q_SPECIFIC
  commit __LEFTHAND_307
__RIGHTHAND_306:
  call Q_VAR
__LEFTHAND_307:
__LEFTHAND_299:
__LEFTHAND_291:
__LEFTHAND_283:
__LEFTHAND_275:
__LEFTHAND_267:
__LEFTHAND_259:
  closecapture 14
  ret
-- Rule
Q_ZEROORONE:
  call __prefix
  opencapture 15
  char 3f
  closecapture 15
  ret
-- Rule
Q_ONEORMORE:
  call __prefix
  opencapture 16
  char 2b
  closecapture 16
  ret
-- Rule
Q_ZEROORMORE:
  call __prefix
  opencapture 17
  char 2a
  closecapture 17
  ret
-- Rule
Q_FROMTO:
  call __prefix
  opencapture 18
  char 5e
  opencapture 19
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_354
__TERM_353:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_353
__TERM_354:
  closecapture 19 0
  char 2d
  opencapture 20
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_372
__TERM_371:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_371
__TERM_372:
  closecapture 20 0
  closecapture 18
  ret
-- Rule
Q_UNTIL:
  call __prefix
  opencapture 21
  char 5e
  char 2d
  opencapture 22
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_396
__TERM_395:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_395
__TERM_396:
  closecapture 22 0
  closecapture 21
  ret
-- Rule
Q_FROM:
  call __prefix
  opencapture 23
  char 5e
  opencapture 24
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_414
__TERM_413:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_413
__TERM_414:
  closecapture 24 0
  char 2d
  closecapture 23
  ret
-- Rule
Q_SPECIFIC:
  call __prefix
  opencapture 25
  char 5e
  opencapture 26
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_438
__TERM_437:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_437
__TERM_438:
  closecapture 26 0
  closecapture 25
  ret
-- Rule
Q_VAR:
  call __prefix
  opencapture 27
  char 5e
  call BOPEN
  call VARREFERENCE
  call BCLOSE
  closecapture 27
  ret
-- Rule
MATCHER:
  call __prefix
  opencapture 28
  catch __RIGHTHAND_464
  call ANY
  commit __LEFTHAND_465
__RIGHTHAND_464:
  catch __RIGHTHAND_472
  call SET
  commit __LEFTHAND_473
__RIGHTHAND_472:
  catch __RIGHTHAND_480
  call STRING
  commit __LEFTHAND_481
__RIGHTHAND_480:
  catch __RIGHTHAND_488
  call BITMASK
  commit __LEFTHAND_489
__RIGHTHAND_488:
  catch __RIGHTHAND_496
  call HEXLITERAL
  commit __LEFTHAND_497
__RIGHTHAND_496:
  catch __RIGHTHAND_504
  call VARCAPTURE
  commit __LEFTHAND_505
__RIGHTHAND_504:
  catch __RIGHTHAND_512
  call CAPTURE
  commit __LEFTHAND_513
__RIGHTHAND_512:
  catch __RIGHTHAND_520
  call GROUP
  commit __LEFTHAND_521
__RIGHTHAND_520:
  catch __RIGHTHAND_528
  call MACRO
  commit __LEFTHAND_529
__RIGHTHAND_528:
  catch __RIGHTHAND_536
  call ENDFORCE
  commit __LEFTHAND_537
__RIGHTHAND_536:
  catch __RIGHTHAND_544
  call VARREFERENCE
  commit __LEFTHAND_545
__RIGHTHAND_544:
  catch __RIGHTHAND_552
  call REFERENCE
  commit __LEFTHAND_553
__RIGHTHAND_552:
  call LIMITEDCALL
__LEFTHAND_553:
__LEFTHAND_545:
__LEFTHAND_537:
__LEFTHAND_529:
__LEFTHAND_521:
__LEFTHAND_513:
__LEFTHAND_505:
__LEFTHAND_497:
__LEFTHAND_489:
__LEFTHAND_481:
__LEFTHAND_473:
__LEFTHAND_465:
  closecapture 28
  ret
-- Rule
BITMASK:
  call __prefix
  opencapture 29
  char 7c
  counter 0 2
__TERM_574:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_574
  char 7c
  counter 0 2
__TERM_586:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_586
  char 7c
  closecapture 29
  ret
-- Rule
VARCAPTURE:
  call __prefix
  opencapture 30
  call CBOPEN
  call COLON
  call IDENT
  catch __TERM_617
  call CAPTURETYPE
  commit __TERM_617
__TERM_617:
  call COLON
  call EXPRESSION
  call CBCLOSE
  call CAPTUREEND
  closecapture 30
  ret
-- Rule
CAPTURETYPE:
  call __prefix
  opencapture 31
  call SEMICOLON
  call TYPE
  closecapture 31
  ret
-- Rule
TYPE:
  call __prefix
  opencapture 32
  catch __RIGHTHAND_656
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_657
__RIGHTHAND_656:
  quad 696e7433
  char 32
__LEFTHAND_657:
  closecapture 32
  ret
-- Rule
CAPTURE:
  call __prefix
  opencapture 33
  call CBOPEN
  call EXPRESSION
  call CBCLOSE
  call CAPTUREEND
  closecapture 33
  ret
-- Rule
GROUP:
  call __prefix
  opencapture 34
  call BOPEN
  call EXPRESSION
  call BCLOSE
  closecapture 34
  ret
-- Rule
CAPTUREEND:
  call __prefix
  opencapture 35
  catch __TERM_715
  catch __RIGHTHAND_718
  call REPLACE
  commit __LEFTHAND_719
__RIGHTHAND_718:
  call RECYCLE
__LEFTHAND_719:
  commit __TERM_715
__TERM_715:
  closecapture 35
  ret
-- Rule
SET:
  call __prefix
  opencapture 36
  call ABOPEN
  catch __TERM_741
  call SETNOT
  commit __TERM_741
__TERM_741:
  catch __RIGHTHAND_750
  opencapture 37
  catch __RIGHTHAND_758
  char 5c
  catch __RIGHTHAND_772
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_773
__RIGHTHAND_772:
  counter 0 3
__TERM_782:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_782
__LEFTHAND_773:
  commit __LEFTHAND_759
__RIGHTHAND_758:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_759:
  closecapture 37 0
  char 2d
  opencapture 38
  catch __RIGHTHAND_804
  char 5c
  catch __RIGHTHAND_818
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_819
__RIGHTHAND_818:
  counter 0 3
__TERM_828:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_828
__LEFTHAND_819:
  commit __LEFTHAND_805
__RIGHTHAND_804:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_805:
  closecapture 38 0
  commit __LEFTHAND_751
__RIGHTHAND_750:
  opencapture 39
  catch __RIGHTHAND_844
  char 5c
  catch __RIGHTHAND_858
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_859
__RIGHTHAND_858:
  counter 0 3
__TERM_868:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_868
__LEFTHAND_859:
  commit __LEFTHAND_845
__RIGHTHAND_844:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_845:
  closecapture 39 0
__LEFTHAND_751:
  catch __TERM_748
__TERM_747:
  catch __RIGHTHAND_878
  opencapture 37
  catch __RIGHTHAND_886
  char 5c
  catch __RIGHTHAND_900
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_901
__RIGHTHAND_900:
  counter 0 3
__TERM_910:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_910
__LEFTHAND_901:
  commit __LEFTHAND_887
__RIGHTHAND_886:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_887:
  closecapture 37 0
  char 2d
  opencapture 38
  catch __RIGHTHAND_932
  char 5c
  catch __RIGHTHAND_946
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_947
__RIGHTHAND_946:
  counter 0 3
__TERM_956:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_956
__LEFTHAND_947:
  commit __LEFTHAND_933
__RIGHTHAND_932:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_933:
  closecapture 38 0
  commit __LEFTHAND_879
__RIGHTHAND_878:
  opencapture 39
  catch __RIGHTHAND_972
  char 5c
  catch __RIGHTHAND_986
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_987
__RIGHTHAND_986:
  counter 0 3
__TERM_996:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_996
__LEFTHAND_987:
  commit __LEFTHAND_973
__RIGHTHAND_972:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_973:
  closecapture 39 0
__LEFTHAND_879:
  partialcommit __TERM_747
__TERM_748:
  call ABCLOSE
  closecapture 36
  ret
-- Rule
VARREFERENCE:
  call __prefix
  opencapture 40
  char 24
  catch __RIGHTHAND_1024
  call IDENT
  commit __LEFTHAND_1025
__RIGHTHAND_1024:
  call NUMBER
__LEFTHAND_1025:
  catch __TERM_1041
  call MASK
  commit __TERM_1041
__TERM_1041:
  closecapture 40
  ret
-- Rule
MASK:
  call __prefix
  opencapture 41
  char 7c
  opencapture 42
  counter 0 2
__TERM_1058:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1058
  closecapture 42 0
  closecapture 41
  ret
-- Rule
REFERENCE:
  call __prefix
  opencapture 43
  catch __TERM_1062
  catch __RIGHTHAND_1068
  call KW_TYPE
  commit __LEFTHAND_1069
__RIGHTHAND_1068:
  catch __RIGHTHAND_1076
  call KW_IMPORT
  commit __LEFTHAND_1077
__RIGHTHAND_1076:
  catch __RIGHTHAND_1084
  call KW_FUNCTION
  commit __LEFTHAND_1085
__RIGHTHAND_1084:
  call KW_VAR
__LEFTHAND_1085:
__LEFTHAND_1077:
__LEFTHAND_1069:
  failtwice
__TERM_1062:
  call IDENT
  catch __TERM_1104
  call LEFTARROW
  failtwice
__TERM_1104:
  closecapture 43
  ret
-- Rule
LIMITEDCALL:
  call __prefix
  opencapture 44
  char 3c
  char 3c
  catch __TERM_1120
__TERM_1119:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1119
__TERM_1120:
  call LCMODES
  catch __TERM_1132
__TERM_1131:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1131
__TERM_1132:
  char 3a
  catch __TERM_1144
__TERM_1143:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1143
__TERM_1144:
  call LCPARAM
  catch __TERM_1156
__TERM_1155:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1155
__TERM_1156:
  char 3a
  catch __TERM_1168
__TERM_1167:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1167
__TERM_1168:
  call IDENT
  catch __TERM_1180
__TERM_1179:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_1179
__TERM_1180:
  char 3e
  char 3e
  closecapture 44
  ret
-- Rule
LCMODES:
  call __prefix
  opencapture 45
  quad 7275696e
  char 74
  char 33
  char 32
  closecapture 45
  ret
-- Rule
LCPARAM:
  call __prefix
  opencapture 46
  catch __TERM_1198
__TERM_1197:
  set ffd1fffffefffffbffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_1197
__TERM_1198:
  closecapture 46
  ret
-- Rule
REPLACE:
  call __prefix
  opencapture 47
  call RIGHTARROW
  call REPLACETERMS
  closecapture 47
  ret
-- Rule
REPLACETERMS:
  call __prefix
  opencapture 48
  call REPLACETERM
  catch __TERM_1216
__TERM_1215:
  call REPLACETERM
  partialcommit __TERM_1215
__TERM_1216:
  closecapture 48
  ret
-- Rule
REPLACETERM:
  call __prefix
  opencapture 49
  catch __RIGHTHAND_1218
  call STRINGLITERAL
  commit __LEFTHAND_1219
__RIGHTHAND_1218:
  catch __RIGHTHAND_1226
  call HEXLITERAL
  commit __LEFTHAND_1227
__RIGHTHAND_1226:
  call VARREFERENCE
__LEFTHAND_1227:
__LEFTHAND_1219:
  closecapture 49
  ret
-- Rule
RECYCLE:
  call __prefix
  opencapture 50
  call FATARROW
  call IDENT
  closecapture 50
  ret
-- Rule
LEFTARROW:
  call __prefix
  opencapture 51
  char 3c
  char 2d
  closecapture 51
  ret
-- Rule
RIGHTARROW:
  call __prefix
  opencapture 52
  char 2d
  char 3e
  closecapture 52
  ret
-- Rule
FATARROW:
  call __prefix
  opencapture 53
  char 3d
  char 3e
  closecapture 53
  ret
-- Rule
NOT:
  call __prefix
  opencapture 54
  char 21
  closecapture 54
  ret
-- Rule
AND:
  call __prefix
  opencapture 55
  char 26
  closecapture 55
  ret
-- Rule
MACRO:
  call __prefix
  opencapture 56
  char 25
  set 0000000000000000feffff07feffff0700000000000000000000000000000000
  catch __TERM_1298
__TERM_1297:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1297
__TERM_1298:
  closecapture 56
  ret
-- Rule
ENDFORCE:
  call __prefix
  opencapture 57
  quad 5f5f656e
  char 64
  call S
  call NUMBER
  closecapture 57
  ret
-- Rule
HEXLITERAL:
  call __prefix
  opencapture 58
  char 30
  char 78
  counter 0 2
__TERM_1326:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1326
  closecapture 58
  ret
-- Rule
NUMBER:
  call __prefix
  opencapture 59
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1334
__TERM_1333:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1333
__TERM_1334:
  closecapture 59
  ret
-- Rule
STRING:
  call __prefix
  opencapture 60
  call STRINGLITERAL
  catch __TERM_1345
  char 69
  commit __TERM_1345
__TERM_1345:
  closecapture 60
  ret
-- Rule
OR:
  call __prefix
  opencapture 61
  char 2f
  closecapture 61
  ret
-- Rule
ANY:
  call __prefix
  opencapture 62
  char 2e
  closecapture 62
  ret
-- Rule
SETNOT:
  call __prefix
  opencapture 63
  char 5e
  closecapture 63
  ret
-- Rule
IMPORTDECL:
  call __prefix
  opencapture 64
  call KW_IMPORT
  call STRING
  call SEMICOLON
  closecapture 64
  ret
-- Rule
TYPEDECL:
  call __prefix
  opencapture 65
  call KW_TYPE
  call S
  call IDENT
  call ABOPEN
  catch __RIGHTHAND_1414
  call VARDECL
  commit __LEFTHAND_1415
__RIGHTHAND_1414:
  call TYPEDECL
__LEFTHAND_1415:
  catch __TERM_1412
__TERM_1411:
  catch __RIGHTHAND_1428
  call VARDECL
  commit __LEFTHAND_1429
__RIGHTHAND_1428:
  call TYPEDECL
__LEFTHAND_1429:
  partialcommit __TERM_1411
__TERM_1412:
  call ABCLOSE
  closecapture 65
  ret
-- Rule
FUNCDECL:
  call __prefix
  opencapture 66
  call KW_FUNCTION
  call S
  call IDENT
  call FUNCPARAMDECL
  call FUNCBODY
  closecapture 66
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  opencapture 67
  call BOPEN
  catch __TERM_1487
  call PARAMDECL
  catch __TERM_1500
__TERM_1499:
  call COMMA
  call PARAMDECL
  partialcommit __TERM_1499
__TERM_1500:
  commit __TERM_1487
__TERM_1487:
  call BCLOSE
  closecapture 67
  ret
-- Rule
PARAMDECL:
  call __prefix
  opencapture 68
  catch __RIGHTHAND_1520
  call SCR_TYPE
  call S
  call IDENT
  commit __LEFTHAND_1521
__RIGHTHAND_1520:
  call IDENT
__LEFTHAND_1521:
  closecapture 68
  ret
-- Rule
FUNCBODY:
  call __prefix
  opencapture 69
  call CBOPEN
  catch __TERM_1556
__TERM_1555:
  call FUNCSTMT
  partialcommit __TERM_1555
__TERM_1556:
  call CBCLOSE
  closecapture 69
  ret
-- Rule
GLOBALVARDECL:
  call __prefix
  opencapture 70
  call VARDECL
  closecapture 70
  ret
-- Rule
FUNCSTMT:
  call __prefix
  opencapture 71
  catch __RIGHTHAND_1570
  call ST_IF
  commit __LEFTHAND_1571
__RIGHTHAND_1570:
  catch __RIGHTHAND_1578
  call ST_WHILE
  commit __LEFTHAND_1579
__RIGHTHAND_1578:
  catch __RIGHTHAND_1586
  call ST_CATCH
  commit __LEFTHAND_1587
__RIGHTHAND_1586:
  catch __RIGHTHAND_1594
  call ST_RETURN
  commit __LEFTHAND_1595
__RIGHTHAND_1594:
  catch __RIGHTHAND_1602
  call VARDECL
  commit __LEFTHAND_1603
__RIGHTHAND_1602:
  catch __RIGHTHAND_1610
  call ASSIGNMENT
  commit __LEFTHAND_1611
__RIGHTHAND_1610:
  catch __TERM_1621
  call SCR_EXPRESSION
  commit __TERM_1621
__TERM_1621:
  call SEMICOLON
__LEFTHAND_1611:
__LEFTHAND_1603:
__LEFTHAND_1595:
__LEFTHAND_1587:
__LEFTHAND_1579:
__LEFTHAND_1571:
  closecapture 71
  ret
-- Rule
BLOCKSTMT:
  call __prefix
  opencapture 72
  catch __RIGHTHAND_1630
  call ST_IF
  commit __LEFTHAND_1631
__RIGHTHAND_1630:
  catch __RIGHTHAND_1638
  call ST_WHILE
  commit __LEFTHAND_1639
__RIGHTHAND_1638:
  catch __RIGHTHAND_1646
  call ST_CATCH
  commit __LEFTHAND_1647
__RIGHTHAND_1646:
  catch __RIGHTHAND_1654
  call ST_RETURN
  commit __LEFTHAND_1655
__RIGHTHAND_1654:
  catch __RIGHTHAND_1662
  call ST_LOOPCTL
  commit __LEFTHAND_1663
__RIGHTHAND_1662:
  catch __RIGHTHAND_1670
  call VARDECL
  commit __LEFTHAND_1671
__RIGHTHAND_1670:
  catch __RIGHTHAND_1678
  call ASSIGNMENT
  commit __LEFTHAND_1679
__RIGHTHAND_1678:
  catch __TERM_1689
  call SCR_EXPRESSION
  commit __TERM_1689
__TERM_1689:
  call SEMICOLON
__LEFTHAND_1679:
__LEFTHAND_1671:
__LEFTHAND_1663:
__LEFTHAND_1655:
__LEFTHAND_1647:
__LEFTHAND_1639:
__LEFTHAND_1631:
  closecapture 72
  ret
-- Rule
ST_IF:
  call __prefix
  opencapture 73
  call KW_IF
  call CONDITION
  call BLOCK
  catch __TERM_1720
__TERM_1719:
  call IF_ELSIF
  partialcommit __TERM_1719
__TERM_1720:
  catch __TERM_1725
  call IF_ELSE
  commit __TERM_1725
__TERM_1725:
  closecapture 73
  ret
-- Rule
CONDITION:
  call __prefix
  opencapture 74
  call BOPEN
  call SCR_EXPRESSION
  call BCLOSE
  closecapture 74
  ret
-- Rule
BLOCK:
  call __prefix
  opencapture 75
  call CBOPEN
  catch __TERM_1756
__TERM_1755:
  call BLOCKSTMT
  partialcommit __TERM_1755
__TERM_1756:
  call CBCLOSE
  closecapture 75
  ret
-- Rule
IF_ELSIF:
  call __prefix
  opencapture 76
  call KW_ELSIF
  call CONDITION
  call BLOCK
  closecapture 76
  ret
-- Rule
IF_ELSE:
  call __prefix
  opencapture 77
  call KW_ELSE
  call BLOCK
  closecapture 77
  ret
-- Rule
ST_WHILE:
  call __prefix
  opencapture 78
  call KW_WHILE
  call CONDITION
  call BLOCK
  closecapture 78
  ret
-- Rule
ST_CATCH:
  call __prefix
  opencapture 79
  call KW_CATCH
  call BLOCK
  closecapture 79
  ret
-- Rule
ST_RETURN:
  call __prefix
  opencapture 80
  call KW_RETURN
  catch __TERM_1833
  call SCR_EXPRESSION
  commit __TERM_1833
__TERM_1833:
  call SEMICOLON
  closecapture 80
  ret
-- Rule
ST_LOOPCTL:
  call __prefix
  opencapture 81
  catch __RIGHTHAND_1848
  call KW_BREAK
  commit __LEFTHAND_1849
__RIGHTHAND_1848:
  call KW_CONTINUE
__LEFTHAND_1849:
  call SEMICOLON
  closecapture 81
  ret
-- Rule
VARDECL:
  call __prefix
  opencapture 82
  call KW_VAR
  call S
  catch __RIGHTHAND_1886
  call SCR_TYPE
  call S
  call IDENT
  commit __LEFTHAND_1887
__RIGHTHAND_1886:
  call IDENT
__LEFTHAND_1887:
  catch __TERM_1915
  call ASSIGN
  call SCR_EXPRESSION
  commit __TERM_1915
__TERM_1915:
  call SEMICOLON
  closecapture 82
  ret
-- Rule
ASSIGNMENT:
  call __prefix
  opencapture 83
  call SCR_REFERENCE
  call ASSIGN
  call SCR_EXPRESSION
  call SEMICOLON
  closecapture 83
  ret
-- Rule
SCR_TYPE:
  call __prefix
  opencapture 84
  call IDENT
  closecapture 84
  ret
-- Rule
SCR_EXPRESSION:
  call __prefix
  opencapture 85
  call BINOP_P12
  closecapture 85
  ret
-- Rule
BINOP_P12:
  call __prefix
  opencapture 86
  call BINOP_P11
  catch __TERM_1982
__TERM_1981:
  call LOGOR
  call BINOP_P11
  partialcommit __TERM_1981
__TERM_1982:
  closecapture 86
  ret
-- Rule
BINOP_P11:
  call __prefix
  opencapture 87
  call BINOP_P10
  catch __TERM_2012
__TERM_2011:
  call LOGAND
  call BINOP_P10
  partialcommit __TERM_2011
__TERM_2012:
  closecapture 87
  ret
-- Rule
BINOP_P10:
  call __prefix
  opencapture 88
  call BINOP_P09
  catch __TERM_2042
__TERM_2041:
  call BITOR
  call BINOP_P09
  partialcommit __TERM_2041
__TERM_2042:
  closecapture 88
  ret
-- Rule
BINOP_P09:
  call __prefix
  opencapture 89
  call BINOP_P08
  catch __TERM_2072
__TERM_2071:
  call BITXOR
  call BINOP_P08
  partialcommit __TERM_2071
__TERM_2072:
  closecapture 89
  ret
-- Rule
BINOP_P08:
  call __prefix
  opencapture 90
  call BINOP_P07
  catch __TERM_2102
__TERM_2101:
  call BITAND
  call BINOP_P07
  partialcommit __TERM_2101
__TERM_2102:
  closecapture 90
  ret
-- Rule
BINOP_P07:
  call __prefix
  opencapture 91
  call BINOP_P06
  catch __TERM_2132
__TERM_2131:
  catch __RIGHTHAND_2140
  call EQUALS
  commit __LEFTHAND_2141
__RIGHTHAND_2140:
  call NEQUALS
__LEFTHAND_2141:
  call BINOP_P06
  partialcommit __TERM_2131
__TERM_2132:
  closecapture 91
  ret
-- Rule
BINOP_P06:
  call __prefix
  opencapture 92
  call BINOP_P05
  catch __TERM_2170
__TERM_2169:
  catch __RIGHTHAND_2178
  call LTEQ
  commit __LEFTHAND_2179
__RIGHTHAND_2178:
  catch __RIGHTHAND_2186
  call LT
  commit __LEFTHAND_2187
__RIGHTHAND_2186:
  catch __RIGHTHAND_2194
  call GTEQ
  commit __LEFTHAND_2195
__RIGHTHAND_2194:
  call GT
__LEFTHAND_2195:
__LEFTHAND_2187:
__LEFTHAND_2179:
  call BINOP_P05
  partialcommit __TERM_2169
__TERM_2170:
  closecapture 92
  ret
-- Rule
BINOP_P05:
  call __prefix
  opencapture 93
  call BINOP_P04
  catch __TERM_2224
__TERM_2223:
  catch __RIGHTHAND_2232
  call LSHIFT
  commit __LEFTHAND_2233
__RIGHTHAND_2232:
  call RSHIFT
__LEFTHAND_2233:
  call BINOP_P04
  partialcommit __TERM_2223
__TERM_2224:
  closecapture 93
  ret
-- Rule
BINOP_P04:
  call __prefix
  opencapture 94
  call BINOP_P03
  catch __TERM_2262
__TERM_2261:
  catch __RIGHTHAND_2270
  call ADD
  commit __LEFTHAND_2271
__RIGHTHAND_2270:
  call SUB
__LEFTHAND_2271:
  call BINOP_P03
  partialcommit __TERM_2261
__TERM_2262:
  closecapture 94
  ret
-- Rule
BINOP_P03:
  call __prefix
  opencapture 95
  call SCR_TERM
  catch __TERM_2306
__TERM_2305:
  catch __RIGHTHAND_2314
  call MUL
  commit __LEFTHAND_2315
__RIGHTHAND_2314:
  catch __RIGHTHAND_2322
  call DIV
  commit __LEFTHAND_2323
__RIGHTHAND_2322:
  call POW
__LEFTHAND_2323:
__LEFTHAND_2315:
  call SCR_TERM
  partialcommit __TERM_2305
__TERM_2306:
  closecapture 95
  ret
-- Rule
UNOP:
  call __prefix
  opencapture 96
  catch __RIGHTHAND_2348
  call LOGNOT
  commit __LEFTHAND_2349
__RIGHTHAND_2348:
  call BITNOT
__LEFTHAND_2349:
  closecapture 96
  ret
-- Rule
SCR_TERM:
  call __prefix
  opencapture 97
  catch __RIGHTHAND_2362
  call FUNCTIONCALL
  commit __LEFTHAND_2363
__RIGHTHAND_2362:
  catch __RIGHTHAND_2370
  call BOPEN
  call SCR_EXPRESSION
  call BCLOSE
  commit __LEFTHAND_2371
__RIGHTHAND_2370:
  catch __RIGHTHAND_2390
  call LITERAL
  commit __LEFTHAND_2391
__RIGHTHAND_2390:
  call SCR_UREFERENCE
__LEFTHAND_2391:
__LEFTHAND_2371:
__LEFTHAND_2363:
  closecapture 97
  ret
-- Rule
SCR_UREFERENCE:
  call __prefix
  opencapture 98
  catch __TERM_2408
__TERM_2407:
  call UNOP
  partialcommit __TERM_2407
__TERM_2408:
  call SCR_REFERENCE
  closecapture 98
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 99
  call IDENT
  call ARGSLIST
  closecapture 99
  ret
-- Rule
ARGSLIST:
  call __prefix
  opencapture 100
  call BOPEN
  catch __TERM_2437
  call SCR_EXPRESSION
  catch __TERM_2450
__TERM_2449:
  call COMMA
  call SCR_EXPRESSION
  partialcommit __TERM_2449
__TERM_2450:
  commit __TERM_2437
__TERM_2437:
  call BCLOSE
  closecapture 100
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  opencapture 101
  call IDENT
  catch __TERM_2486
__TERM_2485:
  call INDEX
  partialcommit __TERM_2485
__TERM_2486:
  catch __TERM_2492
__TERM_2491:
  call DOT
  call SCR_REFERENCE
  partialcommit __TERM_2491
__TERM_2492:
  closecapture 101
  ret
-- Rule
INDEX:
  call __prefix
  opencapture 102
  call ABOPEN
  call SCR_EXPRESSION
  call ABCLOSE
  closecapture 102
  ret
-- Rule
LITERAL:
  call __prefix
  opencapture 103
  catch __RIGHTHAND_2524
  call STRINGLITERAL
  commit __LEFTHAND_2525
__RIGHTHAND_2524:
  catch __RIGHTHAND_2532
  call LISTLITERAL
  commit __LEFTHAND_2533
__RIGHTHAND_2532:
  catch __RIGHTHAND_2540
  call FLOATLITERAL
  commit __LEFTHAND_2541
__RIGHTHAND_2540:
  catch __RIGHTHAND_2548
  call INTLITERAL
  commit __LEFTHAND_2549
__RIGHTHAND_2548:
  call BOOLEANLITERAL
__LEFTHAND_2549:
__LEFTHAND_2541:
__LEFTHAND_2533:
__LEFTHAND_2525:
  closecapture 103
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  opencapture 104
  char 27
  opencapture 105
  catch __TERM_2578
__TERM_2577:
  catch __RIGHTHAND_2580
  char 5c
  catch __RIGHTHAND_2594
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_2595
__RIGHTHAND_2594:
  counter 0 3
__TERM_2604:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_2604
__LEFTHAND_2595:
  commit __LEFTHAND_2581
__RIGHTHAND_2580:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_2581:
  partialcommit __TERM_2577
__TERM_2578:
  closecapture 105 0
  char 27
  closecapture 104
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 106
  call ABOPEN
  catch __TERM_2629
  call LISTELT
  catch __TERM_2642
__TERM_2641:
  call COMMA
  call LISTELT
  partialcommit __TERM_2641
__TERM_2642:
  commit __TERM_2629
__TERM_2629:
  call ABCLOSE
  closecapture 106
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 107
  call SCR_TERM
  closecapture 107
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 108
  catch __TERM_2672
__TERM_2671:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2671
__TERM_2672:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2684
__TERM_2683:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2683
__TERM_2684:
  closecapture 108
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 109
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_2690
__TERM_2689:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_2689
__TERM_2690:
  closecapture 109
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 110
  catch __RIGHTHAND_2692
  quad 74727565
  commit __LEFTHAND_2693
__RIGHTHAND_2692:
  quad 66616c73
  char 65
__LEFTHAND_2693:
  closecapture 110
  ret
-- Rule
KW_IMPORT:
  call __prefix
  opencapture 111
  quad 696d706f
  char 72
  char 74
  closecapture 111
  ret
-- Rule
KW_TYPE:
  call __prefix
  opencapture 112
  quad 74797065
  closecapture 112
  ret
-- Rule
KW_FUNCTION:
  call __prefix
  opencapture 113
  quad 66756e63
  quad 74696f6e
  closecapture 113
  ret
-- Rule
KW_VAR:
  call __prefix
  opencapture 114
  char 76
  char 61
  char 72
  closecapture 114
  ret
-- Rule
KW_WHILE:
  call __prefix
  opencapture 115
  quad 7768696c
  char 65
  closecapture 115
  ret
-- Rule
KW_RETURN:
  call __prefix
  opencapture 116
  quad 72657475
  char 72
  char 6e
  closecapture 116
  ret
-- Rule
KW_IF:
  call __prefix
  opencapture 117
  char 69
  char 66
  closecapture 117
  ret
-- Rule
KW_ELSIF:
  call __prefix
  opencapture 118
  quad 656c7369
  char 66
  closecapture 118
  ret
-- Rule
KW_ELSE:
  call __prefix
  opencapture 119
  quad 656c7365
  closecapture 119
  ret
-- Rule
KW_BREAK:
  call __prefix
  opencapture 120
  quad 62726561
  char 6b
  closecapture 120
  ret
-- Rule
KW_CONTINUE:
  call __prefix
  opencapture 121
  quad 636f6e74
  quad 696e7565
  closecapture 121
  ret
-- Rule
KW_CATCH:
  call __prefix
  opencapture 122
  quad 63617463
  char 68
  closecapture 122
  ret
-- Rule
IDENT:
  call __prefix
  opencapture 123
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_2787
  counter 0 63
__TERM_2788:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_2789
__TERM_2789:
  condjump 0 __TERM_2788
  commit __TERM_2787
__TERM_2787:
  closecapture 123
  ret
-- Rule
BOPEN:
  call __prefix
  opencapture 124
  char 28
  closecapture 124
  ret
-- Rule
BCLOSE:
  call __prefix
  opencapture 125
  char 29
  closecapture 125
  ret
-- Rule
CBOPEN:
  call __prefix
  opencapture 126
  char 7b
  closecapture 126
  ret
-- Rule
CBCLOSE:
  call __prefix
  opencapture 127
  char 7d
  closecapture 127
  ret
-- Rule
ABOPEN:
  call __prefix
  opencapture 128
  char 5b
  closecapture 128
  ret
-- Rule
ABCLOSE:
  call __prefix
  opencapture 129
  char 5d
  closecapture 129
  ret
-- Rule
ASSIGN:
  call __prefix
  opencapture 130
  char 3d
  closecapture 130
  ret
-- Rule
EQUALS:
  call __prefix
  opencapture 131
  char 3d
  char 3d
  closecapture 131
  ret
-- Rule
NEQUALS:
  call __prefix
  opencapture 132
  char 21
  char 3d
  closecapture 132
  ret
-- Rule
LT:
  call __prefix
  opencapture 133
  char 3c
  catch __TERM_2850
  char 3d
  failtwice
__TERM_2850:
  closecapture 133
  ret
-- Rule
GT:
  call __prefix
  opencapture 134
  char 3e
  catch __TERM_2862
  char 3d
  failtwice
__TERM_2862:
  closecapture 134
  ret
-- Rule
LTEQ:
  call __prefix
  opencapture 135
  char 3c
  char 3d
  closecapture 135
  ret
-- Rule
GTEQ:
  call __prefix
  opencapture 136
  char 3e
  char 3d
  closecapture 136
  ret
-- Rule
SEMICOLON:
  call __prefix
  opencapture 137
  char 3b
  closecapture 137
  ret
-- Rule
COLON:
  call __prefix
  opencapture 138
  char 3a
  closecapture 138
  ret
-- Rule
POW:
  call __prefix
  opencapture 139
  char 2a
  char 2a
  closecapture 139
  ret
-- Rule
MUL:
  call __prefix
  opencapture 140
  char 2a
  catch __TERM_2904
  char 2a
  failtwice
__TERM_2904:
  closecapture 140
  ret
-- Rule
DIV:
  call __prefix
  opencapture 141
  char 2f
  closecapture 141
  ret
-- Rule
ADD:
  call __prefix
  opencapture 142
  char 2b
  closecapture 142
  ret
-- Rule
SUB:
  call __prefix
  opencapture 143
  char 2d
  closecapture 143
  ret
-- Rule
LOGAND:
  call __prefix
  opencapture 144
  char 26
  char 26
  closecapture 144
  ret
-- Rule
LOGOR:
  call __prefix
  opencapture 145
  char 7c
  char 7c
  closecapture 145
  ret
-- Rule
LOGNOT:
  call __prefix
  opencapture 146
  char 21
  closecapture 146
  ret
-- Rule
BITAND:
  call __prefix
  opencapture 147
  char 26
  closecapture 147
  ret
-- Rule
BITOR:
  call __prefix
  opencapture 148
  char 7c
  closecapture 148
  ret
-- Rule
BITXOR:
  call __prefix
  opencapture 149
  char 5e
  closecapture 149
  ret
-- Rule
BITNOT:
  call __prefix
  opencapture 150
  char 7e
  closecapture 150
  ret
-- Rule
COMMA:
  call __prefix
  opencapture 151
  char 2c
  closecapture 151
  ret
-- Rule
DOT:
  call __prefix
  opencapture 152
  char 2e
  closecapture 152
  ret
-- Rule
LSHIFT:
  call __prefix
  opencapture 153
  char 3c
  char 3c
  closecapture 153
  ret
-- Rule
RSHIFT:
  call __prefix
  opencapture 154
  char 3e
  char 3e
  closecapture 154
  ret

  end 0

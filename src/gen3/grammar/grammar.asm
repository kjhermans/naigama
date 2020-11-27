  call GRAMMAR
  end
-- Rule
GRAMMAR:
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
  ret
-- Rule
S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __TERM_30
__TERM_29:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_29
__TERM_30:
  ret
-- Rule
MULTILINECOMMENT:
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
  ret
-- Rule
COMMENT:
  char 2d
  char 2d
  catch __TERM_72
__TERM_71:
  set fffbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  partialcommit __TERM_71
__TERM_72:
  char 0a
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
  catch __TERM_108
  any
  failtwice
__TERM_108:
  ret
-- Rule
DEFINITION:
  call __prefix
  catch __RIGHTHAND_114
  opencapture 0
  call GLOBALVARDECL
  closecapture 0 0
  commit __LEFTHAND_115
__RIGHTHAND_114:
  catch __RIGHTHAND_128
  opencapture 1
  call FUNCDECL
  closecapture 1 0
  commit __LEFTHAND_129
__RIGHTHAND_128:
  opencapture 2
  call RULE
  closecapture 2 0
__LEFTHAND_129:
__LEFTHAND_115:
  ret
-- Rule
SINGLE_EXPRESSION:
  call __prefix
  call EXPRESSION
  ret
-- Rule
RULE:
  call __prefix
  opencapture 3
  call IDENT
  closecapture 3 0
  call LEFTARROW
  call EXPRESSION
  ret
-- Rule
EXPRESSION:
  call __prefix
  catch __RIGHTHAND_184
  opencapture 4
  call TERMS
  closecapture 4 0
  call OR
  call NOTHING
  commit __LEFTHAND_185
__RIGHTHAND_184:
  catch __RIGHTHAND_210
  opencapture 5
  call TERMS
  closecapture 5 0
  call OR
  call EXPRESSION
  commit __LEFTHAND_211
__RIGHTHAND_210:
  opencapture 6
  call TERMS
  closecapture 6 0
__LEFTHAND_211:
__LEFTHAND_185:
  ret
-- Rule
TERMS:
  call __prefix
  opencapture 7
  call TERM
  closecapture 7 0
  catch __TERM_252
__TERM_251:
  opencapture 7
  call TERM
  closecapture 7 0
  partialcommit __TERM_251
__TERM_252:
  ret
-- Rule
TERM:
  call __prefix
  catch __RIGHTHAND_266
  opencapture 8
  call SCANMATCHER
  closecapture 8 0
  commit __LEFTHAND_267
__RIGHTHAND_266:
  opencapture 9
  call QUANTIFIEDMATCHER
  closecapture 9 0
__LEFTHAND_267:
  ret
-- Rule
SCANMATCHER:
  call __prefix
  catch __RIGHTHAND_298
  opencapture 10
  call NOT
  closecapture 10 0
  commit __LEFTHAND_299
__RIGHTHAND_298:
  opencapture 11
  call AND
  closecapture 11 0
__LEFTHAND_299:
  call MATCHER
  ret
-- Rule
QUANTIFIEDMATCHER:
  call __prefix
  call MATCHER
  catch __TERM_339
  opencapture 12
  call QUANTIFIER
  closecapture 12 0
  commit __TERM_339
__TERM_339:
  ret
-- Rule
QUANTIFIER:
  call __prefix
  catch __RIGHTHAND_348
  opencapture 13
  char 3f
  closecapture 13 0
  commit __LEFTHAND_349
__RIGHTHAND_348:
  catch __RIGHTHAND_362
  opencapture 14
  char 2b
  closecapture 14 0
  commit __LEFTHAND_363
__RIGHTHAND_362:
  catch __RIGHTHAND_376
  opencapture 15
  char 2a
  closecapture 15 0
  commit __LEFTHAND_377
__RIGHTHAND_376:
  catch __RIGHTHAND_390
  char 5e
  opencapture 16
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_408
__TERM_407:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_407
__TERM_408:
  closecapture 16 0
  char 2d
  opencapture 17
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_426
__TERM_425:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_425
__TERM_426:
  closecapture 17 0
  commit __LEFTHAND_391
__RIGHTHAND_390:
  catch __RIGHTHAND_428
  char 5e
  char 2d
  opencapture 18
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_452
__TERM_451:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_451
__TERM_452:
  closecapture 18 0
  commit __LEFTHAND_429
__RIGHTHAND_428:
  catch __RIGHTHAND_454
  char 5e
  opencapture 19
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_472
__TERM_471:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_471
__TERM_472:
  closecapture 19 0
  char 2d
  commit __LEFTHAND_455
__RIGHTHAND_454:
  catch __RIGHTHAND_480
  char 5e
  opencapture 20
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_498
__TERM_497:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_497
__TERM_498:
  closecapture 20 0
  commit __LEFTHAND_481
__RIGHTHAND_480:
  char 5e
  char 24
  opencapture 21
  call IDENT
  closecapture 21 0
__LEFTHAND_481:
__LEFTHAND_455:
__LEFTHAND_429:
__LEFTHAND_391:
__LEFTHAND_377:
__LEFTHAND_363:
__LEFTHAND_349:
  ret
-- Rule
MATCHER:
  call __prefix
  catch __RIGHTHAND_518
  opencapture 22
  call ANY
  closecapture 22 0
  commit __LEFTHAND_519
__RIGHTHAND_518:
  catch __RIGHTHAND_532
  opencapture 23
  call SET
  closecapture 23 0
  commit __LEFTHAND_533
__RIGHTHAND_532:
  catch __RIGHTHAND_546
  opencapture 24
  call STRING
  closecapture 24 0
  commit __LEFTHAND_547
__RIGHTHAND_546:
  catch __RIGHTHAND_560
  opencapture 25
  call BITMASK
  closecapture 25 0
  commit __LEFTHAND_561
__RIGHTHAND_560:
  catch __RIGHTHAND_574
  opencapture 26
  call HEXLITERAL
  closecapture 26 0
  commit __LEFTHAND_575
__RIGHTHAND_574:
  catch __RIGHTHAND_588
  opencapture 27
  call VARCAPTURE
  closecapture 27 0
  commit __LEFTHAND_589
__RIGHTHAND_588:
  catch __RIGHTHAND_602
  opencapture 28
  call CAPTURE
  closecapture 28 0
  commit __LEFTHAND_603
__RIGHTHAND_602:
  catch __RIGHTHAND_616
  opencapture 29
  call GROUP
  closecapture 29 0
  commit __LEFTHAND_617
__RIGHTHAND_616:
  catch __RIGHTHAND_630
  opencapture 30
  call MACRO
  closecapture 30 0
  commit __LEFTHAND_631
__RIGHTHAND_630:
  catch __RIGHTHAND_644
  opencapture 31
  call ENDFORCE
  closecapture 31 0
  commit __LEFTHAND_645
__RIGHTHAND_644:
  catch __RIGHTHAND_658
  opencapture 32
  call VARREFERENCE
  closecapture 32 0
  commit __LEFTHAND_659
__RIGHTHAND_658:
  opencapture 33
  call REFERENCE
  closecapture 33 0
__LEFTHAND_659:
__LEFTHAND_645:
__LEFTHAND_631:
__LEFTHAND_617:
__LEFTHAND_603:
__LEFTHAND_589:
__LEFTHAND_575:
__LEFTHAND_561:
__LEFTHAND_547:
__LEFTHAND_533:
__LEFTHAND_519:
  ret
-- Rule
BITMASK:
  call __prefix
  char 7c
  counter 0 2
__TERM_692:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_692
  char 7c
  counter 0 2
__TERM_704:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_704
  char 7c
  ret
-- Rule
VARCAPTURE:
  call __prefix
  call CBOPEN
  call COLON
  opencapture 34
  call IDENT
  closecapture 34 0
  catch __TERM_741
  opencapture 35
  call CAPTURETYPE
  closecapture 35 0
  commit __TERM_741
__TERM_741:
  call COLON
  call EXPRESSION
  opencapture 36
  call CBCLOSE
  closecapture 36 0
  call CAPTUREEND
  ret
-- Rule
CAPTURETYPE:
  call __prefix
  call SEMICOLON
  call TYPE
  ret
-- Rule
TYPE:
  call __prefix
  opencapture 37
  catch __RIGHTHAND_798
  quad 75696e74
  char 33
  char 32
  commit __LEFTHAND_799
__RIGHTHAND_798:
  quad 696e7433
  char 32
__LEFTHAND_799:
  closecapture 37 0
  ret
-- Rule
CAPTURE:
  call __prefix
  call CBOPEN
  call EXPRESSION
  call CBCLOSE
  call CAPTUREEND
  ret
-- Rule
GROUP:
  call __prefix
  call BOPEN
  call EXPRESSION
  call BCLOSE
  ret
-- Rule
CAPTUREEND:
  call __prefix
  catch __TERM_857
  opencapture 38
  catch __RIGHTHAND_860
  call REPLACE
  commit __LEFTHAND_861
__RIGHTHAND_860:
  call RECYCLE
__LEFTHAND_861:
  closecapture 38 0
  commit __TERM_857
__TERM_857:
  ret
-- Rule
SET:
  call __prefix
  call ABOPEN
  opencapture 39
  catch __TERM_889
  call SETNOT
  commit __TERM_889
__TERM_889:
  closecapture 39 0
  catch __RIGHTHAND_898
  opencapture 40
  catch __RIGHTHAND_906
  char 5c
  catch __RIGHTHAND_920
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_921
__RIGHTHAND_920:
  counter 0 3
__TERM_930:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_930
__LEFTHAND_921:
  commit __LEFTHAND_907
__RIGHTHAND_906:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_907:
  closecapture 40 0
  char 2d
  opencapture 41
  catch __RIGHTHAND_952
  char 5c
  catch __RIGHTHAND_966
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_967
__RIGHTHAND_966:
  counter 0 3
__TERM_976:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_976
__LEFTHAND_967:
  commit __LEFTHAND_953
__RIGHTHAND_952:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_953:
  closecapture 41 0
  commit __LEFTHAND_899
__RIGHTHAND_898:
  opencapture 42
  catch __RIGHTHAND_992
  char 5c
  catch __RIGHTHAND_1006
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1007
__RIGHTHAND_1006:
  counter 0 3
__TERM_1016:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1016
__LEFTHAND_1007:
  commit __LEFTHAND_993
__RIGHTHAND_992:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_993:
  closecapture 42 0
__LEFTHAND_899:
  catch __TERM_896
__TERM_895:
  catch __RIGHTHAND_1026
  opencapture 40
  catch __RIGHTHAND_1034
  char 5c
  catch __RIGHTHAND_1048
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1049
__RIGHTHAND_1048:
  counter 0 3
__TERM_1058:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1058
__LEFTHAND_1049:
  commit __LEFTHAND_1035
__RIGHTHAND_1034:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1035:
  closecapture 40 0
  char 2d
  opencapture 41
  catch __RIGHTHAND_1080
  char 5c
  catch __RIGHTHAND_1094
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1095
__RIGHTHAND_1094:
  counter 0 3
__TERM_1104:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1104
__LEFTHAND_1095:
  commit __LEFTHAND_1081
__RIGHTHAND_1080:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1081:
  closecapture 41 0
  commit __LEFTHAND_1027
__RIGHTHAND_1026:
  opencapture 42
  catch __RIGHTHAND_1120
  char 5c
  catch __RIGHTHAND_1134
  set 0000000000200000000000300040540000000000000000000000000000000000
  commit __LEFTHAND_1135
__RIGHTHAND_1134:
  counter 0 3
__TERM_1144:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_1144
__LEFTHAND_1135:
  commit __LEFTHAND_1121
__RIGHTHAND_1120:
  set ffffffffffffffffffffffcfffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_1121:
  closecapture 42 0
__LEFTHAND_1027:
  partialcommit __TERM_895
__TERM_896:
  call ABCLOSE
  ret
-- Rule
VARREFERENCE:
  call __prefix
  char 24
  catch __RIGHTHAND_1172
  opencapture 43
  call IDENT
  closecapture 43 0
  commit __LEFTHAND_1173
__RIGHTHAND_1172:
  opencapture 44
  call NUMBER
  closecapture 44 0
__LEFTHAND_1173:
  ret
-- Rule
REFERENCE:
  call __prefix
  catch __TERM_1198
  catch __RIGHTHAND_1204
  call KW_FUNCTION
  commit __LEFTHAND_1205
__RIGHTHAND_1204:
  call KW_VAR
__LEFTHAND_1205:
  failtwice
__TERM_1198:
  opencapture 45
  call IDENT
  closecapture 45 0
  catch __TERM_1230
  call LEFTARROW
  failtwice
__TERM_1230:
  ret
-- Rule
REPLACE:
  call __prefix
  call RIGHTARROW
  opencapture 46
  call REPLACETERMS
  closecapture 46 0
  ret
-- Rule
REPLACETERMS:
  call __prefix
  call REPLACETERM
  catch __TERM_1258
__TERM_1257:
  call REPLACETERM
  partialcommit __TERM_1257
__TERM_1258:
  ret
-- Rule
REPLACETERM:
  call __prefix
  catch __RIGHTHAND_1260
  opencapture 47
  call STRINGLITERAL
  closecapture 47 0
  commit __LEFTHAND_1261
__RIGHTHAND_1260:
  catch __RIGHTHAND_1274
  opencapture 48
  call HEXLITERAL
  closecapture 48 0
  commit __LEFTHAND_1275
__RIGHTHAND_1274:
  opencapture 49
  call VARREFERENCE
  closecapture 49 0
__LEFTHAND_1275:
__LEFTHAND_1261:
  ret
-- Rule
RECYCLE:
  call __prefix
  call FATARROW
  opencapture 50
  call IDENT
  closecapture 50 0
  ret
-- Rule
LEFTARROW:
  call __prefix
  char 3c
  char 2d
  ret
-- Rule
RIGHTARROW:
  call __prefix
  char 2d
  char 3e
  ret
-- Rule
FATARROW:
  call __prefix
  char 3d
  char 3e
  ret
-- Rule
NOT:
  call __prefix
  char 21
  ret
-- Rule
AND:
  call __prefix
  char 26
  ret
-- Rule
MACRO:
  call __prefix
  char 25
  set 0000000000000000feffff07feffff0700000000000000000000000000000000
  catch __TERM_1364
__TERM_1363:
  set 000000000000ff03feffff07feffff0700000000000000000000000000000000
  partialcommit __TERM_1363
__TERM_1364:
  ret
-- Rule
ENDFORCE:
  call __prefix
  quad 5f5f656e
  char 64
  call S
  opencapture 51
  call NUMBER
  closecapture 51 0
  ret
-- Rule
HEXLITERAL:
  call __prefix
  char 30
  char 78
  counter 0 2
__TERM_1398:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_1398
  ret
-- Rule
NUMBER:
  call __prefix
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_1406
__TERM_1405:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_1405
__TERM_1406:
  ret
-- Rule
STRING:
  call __prefix
  call STRINGLITERAL
  catch __TERM_1417
  char 69
  commit __TERM_1417
__TERM_1417:
  ret
-- Rule
OR:
  call __prefix
  char 2f
  ret
-- Rule
ANY:
  call __prefix
  char 2e
  ret
-- Rule
NOTHING:
  call __prefix
  char 2e
  char 2e
  char 2e
  ret
-- Rule
SETNOT:
  call __prefix
  char 5e
  ret
-- Rule
FUNCDECL:
  call __prefix
  call KW_FUNCTION
  call S
  opencapture 52
  call IDENT
  closecapture 52 0
  opencapture 53
  call FUNCPARAMDECL
  closecapture 53 0
  opencapture 54
  call FUNCBODY
  closecapture 54 0
  ret
-- Rule
FUNCPARAMDECL:
  call __prefix
  call BOPEN
  catch __TERM_1501
  opencapture 55
  call PARAMDECL
  closecapture 55 0
  catch __TERM_1520
__TERM_1519:
  call COMMA
  opencapture 56
  call PARAMDECL
  closecapture 56 0
  partialcommit __TERM_1519
__TERM_1520:
  commit __TERM_1501
__TERM_1501:
  call BCLOSE
  ret
-- Rule
PARAMDECL:
  call __prefix
  catch __RIGHTHAND_1546
  opencapture 57
  call SCR_TYPE
  closecapture 57 0
  opencapture 58
  call IDENT
  closecapture 58 0
  commit __LEFTHAND_1547
__RIGHTHAND_1546:
  opencapture 59
  call IDENT
  closecapture 59 0
__LEFTHAND_1547:
  ret
-- Rule
FUNCBODY:
  call __prefix
  call CBOPEN
  catch __TERM_1594
__TERM_1593:
  opencapture 60
  call LOWSTMT
  closecapture 60 0
  partialcommit __TERM_1593
__TERM_1594:
  call CBCLOSE
  ret
-- Rule
GLOBALVARDECL:
  call __prefix
  call VARDECL
  ret
-- Rule
LOWSTMT:
  call __prefix
  catch __RIGHTHAND_1614
  opencapture 61
  call ST_IF
  closecapture 61 0
  commit __LEFTHAND_1615
__RIGHTHAND_1614:
  catch __RIGHTHAND_1628
  opencapture 62
  call ST_WHILE
  closecapture 62 0
  commit __LEFTHAND_1629
__RIGHTHAND_1628:
  catch __RIGHTHAND_1642
  opencapture 63
  call ST_CATCH
  closecapture 63 0
  commit __LEFTHAND_1643
__RIGHTHAND_1642:
  catch __RIGHTHAND_1656
  opencapture 64
  call ST_RETURN
  closecapture 64 0
  commit __LEFTHAND_1657
__RIGHTHAND_1656:
  catch __RIGHTHAND_1670
  opencapture 65
  call ST_OTHER
  closecapture 65 0
  commit __LEFTHAND_1671
__RIGHTHAND_1670:
  catch __RIGHTHAND_1684
  opencapture 66
  call VARDECL
  closecapture 66 0
  commit __LEFTHAND_1685
__RIGHTHAND_1684:
  catch __RIGHTHAND_1698
  opencapture 67
  call ASSIGNMENT
  closecapture 67 0
  commit __LEFTHAND_1699
__RIGHTHAND_1698:
  catch __TERM_1715
  opencapture 68
  call SCR_EXPRESSION
  closecapture 68 0
  commit __TERM_1715
__TERM_1715:
  call SEMICOLON
__LEFTHAND_1699:
__LEFTHAND_1685:
__LEFTHAND_1671:
__LEFTHAND_1657:
__LEFTHAND_1643:
__LEFTHAND_1629:
__LEFTHAND_1615:
  ret
-- Rule
ST_IF:
  call __prefix
  call KW_IF
  call BOPEN
  opencapture 69
  call SCR_EXPRESSION
  closecapture 69 0
  call BCLOSE
  call CBOPEN
  opencapture 70
  catch __TERM_1776
__TERM_1775:
  call LOWSTMT
  partialcommit __TERM_1775
__TERM_1776:
  closecapture 70 0
  call CBCLOSE
  opencapture 71
  catch __TERM_1794
__TERM_1793:
  call IF_ELSEIF
  partialcommit __TERM_1793
__TERM_1794:
  closecapture 71 0
  opencapture 72
  catch __TERM_1805
  call IF_ELSE
  commit __TERM_1805
__TERM_1805:
  closecapture 72 0
  ret
-- Rule
IF_ELSEIF:
  call __prefix
  call KW_ELSEIF
  call BOPEN
  opencapture 73
  call SCR_EXPRESSION
  closecapture 73 0
  call BCLOSE
  call CBOPEN
  opencapture 74
  catch __TERM_1854
__TERM_1853:
  call LOWSTMT
  partialcommit __TERM_1853
__TERM_1854:
  closecapture 74 0
  call CBCLOSE
  ret
-- Rule
IF_ELSE:
  call __prefix
  call KW_ELSE
  call CBOPEN
  opencapture 75
  catch __TERM_1884
__TERM_1883:
  call LOWSTMT
  partialcommit __TERM_1883
__TERM_1884:
  closecapture 75 0
  call CBCLOSE
  ret
-- Rule
ST_WHILE:
  call __prefix
  call KW_WHILE
  call BOPEN
  opencapture 76
  call SCR_EXPRESSION
  closecapture 76 0
  call BCLOSE
  call CBOPEN
  opencapture 77
  catch __TERM_1938
__TERM_1937:
  call LOWSTMT
  partialcommit __TERM_1937
__TERM_1938:
  closecapture 77 0
  call CBCLOSE
  ret
-- Rule
ST_CATCH:
  call __prefix
  call KW_CATCH
  call CBOPEN
  opencapture 78
  catch __TERM_1968
__TERM_1967:
  call LOWSTMT
  partialcommit __TERM_1967
__TERM_1968:
  closecapture 78 0
  call CBCLOSE
  ret
-- Rule
ST_RETURN:
  call __prefix
  call KW_RETURN
  opencapture 79
  catch __TERM_1991
  call SCR_EXPRESSION
  commit __TERM_1991
__TERM_1991:
  closecapture 79 0
  call SEMICOLON
  ret
-- Rule
ST_OTHER:
  call __prefix
  catch __RIGHTHAND_2006
  call KW_BREAK
  commit __LEFTHAND_2007
__RIGHTHAND_2006:
  call KW_CONTINUE
__LEFTHAND_2007:
  call SEMICOLON
  ret
-- Rule
VARDECL:
  call __prefix
  call KW_VAR
  call S
  catch __RIGHTHAND_2044
  opencapture 80
  call SCR_TYPE
  closecapture 80 0
  opencapture 81
  call IDENT
  closecapture 81 0
  commit __LEFTHAND_2045
__RIGHTHAND_2044:
  opencapture 82
  call IDENT
  closecapture 82 0
__LEFTHAND_2045:
  catch __TERM_2085
  call ASSIGN
  opencapture 83
  call SCR_EXPRESSION
  closecapture 83 0
  commit __TERM_2085
__TERM_2085:
  call SEMICOLON
  ret
-- Rule
ASSIGNMENT:
  call __prefix
  call IDENT
  call ASSIGNS
  call SCR_EXPRESSION
  call SEMICOLON
  ret
-- Rule
SCR_TYPE:
  call __prefix
  call IDENT
  ret
-- Rule
ASSIGNS:
  call __prefix
  opencapture 84
  catch __RIGHTHAND_2148
  call ASSIGN
  commit __LEFTHAND_2149
__RIGHTHAND_2148:
  catch __RIGHTHAND_2156
  call PLUSIS
  commit __LEFTHAND_2157
__RIGHTHAND_2156:
  catch __RIGHTHAND_2164
  call MINIS
  commit __LEFTHAND_2165
__RIGHTHAND_2164:
  catch __RIGHTHAND_2172
  call MULIS
  commit __LEFTHAND_2173
__RIGHTHAND_2172:
  catch __RIGHTHAND_2180
  call DIVIS
  commit __LEFTHAND_2181
__RIGHTHAND_2180:
  catch __RIGHTHAND_2188
  call BITANDIS
  commit __LEFTHAND_2189
__RIGHTHAND_2188:
  catch __RIGHTHAND_2196
  call BITORIS
  commit __LEFTHAND_2197
__RIGHTHAND_2196:
  catch __RIGHTHAND_2204
  call BITXORIS
  commit __LEFTHAND_2205
__RIGHTHAND_2204:
  catch __RIGHTHAND_2212
  call BITNOTIS
  commit __LEFTHAND_2213
__RIGHTHAND_2212:
  catch __RIGHTHAND_2220
  call LSHIFTIS
  commit __LEFTHAND_2221
__RIGHTHAND_2220:
  call RSHIFTIS
__LEFTHAND_2221:
__LEFTHAND_2213:
__LEFTHAND_2205:
__LEFTHAND_2197:
__LEFTHAND_2189:
__LEFTHAND_2181:
__LEFTHAND_2173:
__LEFTHAND_2165:
__LEFTHAND_2157:
__LEFTHAND_2149:
  closecapture 84 0
  ret
-- Rule
SCR_EXPRESSION:
  call __prefix
  call BINOP_P12
  ret
-- Rule
BINOP_P12:
  call __prefix
  catch __RIGHTHAND_2246
  call BINOP_P11
  commit __LEFTHAND_2247
__RIGHTHAND_2246:
  call SCR_TERM
__LEFTHAND_2247:
  catch __TERM_2264
__TERM_2263:
  opencapture 85
  call LOGOR
  catch __RIGHTHAND_2284
  call BINOP_P11
  commit __LEFTHAND_2285
__RIGHTHAND_2284:
  call SCR_TERM
__LEFTHAND_2285:
  closecapture 85 0
  partialcommit __TERM_2263
__TERM_2264:
  ret
-- Rule
BINOP_P11:
  call __prefix
  catch __RIGHTHAND_2304
  call BINOP_P10
  commit __LEFTHAND_2305
__RIGHTHAND_2304:
  call SCR_TERM
__LEFTHAND_2305:
  catch __TERM_2322
__TERM_2321:
  opencapture 86
  call LOGAND
  catch __RIGHTHAND_2342
  call BINOP_P10
  commit __LEFTHAND_2343
__RIGHTHAND_2342:
  call SCR_TERM
__LEFTHAND_2343:
  closecapture 86 0
  partialcommit __TERM_2321
__TERM_2322:
  ret
-- Rule
BINOP_P10:
  call __prefix
  catch __RIGHTHAND_2362
  call BINOP_P09
  commit __LEFTHAND_2363
__RIGHTHAND_2362:
  call SCR_TERM
__LEFTHAND_2363:
  catch __TERM_2380
__TERM_2379:
  opencapture 87
  call BITOR
  catch __RIGHTHAND_2400
  call BINOP_P09
  commit __LEFTHAND_2401
__RIGHTHAND_2400:
  call SCR_TERM
__LEFTHAND_2401:
  closecapture 87 0
  partialcommit __TERM_2379
__TERM_2380:
  ret
-- Rule
BINOP_P09:
  call __prefix
  catch __RIGHTHAND_2420
  call BINOP_P08
  commit __LEFTHAND_2421
__RIGHTHAND_2420:
  call SCR_TERM
__LEFTHAND_2421:
  catch __TERM_2438
__TERM_2437:
  opencapture 88
  call BITXOR
  catch __RIGHTHAND_2458
  call BINOP_P08
  commit __LEFTHAND_2459
__RIGHTHAND_2458:
  call SCR_TERM
__LEFTHAND_2459:
  closecapture 88 0
  partialcommit __TERM_2437
__TERM_2438:
  ret
-- Rule
BINOP_P08:
  call __prefix
  catch __RIGHTHAND_2478
  call BINOP_P07
  commit __LEFTHAND_2479
__RIGHTHAND_2478:
  call SCR_TERM
__LEFTHAND_2479:
  catch __TERM_2496
__TERM_2495:
  opencapture 89
  call BITAND
  catch __RIGHTHAND_2516
  call BINOP_P07
  commit __LEFTHAND_2517
__RIGHTHAND_2516:
  call SCR_TERM
__LEFTHAND_2517:
  closecapture 89 0
  partialcommit __TERM_2495
__TERM_2496:
  ret
-- Rule
BINOP_P07:
  call __prefix
  catch __RIGHTHAND_2536
  call BINOP_P06
  commit __LEFTHAND_2537
__RIGHTHAND_2536:
  call SCR_TERM
__LEFTHAND_2537:
  catch __TERM_2554
__TERM_2553:
  opencapture 90
  catch __RIGHTHAND_2562
  call EQUALS
  commit __LEFTHAND_2563
__RIGHTHAND_2562:
  call NEQUALS
__LEFTHAND_2563:
  catch __RIGHTHAND_2582
  call BINOP_P06
  commit __LEFTHAND_2583
__RIGHTHAND_2582:
  call SCR_TERM
__LEFTHAND_2583:
  closecapture 90 0
  partialcommit __TERM_2553
__TERM_2554:
  ret
-- Rule
BINOP_P06:
  call __prefix
  catch __RIGHTHAND_2602
  call BINOP_P05
  commit __LEFTHAND_2603
__RIGHTHAND_2602:
  call SCR_TERM
__LEFTHAND_2603:
  catch __TERM_2620
__TERM_2619:
  opencapture 91
  catch __RIGHTHAND_2628
  call LTEQ
  commit __LEFTHAND_2629
__RIGHTHAND_2628:
  catch __RIGHTHAND_2636
  call LT
  commit __LEFTHAND_2637
__RIGHTHAND_2636:
  catch __RIGHTHAND_2644
  call GTEQ
  commit __LEFTHAND_2645
__RIGHTHAND_2644:
  call GT
__LEFTHAND_2645:
__LEFTHAND_2637:
__LEFTHAND_2629:
  catch __RIGHTHAND_2664
  call BINOP_P05
  commit __LEFTHAND_2665
__RIGHTHAND_2664:
  call SCR_TERM
__LEFTHAND_2665:
  closecapture 91 0
  partialcommit __TERM_2619
__TERM_2620:
  ret
-- Rule
BINOP_P05:
  call __prefix
  catch __RIGHTHAND_2684
  call BINOP_P04
  commit __LEFTHAND_2685
__RIGHTHAND_2684:
  call SCR_TERM
__LEFTHAND_2685:
  catch __TERM_2702
__TERM_2701:
  opencapture 92
  catch __RIGHTHAND_2710
  call LSHIFT
  commit __LEFTHAND_2711
__RIGHTHAND_2710:
  call RSHIFT
__LEFTHAND_2711:
  catch __RIGHTHAND_2730
  call BINOP_P04
  commit __LEFTHAND_2731
__RIGHTHAND_2730:
  call SCR_TERM
__LEFTHAND_2731:
  closecapture 92 0
  partialcommit __TERM_2701
__TERM_2702:
  ret
-- Rule
BINOP_P04:
  call __prefix
  catch __RIGHTHAND_2750
  call BINOP_P03
  commit __LEFTHAND_2751
__RIGHTHAND_2750:
  call SCR_TERM
__LEFTHAND_2751:
  catch __TERM_2768
__TERM_2767:
  opencapture 93
  catch __RIGHTHAND_2776
  call ADD
  commit __LEFTHAND_2777
__RIGHTHAND_2776:
  call SUB
__LEFTHAND_2777:
  catch __RIGHTHAND_2796
  call BINOP_P03
  commit __LEFTHAND_2797
__RIGHTHAND_2796:
  call SCR_TERM
__LEFTHAND_2797:
  closecapture 93 0
  partialcommit __TERM_2767
__TERM_2768:
  ret
-- Rule
BINOP_P03:
  call __prefix
  call SCR_TERM
  catch __TERM_2826
__TERM_2825:
  opencapture 94
  catch __RIGHTHAND_2834
  call MUL
  commit __LEFTHAND_2835
__RIGHTHAND_2834:
  catch __RIGHTHAND_2842
  call DIV
  commit __LEFTHAND_2843
__RIGHTHAND_2842:
  call POW
__LEFTHAND_2843:
__LEFTHAND_2835:
  call SCR_TERM
  closecapture 94 0
  partialcommit __TERM_2825
__TERM_2826:
  ret
-- Rule
UNOP:
  call __prefix
  opencapture 95
  catch __RIGHTHAND_2874
  call LOGNOT
  commit __LEFTHAND_2875
__RIGHTHAND_2874:
  call BITNOT
__LEFTHAND_2875:
  closecapture 95 0
  ret
-- Rule
SCR_TERM:
  call __prefix
  catch __RIGHTHAND_2888
  opencapture 96
  call FUNCTIONCALL
  closecapture 96 0
  commit __LEFTHAND_2889
__RIGHTHAND_2888:
  catch __RIGHTHAND_2902
  opencapture 97
  call BOPEN
  opencapture 98
  call SCR_EXPRESSION
  closecapture 98 0
  call BCLOSE
  closecapture 97 0
  commit __LEFTHAND_2903
__RIGHTHAND_2902:
  catch __RIGHTHAND_2934
  opencapture 99
  call LITERAL
  closecapture 99 0
  commit __LEFTHAND_2935
__RIGHTHAND_2934:
  catch __TERM_2952
__TERM_2951:
  opencapture 100
  call UNOP
  closecapture 100 0
  partialcommit __TERM_2951
__TERM_2952:
  opencapture 101
  call SCR_REFERENCE
  closecapture 101 0
__LEFTHAND_2935:
__LEFTHAND_2903:
__LEFTHAND_2889:
  ret
-- Rule
FUNCTIONCALL:
  call __prefix
  opencapture 102
  call SCR_REFERENCE
  closecapture 102 0
  call BOPEN
  catch __TERM_2993
  opencapture 103
  call SCR_EXPRESSION
  closecapture 103 0
  catch __TERM_3012
__TERM_3011:
  call COMMA
  opencapture 104
  call SCR_EXPRESSION
  closecapture 104 0
  partialcommit __TERM_3011
__TERM_3012:
  commit __TERM_2993
__TERM_2993:
  call BCLOSE
  ret
-- Rule
SCR_REFERENCE:
  call __prefix
  opencapture 105
  call IDENT
  closecapture 105 0
  catch __TERM_3054
__TERM_3053:
  call INDEX
  partialcommit __TERM_3053
__TERM_3054:
  catch __TERM_3060
__TERM_3059:
  call DOT
  call SCR_REFERENCE
  partialcommit __TERM_3059
__TERM_3060:
  ret
-- Rule
INDEX:
  call __prefix
  call ABOPEN
  opencapture 106
  call SCR_EXPRESSION
  closecapture 106 0
  call ABCLOSE
  ret
-- Rule
LITERAL:
  call __prefix
  catch __RIGHTHAND_3098
  call STRINGLITERAL
  commit __LEFTHAND_3099
__RIGHTHAND_3098:
  catch __RIGHTHAND_3106
  call HASHLITERAL
  commit __LEFTHAND_3107
__RIGHTHAND_3106:
  catch __RIGHTHAND_3114
  call LISTLITERAL
  commit __LEFTHAND_3115
__RIGHTHAND_3114:
  catch __RIGHTHAND_3122
  call FLOATLITERAL
  commit __LEFTHAND_3123
__RIGHTHAND_3122:
  catch __RIGHTHAND_3130
  call INTLITERAL
  commit __LEFTHAND_3131
__RIGHTHAND_3130:
  call BOOLEANLITERAL
__LEFTHAND_3131:
__LEFTHAND_3123:
__LEFTHAND_3115:
__LEFTHAND_3107:
__LEFTHAND_3099:
  ret
-- Rule
STRINGLITERAL:
  call __prefix
  char 27
  opencapture 107
  catch __TERM_3160
__TERM_3159:
  catch __RIGHTHAND_3162
  char 5c
  catch __RIGHTHAND_3176
  set 0000000080000000000000100040540000000000000000000000000000000000
  commit __LEFTHAND_3177
__RIGHTHAND_3176:
  counter 0 3
__TERM_3186:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  condjump 0 __TERM_3186
__LEFTHAND_3177:
  commit __LEFTHAND_3163
__RIGHTHAND_3162:
  set ffffffff7fffffffffffffefffffffffffffffffffffffffffffffffffffffff
__LEFTHAND_3163:
  partialcommit __TERM_3159
__TERM_3160:
  closecapture 107 0
  char 27
  ret
-- Rule
HASHLITERAL:
  call __prefix
  opencapture 108
  call CBOPEN
  catch __TERM_3217
  call HASHELT
  catch __TERM_3230
__TERM_3229:
  call COMMA
  call HASHELT
  partialcommit __TERM_3229
__TERM_3230:
  commit __TERM_3217
__TERM_3217:
  call CBCLOSE
  closecapture 108 0
  ret
-- Rule
HASHELT:
  call __prefix
  opencapture 109
  call HASHKEY
  call COLON
  call HASHVALUE
  closecapture 109 0
  ret
-- Rule
HASHKEY:
  call __prefix
  opencapture 110
  call SCR_TERM
  closecapture 110 0
  ret
-- Rule
HASHVALUE:
  call __prefix
  opencapture 111
  call SCR_TERM
  closecapture 111 0
  ret
-- Rule
LISTLITERAL:
  call __prefix
  opencapture 112
  call ABOPEN
  catch __TERM_3313
  call LISTELT
  catch __TERM_3326
__TERM_3325:
  call COMMA
  call LISTELT
  partialcommit __TERM_3325
__TERM_3326:
  commit __TERM_3313
__TERM_3313:
  call ABCLOSE
  closecapture 112 0
  ret
-- Rule
LISTELT:
  call __prefix
  opencapture 113
  call SCR_TERM
  closecapture 113 0
  ret
-- Rule
FLOATLITERAL:
  call __prefix
  opencapture 114
  catch __TERM_3368
__TERM_3367:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3367
__TERM_3368:
  char 2e
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3380
__TERM_3379:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3379
__TERM_3380:
  closecapture 114 0
  ret
-- Rule
INTLITERAL:
  call __prefix
  opencapture 115
  set 000000000000ff03000000000000000000000000000000000000000000000000
  catch __TERM_3392
__TERM_3391:
  set 000000000000ff03000000000000000000000000000000000000000000000000
  partialcommit __TERM_3391
__TERM_3392:
  closecapture 115 0
  ret
-- Rule
BOOLEANLITERAL:
  call __prefix
  opencapture 116
  catch __RIGHTHAND_3400
  quad 74727565
  commit __LEFTHAND_3401
__RIGHTHAND_3400:
  quad 66616c73
  char 65
__LEFTHAND_3401:
  closecapture 116 0
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
KW_CATCH:
  call __prefix
  quad 63617463
  char 68
  ret
-- Rule
IDENT:
  call __prefix
  opencapture 117
  set 0000000000000000feffff87feffff0700000000000000000000000000000000
  catch __TERM_3489
  counter 0 63
__TERM_3490:
  set 000000000000ff03feffff87feffff0700000000000000000000000000000000
  partialcommit __TERM_3491
__TERM_3491:
  condjump 0 __TERM_3490
  commit __TERM_3489
__TERM_3489:
  closecapture 117 0
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
ASSIGN:
  call __prefix
  char 3d
  ret
-- Rule
PLUSIS:
  call __prefix
  opencapture 118
  char 2b
  char 3d
  closecapture 118 0
  ret
-- Rule
MINIS:
  call __prefix
  opencapture 119
  char 2d
  char 3d
  closecapture 119 0
  ret
-- Rule
MULIS:
  call __prefix
  opencapture 120
  char 2a
  char 3d
  closecapture 120 0
  ret
-- Rule
DIVIS:
  call __prefix
  opencapture 121
  char 2f
  char 3d
  closecapture 121 0
  ret
-- Rule
EQUALS:
  call __prefix
  opencapture 122
  char 3d
  char 3d
  closecapture 122 0
  ret
-- Rule
NEQUALS:
  call __prefix
  opencapture 123
  char 21
  char 3d
  closecapture 123 0
  ret
-- Rule
LT:
  call __prefix
  opencapture 124
  char 3c
  closecapture 124 0
  catch __TERM_3618
  char 3d
  failtwice
__TERM_3618:
  ret
-- Rule
GT:
  call __prefix
  opencapture 125
  char 3e
  closecapture 125 0
  catch __TERM_3636
  char 3d
  failtwice
__TERM_3636:
  ret
-- Rule
LTEQ:
  call __prefix
  opencapture 126
  char 3c
  char 3d
  closecapture 126 0
  ret
-- Rule
GTEQ:
  call __prefix
  opencapture 127
  char 3e
  char 3d
  closecapture 127 0
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
  opencapture 128
  char 2a
  char 2a
  closecapture 128 0
  ret
-- Rule
MUL:
  call __prefix
  opencapture 129
  char 2a
  closecapture 129 0
  catch __TERM_3702
  char 2a
  failtwice
__TERM_3702:
  ret
-- Rule
DIV:
  call __prefix
  opencapture 130
  char 2f
  closecapture 130 0
  catch __TERM_3720
  char 3d
  failtwice
__TERM_3720:
  ret
-- Rule
ADD:
  call __prefix
  opencapture 131
  char 2b
  closecapture 131 0
  catch __TERM_3738
  set 0000000000080020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3738:
  ret
-- Rule
SUB:
  call __prefix
  opencapture 132
  char 2d
  closecapture 132 0
  catch __TERM_3756
  set 0000000000200020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3756:
  ret
-- Rule
INC:
  call __prefix
  opencapture 133
  char 2b
  char 2b
  closecapture 133 0
  ret
-- Rule
DEC:
  call __prefix
  opencapture 134
  char 2d
  char 2d
  closecapture 134 0
  ret
-- Rule
LOGAND:
  call __prefix
  opencapture 135
  char 26
  char 26
  closecapture 135 0
  ret
-- Rule
LOGOR:
  call __prefix
  opencapture 136
  char 7c
  char 7c
  closecapture 136 0
  ret
-- Rule
LOGNOT:
  call __prefix
  opencapture 137
  char 21
  closecapture 137 0
  catch __TERM_3822
  char 3d
  failtwice
__TERM_3822:
  ret
-- Rule
BITAND:
  call __prefix
  opencapture 138
  char 26
  closecapture 138 0
  catch __TERM_3840
  set 0000000040000020000000000000000000000000000000000000000000000000
  failtwice
__TERM_3840:
  ret
-- Rule
BITOR:
  call __prefix
  opencapture 139
  char 7c
  closecapture 139 0
  catch __TERM_3858
  set 0000000000000020000000000000001000000000000000000000000000000000
  failtwice
__TERM_3858:
  ret
-- Rule
BITXOR:
  call __prefix
  opencapture 140
  char 5e
  closecapture 140 0
  catch __TERM_3876
  char 3d
  failtwice
__TERM_3876:
  ret
-- Rule
BITNOT:
  call __prefix
  opencapture 141
  char 7e
  closecapture 141 0
  ret
-- Rule
BITANDIS:
  call __prefix
  opencapture 142
  char 26
  char 3d
  closecapture 142 0
  ret
-- Rule
BITORIS:
  call __prefix
  opencapture 143
  char 7c
  char 3d
  closecapture 143 0
  ret
-- Rule
BITXORIS:
  call __prefix
  opencapture 144
  char 5e
  char 3d
  closecapture 144 0
  ret
-- Rule
BITNOTIS:
  call __prefix
  opencapture 145
  char 7e
  char 3d
  closecapture 145 0
  ret
-- Rule
COMMA:
  call __prefix
  char 2c
  ret
-- Rule
DOT:
  call __prefix
  opencapture 146
  char 2e
  closecapture 146 0
  ret
-- Rule
LSHIFT:
  call __prefix
  opencapture 147
  char 3c
  char 3c
  closecapture 147 0
  catch __TERM_3972
  char 3d
  failtwice
__TERM_3972:
  ret
-- Rule
RSHIFT:
  call __prefix
  opencapture 148
  char 3e
  char 3e
  closecapture 148 0
  catch __TERM_3990
  char 3d
  failtwice
__TERM_3990:
  ret
-- Rule
LSHIFTIS:
  call __prefix
  opencapture 149
  char 3c
  char 3c
  char 3d
  closecapture 149 0
  ret
-- Rule
RSHIFTIS:
  call __prefix
  opencapture 150
  char 3e
  char 3e
  char 3d
  closecapture 150 0
  ret

  end 0

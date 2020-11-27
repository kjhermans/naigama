#define SLOTMAP_SWITCH \
  case 0: return "DEFINITION_GLOBALVARDECL"; break; \
  case 1: return "DEFINITION_FUNCDECL"; break; \
  case 2: return "DEFINITION_RULE"; break; \
  case 3: return "RULE_IDENT"; break; \
  case 4: return "EXPRESSION_TERMS"; break; \
  case 5: return "EXPRESSION_TERMS_1"; break; \
  case 6: return "EXPRESSION_TERMS_2"; break; \
  case 7: return "TERMS_TERM"; break; \
  case 8: return "TERM_SCANMATCHER"; break; \
  case 9: return "TERM_QUANTIFIEDMATCHER"; break; \
  case 10: return "SCANMATCHER_NOT"; break; \
  case 11: return "SCANMATCHER_AND"; break; \
  case 12: return "QUANTIFIEDMATCHER_QUANTIFIER"; break; \
  case 13: return "QUANTIFIER"; break; \
  case 14: return "QUANTIFIER_1"; break; \
  case 15: return "QUANTIFIER_2"; break; \
  case 16: return "QUANTIFIER_3"; break; \
  case 17: return "QUANTIFIER_4"; break; \
  case 18: return "QUANTIFIER_5"; break; \
  case 19: return "QUANTIFIER_6"; break; \
  case 20: return "QUANTIFIER_7"; break; \
  case 21: return "QUANTIFIER_IDENT"; break; \
  case 22: return "MATCHER_ANY"; break; \
  case 23: return "MATCHER_SET"; break; \
  case 24: return "MATCHER_STRING"; break; \
  case 25: return "MATCHER_BITMASK"; break; \
  case 26: return "MATCHER_HEXLITERAL"; break; \
  case 27: return "MATCHER_VARCAPTURE"; break; \
  case 28: return "MATCHER_CAPTURE"; break; \
  case 29: return "MATCHER_GROUP"; break; \
  case 30: return "MATCHER_MACRO"; break; \
  case 31: return "MATCHER_ENDFORCE"; break; \
  case 32: return "MATCHER_VARREFERENCE"; break; \
  case 33: return "MATCHER_REFERENCE"; break; \
  case 34: return "VARCAPTURE_IDENT"; break; \
  case 35: return "VARCAPTURE_CAPTURETYPE"; break; \
  case 36: return "VARCAPTURE_CBCLOSE"; break; \
  case 37: return "TYPE_UINTINT"; break; \
  case 38: return "CAPTUREEND_REPLACERECYCLE"; break; \
  case 39: return "SET_SETNOT"; break; \
  case 40: return "SET_NRTV"; break; \
  case 41: return "SET_NRTV_1"; break; \
  case 42: return "SET_NRTV_2"; break; \
  case 43: return "VARREFERENCE_IDENT"; break; \
  case 44: return "VARREFERENCE_NUMBER"; break; \
  case 45: return "REFERENCE_IDENT"; break; \
  case 46: return "REPLACE_REPLACETERMS"; break; \
  case 47: return "REPLACETERM_STRINGLITERAL"; break; \
  case 48: return "REPLACETERM_HEXLITERAL"; break; \
  case 49: return "REPLACETERM_VARREFERENCE"; break; \
  case 50: return "RECYCLE_IDENT"; break; \
  case 51: return "ENDFORCE_NUMBER"; break; \
  case 52: return "FUNCDECL_IDENT"; break; \
  case 53: return "FUNCDECL_FUNCPARAMDECL"; break; \
  case 54: return "FUNCDECL_FUNCBODY"; break; \
  case 55: return "FUNCPARAMDECL_PARAMDECL"; break; \
  case 56: return "FUNCPARAMDECL_PARAMDECL_1"; break; \
  case 57: return "PARAMDECL_SCRTYPE"; break; \
  case 58: return "PARAMDECL_IDENT"; break; \
  case 59: return "PARAMDECL_IDENT_1"; break; \
  case 60: return "FUNCBODY_LOWSTMT"; break; \
  case 61: return "LOWSTMT_STIF"; break; \
  case 62: return "LOWSTMT_STWHILE"; break; \
  case 63: return "LOWSTMT_STCATCH"; break; \
  case 64: return "LOWSTMT_STRETURN"; break; \
  case 65: return "LOWSTMT_STOTHER"; break; \
  case 66: return "LOWSTMT_VARDECL"; break; \
  case 67: return "LOWSTMT_ASSIGNMENT"; break; \
  case 68: return "LOWSTMT_SCREXPRESSION"; break; \
  case 69: return "ST_IF_SCREXPRESSION"; break; \
  case 70: return "ST_IF_LOWSTMT"; break; \
  case 71: return "ST_IF_IFELSEIF"; break; \
  case 72: return "ST_IF_IFELSE"; break; \
  case 73: return "IF_ELSEIF_SCREXPRESSION"; break; \
  case 74: return "IF_ELSEIF_LOWSTMT"; break; \
  case 75: return "IF_ELSE_LOWSTMT"; break; \
  case 76: return "ST_WHILE_SCREXPRESSION"; break; \
  case 77: return "ST_WHILE_LOWSTMT"; break; \
  case 78: return "ST_CATCH_LOWSTMT"; break; \
  case 79: return "ST_RETURN_SCREXPRESSION"; break; \
  case 80: return "VARDECL_SCRTYPE"; break; \
  case 81: return "VARDECL_IDENT"; break; \
  case 82: return "VARDECL_IDENT_1"; break; \
  case 83: return "VARDECL_SCREXPRESSION"; break; \
  case 84: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \
  case 85: return "BINOP_P12_LOGORBINOPPSCRTERM"; break; \
  case 86: return "BINOP_P11_LOGANDBINOPPSCRTERM"; break; \
  case 87: return "BINOP_P10_BITORBINOPPSCRTERM"; break; \
  case 88: return "BINOP_P09_BITXORBINOPPSCRTERM"; break; \
  case 89: return "BINOP_P08_BITANDBINOPPSCRTERM"; break; \
  case 90: return "BINOP_P07_EQUALSNEQUALSBINOPPSCR"; break; \
  case 91: return "BINOP_P06_LTEQLTGTEQGTBINOPPSCRT"; break; \
  case 92: return "BINOP_P05_LSHIFTRSHIFTBINOPPSCRT"; break; \
  case 93: return "BINOP_P04_ADDSUBBINOPPSCRTERM"; break; \
  case 94: return "BINOP_P03_MULDIVPOWSCRTERM"; break; \
  case 95: return "UNOP_LOGNOTBITNOTTODOINCREMENTAN"; break; \
  case 96: return "SCR_TERM_FUNCTIONCALL"; break; \
  case 97: return "SCR_TERM_BOPENSCREXPRESSIONBCLOS"; break; \
  case 98: return "SCR_TERM_SCREXPRESSION"; break; \
  case 99: return "SCR_TERM_LITERAL"; break; \
  case 100: return "SCR_TERM_UNOP"; break; \
  case 101: return "SCR_TERM_SCRREFERENCE"; break; \
  case 102: return "FUNCTIONCALL_SCRREFERENCE"; break; \
  case 103: return "FUNCTIONCALL_SCREXPRESSION"; break; \
  case 104: return "FUNCTIONCALL_SCREXPRESSION_1"; break; \
  case 105: return "SCR_REFERENCE_IDENT"; break; \
  case 106: return "INDEX_SCREXPRESSION"; break; \
  case 107: return "STRINGLITERAL_NRTV"; break; \
  case 108: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 109: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 110: return "HASHKEY_SCRTERM"; break; \
  case 111: return "HASHVALUE_SCRTERM"; break; \
  case 112: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 113: return "LISTELT_SCRTERM"; break; \
  case 114: return "FLOATLITERAL"; break; \
  case 115: return "INTLITERAL"; break; \
  case 116: return "BOOLEANLITERAL_TRUEFALSEKWIMPORT"; break; \
  case 117: return "IDENT_AZAZAZAZ"; break; \
  case 118: return "PLUSIS"; break; \
  case 119: return "MINIS"; break; \
  case 120: return "MULIS"; break; \
  case 121: return "DIVIS"; break; \
  case 122: return "EQUALS"; break; \
  case 123: return "NEQUALS"; break; \
  case 124: return "LT"; break; \
  case 125: return "GT"; break; \
  case 126: return "LTEQ"; break; \
  case 127: return "GTEQ"; break; \
  case 128: return "POW"; break; \
  case 129: return "MUL"; break; \
  case 130: return "DIV"; break; \
  case 131: return "ADD"; break; \
  case 132: return "SUB"; break; \
  case 133: return "INC"; break; \
  case 134: return "DEC"; break; \
  case 135: return "LOGAND"; break; \
  case 136: return "LOGOR"; break; \
  case 137: return "LOGNOT"; break; \
  case 138: return "BITAND"; break; \
  case 139: return "BITOR"; break; \
  case 140: return "BITXOR"; break; \
  case 141: return "BITNOT"; break; \
  case 142: return "BITANDIS"; break; \
  case 143: return "BITORIS"; break; \
  case 144: return "BITXORIS"; break; \
  case 145: return "BITNOTIS"; break; \
  case 146: return "DOT"; break; \
  case 147: return "LSHIFT"; break; \
  case 148: return "RSHIFT"; break; \
  case 149: return "LSHIFTIS"; break; \
  case 150: return "RSHIFTIS"; break; \


#define SLOT_DEFINITION_GLOBALVARDECL 0
#define SLOT_DEFINITION_FUNCDECL 1
#define SLOT_DEFINITION_RULE 2
#define SLOT_RULE_IDENT 3
#define SLOT_EXPRESSION_TERMS 4
#define SLOT_EXPRESSION_TERMS_1 5
#define SLOT_EXPRESSION_TERMS_2 6
#define SLOT_TERMS_TERM 7
#define SLOT_TERM_SCANMATCHER 8
#define SLOT_TERM_QUANTIFIEDMATCHER 9
#define SLOT_SCANMATCHER_NOT 10
#define SLOT_SCANMATCHER_AND 11
#define SLOT_QUANTIFIEDMATCHER_QUANTIFIER 12
#define SLOT_QUANTIFIER 13
#define SLOT_QUANTIFIER_1 14
#define SLOT_QUANTIFIER_2 15
#define SLOT_QUANTIFIER_3 16
#define SLOT_QUANTIFIER_4 17
#define SLOT_QUANTIFIER_5 18
#define SLOT_QUANTIFIER_6 19
#define SLOT_QUANTIFIER_7 20
#define SLOT_QUANTIFIER_IDENT 21
#define SLOT_MATCHER_ANY 22
#define SLOT_MATCHER_SET 23
#define SLOT_MATCHER_STRING 24
#define SLOT_MATCHER_BITMASK 25
#define SLOT_MATCHER_HEXLITERAL 26
#define SLOT_MATCHER_VARCAPTURE 27
#define SLOT_MATCHER_CAPTURE 28
#define SLOT_MATCHER_GROUP 29
#define SLOT_MATCHER_MACRO 30
#define SLOT_MATCHER_ENDFORCE 31
#define SLOT_MATCHER_VARREFERENCE 32
#define SLOT_MATCHER_REFERENCE 33
#define SLOT_VARCAPTURE_IDENT 34
#define SLOT_VARCAPTURE_CAPTURETYPE 35
#define SLOT_VARCAPTURE_CBCLOSE 36
#define SLOT_TYPE_UINTINT 37
#define SLOT_CAPTUREEND_REPLACERECYCLE 38
#define SLOT_SET_SETNOT 39
#define SLOT_SET_NRTV 40
#define SLOT_SET_NRTV_1 41
#define SLOT_SET_NRTV_2 42
#define SLOT_VARREFERENCE_IDENT 43
#define SLOT_VARREFERENCE_NUMBER 44
#define SLOT_REFERENCE_IDENT 45
#define SLOT_REPLACE_REPLACETERMS 46
#define SLOT_REPLACETERM_STRINGLITERAL 47
#define SLOT_REPLACETERM_HEXLITERAL 48
#define SLOT_REPLACETERM_VARREFERENCE 49
#define SLOT_RECYCLE_IDENT 50
#define SLOT_ENDFORCE_NUMBER 51
#define SLOT_FUNCDECL_IDENT 52
#define SLOT_FUNCDECL_FUNCPARAMDECL 53
#define SLOT_FUNCDECL_FUNCBODY 54
#define SLOT_FUNCPARAMDECL_PARAMDECL 55
#define SLOT_FUNCPARAMDECL_PARAMDECL_1 56
#define SLOT_PARAMDECL_SCRTYPE 57
#define SLOT_PARAMDECL_IDENT 58
#define SLOT_PARAMDECL_IDENT_1 59
#define SLOT_FUNCBODY_LOWSTMT 60
#define SLOT_LOWSTMT_STIF 61
#define SLOT_LOWSTMT_STWHILE 62
#define SLOT_LOWSTMT_STCATCH 63
#define SLOT_LOWSTMT_STRETURN 64
#define SLOT_LOWSTMT_STOTHER 65
#define SLOT_LOWSTMT_VARDECL 66
#define SLOT_LOWSTMT_ASSIGNMENT 67
#define SLOT_LOWSTMT_SCREXPRESSION 68
#define SLOT_ST_IF_SCREXPRESSION 69
#define SLOT_ST_IF_LOWSTMT 70
#define SLOT_ST_IF_IFELSEIF 71
#define SLOT_ST_IF_IFELSE 72
#define SLOT_IF_ELSEIF_SCREXPRESSION 73
#define SLOT_IF_ELSEIF_LOWSTMT 74
#define SLOT_IF_ELSE_LOWSTMT 75
#define SLOT_ST_WHILE_SCREXPRESSION 76
#define SLOT_ST_WHILE_LOWSTMT 77
#define SLOT_ST_CATCH_LOWSTMT 78
#define SLOT_ST_RETURN_SCREXPRESSION 79
#define SLOT_VARDECL_SCRTYPE 80
#define SLOT_VARDECL_IDENT 81
#define SLOT_VARDECL_IDENT_1 82
#define SLOT_VARDECL_SCREXPRESSION 83
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 84
#define SLOT_BINOP_P12_LOGORBINOPPSCRTERM 85
#define SLOT_BINOP_P11_LOGANDBINOPPSCRTERM 86
#define SLOT_BINOP_P10_BITORBINOPPSCRTERM 87
#define SLOT_BINOP_P09_BITXORBINOPPSCRTERM 88
#define SLOT_BINOP_P08_BITANDBINOPPSCRTERM 89
#define SLOT_BINOP_P07_EQUALSNEQUALSBINOPPSCR 90
#define SLOT_BINOP_P06_LTEQLTGTEQGTBINOPPSCRT 91
#define SLOT_BINOP_P05_LSHIFTRSHIFTBINOPPSCRT 92
#define SLOT_BINOP_P04_ADDSUBBINOPPSCRTERM 93
#define SLOT_BINOP_P03_MULDIVPOWSCRTERM 94
#define SLOT_UNOP_LOGNOTBITNOTTODOINCREMENTAN 95
#define SLOT_SCR_TERM_FUNCTIONCALL 96
#define SLOT_SCR_TERM_BOPENSCREXPRESSIONBCLOS 97
#define SLOT_SCR_TERM_SCREXPRESSION 98
#define SLOT_SCR_TERM_LITERAL 99
#define SLOT_SCR_TERM_UNOP 100
#define SLOT_SCR_TERM_SCRREFERENCE 101
#define SLOT_FUNCTIONCALL_SCRREFERENCE 102
#define SLOT_FUNCTIONCALL_SCREXPRESSION 103
#define SLOT_FUNCTIONCALL_SCREXPRESSION_1 104
#define SLOT_SCR_REFERENCE_IDENT 105
#define SLOT_INDEX_SCREXPRESSION 106
#define SLOT_STRINGLITERAL_NRTV 107
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 108
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 109
#define SLOT_HASHKEY_SCRTERM 110
#define SLOT_HASHVALUE_SCRTERM 111
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 112
#define SLOT_LISTELT_SCRTERM 113
#define SLOT_FLOATLITERAL 114
#define SLOT_INTLITERAL 115
#define SLOT_BOOLEANLITERAL_TRUEFALSEKWIMPORT 116
#define SLOT_IDENT_AZAZAZAZ 117
#define SLOT_PLUSIS 118
#define SLOT_MINIS 119
#define SLOT_MULIS 120
#define SLOT_DIVIS 121
#define SLOT_EQUALS 122
#define SLOT_NEQUALS 123
#define SLOT_LT 124
#define SLOT_GT 125
#define SLOT_LTEQ 126
#define SLOT_GTEQ 127
#define SLOT_POW 128
#define SLOT_MUL 129
#define SLOT_DIV 130
#define SLOT_ADD 131
#define SLOT_SUB 132
#define SLOT_INC 133
#define SLOT_DEC 134
#define SLOT_LOGAND 135
#define SLOT_LOGOR 136
#define SLOT_LOGNOT 137
#define SLOT_BITAND 138
#define SLOT_BITOR 139
#define SLOT_BITXOR 140
#define SLOT_BITNOT 141
#define SLOT_BITANDIS 142
#define SLOT_BITORIS 143
#define SLOT_BITXORIS 144
#define SLOT_BITNOTIS 145
#define SLOT_DOT 146
#define SLOT_LSHIFT 147
#define SLOT_RSHIFT 148
#define SLOT_LSHIFTIS 149
#define SLOT_RSHIFTIS 150

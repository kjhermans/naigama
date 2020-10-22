#define SLOTMAP_SWITCH \
  case 0: return "DEFINITION_FUNCDECL"; break; \
  case 1: return "DEFINITION_RULE"; break; \
  case 2: return "RULE_IDENT"; break; \
  case 3: return "EXPRESSION_TERMS"; break; \
  case 4: return "EXPRESSION_TERMS_1"; break; \
  case 5: return "EXPRESSION_TERMS_2"; break; \
  case 6: return "TERMS_TERM"; break; \
  case 7: return "TERM_SCANMATCHER"; break; \
  case 8: return "TERM_QUANTIFIEDMATCHER"; break; \
  case 9: return "SCANMATCHER_NOT"; break; \
  case 10: return "SCANMATCHER_AND"; break; \
  case 11: return "QUANTIFIEDMATCHER_QUANTIFIER"; break; \
  case 12: return "QUANTIFIER"; break; \
  case 13: return "QUANTIFIER_1"; break; \
  case 14: return "QUANTIFIER_2"; break; \
  case 15: return "QUANTIFIER_3"; break; \
  case 16: return "QUANTIFIER_4"; break; \
  case 17: return "QUANTIFIER_5"; break; \
  case 18: return "QUANTIFIER_6"; break; \
  case 19: return "QUANTIFIER_7"; break; \
  case 20: return "QUANTIFIER_IDENT"; break; \
  case 21: return "MATCHER_ANY"; break; \
  case 22: return "MATCHER_SET"; break; \
  case 23: return "MATCHER_STRING"; break; \
  case 24: return "MATCHER_BITMASK"; break; \
  case 25: return "MATCHER_HEXLITERAL"; break; \
  case 26: return "MATCHER_VARCAPTURE"; break; \
  case 27: return "MATCHER_CAPTURE"; break; \
  case 28: return "MATCHER_GROUP"; break; \
  case 29: return "MATCHER_MACRO"; break; \
  case 30: return "MATCHER_ENDFORCE"; break; \
  case 31: return "MATCHER_VARREFERENCE"; break; \
  case 32: return "MATCHER_REFERENCE"; break; \
  case 33: return "VARCAPTURE_IDENT"; break; \
  case 34: return "VARCAPTURE_CAPTURETYPE"; break; \
  case 35: return "VARCAPTURE_CBCLOSE"; break; \
  case 36: return "TYPE_UINTINT"; break; \
  case 37: return "CAPTURE_CBCLOSE"; break; \
  case 38: return "SET_SETNOT"; break; \
  case 39: return "SET_NRTV"; break; \
  case 40: return "SET_NRTV_1"; break; \
  case 41: return "SET_NRTV_2"; break; \
  case 42: return "VARREFERENCE_IDENT"; break; \
  case 43: return "VARREFERENCE_NUMBER"; break; \
  case 44: return "REPLACE_REPLACETERMS"; break; \
  case 45: return "REPLACETERM_STRINGLITERAL"; break; \
  case 46: return "REPLACETERM_HEXLITERAL"; break; \
  case 47: return "REPLACETERM_VARREFERENCE"; break; \
  case 48: return "RECYCLE_IDENT"; break; \
  case 49: return "ENDFORCE_NUMBER"; break; \
  case 50: return "FUNCDECL_IDENT"; break; \
  case 51: return "FUNCDECL_FUNCPARAMDECL"; break; \
  case 52: return "FUNCDECL_FUNCBODY"; break; \
  case 53: return "FUNCPARAMDECL_PARAMDECL"; break; \
  case 54: return "FUNCPARAMDECL_PARAMDECL_1"; break; \
  case 55: return "PARAMDECL_IDENT"; break; \
  case 56: return "PARAMDECL_IDENT_1"; break; \
  case 57: return "PARAMDECL_IDENT_2"; break; \
  case 58: return "FUNCBODY_LOWSTMT"; break; \
  case 59: return "LOWSTMT_STIF"; break; \
  case 60: return "LOWSTMT_STWHILE"; break; \
  case 61: return "LOWSTMT_STRETURN"; break; \
  case 62: return "LOWSTMT_STOTHER"; break; \
  case 63: return "LOWSTMT_VARDECL"; break; \
  case 64: return "LOWSTMT_ASSIGNMENT"; break; \
  case 65: return "LOWSTMT_SCREXPRESSION"; break; \
  case 66: return "ST_IF_SCREXPRESSION"; break; \
  case 67: return "ST_IF_LOWSTMT"; break; \
  case 68: return "ST_IF_IFELSEIF"; break; \
  case 69: return "ST_IF_IFELSE"; break; \
  case 70: return "IF_ELSEIF_SCREXPRESSION"; break; \
  case 71: return "IF_ELSEIF_LOWSTMT"; break; \
  case 72: return "IF_ELSE_LOWSTMT"; break; \
  case 73: return "ST_WHILE_SCREXPRESSION"; break; \
  case 74: return "ST_WHILE_LOWSTMT"; break; \
  case 75: return "ST_RETURN_SCREXPRESSION"; break; \
  case 76: return "VARDECL_SCREXPRESSION"; break; \
  case 77: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \
  case 78: return "BINOP_P12_LOGORBINOPPSCRTERM"; break; \
  case 79: return "BINOP_P11_LOGANDBINOPPSCRTERM"; break; \
  case 80: return "BINOP_P10_BITORBINOPPSCRTERM"; break; \
  case 81: return "BINOP_P09_BITXORBINOPPSCRTERM"; break; \
  case 82: return "BINOP_P08_BITANDBINOPPSCRTERM"; break; \
  case 83: return "BINOP_P07_EQUALSNEQUALSBINOPPSCR"; break; \
  case 84: return "BINOP_P06_LTEQLTGTEQGTBINOPPSCRT"; break; \
  case 85: return "BINOP_P05_LSHIFTRSHIFTBINOPPSCRT"; break; \
  case 86: return "BINOP_P04_ADDSUBBINOPPSCRTERM"; break; \
  case 87: return "BINOP_P03_MULDIVPOWSCRTERM"; break; \
  case 88: return "UNOP_LOGNOTBITNOTTODOINCREMENTAN"; break; \
  case 89: return "SCR_TERM_FUNCTIONCALL"; break; \
  case 90: return "SCR_TERM_BOPENSCREXPRESSIONBCLOS"; break; \
  case 91: return "SCR_TERM_SCREXPRESSION"; break; \
  case 92: return "SCR_TERM_LITERAL"; break; \
  case 93: return "SCR_TERM_UNOP"; break; \
  case 94: return "SCR_TERM_SCRREFERENCE"; break; \
  case 95: return "FUNCTIONCALL_SCRREFERENCE"; break; \
  case 96: return "FUNCTIONCALL_SCREXPRESSION"; break; \
  case 97: return "FUNCTIONCALL_SCREXPRESSION_1"; break; \
  case 98: return "SCR_REFERENCE_IDENT"; break; \
  case 99: return "INDEX_SCREXPRESSION"; break; \
  case 100: return "STRINGLITERAL_NRTV"; break; \
  case 101: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 102: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 103: return "HASHKEY_SCRTERM"; break; \
  case 104: return "HASHVALUE_SCRTERM"; break; \
  case 105: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 106: return "LISTELT_SCRTERM"; break; \
  case 107: return "FLOATLITERAL"; break; \
  case 108: return "INTLITERAL"; break; \
  case 109: return "BOOLEANLITERAL_TRUEFALSEKWIMPORT"; break; \
  case 110: return "ASSIGN"; break; \
  case 111: return "PLUSIS"; break; \
  case 112: return "MINIS"; break; \
  case 113: return "MULIS"; break; \
  case 114: return "DIVIS"; break; \
  case 115: return "EQUALS"; break; \
  case 116: return "NEQUALS"; break; \
  case 117: return "LT"; break; \
  case 118: return "GT"; break; \
  case 119: return "LTEQ"; break; \
  case 120: return "GTEQ"; break; \
  case 121: return "COLON"; break; \
  case 122: return "POW"; break; \
  case 123: return "MUL"; break; \
  case 124: return "DIV"; break; \
  case 125: return "ADD"; break; \
  case 126: return "SUB"; break; \
  case 127: return "INC"; break; \
  case 128: return "DEC"; break; \
  case 129: return "LOGAND"; break; \
  case 130: return "LOGOR"; break; \
  case 131: return "LOGNOT"; break; \
  case 132: return "BITAND"; break; \
  case 133: return "BITOR"; break; \
  case 134: return "BITXOR"; break; \
  case 135: return "BITNOT"; break; \
  case 136: return "BITANDIS"; break; \
  case 137: return "BITORIS"; break; \
  case 138: return "BITXORIS"; break; \
  case 139: return "BITNOTIS"; break; \
  case 140: return "DOT"; break; \
  case 141: return "LSHIFT"; break; \
  case 142: return "RSHIFT"; break; \
  case 143: return "LSHIFTIS"; break; \
  case 144: return "RSHIFTIS"; break; \


#define SLOT_DEFINITION_FUNCDECL 0
#define SLOT_DEFINITION_RULE 1
#define SLOT_RULE_IDENT 2
#define SLOT_EXPRESSION_TERMS 3
#define SLOT_EXPRESSION_TERMS_1 4
#define SLOT_EXPRESSION_TERMS_2 5
#define SLOT_TERMS_TERM 6
#define SLOT_TERM_SCANMATCHER 7
#define SLOT_TERM_QUANTIFIEDMATCHER 8
#define SLOT_SCANMATCHER_NOT 9
#define SLOT_SCANMATCHER_AND 10
#define SLOT_QUANTIFIEDMATCHER_QUANTIFIER 11
#define SLOT_QUANTIFIER 12
#define SLOT_QUANTIFIER_1 13
#define SLOT_QUANTIFIER_2 14
#define SLOT_QUANTIFIER_3 15
#define SLOT_QUANTIFIER_4 16
#define SLOT_QUANTIFIER_5 17
#define SLOT_QUANTIFIER_6 18
#define SLOT_QUANTIFIER_7 19
#define SLOT_QUANTIFIER_IDENT 20
#define SLOT_MATCHER_ANY 21
#define SLOT_MATCHER_SET 22
#define SLOT_MATCHER_STRING 23
#define SLOT_MATCHER_BITMASK 24
#define SLOT_MATCHER_HEXLITERAL 25
#define SLOT_MATCHER_VARCAPTURE 26
#define SLOT_MATCHER_CAPTURE 27
#define SLOT_MATCHER_GROUP 28
#define SLOT_MATCHER_MACRO 29
#define SLOT_MATCHER_ENDFORCE 30
#define SLOT_MATCHER_VARREFERENCE 31
#define SLOT_MATCHER_REFERENCE 32
#define SLOT_VARCAPTURE_IDENT 33
#define SLOT_VARCAPTURE_CAPTURETYPE 34
#define SLOT_VARCAPTURE_CBCLOSE 35
#define SLOT_TYPE_UINTINT 36
#define SLOT_CAPTURE_CBCLOSE 37
#define SLOT_SET_SETNOT 38
#define SLOT_SET_NRTV 39
#define SLOT_SET_NRTV_1 40
#define SLOT_SET_NRTV_2 41
#define SLOT_VARREFERENCE_IDENT 42
#define SLOT_VARREFERENCE_NUMBER 43
#define SLOT_REPLACE_REPLACETERMS 44
#define SLOT_REPLACETERM_STRINGLITERAL 45
#define SLOT_REPLACETERM_HEXLITERAL 46
#define SLOT_REPLACETERM_VARREFERENCE 47
#define SLOT_RECYCLE_IDENT 48
#define SLOT_ENDFORCE_NUMBER 49
#define SLOT_FUNCDECL_IDENT 50
#define SLOT_FUNCDECL_FUNCPARAMDECL 51
#define SLOT_FUNCDECL_FUNCBODY 52
#define SLOT_FUNCPARAMDECL_PARAMDECL 53
#define SLOT_FUNCPARAMDECL_PARAMDECL_1 54
#define SLOT_PARAMDECL_IDENT 55
#define SLOT_PARAMDECL_IDENT_1 56
#define SLOT_PARAMDECL_IDENT_2 57
#define SLOT_FUNCBODY_LOWSTMT 58
#define SLOT_LOWSTMT_STIF 59
#define SLOT_LOWSTMT_STWHILE 60
#define SLOT_LOWSTMT_STRETURN 61
#define SLOT_LOWSTMT_STOTHER 62
#define SLOT_LOWSTMT_VARDECL 63
#define SLOT_LOWSTMT_ASSIGNMENT 64
#define SLOT_LOWSTMT_SCREXPRESSION 65
#define SLOT_ST_IF_SCREXPRESSION 66
#define SLOT_ST_IF_LOWSTMT 67
#define SLOT_ST_IF_IFELSEIF 68
#define SLOT_ST_IF_IFELSE 69
#define SLOT_IF_ELSEIF_SCREXPRESSION 70
#define SLOT_IF_ELSEIF_LOWSTMT 71
#define SLOT_IF_ELSE_LOWSTMT 72
#define SLOT_ST_WHILE_SCREXPRESSION 73
#define SLOT_ST_WHILE_LOWSTMT 74
#define SLOT_ST_RETURN_SCREXPRESSION 75
#define SLOT_VARDECL_SCREXPRESSION 76
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 77
#define SLOT_BINOP_P12_LOGORBINOPPSCRTERM 78
#define SLOT_BINOP_P11_LOGANDBINOPPSCRTERM 79
#define SLOT_BINOP_P10_BITORBINOPPSCRTERM 80
#define SLOT_BINOP_P09_BITXORBINOPPSCRTERM 81
#define SLOT_BINOP_P08_BITANDBINOPPSCRTERM 82
#define SLOT_BINOP_P07_EQUALSNEQUALSBINOPPSCR 83
#define SLOT_BINOP_P06_LTEQLTGTEQGTBINOPPSCRT 84
#define SLOT_BINOP_P05_LSHIFTRSHIFTBINOPPSCRT 85
#define SLOT_BINOP_P04_ADDSUBBINOPPSCRTERM 86
#define SLOT_BINOP_P03_MULDIVPOWSCRTERM 87
#define SLOT_UNOP_LOGNOTBITNOTTODOINCREMENTAN 88
#define SLOT_SCR_TERM_FUNCTIONCALL 89
#define SLOT_SCR_TERM_BOPENSCREXPRESSIONBCLOS 90
#define SLOT_SCR_TERM_SCREXPRESSION 91
#define SLOT_SCR_TERM_LITERAL 92
#define SLOT_SCR_TERM_UNOP 93
#define SLOT_SCR_TERM_SCRREFERENCE 94
#define SLOT_FUNCTIONCALL_SCRREFERENCE 95
#define SLOT_FUNCTIONCALL_SCREXPRESSION 96
#define SLOT_FUNCTIONCALL_SCREXPRESSION_1 97
#define SLOT_SCR_REFERENCE_IDENT 98
#define SLOT_INDEX_SCREXPRESSION 99
#define SLOT_STRINGLITERAL_NRTV 100
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 101
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 102
#define SLOT_HASHKEY_SCRTERM 103
#define SLOT_HASHVALUE_SCRTERM 104
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 105
#define SLOT_LISTELT_SCRTERM 106
#define SLOT_FLOATLITERAL 107
#define SLOT_INTLITERAL 108
#define SLOT_BOOLEANLITERAL_TRUEFALSEKWIMPORT 109
#define SLOT_ASSIGN 110
#define SLOT_PLUSIS 111
#define SLOT_MINIS 112
#define SLOT_MULIS 113
#define SLOT_DIVIS 114
#define SLOT_EQUALS 115
#define SLOT_NEQUALS 116
#define SLOT_LT 117
#define SLOT_GT 118
#define SLOT_LTEQ 119
#define SLOT_GTEQ 120
#define SLOT_COLON 121
#define SLOT_POW 122
#define SLOT_MUL 123
#define SLOT_DIV 124
#define SLOT_ADD 125
#define SLOT_SUB 126
#define SLOT_INC 127
#define SLOT_DEC 128
#define SLOT_LOGAND 129
#define SLOT_LOGOR 130
#define SLOT_LOGNOT 131
#define SLOT_BITAND 132
#define SLOT_BITOR 133
#define SLOT_BITXOR 134
#define SLOT_BITNOT 135
#define SLOT_BITANDIS 136
#define SLOT_BITORIS 137
#define SLOT_BITXORIS 138
#define SLOT_BITNOTIS 139
#define SLOT_DOT 140
#define SLOT_LSHIFT 141
#define SLOT_RSHIFT 142
#define SLOT_LSHIFTIS 143
#define SLOT_RSHIFTIS 144

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
  case 44: return "REFERENCE_IDENT"; break; \
  case 45: return "REPLACE_REPLACETERMS"; break; \
  case 46: return "REPLACETERM_STRINGLITERAL"; break; \
  case 47: return "REPLACETERM_HEXLITERAL"; break; \
  case 48: return "REPLACETERM_VARREFERENCE"; break; \
  case 49: return "RECYCLE_IDENT"; break; \
  case 50: return "ENDFORCE_NUMBER"; break; \
  case 51: return "FUNCDECL_IDENT"; break; \
  case 52: return "FUNCDECL_FUNCPARAMDECL"; break; \
  case 53: return "FUNCDECL_FUNCBODY"; break; \
  case 54: return "FUNCPARAMDECL_PARAMDECL"; break; \
  case 55: return "FUNCPARAMDECL_PARAMDECL_1"; break; \
  case 56: return "PARAMDECL_IDENT"; break; \
  case 57: return "PARAMDECL_IDENT_1"; break; \
  case 58: return "PARAMDECL_IDENT_2"; break; \
  case 59: return "FUNCBODY_LOWSTMT"; break; \
  case 60: return "LOWSTMT_STIF"; break; \
  case 61: return "LOWSTMT_STWHILE"; break; \
  case 62: return "LOWSTMT_STRETURN"; break; \
  case 63: return "LOWSTMT_STOTHER"; break; \
  case 64: return "LOWSTMT_VARDECL"; break; \
  case 65: return "LOWSTMT_ASSIGNMENT"; break; \
  case 66: return "LOWSTMT_SCREXPRESSION"; break; \
  case 67: return "ST_IF_SCREXPRESSION"; break; \
  case 68: return "ST_IF_LOWSTMT"; break; \
  case 69: return "ST_IF_IFELSEIF"; break; \
  case 70: return "ST_IF_IFELSE"; break; \
  case 71: return "IF_ELSEIF_SCREXPRESSION"; break; \
  case 72: return "IF_ELSEIF_LOWSTMT"; break; \
  case 73: return "IF_ELSE_LOWSTMT"; break; \
  case 74: return "ST_WHILE_SCREXPRESSION"; break; \
  case 75: return "ST_WHILE_LOWSTMT"; break; \
  case 76: return "ST_RETURN_SCREXPRESSION"; break; \
  case 77: return "VARDECL_SCREXPRESSION"; break; \
  case 78: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \
  case 79: return "BINOP_P12_LOGORBINOPPSCRTERM"; break; \
  case 80: return "BINOP_P11_LOGANDBINOPPSCRTERM"; break; \
  case 81: return "BINOP_P10_BITORBINOPPSCRTERM"; break; \
  case 82: return "BINOP_P09_BITXORBINOPPSCRTERM"; break; \
  case 83: return "BINOP_P08_BITANDBINOPPSCRTERM"; break; \
  case 84: return "BINOP_P07_EQUALSNEQUALSBINOPPSCR"; break; \
  case 85: return "BINOP_P06_LTEQLTGTEQGTBINOPPSCRT"; break; \
  case 86: return "BINOP_P05_LSHIFTRSHIFTBINOPPSCRT"; break; \
  case 87: return "BINOP_P04_ADDSUBBINOPPSCRTERM"; break; \
  case 88: return "BINOP_P03_MULDIVPOWSCRTERM"; break; \
  case 89: return "UNOP_LOGNOTBITNOTTODOINCREMENTAN"; break; \
  case 90: return "SCR_TERM_FUNCTIONCALL"; break; \
  case 91: return "SCR_TERM_BOPENSCREXPRESSIONBCLOS"; break; \
  case 92: return "SCR_TERM_SCREXPRESSION"; break; \
  case 93: return "SCR_TERM_LITERAL"; break; \
  case 94: return "SCR_TERM_UNOP"; break; \
  case 95: return "SCR_TERM_SCRREFERENCE"; break; \
  case 96: return "FUNCTIONCALL_SCRREFERENCE"; break; \
  case 97: return "FUNCTIONCALL_SCREXPRESSION"; break; \
  case 98: return "FUNCTIONCALL_SCREXPRESSION_1"; break; \
  case 99: return "SCR_REFERENCE_IDENT"; break; \
  case 100: return "INDEX_SCREXPRESSION"; break; \
  case 101: return "STRINGLITERAL_NRTV"; break; \
  case 102: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 103: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 104: return "HASHKEY_SCRTERM"; break; \
  case 105: return "HASHVALUE_SCRTERM"; break; \
  case 106: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 107: return "LISTELT_SCRTERM"; break; \
  case 108: return "FLOATLITERAL"; break; \
  case 109: return "INTLITERAL"; break; \
  case 110: return "BOOLEANLITERAL_TRUEFALSEKWIMPORT"; break; \
  case 111: return "ASSIGN"; break; \
  case 112: return "PLUSIS"; break; \
  case 113: return "MINIS"; break; \
  case 114: return "MULIS"; break; \
  case 115: return "DIVIS"; break; \
  case 116: return "EQUALS"; break; \
  case 117: return "NEQUALS"; break; \
  case 118: return "LT"; break; \
  case 119: return "GT"; break; \
  case 120: return "LTEQ"; break; \
  case 121: return "GTEQ"; break; \
  case 122: return "COLON"; break; \
  case 123: return "POW"; break; \
  case 124: return "MUL"; break; \
  case 125: return "DIV"; break; \
  case 126: return "ADD"; break; \
  case 127: return "SUB"; break; \
  case 128: return "INC"; break; \
  case 129: return "DEC"; break; \
  case 130: return "LOGAND"; break; \
  case 131: return "LOGOR"; break; \
  case 132: return "LOGNOT"; break; \
  case 133: return "BITAND"; break; \
  case 134: return "BITOR"; break; \
  case 135: return "BITXOR"; break; \
  case 136: return "BITNOT"; break; \
  case 137: return "BITANDIS"; break; \
  case 138: return "BITORIS"; break; \
  case 139: return "BITXORIS"; break; \
  case 140: return "BITNOTIS"; break; \
  case 141: return "DOT"; break; \
  case 142: return "LSHIFT"; break; \
  case 143: return "RSHIFT"; break; \
  case 144: return "LSHIFTIS"; break; \
  case 145: return "RSHIFTIS"; break; \


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
#define SLOT_REFERENCE_IDENT 44
#define SLOT_REPLACE_REPLACETERMS 45
#define SLOT_REPLACETERM_STRINGLITERAL 46
#define SLOT_REPLACETERM_HEXLITERAL 47
#define SLOT_REPLACETERM_VARREFERENCE 48
#define SLOT_RECYCLE_IDENT 49
#define SLOT_ENDFORCE_NUMBER 50
#define SLOT_FUNCDECL_IDENT 51
#define SLOT_FUNCDECL_FUNCPARAMDECL 52
#define SLOT_FUNCDECL_FUNCBODY 53
#define SLOT_FUNCPARAMDECL_PARAMDECL 54
#define SLOT_FUNCPARAMDECL_PARAMDECL_1 55
#define SLOT_PARAMDECL_IDENT 56
#define SLOT_PARAMDECL_IDENT_1 57
#define SLOT_PARAMDECL_IDENT_2 58
#define SLOT_FUNCBODY_LOWSTMT 59
#define SLOT_LOWSTMT_STIF 60
#define SLOT_LOWSTMT_STWHILE 61
#define SLOT_LOWSTMT_STRETURN 62
#define SLOT_LOWSTMT_STOTHER 63
#define SLOT_LOWSTMT_VARDECL 64
#define SLOT_LOWSTMT_ASSIGNMENT 65
#define SLOT_LOWSTMT_SCREXPRESSION 66
#define SLOT_ST_IF_SCREXPRESSION 67
#define SLOT_ST_IF_LOWSTMT 68
#define SLOT_ST_IF_IFELSEIF 69
#define SLOT_ST_IF_IFELSE 70
#define SLOT_IF_ELSEIF_SCREXPRESSION 71
#define SLOT_IF_ELSEIF_LOWSTMT 72
#define SLOT_IF_ELSE_LOWSTMT 73
#define SLOT_ST_WHILE_SCREXPRESSION 74
#define SLOT_ST_WHILE_LOWSTMT 75
#define SLOT_ST_RETURN_SCREXPRESSION 76
#define SLOT_VARDECL_SCREXPRESSION 77
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 78
#define SLOT_BINOP_P12_LOGORBINOPPSCRTERM 79
#define SLOT_BINOP_P11_LOGANDBINOPPSCRTERM 80
#define SLOT_BINOP_P10_BITORBINOPPSCRTERM 81
#define SLOT_BINOP_P09_BITXORBINOPPSCRTERM 82
#define SLOT_BINOP_P08_BITANDBINOPPSCRTERM 83
#define SLOT_BINOP_P07_EQUALSNEQUALSBINOPPSCR 84
#define SLOT_BINOP_P06_LTEQLTGTEQGTBINOPPSCRT 85
#define SLOT_BINOP_P05_LSHIFTRSHIFTBINOPPSCRT 86
#define SLOT_BINOP_P04_ADDSUBBINOPPSCRTERM 87
#define SLOT_BINOP_P03_MULDIVPOWSCRTERM 88
#define SLOT_UNOP_LOGNOTBITNOTTODOINCREMENTAN 89
#define SLOT_SCR_TERM_FUNCTIONCALL 90
#define SLOT_SCR_TERM_BOPENSCREXPRESSIONBCLOS 91
#define SLOT_SCR_TERM_SCREXPRESSION 92
#define SLOT_SCR_TERM_LITERAL 93
#define SLOT_SCR_TERM_UNOP 94
#define SLOT_SCR_TERM_SCRREFERENCE 95
#define SLOT_FUNCTIONCALL_SCRREFERENCE 96
#define SLOT_FUNCTIONCALL_SCREXPRESSION 97
#define SLOT_FUNCTIONCALL_SCREXPRESSION_1 98
#define SLOT_SCR_REFERENCE_IDENT 99
#define SLOT_INDEX_SCREXPRESSION 100
#define SLOT_STRINGLITERAL_NRTV 101
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 102
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 103
#define SLOT_HASHKEY_SCRTERM 104
#define SLOT_HASHVALUE_SCRTERM 105
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 106
#define SLOT_LISTELT_SCRTERM 107
#define SLOT_FLOATLITERAL 108
#define SLOT_INTLITERAL 109
#define SLOT_BOOLEANLITERAL_TRUEFALSEKWIMPORT 110
#define SLOT_ASSIGN 111
#define SLOT_PLUSIS 112
#define SLOT_MINIS 113
#define SLOT_MULIS 114
#define SLOT_DIVIS 115
#define SLOT_EQUALS 116
#define SLOT_NEQUALS 117
#define SLOT_LT 118
#define SLOT_GT 119
#define SLOT_LTEQ 120
#define SLOT_GTEQ 121
#define SLOT_COLON 122
#define SLOT_POW 123
#define SLOT_MUL 124
#define SLOT_DIV 125
#define SLOT_ADD 126
#define SLOT_SUB 127
#define SLOT_INC 128
#define SLOT_DEC 129
#define SLOT_LOGAND 130
#define SLOT_LOGOR 131
#define SLOT_LOGNOT 132
#define SLOT_BITAND 133
#define SLOT_BITOR 134
#define SLOT_BITXOR 135
#define SLOT_BITNOT 136
#define SLOT_BITANDIS 137
#define SLOT_BITORIS 138
#define SLOT_BITXORIS 139
#define SLOT_BITNOTIS 140
#define SLOT_DOT 141
#define SLOT_LSHIFT 142
#define SLOT_RSHIFT 143
#define SLOT_LSHIFTIS 144
#define SLOT_RSHIFTIS 145

#define SLOTMAP_SWITCH \
  case 0: return "DEFINITION_FUNCDECL"; break; \
  case 1: return "DEFINITION_RULE"; break; \
  case 2: return "RULE_IDENT"; break; \
  case 3: return "EXPRESSION_TERMS"; break; \
  case 4: return "EXPRESSION_TERMS_1"; break; \
  case 5: return "EXPRESSION_TERMS_2"; break; \
  case 6: return "TERMS_TERM"; break; \
  case 7: return "TERM_ENDOWEDMATCHER"; break; \
  case 8: return "ENDOWEDMATCHER_NOTAND"; break; \
  case 9: return "ENDOWEDMATCHER_QUANTIFIER"; break; \
  case 10: return "QUANTIFIER"; break; \
  case 11: return "QUANTIFIER_1"; break; \
  case 12: return "QUANTIFIER_2"; break; \
  case 13: return "QUANTIFIER_3"; break; \
  case 14: return "QUANTIFIER_4"; break; \
  case 15: return "QUANTIFIER_IDENT"; break; \
  case 16: return "MATCHER_ANY"; break; \
  case 17: return "MATCHER_SET"; break; \
  case 18: return "MATCHER_STRING"; break; \
  case 19: return "MATCHER_BITMASK"; break; \
  case 20: return "MATCHER_HEXLITERAL"; break; \
  case 21: return "MATCHER_VARCAPTURE"; break; \
  case 22: return "MATCHER_CAPTURE"; break; \
  case 23: return "MATCHER_GROUP"; break; \
  case 24: return "MATCHER_MACRO"; break; \
  case 25: return "MATCHER_ENDFORCE"; break; \
  case 26: return "MATCHER_VARREFERENCE"; break; \
  case 27: return "MATCHER_REFERENCE"; break; \
  case 28: return "VARCAPTURE_IDENT"; break; \
  case 29: return "VARCAPTURE_CAPTURETYPE"; break; \
  case 30: return "VARCAPTURE_CBCLOSE"; break; \
  case 31: return "TYPE_UINTINT"; break; \
  case 32: return "CAPTURE_CBCLOSE"; break; \
  case 33: return "GROUP_BCLOSE"; break; \
  case 34: return "SET_SETNOT"; break; \
  case 35: return "SET_NRTV"; break; \
  case 36: return "SET_NRTV_1"; break; \
  case 37: return "SET_NRTV_2"; break; \
  case 38: return "SET_ABCLOSE"; break; \
  case 39: return "VARREFERENCE_IDENT"; break; \
  case 40: return "VARREFERENCE_NUMBER"; break; \
  case 41: return "REPLACE_REPLACETERMS"; break; \
  case 42: return "REPLACETERM_STRINGLITERAL"; break; \
  case 43: return "REPLACETERM_HEXLITERAL"; break; \
  case 44: return "REPLACETERM_VARREFERENCE"; break; \
  case 45: return "RECYCLE_IDENT"; break; \
  case 46: return "ENDFORCE_NUMBER"; break; \
  case 47: return "FUNCDECL_IDENT"; break; \
  case 48: return "FUNCDECL_FUNCPARAMDECL"; break; \
  case 49: return "FUNCDECL_FUNCBODY"; break; \
  case 50: return "FUNCPARAMDECL_PARAMDECL"; break; \
  case 51: return "FUNCPARAMDECL_PARAMDECL_1"; break; \
  case 52: return "PARAMDECL_IDENT"; break; \
  case 53: return "PARAMDECL_IDENT_1"; break; \
  case 54: return "PARAMDECL_IDENT_2"; break; \
  case 55: return "FUNCBODY_LOWSTMT"; break; \
  case 56: return "LOWSTMT_STIF"; break; \
  case 57: return "LOWSTMT_STWHILE"; break; \
  case 58: return "LOWSTMT_STRETURN"; break; \
  case 59: return "LOWSTMT_STOTHER"; break; \
  case 60: return "LOWSTMT_VARDECL"; break; \
  case 61: return "LOWSTMT_ASSIGNMENT"; break; \
  case 62: return "LOWSTMT_SCREXPRESSION"; break; \
  case 63: return "ST_IF_SCREXPRESSION"; break; \
  case 64: return "ST_IF_LOWSTMT"; break; \
  case 65: return "ST_IF_IFELSEIF"; break; \
  case 66: return "ST_IF_IFELSE"; break; \
  case 67: return "IF_ELSEIF_SCREXPRESSION"; break; \
  case 68: return "IF_ELSEIF_LOWSTMT"; break; \
  case 69: return "IF_ELSE_LOWSTMT"; break; \
  case 70: return "ST_WHILE_SCREXPRESSION"; break; \
  case 71: return "ST_WHILE_LOWSTMT"; break; \
  case 72: return "ST_RETURN_SCREXPRESSION"; break; \
  case 73: return "VARDECL_SCREXPRESSION"; break; \
  case 74: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \
  case 75: return "BINOP_P12_LOGORBINOPPSCRTERM"; break; \
  case 76: return "BINOP_P11_LOGANDBINOPPSCRTERM"; break; \
  case 77: return "BINOP_P10_BITORBINOPPSCRTERM"; break; \
  case 78: return "BINOP_P09_BITXORBINOPPSCRTERM"; break; \
  case 79: return "BINOP_P08_BITANDBINOPPSCRTERM"; break; \
  case 80: return "BINOP_P07_EQUALSNEQUALSBINOPPSCR"; break; \
  case 81: return "BINOP_P06_LTEQLTGTEQGTBINOPPSCRT"; break; \
  case 82: return "BINOP_P05_LSHIFTRSHIFTBINOPPSCRT"; break; \
  case 83: return "BINOP_P04_ADDSUBBINOPPSCRTERM"; break; \
  case 84: return "BINOP_P03_MULDIVPOWSCRTERM"; break; \
  case 85: return "UNOP_LOGNOTBITNOTINCDEC"; break; \
  case 86: return "SCR_TERM_FUNCTIONCALL"; break; \
  case 87: return "SCR_TERM_BOPENSCREXPRESSIONBCLOS"; break; \
  case 88: return "SCR_TERM_SCREXPRESSION"; break; \
  case 89: return "SCR_TERM_LITERAL"; break; \
  case 90: return "SCR_TERM_UNOP"; break; \
  case 91: return "SCR_TERM_SCRREFERENCE"; break; \
  case 92: return "FUNCTIONCALL_SCRREFERENCE"; break; \
  case 93: return "FUNCTIONCALL_SCREXPRESSION"; break; \
  case 94: return "FUNCTIONCALL_SCREXPRESSION_1"; break; \
  case 95: return "SCR_REFERENCE_IDENT"; break; \
  case 96: return "INDEX_SCREXPRESSION"; break; \
  case 97: return "STRINGLITERAL_NRTV"; break; \
  case 98: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 99: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 100: return "HASHKEY_SCRTERM"; break; \
  case 101: return "HASHVALUE_SCRTERM"; break; \
  case 102: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 103: return "LISTELT_SCRTERM"; break; \
  case 104: return "FLOATLITERAL"; break; \
  case 105: return "INTLITERAL"; break; \
  case 106: return "BOOLEANLITERAL_TRUEFALSEKWIMPORT"; break; \
  case 107: return "ASSIGN"; break; \
  case 108: return "PLUSIS"; break; \
  case 109: return "MINIS"; break; \
  case 110: return "MULIS"; break; \
  case 111: return "DIVIS"; break; \
  case 112: return "EQUALS"; break; \
  case 113: return "NEQUALS"; break; \
  case 114: return "LT"; break; \
  case 115: return "GT"; break; \
  case 116: return "LTEQ"; break; \
  case 117: return "GTEQ"; break; \
  case 118: return "COLON"; break; \
  case 119: return "POW"; break; \
  case 120: return "MUL"; break; \
  case 121: return "DIV"; break; \
  case 122: return "ADD"; break; \
  case 123: return "SUB"; break; \
  case 124: return "INC"; break; \
  case 125: return "DEC"; break; \
  case 126: return "LOGAND"; break; \
  case 127: return "LOGOR"; break; \
  case 128: return "LOGNOT"; break; \
  case 129: return "BITAND"; break; \
  case 130: return "BITOR"; break; \
  case 131: return "BITXOR"; break; \
  case 132: return "BITNOT"; break; \
  case 133: return "BITANDIS"; break; \
  case 134: return "BITORIS"; break; \
  case 135: return "BITXORIS"; break; \
  case 136: return "BITNOTIS"; break; \
  case 137: return "DOT"; break; \
  case 138: return "LSHIFT"; break; \
  case 139: return "RSHIFT"; break; \
  case 140: return "LSHIFTIS"; break; \
  case 141: return "RSHIFTIS"; break; \


#define SLOT_DEFINITION_FUNCDECL 0
#define SLOT_DEFINITION_RULE 1
#define SLOT_RULE_IDENT 2
#define SLOT_EXPRESSION_TERMS 3
#define SLOT_EXPRESSION_TERMS_1 4
#define SLOT_EXPRESSION_TERMS_2 5
#define SLOT_TERMS_TERM 6
#define SLOT_TERM_ENDOWEDMATCHER 7
#define SLOT_ENDOWEDMATCHER_NOTAND 8
#define SLOT_ENDOWEDMATCHER_QUANTIFIER 9
#define SLOT_QUANTIFIER 10
#define SLOT_QUANTIFIER_1 11
#define SLOT_QUANTIFIER_2 12
#define SLOT_QUANTIFIER_3 13
#define SLOT_QUANTIFIER_4 14
#define SLOT_QUANTIFIER_IDENT 15
#define SLOT_MATCHER_ANY 16
#define SLOT_MATCHER_SET 17
#define SLOT_MATCHER_STRING 18
#define SLOT_MATCHER_BITMASK 19
#define SLOT_MATCHER_HEXLITERAL 20
#define SLOT_MATCHER_VARCAPTURE 21
#define SLOT_MATCHER_CAPTURE 22
#define SLOT_MATCHER_GROUP 23
#define SLOT_MATCHER_MACRO 24
#define SLOT_MATCHER_ENDFORCE 25
#define SLOT_MATCHER_VARREFERENCE 26
#define SLOT_MATCHER_REFERENCE 27
#define SLOT_VARCAPTURE_IDENT 28
#define SLOT_VARCAPTURE_CAPTURETYPE 29
#define SLOT_VARCAPTURE_CBCLOSE 30
#define SLOT_TYPE_UINTINT 31
#define SLOT_CAPTURE_CBCLOSE 32
#define SLOT_GROUP_BCLOSE 33
#define SLOT_SET_SETNOT 34
#define SLOT_SET_NRTV 35
#define SLOT_SET_NRTV_1 36
#define SLOT_SET_NRTV_2 37
#define SLOT_SET_ABCLOSE 38
#define SLOT_VARREFERENCE_IDENT 39
#define SLOT_VARREFERENCE_NUMBER 40
#define SLOT_REPLACE_REPLACETERMS 41
#define SLOT_REPLACETERM_STRINGLITERAL 42
#define SLOT_REPLACETERM_HEXLITERAL 43
#define SLOT_REPLACETERM_VARREFERENCE 44
#define SLOT_RECYCLE_IDENT 45
#define SLOT_ENDFORCE_NUMBER 46
#define SLOT_FUNCDECL_IDENT 47
#define SLOT_FUNCDECL_FUNCPARAMDECL 48
#define SLOT_FUNCDECL_FUNCBODY 49
#define SLOT_FUNCPARAMDECL_PARAMDECL 50
#define SLOT_FUNCPARAMDECL_PARAMDECL_1 51
#define SLOT_PARAMDECL_IDENT 52
#define SLOT_PARAMDECL_IDENT_1 53
#define SLOT_PARAMDECL_IDENT_2 54
#define SLOT_FUNCBODY_LOWSTMT 55
#define SLOT_LOWSTMT_STIF 56
#define SLOT_LOWSTMT_STWHILE 57
#define SLOT_LOWSTMT_STRETURN 58
#define SLOT_LOWSTMT_STOTHER 59
#define SLOT_LOWSTMT_VARDECL 60
#define SLOT_LOWSTMT_ASSIGNMENT 61
#define SLOT_LOWSTMT_SCREXPRESSION 62
#define SLOT_ST_IF_SCREXPRESSION 63
#define SLOT_ST_IF_LOWSTMT 64
#define SLOT_ST_IF_IFELSEIF 65
#define SLOT_ST_IF_IFELSE 66
#define SLOT_IF_ELSEIF_SCREXPRESSION 67
#define SLOT_IF_ELSEIF_LOWSTMT 68
#define SLOT_IF_ELSE_LOWSTMT 69
#define SLOT_ST_WHILE_SCREXPRESSION 70
#define SLOT_ST_WHILE_LOWSTMT 71
#define SLOT_ST_RETURN_SCREXPRESSION 72
#define SLOT_VARDECL_SCREXPRESSION 73
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 74
#define SLOT_BINOP_P12_LOGORBINOPPSCRTERM 75
#define SLOT_BINOP_P11_LOGANDBINOPPSCRTERM 76
#define SLOT_BINOP_P10_BITORBINOPPSCRTERM 77
#define SLOT_BINOP_P09_BITXORBINOPPSCRTERM 78
#define SLOT_BINOP_P08_BITANDBINOPPSCRTERM 79
#define SLOT_BINOP_P07_EQUALSNEQUALSBINOPPSCR 80
#define SLOT_BINOP_P06_LTEQLTGTEQGTBINOPPSCRT 81
#define SLOT_BINOP_P05_LSHIFTRSHIFTBINOPPSCRT 82
#define SLOT_BINOP_P04_ADDSUBBINOPPSCRTERM 83
#define SLOT_BINOP_P03_MULDIVPOWSCRTERM 84
#define SLOT_UNOP_LOGNOTBITNOTINCDEC 85
#define SLOT_SCR_TERM_FUNCTIONCALL 86
#define SLOT_SCR_TERM_BOPENSCREXPRESSIONBCLOS 87
#define SLOT_SCR_TERM_SCREXPRESSION 88
#define SLOT_SCR_TERM_LITERAL 89
#define SLOT_SCR_TERM_UNOP 90
#define SLOT_SCR_TERM_SCRREFERENCE 91
#define SLOT_FUNCTIONCALL_SCRREFERENCE 92
#define SLOT_FUNCTIONCALL_SCREXPRESSION 93
#define SLOT_FUNCTIONCALL_SCREXPRESSION_1 94
#define SLOT_SCR_REFERENCE_IDENT 95
#define SLOT_INDEX_SCREXPRESSION 96
#define SLOT_STRINGLITERAL_NRTV 97
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 98
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 99
#define SLOT_HASHKEY_SCRTERM 100
#define SLOT_HASHVALUE_SCRTERM 101
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 102
#define SLOT_LISTELT_SCRTERM 103
#define SLOT_FLOATLITERAL 104
#define SLOT_INTLITERAL 105
#define SLOT_BOOLEANLITERAL_TRUEFALSEKWIMPORT 106
#define SLOT_ASSIGN 107
#define SLOT_PLUSIS 108
#define SLOT_MINIS 109
#define SLOT_MULIS 110
#define SLOT_DIVIS 111
#define SLOT_EQUALS 112
#define SLOT_NEQUALS 113
#define SLOT_LT 114
#define SLOT_GT 115
#define SLOT_LTEQ 116
#define SLOT_GTEQ 117
#define SLOT_COLON 118
#define SLOT_POW 119
#define SLOT_MUL 120
#define SLOT_DIV 121
#define SLOT_ADD 122
#define SLOT_SUB 123
#define SLOT_INC 124
#define SLOT_DEC 125
#define SLOT_LOGAND 126
#define SLOT_LOGOR 127
#define SLOT_LOGNOT 128
#define SLOT_BITAND 129
#define SLOT_BITOR 130
#define SLOT_BITXOR 131
#define SLOT_BITNOT 132
#define SLOT_BITANDIS 133
#define SLOT_BITORIS 134
#define SLOT_BITXORIS 135
#define SLOT_BITNOTIS 136
#define SLOT_DOT 137
#define SLOT_LSHIFT 138
#define SLOT_RSHIFT 139
#define SLOT_LSHIFTIS 140
#define SLOT_RSHIFTIS 141

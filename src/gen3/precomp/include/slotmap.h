#define SLOTMAP_SWITCH \
  case 0: return "RULE_IDENT"; break; \
  case 1: return "EXPRESSION_TERMS"; break; \
  case 2: return "EXPRESSION_TERMS_1"; break; \
  case 3: return "EXPRESSION_TERMS_2"; break; \
  case 4: return "TERMS_TERM"; break; \
  case 5: return "TERM_ENDOWEDMATCHER"; break; \
  case 6: return "ENDOWEDMATCHER_NOTAND"; break; \
  case 7: return "ENDOWEDMATCHER_QUANTIFIER"; break; \
  case 8: return "QUANTIFIER"; break; \
  case 9: return "QUANTIFIER_1"; break; \
  case 10: return "QUANTIFIER_2"; break; \
  case 11: return "QUANTIFIER_3"; break; \
  case 12: return "QUANTIFIER_4"; break; \
  case 13: return "QUANTIFIER_IDENT"; break; \
  case 14: return "MATCHER_ANY"; break; \
  case 15: return "MATCHER_SET"; break; \
  case 16: return "MATCHER_STRING"; break; \
  case 17: return "MATCHER_BITMASK"; break; \
  case 18: return "MATCHER_HEXLITERAL"; break; \
  case 19: return "MATCHER_VARCAPTURE"; break; \
  case 20: return "MATCHER_CAPTURE"; break; \
  case 21: return "MATCHER_GROUP"; break; \
  case 22: return "MATCHER_MACRO"; break; \
  case 23: return "MATCHER_ENDFORCE"; break; \
  case 24: return "MATCHER_VARREFERENCE"; break; \
  case 25: return "MATCHER_REFERENCE"; break; \
  case 26: return "VARCAPTURE_IDENT"; break; \
  case 27: return "VARCAPTURE_CAPTURETYPE"; break; \
  case 28: return "VARCAPTURE_CBCLOSE"; break; \
  case 29: return "TYPE_UINTINT"; break; \
  case 30: return "CAPTURE_CBCLOSE"; break; \
  case 31: return "GROUP_BCLOSE"; break; \
  case 32: return "SET_SETNOT"; break; \
  case 33: return "SET_NRTV"; break; \
  case 34: return "SET_NRTV_1"; break; \
  case 35: return "SET_NRTV_2"; break; \
  case 36: return "SET_ABCLOSE"; break; \
  case 37: return "VARREFERENCE_IDENT"; break; \
  case 38: return "VARREFERENCE_NUMBER"; break; \
  case 39: return "REPLACE_REPLACETERMS"; break; \
  case 40: return "REPLACETERM_STRINGLITERAL"; break; \
  case 41: return "REPLACETERM_HEXLITERAL"; break; \
  case 42: return "REPLACETERM_VARREFERENCE"; break; \
  case 43: return "RECYCLE_IDENT"; break; \
  case 44: return "ENDFORCE_NUMBER"; break; \
  case 45: return "FUNCDECL_IDENT"; break; \
  case 46: return "FUNCDECL_FUNCPARAMDECL"; break; \
  case 47: return "FUNCDECL_FUNCBODY"; break; \
  case 48: return "FUNCPARAMDECL_PARAMDECL"; break; \
  case 49: return "FUNCPARAMDECL_PARAMDECL_1"; break; \
  case 50: return "PARAMDECL_IDENT"; break; \
  case 51: return "PARAMDECL_IDENT_1"; break; \
  case 52: return "PARAMDECL_IDENT_2"; break; \
  case 53: return "FUNCBODY_LOWSTMT"; break; \
  case 54: return "LOWSTMT_STIF"; break; \
  case 55: return "LOWSTMT_STWHILE"; break; \
  case 56: return "LOWSTMT_STRETURN"; break; \
  case 57: return "LOWSTMT_STOTHER"; break; \
  case 58: return "LOWSTMT_VARDECL"; break; \
  case 59: return "LOWSTMT_ASSIGNMENT"; break; \
  case 60: return "ST_IF_SCREXPRESSION"; break; \
  case 61: return "ST_IF_LOWSTMT"; break; \
  case 62: return "ST_IF_IFELSEIF"; break; \
  case 63: return "ST_IF_IFELSE"; break; \
  case 64: return "IF_ELSEIF_SCREXPRESSION"; break; \
  case 65: return "IF_ELSEIF_LOWSTMT"; break; \
  case 66: return "IF_ELSE_LOWSTMT"; break; \
  case 67: return "ST_WHILE_SCREXPRESSION"; break; \
  case 68: return "ST_WHILE_LOWSTMT"; break; \
  case 69: return "ST_RETURN_SCREXPRESSION"; break; \
  case 70: return "VARDECL_SCREXPRESSION"; break; \
  case 71: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \
  case 72: return "BINOP_P12_LOGORBINOPPEXPATOM"; break; \
  case 73: return "BINOP_P12_LOGOR"; break; \
  case 74: return "BINOP_P11_LOGANDBINOPPEXPATOM"; break; \
  case 75: return "BINOP_P11_LOGAND"; break; \
  case 76: return "BINOP_P10_BITORBINOPPEXPATOM"; break; \
  case 77: return "BINOP_P10_BITOR"; break; \
  case 78: return "BINOP_P09_BITXORBINOPPEXPATOM"; break; \
  case 79: return "BINOP_P09_BITXOR"; break; \
  case 80: return "BINOP_P08_BITANDBINOPPEXPATOM"; break; \
  case 81: return "BINOP_P08_BITAND"; break; \
  case 82: return "BINOP_P07_EQUALSNEQUALSBINOPPEXP"; break; \
  case 83: return "BINOP_P07_EQUALSNEQUALS"; break; \
  case 84: return "BINOP_P06_LTEQLTGTEQGTBINOPPEXPA"; break; \
  case 85: return "BINOP_P06_LTEQLTGTEQGT"; break; \
  case 86: return "BINOP_P05_LSHIFTRSHIFTBINOPPEXPA"; break; \
  case 87: return "BINOP_P05_LSHIFTRSHIFT"; break; \
  case 88: return "BINOP_P04_ADDSUBBINOPPEXPATOM"; break; \
  case 89: return "BINOP_P04_ADDSUB"; break; \
  case 90: return "BINOP_P03_MULDIVPOWEXPATOM"; break; \
  case 91: return "BINOP_P03_MULDIVPOW"; break; \
  case 92: return "EXPATOM_UNARY"; break; \
  case 93: return "EXPATOM_SCRTERM"; break; \
  case 94: return "UNARY_LOGNOTBITNOTINCDEC"; break; \
  case 95: return "SCR_TERM_LITERAL"; break; \
  case 96: return "SCR_TERM_FUNCTIONCALL"; break; \
  case 97: return "SCR_TERM_SCRREFERENCE"; break; \
  case 98: return "SCR_TERM_BOPENSCREXPRESSIONBCLOS"; break; \
  case 99: return "SCR_TERM_SCREXPRESSION"; break; \
  case 100: return "FUNCTIONCALL_SCRREFERENCE"; break; \
  case 101: return "INDEX_SCREXPRESSION"; break; \
  case 102: return "STRINGLITERAL_NRTV"; break; \
  case 103: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 104: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 105: return "HASHKEY_SCRTERM"; break; \
  case 106: return "HASHVALUE_SCRTERM"; break; \
  case 107: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 108: return "LISTELT_SCRTERM"; break; \
  case 109: return "FLOATLITERAL"; break; \
  case 110: return "INTLITERAL"; break; \
  case 111: return "BOOLEANLITERAL_TRUEFALSEKWIMPORT"; break; \
  case 112: return "ASSIGN"; break; \
  case 113: return "PLUSIS"; break; \
  case 114: return "MINIS"; break; \
  case 115: return "MULIS"; break; \
  case 116: return "DIVIS"; break; \
  case 117: return "EQUALS"; break; \
  case 118: return "NEQUALS"; break; \
  case 119: return "LT"; break; \
  case 120: return "GT"; break; \
  case 121: return "LTEQ"; break; \
  case 122: return "GTEQ"; break; \
  case 123: return "COLON"; break; \
  case 124: return "POW"; break; \
  case 125: return "MUL"; break; \
  case 126: return "DIV"; break; \
  case 127: return "ADD"; break; \
  case 128: return "SUB"; break; \
  case 129: return "INC"; break; \
  case 130: return "DEC"; break; \
  case 131: return "LOGAND"; break; \
  case 132: return "LOGOR"; break; \
  case 133: return "LOGNOT"; break; \
  case 134: return "BITAND"; break; \
  case 135: return "BITOR"; break; \
  case 136: return "BITXOR"; break; \
  case 137: return "BITNOT"; break; \
  case 138: return "BITANDIS"; break; \
  case 139: return "BITORIS"; break; \
  case 140: return "BITXORIS"; break; \
  case 141: return "BITNOTIS"; break; \
  case 142: return "DOT"; break; \
  case 143: return "LSHIFT"; break; \
  case 144: return "RSHIFT"; break; \
  case 145: return "LSHIFTIS"; break; \
  case 146: return "RSHIFTIS"; break; \


#define SLOT_RULE_IDENT 0
#define SLOT_EXPRESSION_TERMS 1
#define SLOT_EXPRESSION_TERMS_1 2
#define SLOT_EXPRESSION_TERMS_2 3
#define SLOT_TERMS_TERM 4
#define SLOT_TERM_ENDOWEDMATCHER 5
#define SLOT_ENDOWEDMATCHER_NOTAND 6
#define SLOT_ENDOWEDMATCHER_QUANTIFIER 7
#define SLOT_QUANTIFIER 8
#define SLOT_QUANTIFIER_1 9
#define SLOT_QUANTIFIER_2 10
#define SLOT_QUANTIFIER_3 11
#define SLOT_QUANTIFIER_4 12
#define SLOT_QUANTIFIER_IDENT 13
#define SLOT_MATCHER_ANY 14
#define SLOT_MATCHER_SET 15
#define SLOT_MATCHER_STRING 16
#define SLOT_MATCHER_BITMASK 17
#define SLOT_MATCHER_HEXLITERAL 18
#define SLOT_MATCHER_VARCAPTURE 19
#define SLOT_MATCHER_CAPTURE 20
#define SLOT_MATCHER_GROUP 21
#define SLOT_MATCHER_MACRO 22
#define SLOT_MATCHER_ENDFORCE 23
#define SLOT_MATCHER_VARREFERENCE 24
#define SLOT_MATCHER_REFERENCE 25
#define SLOT_VARCAPTURE_IDENT 26
#define SLOT_VARCAPTURE_CAPTURETYPE 27
#define SLOT_VARCAPTURE_CBCLOSE 28
#define SLOT_TYPE_UINTINT 29
#define SLOT_CAPTURE_CBCLOSE 30
#define SLOT_GROUP_BCLOSE 31
#define SLOT_SET_SETNOT 32
#define SLOT_SET_NRTV 33
#define SLOT_SET_NRTV_1 34
#define SLOT_SET_NRTV_2 35
#define SLOT_SET_ABCLOSE 36
#define SLOT_VARREFERENCE_IDENT 37
#define SLOT_VARREFERENCE_NUMBER 38
#define SLOT_REPLACE_REPLACETERMS 39
#define SLOT_REPLACETERM_STRINGLITERAL 40
#define SLOT_REPLACETERM_HEXLITERAL 41
#define SLOT_REPLACETERM_VARREFERENCE 42
#define SLOT_RECYCLE_IDENT 43
#define SLOT_ENDFORCE_NUMBER 44
#define SLOT_FUNCDECL_IDENT 45
#define SLOT_FUNCDECL_FUNCPARAMDECL 46
#define SLOT_FUNCDECL_FUNCBODY 47
#define SLOT_FUNCPARAMDECL_PARAMDECL 48
#define SLOT_FUNCPARAMDECL_PARAMDECL_1 49
#define SLOT_PARAMDECL_IDENT 50
#define SLOT_PARAMDECL_IDENT_1 51
#define SLOT_PARAMDECL_IDENT_2 52
#define SLOT_FUNCBODY_LOWSTMT 53
#define SLOT_LOWSTMT_STIF 54
#define SLOT_LOWSTMT_STWHILE 55
#define SLOT_LOWSTMT_STRETURN 56
#define SLOT_LOWSTMT_STOTHER 57
#define SLOT_LOWSTMT_VARDECL 58
#define SLOT_LOWSTMT_ASSIGNMENT 59
#define SLOT_ST_IF_SCREXPRESSION 60
#define SLOT_ST_IF_LOWSTMT 61
#define SLOT_ST_IF_IFELSEIF 62
#define SLOT_ST_IF_IFELSE 63
#define SLOT_IF_ELSEIF_SCREXPRESSION 64
#define SLOT_IF_ELSEIF_LOWSTMT 65
#define SLOT_IF_ELSE_LOWSTMT 66
#define SLOT_ST_WHILE_SCREXPRESSION 67
#define SLOT_ST_WHILE_LOWSTMT 68
#define SLOT_ST_RETURN_SCREXPRESSION 69
#define SLOT_VARDECL_SCREXPRESSION 70
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 71
#define SLOT_BINOP_P12_LOGORBINOPPEXPATOM 72
#define SLOT_BINOP_P12_LOGOR 73
#define SLOT_BINOP_P11_LOGANDBINOPPEXPATOM 74
#define SLOT_BINOP_P11_LOGAND 75
#define SLOT_BINOP_P10_BITORBINOPPEXPATOM 76
#define SLOT_BINOP_P10_BITOR 77
#define SLOT_BINOP_P09_BITXORBINOPPEXPATOM 78
#define SLOT_BINOP_P09_BITXOR 79
#define SLOT_BINOP_P08_BITANDBINOPPEXPATOM 80
#define SLOT_BINOP_P08_BITAND 81
#define SLOT_BINOP_P07_EQUALSNEQUALSBINOPPEXP 82
#define SLOT_BINOP_P07_EQUALSNEQUALS 83
#define SLOT_BINOP_P06_LTEQLTGTEQGTBINOPPEXPA 84
#define SLOT_BINOP_P06_LTEQLTGTEQGT 85
#define SLOT_BINOP_P05_LSHIFTRSHIFTBINOPPEXPA 86
#define SLOT_BINOP_P05_LSHIFTRSHIFT 87
#define SLOT_BINOP_P04_ADDSUBBINOPPEXPATOM 88
#define SLOT_BINOP_P04_ADDSUB 89
#define SLOT_BINOP_P03_MULDIVPOWEXPATOM 90
#define SLOT_BINOP_P03_MULDIVPOW 91
#define SLOT_EXPATOM_UNARY 92
#define SLOT_EXPATOM_SCRTERM 93
#define SLOT_UNARY_LOGNOTBITNOTINCDEC 94
#define SLOT_SCR_TERM_LITERAL 95
#define SLOT_SCR_TERM_FUNCTIONCALL 96
#define SLOT_SCR_TERM_SCRREFERENCE 97
#define SLOT_SCR_TERM_BOPENSCREXPRESSIONBCLOS 98
#define SLOT_SCR_TERM_SCREXPRESSION 99
#define SLOT_FUNCTIONCALL_SCRREFERENCE 100
#define SLOT_INDEX_SCREXPRESSION 101
#define SLOT_STRINGLITERAL_NRTV 102
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 103
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 104
#define SLOT_HASHKEY_SCRTERM 105
#define SLOT_HASHVALUE_SCRTERM 106
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 107
#define SLOT_LISTELT_SCRTERM 108
#define SLOT_FLOATLITERAL 109
#define SLOT_INTLITERAL 110
#define SLOT_BOOLEANLITERAL_TRUEFALSEKWIMPORT 111
#define SLOT_ASSIGN 112
#define SLOT_PLUSIS 113
#define SLOT_MINIS 114
#define SLOT_MULIS 115
#define SLOT_DIVIS 116
#define SLOT_EQUALS 117
#define SLOT_NEQUALS 118
#define SLOT_LT 119
#define SLOT_GT 120
#define SLOT_LTEQ 121
#define SLOT_GTEQ 122
#define SLOT_COLON 123
#define SLOT_POW 124
#define SLOT_MUL 125
#define SLOT_DIV 126
#define SLOT_ADD 127
#define SLOT_SUB 128
#define SLOT_INC 129
#define SLOT_DEC 130
#define SLOT_LOGAND 131
#define SLOT_LOGOR 132
#define SLOT_LOGNOT 133
#define SLOT_BITAND 134
#define SLOT_BITOR 135
#define SLOT_BITXOR 136
#define SLOT_BITNOT 137
#define SLOT_BITANDIS 138
#define SLOT_BITORIS 139
#define SLOT_BITXORIS 140
#define SLOT_BITNOTIS 141
#define SLOT_DOT 142
#define SLOT_LSHIFT 143
#define SLOT_RSHIFT 144
#define SLOT_LSHIFTIS 145
#define SLOT_RSHIFTIS 146

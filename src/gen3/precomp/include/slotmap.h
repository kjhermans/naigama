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
  case 23: return "MATCHER_VARREFERENCE"; break; \
  case 24: return "MATCHER_REFERENCE"; break; \
  case 25: return "VARCAPTURE_IDENT"; break; \
  case 26: return "VARCAPTURE_CAPTURETYPE"; break; \
  case 27: return "VARCAPTURE_CBCLOSE"; break; \
  case 28: return "TYPE_UINTINT"; break; \
  case 29: return "CAPTURE_CBCLOSE"; break; \
  case 30: return "GROUP_BCLOSE"; break; \
  case 31: return "SET_SETNOT"; break; \
  case 32: return "SET_NRTV"; break; \
  case 33: return "SET_NRTV_1"; break; \
  case 34: return "SET_NRTV_2"; break; \
  case 35: return "SET_ABCLOSE"; break; \
  case 36: return "VARREFERENCE_IDENT"; break; \
  case 37: return "VARREFERENCE_NUMBER"; break; \
  case 38: return "REPLACE_REPLACETERMS"; break; \
  case 39: return "REPLACETERM_STRINGLITERAL"; break; \
  case 40: return "REPLACETERM_HEXLITERAL"; break; \
  case 41: return "REPLACETERM_VARREFERENCE"; break; \
  case 42: return "RECYCLE_IDENT"; break; \
  case 43: return "FUNCDECL_IDENT"; break; \
  case 44: return "FUNCDECL_FUNCPARAMDECL"; break; \
  case 45: return "FUNCDECL_FUNCBODY"; break; \
  case 46: return "FUNCPARAMDECL_PARAMDECL"; break; \
  case 47: return "FUNCPARAMDECL_PARAMDECL_1"; break; \
  case 48: return "PARAMDECL_IDENT"; break; \
  case 49: return "PARAMDECL_IDENT_1"; break; \
  case 50: return "PARAMDECL_IDENT_2"; break; \
  case 51: return "FUNCBODY_LOWSTMT"; break; \
  case 52: return "LOWSTMT_STIF"; break; \
  case 53: return "LOWSTMT_STWHILE"; break; \
  case 54: return "LOWSTMT_STRETURN"; break; \
  case 55: return "LOWSTMT_STOTHER"; break; \
  case 56: return "LOWSTMT_VARDECL"; break; \
  case 57: return "LOWSTMT_ASSIGNMENT"; break; \
  case 58: return "ST_IF_SCREXPRESSION"; break; \
  case 59: return "ST_IF_LOWSTMT"; break; \
  case 60: return "ST_IF_IFELSEIF"; break; \
  case 61: return "ST_IF_IFELSE"; break; \
  case 62: return "IF_ELSEIF_SCREXPRESSION"; break; \
  case 63: return "IF_ELSEIF_LOWSTMT"; break; \
  case 64: return "IF_ELSE_LOWSTMT"; break; \
  case 65: return "ST_WHILE_SCREXPRESSION"; break; \
  case 66: return "ST_WHILE_LOWSTMT"; break; \
  case 67: return "ST_RETURN_SCREXPRESSION"; break; \
  case 68: return "VARDECL_SCREXPRESSION"; break; \
  case 69: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \
  case 70: return "BINOP_P12_BINOPP"; break; \
  case 71: return "BINOP_P12_LOGORSCREXPRESSION"; break; \
  case 72: return "BINOP_P11_BINOPP"; break; \
  case 73: return "BINOP_P11_LOGANDSCREXPRESSION"; break; \
  case 74: return "BINOP_P10_BINOPP"; break; \
  case 75: return "BINOP_P10_BITORSCREXPRESSION"; break; \
  case 76: return "BINOP_P09_BINOPP"; break; \
  case 77: return "BINOP_P09_BITXORSCREXPRESSION"; break; \
  case 78: return "BINOP_P08_BINOPP"; break; \
  case 79: return "BINOP_P08_BITANDSCREXPRESSION"; break; \
  case 80: return "BINOP_P07_BINOPP"; break; \
  case 81: return "BINOP_P07_EQUALSNEQUALSSCREXPRES"; break; \
  case 82: return "BINOP_P06_BINOPP"; break; \
  case 83: return "BINOP_P06_LTEQLTGTEQGTSCREXPRESS"; break; \
  case 84: return "BINOP_P05_BINOPP"; break; \
  case 85: return "BINOP_P05_LSHIFTRSHIFTSCREXPRESS"; break; \
  case 86: return "BINOP_P04_BINOPP"; break; \
  case 87: return "BINOP_P04_ADDSUBSCREXPRESSION"; break; \
  case 88: return "BINOP_P03_UNARIES"; break; \
  case 89: return "BINOP_P03_MULDIVPOWSCREXPRESSION"; break; \
  case 90: return "UNARIES_UNARY"; break; \
  case 91: return "UNARIES_SCRTERM"; break; \
  case 92: return "UNARY_LOGNOTBITNOTINCDEC"; break; \
  case 93: return "SCR_TERM_LITERAL"; break; \
  case 94: return "SCR_TERM_FUNCTIONCALL"; break; \
  case 95: return "SCR_TERM_SCRREFERENCE"; break; \
  case 96: return "SCR_TERM_BOPENSCREXPRESSIONBCLOS"; break; \
  case 97: return "SCR_TERM_SCREXPRESSION"; break; \
  case 98: return "FUNCTIONCALL_SCRREFERENCE"; break; \
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
  case 121: return "SEMICOLON"; break; \
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
  case 141: return "COMMA"; break; \
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
#define SLOT_MATCHER_VARREFERENCE 23
#define SLOT_MATCHER_REFERENCE 24
#define SLOT_VARCAPTURE_IDENT 25
#define SLOT_VARCAPTURE_CAPTURETYPE 26
#define SLOT_VARCAPTURE_CBCLOSE 27
#define SLOT_TYPE_UINTINT 28
#define SLOT_CAPTURE_CBCLOSE 29
#define SLOT_GROUP_BCLOSE 30
#define SLOT_SET_SETNOT 31
#define SLOT_SET_NRTV 32
#define SLOT_SET_NRTV_1 33
#define SLOT_SET_NRTV_2 34
#define SLOT_SET_ABCLOSE 35
#define SLOT_VARREFERENCE_IDENT 36
#define SLOT_VARREFERENCE_NUMBER 37
#define SLOT_REPLACE_REPLACETERMS 38
#define SLOT_REPLACETERM_STRINGLITERAL 39
#define SLOT_REPLACETERM_HEXLITERAL 40
#define SLOT_REPLACETERM_VARREFERENCE 41
#define SLOT_RECYCLE_IDENT 42
#define SLOT_FUNCDECL_IDENT 43
#define SLOT_FUNCDECL_FUNCPARAMDECL 44
#define SLOT_FUNCDECL_FUNCBODY 45
#define SLOT_FUNCPARAMDECL_PARAMDECL 46
#define SLOT_FUNCPARAMDECL_PARAMDECL_1 47
#define SLOT_PARAMDECL_IDENT 48
#define SLOT_PARAMDECL_IDENT_1 49
#define SLOT_PARAMDECL_IDENT_2 50
#define SLOT_FUNCBODY_LOWSTMT 51
#define SLOT_LOWSTMT_STIF 52
#define SLOT_LOWSTMT_STWHILE 53
#define SLOT_LOWSTMT_STRETURN 54
#define SLOT_LOWSTMT_STOTHER 55
#define SLOT_LOWSTMT_VARDECL 56
#define SLOT_LOWSTMT_ASSIGNMENT 57
#define SLOT_ST_IF_SCREXPRESSION 58
#define SLOT_ST_IF_LOWSTMT 59
#define SLOT_ST_IF_IFELSEIF 60
#define SLOT_ST_IF_IFELSE 61
#define SLOT_IF_ELSEIF_SCREXPRESSION 62
#define SLOT_IF_ELSEIF_LOWSTMT 63
#define SLOT_IF_ELSE_LOWSTMT 64
#define SLOT_ST_WHILE_SCREXPRESSION 65
#define SLOT_ST_WHILE_LOWSTMT 66
#define SLOT_ST_RETURN_SCREXPRESSION 67
#define SLOT_VARDECL_SCREXPRESSION 68
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 69
#define SLOT_BINOP_P12_BINOPP 70
#define SLOT_BINOP_P12_LOGORSCREXPRESSION 71
#define SLOT_BINOP_P11_BINOPP 72
#define SLOT_BINOP_P11_LOGANDSCREXPRESSION 73
#define SLOT_BINOP_P10_BINOPP 74
#define SLOT_BINOP_P10_BITORSCREXPRESSION 75
#define SLOT_BINOP_P09_BINOPP 76
#define SLOT_BINOP_P09_BITXORSCREXPRESSION 77
#define SLOT_BINOP_P08_BINOPP 78
#define SLOT_BINOP_P08_BITANDSCREXPRESSION 79
#define SLOT_BINOP_P07_BINOPP 80
#define SLOT_BINOP_P07_EQUALSNEQUALSSCREXPRES 81
#define SLOT_BINOP_P06_BINOPP 82
#define SLOT_BINOP_P06_LTEQLTGTEQGTSCREXPRESS 83
#define SLOT_BINOP_P05_BINOPP 84
#define SLOT_BINOP_P05_LSHIFTRSHIFTSCREXPRESS 85
#define SLOT_BINOP_P04_BINOPP 86
#define SLOT_BINOP_P04_ADDSUBSCREXPRESSION 87
#define SLOT_BINOP_P03_UNARIES 88
#define SLOT_BINOP_P03_MULDIVPOWSCREXPRESSION 89
#define SLOT_UNARIES_UNARY 90
#define SLOT_UNARIES_SCRTERM 91
#define SLOT_UNARY_LOGNOTBITNOTINCDEC 92
#define SLOT_SCR_TERM_LITERAL 93
#define SLOT_SCR_TERM_FUNCTIONCALL 94
#define SLOT_SCR_TERM_SCRREFERENCE 95
#define SLOT_SCR_TERM_BOPENSCREXPRESSIONBCLOS 96
#define SLOT_SCR_TERM_SCREXPRESSION 97
#define SLOT_FUNCTIONCALL_SCRREFERENCE 98
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
#define SLOT_SEMICOLON 121
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
#define SLOT_COMMA 141
#define SLOT_DOT 142
#define SLOT_LSHIFT 143
#define SLOT_RSHIFT 144
#define SLOT_LSHIFTIS 145
#define SLOT_RSHIFTIS 146

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
  case 44: return "FUNCPARAMDECL_IDENTCOMMAIDENT"; break; \
  case 45: return "FUNCBODY_LOWSTMT"; break; \
  case 46: return "LOWSTMT_STIF"; break; \
  case 47: return "LOWSTMT_STWHILE"; break; \
  case 48: return "LOWSTMT_STRETURN"; break; \
  case 49: return "LOWSTMT_STOTHER"; break; \
  case 50: return "LOWSTMT_VARDECL"; break; \
  case 51: return "LOWSTMT_ASSIGNMENT"; break; \
  case 52: return "ST_IF_SCREXPRESSION"; break; \
  case 53: return "ST_IF_LOWSTMT"; break; \
  case 54: return "ST_IF_IFELSEIF"; break; \
  case 55: return "ST_IF_IFELSE"; break; \
  case 56: return "IF_ELSEIF_SCREXPRESSION"; break; \
  case 57: return "IF_ELSEIF_LOWSTMT"; break; \
  case 58: return "IF_ELSE_LOWSTMT"; break; \
  case 59: return "ST_WHILE_SCREXPRESSION"; break; \
  case 60: return "ST_WHILE_LOWSTMT"; break; \
  case 61: return "ST_RETURN_SCREXPRESSION"; break; \
  case 62: return "VARDECL_SCREXPRESSION"; break; \
  case 63: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \
  case 64: return "BINOP_P12_BINOPP"; break; \
  case 65: return "BINOP_P11_BINOPP"; break; \
  case 66: return "BINOP_P10_BINOPP"; break; \
  case 67: return "BINOP_P09_BINOPP"; break; \
  case 68: return "BINOP_P08_BINOPP"; break; \
  case 69: return "BINOP_P07_BINOPP"; break; \
  case 70: return "BINOP_P06_BINOPP"; break; \
  case 71: return "BINOP_P05_BINOPP"; break; \
  case 72: return "BINOP_P04_BINOPP"; break; \
  case 73: return "BINOP_P03_UNARIES"; break; \
  case 74: return "UNARIES_UNARY"; break; \
  case 75: return "UNARIES_SCRTERM"; break; \
  case 76: return "UNARY_LOGNOTBITNOTINCDEC"; break; \
  case 77: return "SCR_TERM_LITERAL"; break; \
  case 78: return "SCR_TERM_FUNCTIONCALL"; break; \
  case 79: return "SCR_TERM_SCRREFERENCE"; break; \
  case 80: return "SCR_TERM_BOPENSCREXPRESSIONBCLOS"; break; \
  case 81: return "SCR_TERM_SCREXPRESSION"; break; \
  case 82: return "FUNCTIONCALL_SCRREFERENCE"; break; \
  case 83: return "INDEX_SCREXPRESSION"; break; \
  case 84: return "STRINGLITERAL_NRTV"; break; \
  case 85: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 86: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 87: return "HASHKEY_SCRTERM"; break; \
  case 88: return "HASHVALUE_SCRTERM"; break; \
  case 89: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 90: return "LISTELT_SCRTERM"; break; \
  case 91: return "FLOATLITERAL"; break; \
  case 92: return "INTLITERAL"; break; \
  case 93: return "BOOLEANLITERAL_TRUEFALSEKWIMPORT"; break; \


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
#define SLOT_FUNCPARAMDECL_IDENTCOMMAIDENT 44
#define SLOT_FUNCBODY_LOWSTMT 45
#define SLOT_LOWSTMT_STIF 46
#define SLOT_LOWSTMT_STWHILE 47
#define SLOT_LOWSTMT_STRETURN 48
#define SLOT_LOWSTMT_STOTHER 49
#define SLOT_LOWSTMT_VARDECL 50
#define SLOT_LOWSTMT_ASSIGNMENT 51
#define SLOT_ST_IF_SCREXPRESSION 52
#define SLOT_ST_IF_LOWSTMT 53
#define SLOT_ST_IF_IFELSEIF 54
#define SLOT_ST_IF_IFELSE 55
#define SLOT_IF_ELSEIF_SCREXPRESSION 56
#define SLOT_IF_ELSEIF_LOWSTMT 57
#define SLOT_IF_ELSE_LOWSTMT 58
#define SLOT_ST_WHILE_SCREXPRESSION 59
#define SLOT_ST_WHILE_LOWSTMT 60
#define SLOT_ST_RETURN_SCREXPRESSION 61
#define SLOT_VARDECL_SCREXPRESSION 62
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 63
#define SLOT_BINOP_P12_BINOPP 64
#define SLOT_BINOP_P11_BINOPP 65
#define SLOT_BINOP_P10_BINOPP 66
#define SLOT_BINOP_P09_BINOPP 67
#define SLOT_BINOP_P08_BINOPP 68
#define SLOT_BINOP_P07_BINOPP 69
#define SLOT_BINOP_P06_BINOPP 70
#define SLOT_BINOP_P05_BINOPP 71
#define SLOT_BINOP_P04_BINOPP 72
#define SLOT_BINOP_P03_UNARIES 73
#define SLOT_UNARIES_UNARY 74
#define SLOT_UNARIES_SCRTERM 75
#define SLOT_UNARY_LOGNOTBITNOTINCDEC 76
#define SLOT_SCR_TERM_LITERAL 77
#define SLOT_SCR_TERM_FUNCTIONCALL 78
#define SLOT_SCR_TERM_SCRREFERENCE 79
#define SLOT_SCR_TERM_BOPENSCREXPRESSIONBCLOS 80
#define SLOT_SCR_TERM_SCREXPRESSION 81
#define SLOT_FUNCTIONCALL_SCRREFERENCE 82
#define SLOT_INDEX_SCREXPRESSION 83
#define SLOT_STRINGLITERAL_NRTV 84
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 85
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 86
#define SLOT_HASHKEY_SCRTERM 87
#define SLOT_HASHVALUE_SCRTERM 88
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 89
#define SLOT_LISTELT_SCRTERM 90
#define SLOT_FLOATLITERAL 91
#define SLOT_INTLITERAL 92
#define SLOT_BOOLEANLITERAL_TRUEFALSEKWIMPORT 93

#define SLOTMAP_SWITCH \
  case 0: return "RULE_IDENT"; break; \
  case 1: return "EXPRESSION_TERMS"; break; \
  case 2: return "EXPRESSION_TERMS_1"; break; \
  case 3: return "EXPRESSION_TERMS_2"; break; \
  case 4: return "TERMS_TERM"; break; \
  case 5: return "TERM_NOTAND"; break; \
  case 6: return "TERM_QUANTIFIER"; break; \
  case 7: return "QUANTIFIER"; break; \
  case 8: return "QUANTIFIER_1"; break; \
  case 9: return "QUANTIFIER_2"; break; \
  case 10: return "QUANTIFIER_3"; break; \
  case 11: return "QUANTIFIER_4"; break; \
  case 12: return "QUANTIFIER_IDENT"; break; \
  case 13: return "MATCHER_ANY"; break; \
  case 14: return "MATCHER_SET"; break; \
  case 15: return "MATCHER_STRING"; break; \
  case 16: return "MATCHER_BITMASK"; break; \
  case 17: return "MATCHER_HEXLITERAL"; break; \
  case 18: return "MATCHER_VARCAPTURE"; break; \
  case 19: return "MATCHER_CAPTURE"; break; \
  case 20: return "MATCHER_GROUP"; break; \
  case 21: return "MATCHER_MACRO"; break; \
  case 22: return "MATCHER_VARREFERENCE"; break; \
  case 23: return "MATCHER_REFERENCE"; break; \
  case 24: return "VARCAPTURE_IDENT"; break; \
  case 25: return "VARCAPTURE_CAPTURETYPE"; break; \
  case 26: return "VARCAPTURE_CBCLOSE"; break; \
  case 27: return "TYPE_UINTINT"; break; \
  case 28: return "CAPTURE_CBCLOSE"; break; \
  case 29: return "GROUP_BCLOSE"; break; \
  case 30: return "SET_SETNOT"; break; \
  case 31: return "SET_NRTV"; break; \
  case 32: return "SET_NRTV_1"; break; \
  case 33: return "SET_NRTV_2"; break; \
  case 34: return "SET_ABCLOSE"; break; \
  case 35: return "VARREFERENCE_IDENT"; break; \
  case 36: return "VARREFERENCE_NUMBER"; break; \
  case 37: return "REPLACE_REPLACETERMS"; break; \
  case 38: return "REPLACETERM_STRINGLITERAL"; break; \
  case 39: return "REPLACETERM_HEXLITERAL"; break; \
  case 40: return "REPLACETERM_VARREFERENCE"; break; \
  case 41: return "RECYCLE_IDENT"; break; \
  case 42: return "FUNCPARAMDECL_IDENTCOMMAIDENT"; break; \
  case 43: return "FUNCBODY_LOWSTMT"; break; \
  case 44: return "LOWSTMT_STIF"; break; \
  case 45: return "LOWSTMT_STWHILE"; break; \
  case 46: return "LOWSTMT_STRETURN"; break; \
  case 47: return "LOWSTMT_STOTHER"; break; \
  case 48: return "LOWSTMT_VARDECL"; break; \
  case 49: return "LOWSTMT_ASSIGNMENT"; break; \
  case 50: return "ST_IF_SCREXPRESSION"; break; \
  case 51: return "ST_IF_LOWSTMT"; break; \
  case 52: return "ST_IF_IFELSEIF"; break; \
  case 53: return "ST_IF_IFELSE"; break; \
  case 54: return "IF_ELSEIF_SCREXPRESSION"; break; \
  case 55: return "IF_ELSEIF_LOWSTMT"; break; \
  case 56: return "IF_ELSE_LOWSTMT"; break; \
  case 57: return "ST_WHILE_SCREXPRESSION"; break; \
  case 58: return "ST_WHILE_LOWSTMT"; break; \
  case 59: return "ST_RETURN_SCREXPRESSION"; break; \
  case 60: return "VARDECL_SCREXPRESSION"; break; \
  case 61: return "BINOP_P12_BINOPP"; break; \
  case 62: return "BINOP_P11_BINOPP"; break; \
  case 63: return "BINOP_P10_BINOPP"; break; \
  case 64: return "BINOP_P09_BINOPP"; break; \
  case 65: return "BINOP_P08_BINOPP"; break; \
  case 66: return "BINOP_P07_BINOPP"; break; \
  case 67: return "BINOP_P06_BINOPP"; break; \
  case 68: return "BINOP_P05_BINOPP"; break; \
  case 69: return "BINOP_P04_BINOPP"; break; \
  case 70: return "BINOP_P03_UNARIES"; break; \
  case 71: return "UNARIES_UNARY"; break; \
  case 72: return "UNARIES_SCRTERM"; break; \
  case 73: return "UNARY_LOGNOTBITNOTINCDEC"; break; \
  case 74: return "SCR_TERM_LITERAL"; break; \
  case 75: return "SCR_TERM_FUNCTIONCALL"; break; \
  case 76: return "SCR_TERM_SCRREFERENCE"; break; \
  case 77: return "SCR_TERM_BOPENSCREXPRESSIONBCLOS"; break; \
  case 78: return "SCR_TERM_SCREXPRESSION"; break; \
  case 79: return "FUNCTIONCALL_SCRREFERENCE"; break; \
  case 80: return "INDEX_SCREXPRESSION"; break; \
  case 81: return "STRINGLITERAL_NRTV"; break; \
  case 82: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 83: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 84: return "HASHKEY_SCRTERM"; break; \
  case 85: return "HASHVALUE_SCRTERM"; break; \
  case 86: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 87: return "LISTELT_SCRTERM"; break; \
  case 88: return "FLOATLITERAL"; break; \
  case 89: return "INTLITERAL"; break; \
  case 90: return "BOOLEANLITERAL_TRUEFALSEKWIMPORT"; break; \
  case 91: return "IDENT_AZAZAZAZ"; break; \
  case 92: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \


#define SLOT_RULE_IDENT 0
#define SLOT_EXPRESSION_TERMS 1
#define SLOT_EXPRESSION_TERMS_1 2
#define SLOT_EXPRESSION_TERMS_2 3
#define SLOT_TERMS_TERM 4
#define SLOT_TERM_NOTAND 5
#define SLOT_TERM_QUANTIFIER 6
#define SLOT_QUANTIFIER 7
#define SLOT_QUANTIFIER_1 8
#define SLOT_QUANTIFIER_2 9
#define SLOT_QUANTIFIER_3 10
#define SLOT_QUANTIFIER_4 11
#define SLOT_QUANTIFIER_IDENT 12
#define SLOT_MATCHER_ANY 13
#define SLOT_MATCHER_SET 14
#define SLOT_MATCHER_STRING 15
#define SLOT_MATCHER_BITMASK 16
#define SLOT_MATCHER_HEXLITERAL 17
#define SLOT_MATCHER_VARCAPTURE 18
#define SLOT_MATCHER_CAPTURE 19
#define SLOT_MATCHER_GROUP 20
#define SLOT_MATCHER_MACRO 21
#define SLOT_MATCHER_VARREFERENCE 22
#define SLOT_MATCHER_REFERENCE 23
#define SLOT_VARCAPTURE_IDENT 24
#define SLOT_VARCAPTURE_CAPTURETYPE 25
#define SLOT_VARCAPTURE_CBCLOSE 26
#define SLOT_TYPE_UINTINT 27
#define SLOT_CAPTURE_CBCLOSE 28
#define SLOT_GROUP_BCLOSE 29
#define SLOT_SET_SETNOT 30
#define SLOT_SET_NRTV 31
#define SLOT_SET_NRTV_1 32
#define SLOT_SET_NRTV_2 33
#define SLOT_SET_ABCLOSE 34
#define SLOT_VARREFERENCE_IDENT 35
#define SLOT_VARREFERENCE_NUMBER 36
#define SLOT_REPLACE_REPLACETERMS 37
#define SLOT_REPLACETERM_STRINGLITERAL 38
#define SLOT_REPLACETERM_HEXLITERAL 39
#define SLOT_REPLACETERM_VARREFERENCE 40
#define SLOT_RECYCLE_IDENT 41
#define SLOT_FUNCPARAMDECL_IDENTCOMMAIDENT 42
#define SLOT_FUNCBODY_LOWSTMT 43
#define SLOT_LOWSTMT_STIF 44
#define SLOT_LOWSTMT_STWHILE 45
#define SLOT_LOWSTMT_STRETURN 46
#define SLOT_LOWSTMT_STOTHER 47
#define SLOT_LOWSTMT_VARDECL 48
#define SLOT_LOWSTMT_ASSIGNMENT 49
#define SLOT_ST_IF_SCREXPRESSION 50
#define SLOT_ST_IF_LOWSTMT 51
#define SLOT_ST_IF_IFELSEIF 52
#define SLOT_ST_IF_IFELSE 53
#define SLOT_IF_ELSEIF_SCREXPRESSION 54
#define SLOT_IF_ELSEIF_LOWSTMT 55
#define SLOT_IF_ELSE_LOWSTMT 56
#define SLOT_ST_WHILE_SCREXPRESSION 57
#define SLOT_ST_WHILE_LOWSTMT 58
#define SLOT_ST_RETURN_SCREXPRESSION 59
#define SLOT_VARDECL_SCREXPRESSION 60
#define SLOT_BINOP_P12_BINOPP 61
#define SLOT_BINOP_P11_BINOPP 62
#define SLOT_BINOP_P10_BINOPP 63
#define SLOT_BINOP_P09_BINOPP 64
#define SLOT_BINOP_P08_BINOPP 65
#define SLOT_BINOP_P07_BINOPP 66
#define SLOT_BINOP_P06_BINOPP 67
#define SLOT_BINOP_P05_BINOPP 68
#define SLOT_BINOP_P04_BINOPP 69
#define SLOT_BINOP_P03_UNARIES 70
#define SLOT_UNARIES_UNARY 71
#define SLOT_UNARIES_SCRTERM 72
#define SLOT_UNARY_LOGNOTBITNOTINCDEC 73
#define SLOT_SCR_TERM_LITERAL 74
#define SLOT_SCR_TERM_FUNCTIONCALL 75
#define SLOT_SCR_TERM_SCRREFERENCE 76
#define SLOT_SCR_TERM_BOPENSCREXPRESSIONBCLOS 77
#define SLOT_SCR_TERM_SCREXPRESSION 78
#define SLOT_FUNCTIONCALL_SCRREFERENCE 79
#define SLOT_INDEX_SCREXPRESSION 80
#define SLOT_STRINGLITERAL_NRTV 81
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 82
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 83
#define SLOT_HASHKEY_SCRTERM 84
#define SLOT_HASHVALUE_SCRTERM 85
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 86
#define SLOT_LISTELT_SCRTERM 87
#define SLOT_FLOATLITERAL 88
#define SLOT_INTLITERAL 89
#define SLOT_BOOLEANLITERAL_TRUEFALSEKWIMPORT 90
#define SLOT_IDENT_AZAZAZAZ 91
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 92

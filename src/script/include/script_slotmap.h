#define SLOTMAP_SWITCH \
  case 0: return "TOPSTMT_FUNCDECL"; break; \
  case 1: return "TOPSTMT_IMPORTSTMT"; break; \
  case 2: return "LOWSTMT_STIF"; break; \
  case 3: return "LOWSTMT_STWHILE"; break; \
  case 4: return "LOWSTMT_STRETURN"; break; \
  case 5: return "LOWSTMT_STOTHER"; break; \
  case 6: return "LOWSTMT_VARDECL"; break; \
  case 7: return "LOWSTMT_ASSIGNMENT"; break; \
  case 8: return "FUNCPARAMDECL_IDENTCOMMAIDENT"; break; \
  case 9: return "FUNCBODY_LOWSTMT"; break; \
  case 10: return "ST_IF_EXPRESSION"; break; \
  case 11: return "ST_IF_LOWSTMT"; break; \
  case 12: return "ST_IF_IFELSEIF"; break; \
  case 13: return "ST_IF_IFELSE"; break; \
  case 14: return "IF_ELSEIF_EXPRESSION"; break; \
  case 15: return "IF_ELSEIF_LOWSTMT"; break; \
  case 16: return "IF_ELSE_LOWSTMT"; break; \
  case 17: return "ST_WHILE_EXPRESSION"; break; \
  case 18: return "ST_WHILE_LOWSTMT"; break; \
  case 19: return "ST_RETURN_EXPRESSION"; break; \
  case 20: return "VARDECL_EXPRESSION"; break; \
  case 21: return "BINOP_P12_BINOPP"; break; \
  case 22: return "BINOP_P11_BINOPP"; break; \
  case 23: return "BINOP_P10_BINOPP"; break; \
  case 24: return "BINOP_P09_BINOPP"; break; \
  case 25: return "BINOP_P08_BINOPP"; break; \
  case 26: return "BINOP_P07_BINOPP"; break; \
  case 27: return "BINOP_P06_BINOPP"; break; \
  case 28: return "BINOP_P05_BINOPP"; break; \
  case 29: return "BINOP_P04_BINOPP"; break; \
  case 30: return "BINOP_P03_UNARIES"; break; \
  case 31: return "UNARIES_UNARY"; break; \
  case 32: return "UNARIES_TERM"; break; \
  case 33: return "TERM_LITERAL"; break; \
  case 34: return "TERM_FUNCTIONCALL"; break; \
  case 35: return "TERM_REFERENCE"; break; \
  case 36: return "TERM_BOPENEXPRESSIONBCLOSE"; break; \
  case 37: return "TERM_EXPRESSION"; break; \
  case 38: return "FUNCTIONCALL_REFERENCE"; break; \
  case 39: return "INDEX_EXPRESSION"; break; \
  case 40: return "STRINGLITERAL_NRTV"; break; \
  case 41: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 42: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 43: return "HASHKEY_TERM"; break; \
  case 44: return "HASHVALUE_TERM"; break; \
  case 45: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 46: return "LISTELT_TERM"; break; \
  case 47: return "FLOATLITERAL"; break; \
  case 48: return "INTLITERAL"; break; \
  case 49: return "BOOLEANLITERAL_TRUEFALSE"; break; \
  case 50: return "IDENT_AZAZAZAZ"; break; \
  case 51: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \
  case 52: return "ASSIGN"; break; \
  case 53: return "PLUSIS"; break; \
  case 54: return "MINIS"; break; \
  case 55: return "MULIS"; break; \
  case 56: return "DIVIS"; break; \
  case 57: return "EQUALS"; break; \
  case 58: return "NEQUALS"; break; \
  case 59: return "LT"; break; \
  case 60: return "GT"; break; \
  case 61: return "LTEQ"; break; \
  case 62: return "GTEQ"; break; \
  case 63: return "COLON"; break; \
  case 64: return "POW"; break; \
  case 65: return "MUL"; break; \
  case 66: return "DIV"; break; \
  case 67: return "ADD"; break; \
  case 68: return "SUB"; break; \
  case 69: return "INC"; break; \
  case 70: return "DEC"; break; \
  case 71: return "AND"; break; \
  case 72: return "OR"; break; \
  case 73: return "BITAND"; break; \
  case 74: return "BITOR"; break; \
  case 75: return "BITXOR"; break; \
  case 76: return "NOT"; break; \
  case 77: return "COMMA"; break; \
  case 78: return "DOT"; break; \
  case 79: return "LSHIFT"; break; \
  case 80: return "RSHIFT"; break; \


#define SLOT_TOPSTMT_FUNCDECL 0
#define SLOT_TOPSTMT_IMPORTSTMT 1
#define SLOT_LOWSTMT_STIF 2
#define SLOT_LOWSTMT_STWHILE 3
#define SLOT_LOWSTMT_STRETURN 4
#define SLOT_LOWSTMT_STOTHER 5
#define SLOT_LOWSTMT_VARDECL 6
#define SLOT_LOWSTMT_ASSIGNMENT 7
#define SLOT_FUNCPARAMDECL_IDENTCOMMAIDENT 8
#define SLOT_FUNCBODY_LOWSTMT 9
#define SLOT_ST_IF_EXPRESSION 10
#define SLOT_ST_IF_LOWSTMT 11
#define SLOT_ST_IF_IFELSEIF 12
#define SLOT_ST_IF_IFELSE 13
#define SLOT_IF_ELSEIF_EXPRESSION 14
#define SLOT_IF_ELSEIF_LOWSTMT 15
#define SLOT_IF_ELSE_LOWSTMT 16
#define SLOT_ST_WHILE_EXPRESSION 17
#define SLOT_ST_WHILE_LOWSTMT 18
#define SLOT_ST_RETURN_EXPRESSION 19
#define SLOT_VARDECL_EXPRESSION 20
#define SLOT_BINOP_P12_BINOPP 21
#define SLOT_BINOP_P11_BINOPP 22
#define SLOT_BINOP_P10_BINOPP 23
#define SLOT_BINOP_P09_BINOPP 24
#define SLOT_BINOP_P08_BINOPP 25
#define SLOT_BINOP_P07_BINOPP 26
#define SLOT_BINOP_P06_BINOPP 27
#define SLOT_BINOP_P05_BINOPP 28
#define SLOT_BINOP_P04_BINOPP 29
#define SLOT_BINOP_P03_UNARIES 30
#define SLOT_UNARIES_UNARY 31
#define SLOT_UNARIES_TERM 32
#define SLOT_TERM_LITERAL 33
#define SLOT_TERM_FUNCTIONCALL 34
#define SLOT_TERM_REFERENCE 35
#define SLOT_TERM_BOPENEXPRESSIONBCLOSE 36
#define SLOT_TERM_EXPRESSION 37
#define SLOT_FUNCTIONCALL_REFERENCE 38
#define SLOT_INDEX_EXPRESSION 39
#define SLOT_STRINGLITERAL_NRTV 40
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 41
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 42
#define SLOT_HASHKEY_TERM 43
#define SLOT_HASHVALUE_TERM 44
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 45
#define SLOT_LISTELT_TERM 46
#define SLOT_FLOATLITERAL 47
#define SLOT_INTLITERAL 48
#define SLOT_BOOLEANLITERAL_TRUEFALSE 49
#define SLOT_IDENT_AZAZAZAZ 50
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 51
#define SLOT_ASSIGN 52
#define SLOT_PLUSIS 53
#define SLOT_MINIS 54
#define SLOT_MULIS 55
#define SLOT_DIVIS 56
#define SLOT_EQUALS 57
#define SLOT_NEQUALS 58
#define SLOT_LT 59
#define SLOT_GT 60
#define SLOT_LTEQ 61
#define SLOT_GTEQ 62
#define SLOT_COLON 63
#define SLOT_POW 64
#define SLOT_MUL 65
#define SLOT_DIV 66
#define SLOT_ADD 67
#define SLOT_SUB 68
#define SLOT_INC 69
#define SLOT_DEC 70
#define SLOT_AND 71
#define SLOT_OR 72
#define SLOT_BITAND 73
#define SLOT_BITOR 74
#define SLOT_BITXOR 75
#define SLOT_NOT 76
#define SLOT_COMMA 77
#define SLOT_DOT 78
#define SLOT_LSHIFT 79
#define SLOT_RSHIFT 80

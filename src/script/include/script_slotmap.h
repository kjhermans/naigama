#define SLOTMAP_SWITCH \
  case 0: return "TOPSTMT_FUNCDECL"; break; \
  case 1: return "TOPSTMT_IMPORTSTMT"; break; \
  case 2: return "IMPORTSTMT_STRINGLITERAL"; break; \
  case 3: return "LOWSTMT_STIF"; break; \
  case 4: return "LOWSTMT_STWHILE"; break; \
  case 5: return "LOWSTMT_STRETURN"; break; \
  case 6: return "LOWSTMT_STOTHER"; break; \
  case 7: return "LOWSTMT_VARDECL"; break; \
  case 8: return "LOWSTMT_ASSIGNMENT"; break; \
  case 9: return "FUNCPARAMDECL_IDENTCOMMAIDENT"; break; \
  case 10: return "FUNCBODY_LOWSTMT"; break; \
  case 11: return "ST_IF_EXPRESSION"; break; \
  case 12: return "ST_IF_LOWSTMT"; break; \
  case 13: return "ST_IF_IFELSEIF"; break; \
  case 14: return "ST_IF_IFELSE"; break; \
  case 15: return "IF_ELSEIF_EXPRESSION"; break; \
  case 16: return "IF_ELSEIF_LOWSTMT"; break; \
  case 17: return "IF_ELSE_LOWSTMT"; break; \
  case 18: return "ST_WHILE_EXPRESSION"; break; \
  case 19: return "ST_WHILE_LOWSTMT"; break; \
  case 20: return "ST_RETURN_EXPRESSION"; break; \
  case 21: return "EXPRESSION_ANDOR"; break; \
  case 22: return "EXPR2_BITANDBITORBITXOR"; break; \
  case 23: return "EXPR3_EQUALSNEQUALSLTEQLTGTEQGT"; break; \
  case 24: return "EXPR4_POWMULDIV"; break; \
  case 25: return "EXPR5_ADDSUB"; break; \
  case 26: return "EXPR6_UNARY"; break; \
  case 27: return "EXPR6_TERM"; break; \
  case 28: return "TERM_LITERAL"; break; \
  case 29: return "TERM_IDENT"; break; \
  case 30: return "TERM_IDENT_1"; break; \
  case 31: return "TERM_EXPRESSION"; break; \
  case 32: return "STRINGLITERAL_NRTV"; break; \
  case 33: return "HASHLITERAL_CBOPENHASHELTCOMMAHA"; break; \
  case 34: return "HASHELT_HASHKEYCOLONHASHVALUE"; break; \
  case 35: return "HASHKEY_TERM"; break; \
  case 36: return "HASHVALUE_TERM"; break; \
  case 37: return "LISTLITERAL_ABOPENLISTELTCOMMALI"; break; \
  case 38: return "LISTELT_TERM"; break; \
  case 39: return "FLOATLITERAL"; break; \
  case 40: return "INTLITERAL"; break; \
  case 41: return "BOOLEANLITERAL_TRUEFALSE"; break; \
  case 42: return "IDENT_AZAZAZAZ"; break; \
  case 43: return "ASSIGNS_ASSIGNPLUSISMINISMULISDI"; break; \


#define SLOT_TOPSTMT_FUNCDECL 0
#define SLOT_TOPSTMT_IMPORTSTMT 1
#define SLOT_IMPORTSTMT_STRINGLITERAL 2
#define SLOT_LOWSTMT_STIF 3
#define SLOT_LOWSTMT_STWHILE 4
#define SLOT_LOWSTMT_STRETURN 5
#define SLOT_LOWSTMT_STOTHER 6
#define SLOT_LOWSTMT_VARDECL 7
#define SLOT_LOWSTMT_ASSIGNMENT 8
#define SLOT_FUNCPARAMDECL_IDENTCOMMAIDENT 9
#define SLOT_FUNCBODY_LOWSTMT 10
#define SLOT_ST_IF_EXPRESSION 11
#define SLOT_ST_IF_LOWSTMT 12
#define SLOT_ST_IF_IFELSEIF 13
#define SLOT_ST_IF_IFELSE 14
#define SLOT_IF_ELSEIF_EXPRESSION 15
#define SLOT_IF_ELSEIF_LOWSTMT 16
#define SLOT_IF_ELSE_LOWSTMT 17
#define SLOT_ST_WHILE_EXPRESSION 18
#define SLOT_ST_WHILE_LOWSTMT 19
#define SLOT_ST_RETURN_EXPRESSION 20
#define SLOT_EXPRESSION_ANDOR 21
#define SLOT_EXPR2_BITANDBITORBITXOR 22
#define SLOT_EXPR3_EQUALSNEQUALSLTEQLTGTEQGT 23
#define SLOT_EXPR4_POWMULDIV 24
#define SLOT_EXPR5_ADDSUB 25
#define SLOT_EXPR6_UNARY 26
#define SLOT_EXPR6_TERM 27
#define SLOT_TERM_LITERAL 28
#define SLOT_TERM_IDENT 29
#define SLOT_TERM_IDENT_1 30
#define SLOT_TERM_EXPRESSION 31
#define SLOT_STRINGLITERAL_NRTV 32
#define SLOT_HASHLITERAL_CBOPENHASHELTCOMMAHA 33
#define SLOT_HASHELT_HASHKEYCOLONHASHVALUE 34
#define SLOT_HASHKEY_TERM 35
#define SLOT_HASHVALUE_TERM 36
#define SLOT_LISTLITERAL_ABOPENLISTELTCOMMALI 37
#define SLOT_LISTELT_TERM 38
#define SLOT_FLOATLITERAL 39
#define SLOT_INTLITERAL 40
#define SLOT_BOOLEANLITERAL_TRUEFALSE 41
#define SLOT_IDENT_AZAZAZAZ 42
#define SLOT_ASSIGNS_ASSIGNPLUSISMINISMULISDI 43

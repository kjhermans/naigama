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
  case 25: return "VARCAPTURE_TYPE"; break; \
  case 26: return "VARCAPTURE_CBCLOSE"; break; \
  case 27: return "CAPTURE_CBCLOSE"; break; \
  case 28: return "GROUP_BCLOSE"; break; \
  case 29: return "SET_SETNOT"; break; \
  case 30: return "SET_NRTV"; break; \
  case 31: return "SET_NRTV_1"; break; \
  case 32: return "SET_NRTV_2"; break; \
  case 33: return "SET_ABCLOSE"; break; \
  case 34: return "VARREFERENCE_IDENTNUMBER"; break; \
  case 35: return "REPLACE_TERMS"; break; \
  case 36: return "RECYCLE_IDENT"; break; \
  case 37: return "OPTARGS_ARGS"; break; \
  case 38: return "ARGS_IDENT"; break; \
  case 39: return "ARGS_IDENT_1"; break; \
  case 40: return "CALL_IDENT"; break; \
  case 41: return "CALL_ARGS"; break; \


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
#define SLOT_VARCAPTURE_TYPE 25
#define SLOT_VARCAPTURE_CBCLOSE 26
#define SLOT_CAPTURE_CBCLOSE 27
#define SLOT_GROUP_BCLOSE 28
#define SLOT_SET_SETNOT 29
#define SLOT_SET_NRTV 30
#define SLOT_SET_NRTV_1 31
#define SLOT_SET_NRTV_2 32
#define SLOT_SET_ABCLOSE 33
#define SLOT_VARREFERENCE_IDENTNUMBER 34
#define SLOT_REPLACE_TERMS 35
#define SLOT_RECYCLE_IDENT 36
#define SLOT_OPTARGS_ARGS 37
#define SLOT_ARGS_IDENT 38
#define SLOT_ARGS_IDENT_1 39
#define SLOT_CALL_IDENT 40
#define SLOT_CALL_ARGS 41

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
  case 26: return "VARCAPTURE_CBCLOSE"; break; \
  case 27: return "CAPTURE_CBCLOSE"; break; \
  case 28: return "GROUP_BCLOSE"; break; \
  case 29: return "SET_SETNOT"; break; \
  case 30: return "SET_NRTV"; break; \
  case 31: return "SET_NRTV_1"; break; \
  case 32: return "SET_NRTV_2"; break; \
  case 33: return "SET_ABCLOSE"; break; \
  case 34: return "VARREFERENCE_IDENT"; break; \
  case 35: return "VARREFERENCE_NUMBER"; break; \
  case 36: return "REPLACE_REPLACETERMS"; break; \
  case 37: return "REPLACETERM_STRINGLITERAL"; break; \
  case 38: return "REPLACETERM_HEXLITERAL"; break; \
  case 39: return "REPLACETERM_VARREFERENCE"; break; \
  case 40: return "RECYCLE_IDENT"; break; \


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
#define SLOT_VARCAPTURE_CBCLOSE 26
#define SLOT_CAPTURE_CBCLOSE 27
#define SLOT_GROUP_BCLOSE 28
#define SLOT_SET_SETNOT 29
#define SLOT_SET_NRTV 30
#define SLOT_SET_NRTV_1 31
#define SLOT_SET_NRTV_2 32
#define SLOT_SET_ABCLOSE 33
#define SLOT_VARREFERENCE_IDENT 34
#define SLOT_VARREFERENCE_NUMBER 35
#define SLOT_REPLACE_REPLACETERMS 36
#define SLOT_REPLACETERM_STRINGLITERAL 37
#define SLOT_REPLACETERM_HEXLITERAL 38
#define SLOT_REPLACETERM_VARREFERENCE 39
#define SLOT_RECYCLE_IDENT 40

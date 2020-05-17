#define ASMSLOTMAP_SWITCH \
  case 5: return "CHARINSTR_CHAR"; break; \
  case 21: return "SETINSTR_SET"; break; \
  case 22: return "RANGEINSTR_RANGE"; break; \
  case 2: return "BACKCOMMITINSTR_BACKCOMMIT"; break; \
  case 28: return "TESTSETINSTR_TESTSET"; break; \
  case 20: return "RETINSTR_RET"; break; \
  case 3: return "CALLINSTR_CALL"; break; \
  case 18: return "REPLACEINSTR_REPLACE"; break; \
  case 35: return "NUMBER"; break; \
  case 23: return "SKIPINSTR_SKIP"; break; \
  case 14: return "TRAPINSTR_TRAP"; break; \
  case 24: return "SPANINSTR_SPAN"; break; \
  case 26: return "TESTCHARINSTR_TESTCHAR"; break; \
  case 12: return "JUMPINSTR_JUMP"; break; \
  case 6: return "MASKEDCHARINSTR_MASKEDCHAR"; break; \
  case 13: return "NOOPINSTR_NOOP"; break; \
  case 10: return "FAILINSTR_FAIL"; break; \
  case 16: return "PARTIALCOMMITINSTR_PARTIALCOMMIT"; break; \
  case 31: return "CONDJUMPINSTR_CONDJUMP"; break; \
  case 11: return "FAILTWICEINSTR_FAILTWICE"; break; \
  case 15: return "OPENCAPTUREINSTR_OPENCAPTURE"; break; \
  case 32: return "LABELDEF_LABEL"; break; \
  case 17: return "QUADINSTR_QUAD"; break; \
  case 37: return "SET_AFAF"; break; \
  case 4: return "CATCHINSTR_CATCH"; break; \
  case 29: return "VARINSTR_VAR"; break; \
  case 27: return "TESTQUADINSTR_TESTQUAD"; break; \
  case 30: return "COUNTERINSTR_COUNTER"; break; \
  case 9: return "ENDINSTR_END"; break; \
  case 7: return "CLOSECAPTUREINSTR_CLOSECAPTURE"; break; \
  case 33: return "HEXBYTE_AFAF"; break; \
  case 25: return "TESTANYINSTR_TESTANY"; break; \
  case 0: return "INSTRUCTION_ANYINSTRBACKCOMMITINSTRCALLINSTRCATCHINSTRCHARINSTRMASKEDCHARINSTRCLOSECAPTUREINSTRCOMMITINSTRENDREPLACEINSTRREPLACEINSTRENDINSTRFAILTWICEINSTRFAILINSTRJUMPINSTRNOOPINSTRTRAPINSTROPENCAPTUREINSTRPARTIALCOMMITINSTRQUADINSTRRETINSTRSETINSTRRANGEINSTRSKIPINSTRSPANINSTRTESTANYINSTRTESTCHARINSTRTESTQUADINSTRTESTSETINSTRVARINSTRCOUNTERINSTRCONDJUMPINSTRLABELDEF"; break; \
  case 19: return "ENDREPLACEINSTR_ENDREPLACE"; break; \
  case 36: return "QUAD_AFAF"; break; \
  case 34: return "LABEL_AZAZ"; break; \
  case 1: return "ANYINSTR_ANY"; break; \
  case 8: return "COMMITINSTR_COMMIT"; break; \


#define ASMSLOT_CHARINSTR_CHAR 5
#define ASMSLOT_SETINSTR_SET 21
#define ASMSLOT_RANGEINSTR_RANGE 22
#define ASMSLOT_BACKCOMMITINSTR_BACKCOMMIT 2
#define ASMSLOT_TESTSETINSTR_TESTSET 28
#define ASMSLOT_RETINSTR_RET 20
#define ASMSLOT_CALLINSTR_CALL 3
#define ASMSLOT_REPLACEINSTR_REPLACE 18
#define ASMSLOT_NUMBER 35
#define ASMSLOT_SKIPINSTR_SKIP 23
#define ASMSLOT_TRAPINSTR_TRAP 14
#define ASMSLOT_SPANINSTR_SPAN 24
#define ASMSLOT_TESTCHARINSTR_TESTCHAR 26
#define ASMSLOT_JUMPINSTR_JUMP 12
#define ASMSLOT_MASKEDCHARINSTR_MASKEDCHAR 6
#define ASMSLOT_NOOPINSTR_NOOP 13
#define ASMSLOT_FAILINSTR_FAIL 10
#define ASMSLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT 16
#define ASMSLOT_CONDJUMPINSTR_CONDJUMP 31
#define ASMSLOT_FAILTWICEINSTR_FAILTWICE 11
#define ASMSLOT_OPENCAPTUREINSTR_OPENCAPTURE 15
#define ASMSLOT_LABELDEF_LABEL 32
#define ASMSLOT_QUADINSTR_QUAD 17
#define ASMSLOT_SET_AFAF 37
#define ASMSLOT_CATCHINSTR_CATCH 4
#define ASMSLOT_VARINSTR_VAR 29
#define ASMSLOT_TESTQUADINSTR_TESTQUAD 27
#define ASMSLOT_COUNTERINSTR_COUNTER 30
#define ASMSLOT_ENDINSTR_END 9
#define ASMSLOT_CLOSECAPTUREINSTR_CLOSECAPTURE 7
#define ASMSLOT_HEXBYTE_AFAF 33
#define ASMSLOT_TESTANYINSTR_TESTANY 25
#define ASMSLOT_INSTRUCTION_ANYINSTRBACKCOMMITINSTRCALLINSTRCATCHINSTRCHARINSTRMASKEDCHARINSTRCLOSECAPTUREINSTRCOMMITINSTRENDREPLACEINSTRREPLACEINSTRENDINSTRFAILTWICEINSTRFAILINSTRJUMPINSTRNOOPINSTRTRAPINSTROPENCAPTUREINSTRPARTIALCOMMITINSTRQUADINSTRRETINSTRSETINSTRRANGEINSTRSKIPINSTRSPANINSTRTESTANYINSTRTESTCHARINSTRTESTQUADINSTRTESTSETINSTRVARINSTRCOUNTERINSTRCONDJUMPINSTRLABELDEF 0
#define ASMSLOT_ENDREPLACEINSTR_ENDREPLACE 19
#define ASMSLOT_QUAD_AFAF 36
#define ASMSLOT_LABEL_AZAZ 34
#define ASMSLOT_ANYINSTR_ANY 1
#define ASMSLOT_COMMITINSTR_COMMIT 8

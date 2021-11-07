#ifndef _SLOTMAP_ASSEMBLY_H_
#define _SLOTMAP_ASSEMBLY_H_

/* Generated by genslthdr in ./grammar/assembly.slotmap */

#define ASMSLOT_ANYINSTR_ANY 1
#define ASMSLOT_BACKCOMMITINSTR_BACKCOMMIT 2
#define ASMSLOT_CALLINSTR_CALL 3
#define ASMSLOT_CATCHINSTR_CATCH 4
#define ASMSLOT_CHARINSTR_CHAR 5
#define ASMSLOT_CLOSECAPTUREINSTR_CLOSECAPTURE 7
#define ASMSLOT_COMMITINSTR_COMMIT 8
#define ASMSLOT_CONDJUMPINSTR_CONDJUMP 31
#define ASMSLOT_COUNTERINSTR_COUNTER 30
#define ASMSLOT_ENDINSTR_END 9
#define ASMSLOT_ENDREPLACEINSTR_ENDREPLACE 19
#define ASMSLOT_FAILINSTR_FAIL 10
#define ASMSLOT_FAILTWICEINSTR_FAILTWICE 11
#define ASMSLOT_HEXBYTE_AFAF 33
#define ASMSLOT_INSTRUCTION_ANYINSTRBACKCOMMITINSTRCALLINSTRCATCHINSTRCHARINSTRMASKEDCHARINSTRCLOSECAPTUREINSTRCOMMITINSTRENDREPLACEINSTRREPLACEINSTRENDINSTRFAILTWICEINSTRFAILINSTRJUMPINSTRNOOPINSTRTRAPINSTROPENCAPTUREINSTRPARTIALCOMMITINSTRQUADINSTRRETINSTRSETINSTRRANGEINSTRSKIPINSTRSPANINSTRTESTANYINSTRTESTCHARINSTRTESTQUADINSTRTESTSETINSTRVARINSTRCOUNTERINSTRCONDJUMPINSTRLABELDEF 0
#define ASMSLOT_JUMPINSTR_JUMP 12
#define ASMSLOT_LABELDEF_LABEL 32
#define ASMSLOT_LABEL_AZAZ 34
#define ASMSLOT_MASKEDCHARINSTR_MASKEDCHAR 6
#define ASMSLOT_NOOPINSTR_NOOP 13
#define ASMSLOT_NUMBER 35
#define ASMSLOT_OPENCAPTUREINSTR_OPENCAPTURE 15
#define ASMSLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT 16
#define ASMSLOT_QUADINSTR_QUAD 17
#define ASMSLOT_QUAD_AFAF 36
#define ASMSLOT_RANGEINSTR_RANGE 22
#define ASMSLOT_REPLACEINSTR_REPLACE 18
#define ASMSLOT_RETINSTR_RET 20
#define ASMSLOT_SETINSTR_SET 21
#define ASMSLOT_SET_AFAF 37
#define ASMSLOT_SKIPINSTR_SKIP 23
#define ASMSLOT_SPANINSTR_SPAN 24
#define ASMSLOT_TESTANYINSTR_TESTANY 25
#define ASMSLOT_TESTCHARINSTR_TESTCHAR 26
#define ASMSLOT_TESTQUADINSTR_TESTQUAD 27
#define ASMSLOT_TESTSETINSTR_TESTSET 28
#define ASMSLOT_TRAPINSTR_TRAP 14
#define ASMSLOT_VARINSTR_VAR 29

#define _SLOTMAP_ASSEMBLY_SWITCH \
  case 1: return "ASMSLOT_ANYINSTR_ANY"; break; \
  case 2: return "ASMSLOT_BACKCOMMITINSTR_BACKCOMMIT"; break; \
  case 3: return "ASMSLOT_CALLINSTR_CALL"; break; \
  case 4: return "ASMSLOT_CATCHINSTR_CATCH"; break; \
  case 5: return "ASMSLOT_CHARINSTR_CHAR"; break; \
  case 7: return "ASMSLOT_CLOSECAPTUREINSTR_CLOSECAPTURE"; break; \
  case 8: return "ASMSLOT_COMMITINSTR_COMMIT"; break; \
  case 31: return "ASMSLOT_CONDJUMPINSTR_CONDJUMP"; break; \
  case 30: return "ASMSLOT_COUNTERINSTR_COUNTER"; break; \
  case 9: return "ASMSLOT_ENDINSTR_END"; break; \
  case 19: return "ASMSLOT_ENDREPLACEINSTR_ENDREPLACE"; break; \
  case 10: return "ASMSLOT_FAILINSTR_FAIL"; break; \
  case 11: return "ASMSLOT_FAILTWICEINSTR_FAILTWICE"; break; \
  case 33: return "ASMSLOT_HEXBYTE_AFAF"; break; \
  case 0: return "ASMSLOT_INSTRUCTION_ANYINSTRBACKCOMMITINSTRCALLINSTRCATCHINSTRCHARINSTRMASKEDCHARINSTRCLOSECAPTUREINSTRCOMMITINSTRENDREPLACEINSTRREPLACEINSTRENDINSTRFAILTWICEINSTRFAILINSTRJUMPINSTRNOOPINSTRTRAPINSTROPENCAPTUREINSTRPARTIALCOMMITINSTRQUADINSTRRETINSTRSETINSTRRANGEINSTRSKIPINSTRSPANINSTRTESTANYINSTRTESTCHARINSTRTESTQUADINSTRTESTSETINSTRVARINSTRCOUNTERINSTRCONDJUMPINSTRLABELDEF"; break; \
  case 12: return "ASMSLOT_JUMPINSTR_JUMP"; break; \
  case 32: return "ASMSLOT_LABELDEF_LABEL"; break; \
  case 34: return "ASMSLOT_LABEL_AZAZ"; break; \
  case 6: return "ASMSLOT_MASKEDCHARINSTR_MASKEDCHAR"; break; \
  case 13: return "ASMSLOT_NOOPINSTR_NOOP"; break; \
  case 35: return "ASMSLOT_NUMBER"; break; \
  case 15: return "ASMSLOT_OPENCAPTUREINSTR_OPENCAPTURE"; break; \
  case 16: return "ASMSLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT"; break; \
  case 17: return "ASMSLOT_QUADINSTR_QUAD"; break; \
  case 36: return "ASMSLOT_QUAD_AFAF"; break; \
  case 22: return "ASMSLOT_RANGEINSTR_RANGE"; break; \
  case 18: return "ASMSLOT_REPLACEINSTR_REPLACE"; break; \
  case 20: return "ASMSLOT_RETINSTR_RET"; break; \
  case 21: return "ASMSLOT_SETINSTR_SET"; break; \
  case 37: return "ASMSLOT_SET_AFAF"; break; \
  case 23: return "ASMSLOT_SKIPINSTR_SKIP"; break; \
  case 24: return "ASMSLOT_SPANINSTR_SPAN"; break; \
  case 25: return "ASMSLOT_TESTANYINSTR_TESTANY"; break; \
  case 26: return "ASMSLOT_TESTCHARINSTR_TESTCHAR"; break; \
  case 27: return "ASMSLOT_TESTQUADINSTR_TESTQUAD"; break; \
  case 28: return "ASMSLOT_TESTSETINSTR_TESTSET"; break; \
  case 14: return "ASMSLOT_TRAPINSTR_TRAP"; break; \
  case 29: return "ASMSLOT_VARINSTR_VAR"; break; \


#endif

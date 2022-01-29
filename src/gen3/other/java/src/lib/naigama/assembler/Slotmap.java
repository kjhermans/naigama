
package lib.naigama.assembler;

public class Slotmap {

  public static final int SLOT_ANYINSTR_ANY = 1;
  public static final int SLOT_BACKCOMMITINSTR_BACKCOMMIT = 2;
  public static final int SLOT_CALLINSTR_CALL = 3;
  public static final int SLOT_CATCHINSTR_CATCH = 4;
  public static final int SLOT_CHARINSTR_CHAR = 5;
  public static final int SLOT_CLOSECAPTUREINSTR_CLOSECAPTURE = 7;
  public static final int SLOT_COMMITINSTR_COMMIT = 8;
  public static final int SLOT_CONDJUMPINSTR_CONDJUMP = 31;
  public static final int SLOT_COUNTERINSTR_COUNTER = 30;
  public static final int SLOT_ENDINSTR_END = 9;
  public static final int SLOT_ENDREPLACEINSTR_ENDREPLACE = 19;
  public static final int SLOT_FAILINSTR_FAIL = 10;
  public static final int SLOT_FAILTWICEINSTR_FAILTWICE = 11;
  public static final int SLOT_HEXBYTE_AFAF = 33;
  public static final int SLOT_INSTRUCTION_ANYINSTRBACKCOMMITINSTRCALLINSTRCATCHINSTRCHARINSTRMASKEDCHARINSTRCLOSECAPTUREINSTRCOMMITINSTRENDREPLACEINSTRREPLACEINSTRENDINSTRFAILTWICEINSTRFAILINSTRJUMPINSTRNOOPINSTRTRAPINSTROPENCAPTUREINSTRPARTIALCOMMITINSTRQUADINSTRRETINSTRSETINSTRRANGEINSTRSKIPINSTRSPANINSTRTESTANYINSTRTESTCHARINSTRTESTQUADINSTRTESTSETINSTRVARINSTRCOUNTERINSTRCONDJUMPINSTRLABELDEF = 0;
  public static final int SLOT_JUMPINSTR_JUMP = 12;
  public static final int SLOT_LABELDEF_LABEL = 32;
  public static final int SLOT_LABEL_AZAZ = 34;
  public static final int SLOT_MASKEDCHARINSTR_MASKEDCHAR = 6;
  public static final int SLOT_NOOPINSTR_NOOP = 13;
  public static final int SLOT_NUMBER = 35;
  public static final int SLOT_OPENCAPTUREINSTR_OPENCAPTURE = 15;
  public static final int SLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT = 16;
  public static final int SLOT_QUADINSTR_QUAD = 17;
  public static final int SLOT_QUAD_AFAF = 36;
  public static final int SLOT_RANGEINSTR_RANGE = 22;
  public static final int SLOT_REPLACEINSTR_REPLACE = 18;
  public static final int SLOT_RETINSTR_RET = 20;
  public static final int SLOT_SETINSTR_SET = 21;
  public static final int SLOT_SET_AFAF = 37;
  public static final int SLOT_SKIPINSTR_SKIP = 23;
  public static final int SLOT_SPANINSTR_SPAN = 24;
  public static final int SLOT_TESTANYINSTR_TESTANY = 25;
  public static final int SLOT_TESTCHARINSTR_TESTCHAR = 26;
  public static final int SLOT_TESTQUADINSTR_TESTQUAD = 27;
  public static final int SLOT_TESTSETINSTR_TESTSET = 28;
  public static final int SLOT_TRAPINSTR_TRAP = 14;
  public static final int SLOT_VARINSTR_VAR = 29;


  private int slot = -1;
  public Slotmap(int s) { slot=s; }
  public String toString()
  {
    switch(slot) {
    case 1: return "SLOT_ANYINSTR_ANY";
    case 2: return "SLOT_BACKCOMMITINSTR_BACKCOMMIT";
    case 3: return "SLOT_CALLINSTR_CALL";
    case 4: return "SLOT_CATCHINSTR_CATCH";
    case 5: return "SLOT_CHARINSTR_CHAR";
    case 7: return "SLOT_CLOSECAPTUREINSTR_CLOSECAPTURE";
    case 8: return "SLOT_COMMITINSTR_COMMIT";
    case 31: return "SLOT_CONDJUMPINSTR_CONDJUMP";
    case 30: return "SLOT_COUNTERINSTR_COUNTER";
    case 9: return "SLOT_ENDINSTR_END";
    case 19: return "SLOT_ENDREPLACEINSTR_ENDREPLACE";
    case 10: return "SLOT_FAILINSTR_FAIL";
    case 11: return "SLOT_FAILTWICEINSTR_FAILTWICE";
    case 33: return "SLOT_HEXBYTE_AFAF";
    case 0: return "SLOT_INSTRUCTION_ANYINSTRBACKCOMMITINSTRCALLINSTRCATCHINSTRCHARINSTRMASKEDCHARINSTRCLOSECAPTUREINSTRCOMMITINSTRENDREPLACEINSTRREPLACEINSTRENDINSTRFAILTWICEINSTRFAILINSTRJUMPINSTRNOOPINSTRTRAPINSTROPENCAPTUREINSTRPARTIALCOMMITINSTRQUADINSTRRETINSTRSETINSTRRANGEINSTRSKIPINSTRSPANINSTRTESTANYINSTRTESTCHARINSTRTESTQUADINSTRTESTSETINSTRVARINSTRCOUNTERINSTRCONDJUMPINSTRLABELDEF";
    case 12: return "SLOT_JUMPINSTR_JUMP";
    case 32: return "SLOT_LABELDEF_LABEL";
    case 34: return "SLOT_LABEL_AZAZ";
    case 6: return "SLOT_MASKEDCHARINSTR_MASKEDCHAR";
    case 13: return "SLOT_NOOPINSTR_NOOP";
    case 35: return "SLOT_NUMBER";
    case 15: return "SLOT_OPENCAPTUREINSTR_OPENCAPTURE";
    case 16: return "SLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT";
    case 17: return "SLOT_QUADINSTR_QUAD";
    case 36: return "SLOT_QUAD_AFAF";
    case 22: return "SLOT_RANGEINSTR_RANGE";
    case 18: return "SLOT_REPLACEINSTR_REPLACE";
    case 20: return "SLOT_RETINSTR_RET";
    case 21: return "SLOT_SETINSTR_SET";
    case 37: return "SLOT_SET_AFAF";
    case 23: return "SLOT_SKIPINSTR_SKIP";
    case 24: return "SLOT_SPANINSTR_SPAN";
    case 25: return "SLOT_TESTANYINSTR_TESTANY";
    case 26: return "SLOT_TESTCHARINSTR_TESTCHAR";
    case 27: return "SLOT_TESTQUADINSTR_TESTQUAD";
    case 28: return "SLOT_TESTSETINSTR_TESTSET";
    case 14: return "SLOT_TRAPINSTR_TRAP";
    case 29: return "SLOT_VARINSTR_VAR";
    default: return "Unknown slot";
    }
  }
}

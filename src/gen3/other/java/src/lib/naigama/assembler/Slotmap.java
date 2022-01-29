
package lib.naigama.assembler;

public class Slotmap {

  public static final int SLOT_INSTRUCTION_RULEINSTR = 0;
  public static final int SLOT_INSTRUCTION_LABELDEF = 1;
  public static final int SLOT_ANYINSTR_ANY = 2;
  public static final int SLOT_BACKCOMMITINSTR_BACKCOMMIT = 3;
  public static final int SLOT_CALLINSTR_CALL = 4;
  public static final int SLOT_CATCHINSTR_CATCH = 5;
  public static final int SLOT_CHARINSTR_CHAR = 6;
  public static final int SLOT_MASKEDCHARINSTR_MASKEDCHAR = 7;
  public static final int SLOT_CLOSECAPTUREINSTR_CLOSECAPTURE = 8;
  public static final int SLOT_COMMITINSTR_COMMIT = 9;
  public static final int SLOT_ENDINSTR_END = 10;
  public static final int SLOT_FAILINSTR_FAIL = 11;
  public static final int SLOT_FAILTWICEINSTR_FAILTWICE = 12;
  public static final int SLOT_INTRPCAPTUREINSTR_INTRPCAPTURE = 13;
  public static final int SLOT_INTRPCAPTUREINSTR_DEFAULT = 14;
  public static final int SLOT_JUMPINSTR_JUMP = 15;
  public static final int SLOT_NOOPINSTR_NOOP = 16;
  public static final int SLOT_TRAPINSTR_TRAP = 17;
  public static final int SLOT_OPENCAPTUREINSTR_OPENCAPTURE = 18;
  public static final int SLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT = 19;
  public static final int SLOT_QUADINSTR_QUAD = 20;
  public static final int SLOT_REPLACEINSTR_REPLACE = 21;
  public static final int SLOT_ENDREPLACEINSTR_ENDREPLACE = 22;
  public static final int SLOT_RETINSTR_RET = 23;
  public static final int SLOT_SETINSTR_SET = 24;
  public static final int SLOT_RANGEINSTR_RANGE = 25;
  public static final int SLOT_SKIPINSTR_SKIP = 26;
  public static final int SLOT_SPANINSTR_SPAN = 27;
  public static final int SLOT_TESTANYINSTR_TESTANY = 28;
  public static final int SLOT_TESTCHARINSTR_TESTCHAR = 29;
  public static final int SLOT_TESTQUADINSTR_TESTQUAD = 30;
  public static final int SLOT_TESTSETINSTR_TESTSET = 31;
  public static final int SLOT_VARINSTR_VAR = 32;
  public static final int SLOT_COUNTERINSTR_COUNTER = 33;
  public static final int SLOT_CONDJUMPINSTR_CONDJUMP = 34;
  public static final int SLOT_ISOLATEINSTR_ISOLATE = 35;
  public static final int SLOT_ENDISOLATEINSTR_ENDISOLATE = 36;
  public static final int SLOT_MODEINSTR_MODE = 37;
  public static final int SLOT_HEXBYTE_AFAF = 38;
  public static final int SLOT_LABEL_AZAZ = 39;
  public static final int SLOT_UNSIGNED = 40;
  public static final int SLOT_NUMBER = 41;
  public static final int SLOT_QUAD_AFAF = 42;
  public static final int SLOT_SET_AFAF = 43;
  public static final int SLOT_STRINGLITERAL_NRTV = 44;
  public static final int SLOT_INTRPCAPTURETYPES_RUINT = 45;


  private int slot = -1;
  public Slotmap(int s) { slot=s; }
  public String toString()
  {
    switch(slot) {
    case 2: return "SLOT_ANYINSTR_ANY";
    case 3: return "SLOT_BACKCOMMITINSTR_BACKCOMMIT";
    case 4: return "SLOT_CALLINSTR_CALL";
    case 5: return "SLOT_CATCHINSTR_CATCH";
    case 6: return "SLOT_CHARINSTR_CHAR";
    case 8: return "SLOT_CLOSECAPTUREINSTR_CLOSECAPTURE";
    case 9: return "SLOT_COMMITINSTR_COMMIT";
    case 34: return "SLOT_CONDJUMPINSTR_CONDJUMP";
    case 33: return "SLOT_COUNTERINSTR_COUNTER";
    case 10: return "SLOT_ENDINSTR_END";
    case 36: return "SLOT_ENDISOLATEINSTR_ENDISOLATE";
    case 22: return "SLOT_ENDREPLACEINSTR_ENDREPLACE";
    case 11: return "SLOT_FAILINSTR_FAIL";
    case 12: return "SLOT_FAILTWICEINSTR_FAILTWICE";
    case 38: return "SLOT_HEXBYTE_AFAF";
    case 1: return "SLOT_INSTRUCTION_LABELDEF";
    case 0: return "SLOT_INSTRUCTION_RULEINSTR";
    case 14: return "SLOT_INTRPCAPTUREINSTR_DEFAULT";
    case 13: return "SLOT_INTRPCAPTUREINSTR_INTRPCAPTURE";
    case 45: return "SLOT_INTRPCAPTURETYPES_RUINT";
    case 35: return "SLOT_ISOLATEINSTR_ISOLATE";
    case 15: return "SLOT_JUMPINSTR_JUMP";
    case 39: return "SLOT_LABEL_AZAZ";
    case 7: return "SLOT_MASKEDCHARINSTR_MASKEDCHAR";
    case 37: return "SLOT_MODEINSTR_MODE";
    case 16: return "SLOT_NOOPINSTR_NOOP";
    case 41: return "SLOT_NUMBER";
    case 18: return "SLOT_OPENCAPTUREINSTR_OPENCAPTURE";
    case 19: return "SLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT";
    case 20: return "SLOT_QUADINSTR_QUAD";
    case 42: return "SLOT_QUAD_AFAF";
    case 25: return "SLOT_RANGEINSTR_RANGE";
    case 21: return "SLOT_REPLACEINSTR_REPLACE";
    case 23: return "SLOT_RETINSTR_RET";
    case 24: return "SLOT_SETINSTR_SET";
    case 43: return "SLOT_SET_AFAF";
    case 26: return "SLOT_SKIPINSTR_SKIP";
    case 27: return "SLOT_SPANINSTR_SPAN";
    case 44: return "SLOT_STRINGLITERAL_NRTV";
    case 28: return "SLOT_TESTANYINSTR_TESTANY";
    case 29: return "SLOT_TESTCHARINSTR_TESTCHAR";
    case 30: return "SLOT_TESTQUADINSTR_TESTQUAD";
    case 31: return "SLOT_TESTSETINSTR_TESTSET";
    case 17: return "SLOT_TRAPINSTR_TRAP";
    case 40: return "SLOT_UNSIGNED";
    case 32: return "SLOT_VARINSTR_VAR";
    default: return "Unknown slot";
    }
  }
}

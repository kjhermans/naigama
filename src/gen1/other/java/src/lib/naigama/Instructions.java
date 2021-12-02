package lib.naigama;

public class Instructions
{
  public static final int INSTR_ANY = 0x000003e4;
  public static final int INSTR_BACKCOMMIT = 0x000403c0;
  public static final int INSTR_CALL = 0x00040382;
  public static final int INSTR_CATCH = 0x00040393;
  public static final int INSTR_CHAR = 0x000403d7;
  public static final int INSTR_CLOSECAPTURE = 0x00040300;
  public static final int INSTR_COMMIT = 0x00040336;
  public static final int INSTR_CONDJUMP = 0x00080321;
  public static final int INSTR_COUNTER = 0x00080356;
  public static final int INSTR_END = 0x000400d8;
  public static final int INSTR_ENDREPLACE = 0x00000399;
  public static final int INSTR_FAIL = 0x0000034b;
  public static final int INSTR_FAILTWICE = 0x00000390;
  public static final int INSTR_JUMP = 0x00040333;
  public static final int INSTR_MASKEDCHAR = 0x00080365;
  public static final int INSTR_NOOP = 0x00000000;
  public static final int INSTR_OPENCAPTURE = 0x0004039c;
  public static final int INSTR_PARTIALCOMMIT = 0x000403b4;
  public static final int INSTR_QUAD = 0x0004037e;
  public static final int INSTR_RANGE = 0x000803bd;
  public static final int INSTR_REPLACE = 0x00080348;
  public static final int INSTR_RET = 0x000003a0;
  public static final int INSTR_SET = 0x002003ca;
  public static final int INSTR_SKIP = 0x00040330;
  public static final int INSTR_SPAN = 0x002003e1;
  public static final int INSTR_TESTANY = 0x00040306;
  public static final int INSTR_TESTCHAR = 0x0008039a;
  public static final int INSTR_TESTQUAD = 0x000803db;
  public static final int INSTR_TESTSET = 0x00240363;
  public static final int INSTR_TRAP = 0xff00ffff;
  public static final int INSTR_VAR = 0x000403ee;


  public static int getSize
    (int opcode)
  {
    return ((opcode >> 16) & 0xff) + 4;
  }

  public static String getString
    (int opcode)
  {
    switch (opcode) {
    case 0x000003e4: return "any";
    case 0x000403c0: return "backcommit";
    case 0x00040382: return "call";
    case 0x00040393: return "catch";
    case 0x000403d7: return "char";
    case 0x00040300: return "closecapture";
    case 0x00040336: return "commit";
    case 0x00080321: return "condjump";
    case 0x00080356: return "counter";
    case 0x000400d8: return "end";
    case 0x00000399: return "endreplace";
    case 0x0000034b: return "fail";
    case 0x00000390: return "failtwice";
    case 0x00040333: return "jump";
    case 0x00080365: return "maskedchar";
    case 0x00000000: return "noop";
    case 0x0004039c: return "opencapture";
    case 0x000403b4: return "partialcommit";
    case 0x0004037e: return "quad";
    case 0x000803bd: return "range";
    case 0x00080348: return "replace";
    case 0x000003a0: return "ret";
    case 0x002003ca: return "set";
    case 0x00040330: return "skip";
    case 0x002003e1: return "span";
    case 0x00040306: return "testany";
    case 0x0008039a: return "testchar";
    case 0x000803db: return "testquad";
    case 0x00240363: return "testset";
    case 0xff00ffff: return "trap";
    case 0x000403ee: return "var";
    default: return "Unknown opcode";
    }
  }
}

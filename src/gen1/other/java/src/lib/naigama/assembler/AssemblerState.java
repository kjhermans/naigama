package lib.naigama.assembler;

import java.util.Hashtable;
import lib.naigama.NaigamaException;

class AssemblerState
{
  AssemblerOptions options;
  Hashtable<String,Integer> labels = new Hashtable<String,Integer>();
  byte[] output = new byte[ 0 ];

  void labelSet
    (String key, int offset)
    throws NaigamaException
  {
    if (labels.get(key) != null) {
      throw new NaigamaAssemblerError("Duplicate label defined '" + key + "'");
    }
    labels.put(key, new Integer(offset));
  }

  int labelGet
    (String key)
    throws NaigamaException
  {
    if (key.equals("__NEXT__")) {
//..
    }
    Integer i = labels.get(key);
    if (i == null) {
      throw new NaigamaAssemblerError("Label refereneced but not found '" + key + "'");
    }
    return i.intValue();
  }

  void output
    (byte[] add)
  {
  }

  void output_int
    (int add)
  {
  }

  void output_instr
    (int instr)
  {
  }
}

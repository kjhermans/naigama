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
    Integer i = labels.get(key);
    if (i == null) {
      throw new NaigamaAssemblerError("Label referenced but not found '" + key + "'");
    }
    return i.intValue();
  }

  void output_add_bytes
    (byte[] add)
  {
    byte[] newarray = new byte[ output.length + add.length ];
    System.arraycopy(output, 0, newarray, 0, output.length);
    System.arraycopy(add, 0, newarray, output.length, add.length);
    output = newarray;
  }

  void output_add_int
    (int add)
  {
    output_add_bytes(
      new byte[]{
        (byte)((add >> 24) & 0xff),
        (byte)((add >> 16) & 0xff),
        (byte)((add >> 8) & 0xff),
        (byte)(add & 0xff)
      }
    );
  }

  void output_add_instr
    (int instr)
  {
    output_add_int(instr);
  }
}

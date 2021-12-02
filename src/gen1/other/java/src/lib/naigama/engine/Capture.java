package lib.naigama.engine;

public class Capture
{
  public static final int TYPE_CAPTURE = 1;

  int type;
  int offset;
  int length;
  int slot;

  public Capture
    (int t, int o, int l, int s)
  {
    type = t;
    offset = o;
    length = l;
    slot = s;
  }

  public int getType()   { return type; }
  public int getOffset() { return offset; }
  public int getLength() { return length; }
  public int getSlot()   { return slot; }

  public String toString
    ()
  {
    String result = "typ=" + type + "; slt=" + slot + "; off=" + offset + "; len=" + length;
    return result;
  }
}

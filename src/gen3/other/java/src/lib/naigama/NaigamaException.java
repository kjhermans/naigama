package lib.naigama;

public class NaigamaException
  extends Exception
{
  String msg;

  public NaigamaException
    (String e)
  {
    msg = e;
  }

  public String toString
    ()
  {
    return msg;
  }
}

package lib.naigama.engine;

import lib.naigama.NaigamaException;

public class NaigamaFailure
  extends NaigamaException
{
  public NaigamaFailure
    ()
  {
    super("Parsing failure");
  }
}

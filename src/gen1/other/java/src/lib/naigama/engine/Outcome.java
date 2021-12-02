package lib.naigama.engine;

import java.util.Vector;

public class Outcome
{
  byte[]           input;
  int              exitcode;
  Vector<Capture>  captures;

  public int getExitCode
    ()
  {
    return exitcode;
  }

  public Vector<Capture> getCaptures
    ()
  {
    return captures;
  }

  public String toString
    ()
  {
    String result = "Exitcode: " + exitcode + "\n";
    for (int i=0; i < captures.size(); i++) {
      Capture c = captures.elementAt(i);
      result += "#" + i + "; " + c + "\n";
    }
    return result;
  }
}

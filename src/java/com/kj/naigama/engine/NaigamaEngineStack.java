package com.kj.naigama.engine;

import java.util.Vector;

public class NaigamaEngineStack
{
  private Vector<NaigamaEngineStackEntry> entries
    = new Vector<NaigamaEngineStackEntry>();

  public void push
    (NaigamaEngineStackEntry entry)
  {
    entries.add(entry);
  }

  public NaigamaEngineStackEntry pop
    ()
  {
    NaigamaEngineStackEntry result;
    if (entries.size() > 0) {
      result = entries.elementAt( entries.size()-1 );
      entries.removeElementAt( entries.size() - 1 );
      return result;
    }
    return null;
  }

  public int size
    ()
  {
    return entries.size();
  }
}

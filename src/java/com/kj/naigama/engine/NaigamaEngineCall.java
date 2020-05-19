package com.kj.naigama.engine;

public class NaigamaEngineCall
  implements NaigamaEngineStackEntry
{
  private int bytecodepos;

  public int getType
    ()
  {
    return NaigamaEngineStackEntry.CALL;
  }

  public NaigamaEngineCall
    (int i)
  {
    bytecodepos = i;
  }

  public int getBytecodepos
    ()
  {
    return bytecodepos;
  }
}

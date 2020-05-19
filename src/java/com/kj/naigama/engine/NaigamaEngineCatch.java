package com.kj.naigama.engine;

public class NaigamaEngineCatch
  implements NaigamaEngineStackEntry
{
  private int inputpos;
  private int actionlength;
  private int bytecodepos;

  public int getType
    ()
  {
    return NaigamaEngineStackEntry.CATCH;
  }

  public NaigamaEngineCatch
    (int i, int a, int b)
  {
    inputpos = i;
    actionlength = a;
    bytecodepos = b;
  }

  public int getInputpos
    ()
  {
    return inputpos;
  }

  public int getActionlength
    ()
  {
    return actionlength;
  }

  public int getBytecodepos
    ()
  {
    return bytecodepos;
  }
}

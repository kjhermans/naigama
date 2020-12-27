package com.kj.naigama.engine;

public class NaigamaEngineResult
{
  boolean success;
  int endcode;

  public NaigamaEngineResult
    (boolean s)
  {
    success = s;
    if (s) {
      endcode = 0;
    } else {
      endcode = -1;
    }
  }

  public NaigamaEngineResult
    (int e)
  {
    success = true;
    endcode = e;
  }
}

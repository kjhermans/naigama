package com.kj.naigama.engine;

public interface NaigamaEngineStackEntry
{
  public static final int CATCH = 1;
  public static final int CALL  = 2;

  public abstract int getType();
}

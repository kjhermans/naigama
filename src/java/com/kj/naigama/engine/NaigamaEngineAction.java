package com.kj.naigama.engine;

public interface NaigamaEngineAction
{
  public static final int OPENCAPTURE = 1;
  public static final int CLOSECAPTURE = 2;
  public static final int REPLACE = 3;

  public abstract int getType();
}

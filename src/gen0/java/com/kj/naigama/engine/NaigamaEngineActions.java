package com.kj.naigama.engine;

import java.util.Vector;

public class NaigamaEngineActions
{
  private Vector<NaigamaEngineAction> actions
    = new Vector<NaigamaEngineAction>();

  public void push
    (NaigamaEngineAction action)
  {
    actions.add(action);
  }

  public int size
    ()
  {
    return actions.size();
  }

  public void setSize
    (int s)
  {
    actions.setSize(s);
  }
}

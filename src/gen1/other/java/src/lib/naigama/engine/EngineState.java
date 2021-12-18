package lib.naigama.engine;

import java.util.Stack;
import java.util.Hashtable;

class EngineState
{
  Stack<StackElt>             stack;
  Stack<Action>               actions;
  byte[]                      input;
  Hashtable<Long,Integer>     counters;
  int                         bytecode_offset  = 0;
  int                         input_offset     = 0;
  boolean                     end              = false;
  int                         exitcode         = 0;
  boolean                     fail             = false;
  int                         opcode           = 0;
  int                         instrsize        = 0;

  EngineState
    (byte[] in)
  {
    stack = new Stack<StackElt>();
    actions = new Stack<Action>();
    counters = new Hashtable<Long,Integer>();
    input = in;
    end = false;
    fail = false;
  }
}

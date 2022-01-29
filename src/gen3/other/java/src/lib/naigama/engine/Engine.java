package lib.naigama.engine;

import lib.naigama.Instructions;
import java.util.Vector;

import lib.naigama.NaigamaException;

public class Engine
{
  byte[] bytecode = null;
  EngineOptions options = new EngineOptions();

  public Engine
    (byte[] bc)
  {
    this(bc, null);
  }

  public Engine
    (byte[] bc, EngineOptions op)
  {
    if (bc == null) {
      throw new NullPointerException("Bytecode must not be null");
    }
    bytecode = bc;
    if (op != null) {
      options = op;
    }
  }

  public void setDebug
    (boolean d)
  {
    options.debug = d;
  }

  public Outcome run
    (byte[] in)
    throws NaigamaException
  {
    if (in == null) {
      throw new NullPointerException("Bytecode must not be null");
    }
    EngineState state = new EngineState(in);
    int instrctr = 0;
    while (!(state.end)) {
      if (state.bytecode_offset > bytecode.length - 4) {
        throw new NaigamaBytecodeException("Ran out of bytecode.");
      }
      state.opcode = get_protected_quad(state.bytecode_offset);
      state.instrsize = Instructions.getSize(state.opcode);
      if (state.bytecode_offset > bytecode.length - state.instrsize) {
        throw new NaigamaBytecodeException(
          "Bytecode length does not support instruction size."
        );
      }
      if (options.debug) {
        System.err.println(
          instrctr++ +
          "; byc=" + state.bytecode_offset +
          "; inp=" + state.input_offset + 
          "; " + Instructions.getString(state.opcode) +
          "; stk=" + stack_string(state)
        );
      }
      switch (state.opcode) {
      case Instructions.INSTR_ANY: process_any(state); break;
      case Instructions.INSTR_BACKCOMMIT: process_backcommit(state); break;
      case Instructions.INSTR_CALL: process_call(state); break;
      case Instructions.INSTR_CATCH: process_catch(state); break;
      case Instructions.INSTR_CHAR: process_char(state); break;
      case Instructions.INSTR_CLOSECAPTURE: process_closecapture(state); break;
      case Instructions.INSTR_COMMIT: process_commit(state); break;
      case Instructions.INSTR_CONDJUMP: process_condjump(state); break;
      case Instructions.INSTR_COUNTER: process_counter(state); break;
      case Instructions.INSTR_END: process_end(state); break;
      case Instructions.INSTR_ENDREPLACE: process_endreplace(state); break;
      case Instructions.INSTR_FAIL: state.fail = true; break;
      case Instructions.INSTR_FAILTWICE: process_failtwice(state); break;
      case Instructions.INSTR_JUMP: process_jump(state); break;
      case Instructions.INSTR_MASKEDCHAR: process_maskedchar(state); break;
      case Instructions.INSTR_NOOP: state.bytecode_offset += state.instrsize; break;
      case Instructions.INSTR_OPENCAPTURE: process_opencapture(state); break;
      case Instructions.INSTR_PARTIALCOMMIT: process_partialcommit(state); break;
      case Instructions.INSTR_QUAD: process_quad(state); break;
      case Instructions.INSTR_RANGE: process_range(state); break;
      case Instructions.INSTR_REPLACE: process_replace(state); break;
      case Instructions.INSTR_RET: process_ret(state); break;
      case Instructions.INSTR_SET: process_set(state); break;
      case Instructions.INSTR_SKIP: process_skip(state); break;
      case Instructions.INSTR_SPAN: process_span(state); break;
      case Instructions.INSTR_TESTANY: process_testany(state); break;
      case Instructions.INSTR_TESTCHAR: process_testchar(state); break;
      case Instructions.INSTR_TESTQUAD: process_testquad(state); break;
      case Instructions.INSTR_TESTSET: process_testset(state); break;
      case Instructions.INSTR_TRAP: throw new NaigamaTrap("At byc=" + state.bytecode_offset + "; inp=" + state.input_offset);
      case Instructions.INSTR_VAR: process_var(state);
        break;
      default:
        throw new NaigamaBytecodeException("Unknown instruction opcode " + state.opcode);
      }
      if (state.fail) {
        if (options.debug) {
          System.err.println("FAIL");
        }
        fail(state);
      }
    }
    Outcome o = new Outcome();
    o.input    = state.input;
    o.exitcode = state.exitcode;
    o.captures = pins_to_captures(state);
    return o;
  }

  private int get_protected_quad
    (int off)
  {
    int result =
      (bytecode[ off+1 ] << 16) |
      (bytecode[ off+2 ] << 8) |
      (bytecode[ off+3 ] & 0xff);
    return result;
  }

  private void fail
    (EngineState state)
    throws NaigamaFailure
  {
    while (state.stack.size() > 0) {
      StackElt e = state.stack.pop();
      if (e.type == StackElt.TYPE_ALT) {
        state.bytecode_offset = e.offset;
        state.input_offset = e.input_offset;
        state.actions.setSize(e.pp_size);
        state.fail = false;
        return;
      }
    }
    throw new NaigamaFailure();
  }

  private int counter_resolve
    (EngineState state, int counter)
  {
    long key = (state.stack.size()) << 32 | counter;
    Integer value = state.counters.get(new Long(key));
    if (value != null) {
      if (--value == 0) {
        state.counters.remove(new Long(key));
      } else {
        state.counters.put(new Long(key), new Integer(value));
      }
      return value;
    }
    return 0;
  }

  private void counter_push
    (EngineState state, int counter, int value)
  {
    long key = (state.stack.size()) << 32 | counter;
    state.counters.put(new Long(key), new Integer(value));
  }

  private void process_any
    (EngineState state)
  {
    if (state.input_offset == state.input.length) {
      state.fail = true;
    } else {
      ++(state.input_offset);
      state.bytecode_offset += state.instrsize;
    }
  }

  private void process_backcommit
    (EngineState state)
    throws NaigamaException
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    StackElt e = state.stack.pop();
    if (e.type == StackElt.TYPE_ALT) {
      state.bytecode_offset = offset;
      state.input_offset = e.input_offset;
      state.actions.setSize(e.pp_size);
    } else { 
      throw new NaigamaStackException("Expected ALT type in backcommit");
    }
  }

  private void process_call
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    StackElt e = new StackElt();
    e.type = StackElt.TYPE_CLL;
    e.offset = state.bytecode_offset + state.instrsize;
    state.stack.push(e);
    state.bytecode_offset = offset;
  }

  private void process_catch
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    StackElt e = new StackElt();
    e.type = StackElt.TYPE_ALT;
    e.offset = offset;
    e.input_offset = state.input_offset;
    e.pp_size = state.actions.size();
    state.stack.push(e);
    state.bytecode_offset += state.instrsize;
  }

  private void process_char
    (EngineState state)
  {
    int chr = get_protected_quad(state.bytecode_offset + 4);
    if (state.input_offset == state.input.length) {
      state.fail = true;
    } else {
      if (state.input[ state.input_offset ] == (byte)chr) {
        ++(state.input_offset);
        state.bytecode_offset += state.instrsize;
      } else {
        state.fail = true;
      }
    }
  }

  private void process_closecapture
    (EngineState state)
  {
    int slot = get_protected_quad(state.bytecode_offset + 4);
    Action p = new Action();
    p.type = Action.TYPE_CAPTURE_CLOSE;
    p.slot = slot;
    p.offset = state.input_offset;
    state.actions.push(p);
    state.bytecode_offset += state.instrsize;
  }

  private void process_commit
    (EngineState state)
    throws NaigamaException
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    StackElt e = state.stack.pop();
    if (e.type == StackElt.TYPE_ALT) {
      state.bytecode_offset = offset;
    } else {
      throw new NaigamaStackException("Expected ALT type in commit");
    }
  }

  private void process_condjump
    (EngineState state)
  {
    int counter = get_protected_quad(state.bytecode_offset + 4);
    int offset = get_protected_quad(state.bytecode_offset + 8);
    int value = counter_resolve(state, counter);
    if (value > 0) {
      state.bytecode_offset = offset;
    } else {
      state.bytecode_offset += state.instrsize;
    }
  }

  private void process_counter
    (EngineState state)
  {
    int counter = get_protected_quad(state.bytecode_offset + 4);
    int value = get_protected_quad(state.bytecode_offset + 8);
    counter_push(state, counter, value);
    state.bytecode_offset += state.instrsize;
  }

  private void process_end
    (EngineState state)
  {
    int exitcode = get_protected_quad(state.bytecode_offset + 4);
    state.end = true;
    state.exitcode = exitcode;
  }

  private void process_endreplace
    (EngineState state)
  {
    state.bytecode_offset += state.instrsize;
  }

  private void process_failtwice
    (EngineState state)
    throws NaigamaException
  {
    StackElt e = state.stack.pop();
    if (e.type == StackElt.TYPE_ALT) {
      state.fail = true;
    } else {
      throw new NaigamaStackException("Expected ALT type in failtwice");
    }
  }

  private void process_jump
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    state.bytecode_offset = offset;
  }

  private void process_maskedchar
    (EngineState state)
  {
    int result = get_protected_quad(state.bytecode_offset + 4);
    int mask = get_protected_quad(state.bytecode_offset + 8);
    if (state.input_offset == state.input.length) {
      state.fail = true;
    } else {
      if ((state.input[ state.input_offset ] & (byte)mask) == (byte)result) {
        ++(state.input_offset);
        state.bytecode_offset += state.instrsize;
      } else {
        state.fail = true;
      }
    }
  }

  private void process_opencapture
    (EngineState state)
  {
    int slot = get_protected_quad(state.bytecode_offset + 4);
    Action p = new Action();
    p.type = Action.TYPE_CAPTURE_OPEN;
    p.slot = slot;
    p.offset = state.input_offset;
    state.actions.push(p);
    state.bytecode_offset += state.instrsize;
  }

  private void process_partialcommit
    (EngineState state)
    throws NaigamaException
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    StackElt e = state.stack.peek();
    if (e.type == StackElt.TYPE_ALT) {
      e.input_offset = state.input_offset;
      e.pp_size = state.actions.size();
      state.bytecode_offset = offset;
    } else {
      throw new NaigamaStackException("Expected ALT type in partialcommit");
    }
  }

  private void process_quad
    (EngineState state)
  {
    if (state.input_offset > state.input.length - 4) {
      state.fail = true;
    } else {
      if (state.input[ state.input_offset ] == bytecode[ state.bytecode_offset + 4 ]
          && state.input[ state.input_offset + 1 ] == bytecode[ state.bytecode_offset + 5 ]
          && state.input[ state.input_offset + 2 ] == bytecode[ state.bytecode_offset + 6 ]
          && state.input[ state.input_offset + 3 ] == bytecode[ state.bytecode_offset + 7 ])
      {
        state.input_offset += 4;
        state.bytecode_offset += state.instrsize;
      } else {
        state.fail = true;
      }
    }
  }

  private void process_range
    (EngineState state)
  {
    int from = get_protected_quad(state.bytecode_offset + 4);
    int until = get_protected_quad(state.bytecode_offset + 8);
    if (state.input_offset == state.input.length) {
      state.fail = true;
    } else {
      if (state.input[ state.input_offset ] >= (byte)from
          && state.input[ state.input_offset ] <= (byte)until)
      {
        ++(state.input_offset);
        state.bytecode_offset += state.instrsize;
      } else {
        state.fail = true;
      }
    }
  }

  private void process_replace
    (EngineState state)
    throws NaigamaException
  {
    int slot = get_protected_quad(state.bytecode_offset + 4);
    int offset = get_protected_quad(state.bytecode_offset + 8);
    if (options.replace) {
      state.bytecode_offset += state.instrsize;
      boolean endreplace = false;
      while (!endreplace) {
        if (state.bytecode_offset > bytecode.length - 4) {
          throw new NaigamaBytecodeException("Ran out of bytecode.");
        }
        state.opcode = get_protected_quad(state.bytecode_offset);
        state.instrsize = Instructions.getSize(state.opcode);
        if (state.bytecode_offset > bytecode.length - state.instrsize) {
          throw new NaigamaBytecodeException(
            "Bytecode length does not support instruction size."
          );
        }
        switch (state.opcode) {
        case Instructions.INSTR_NOOP:
          state.bytecode_offset += state.instrsize;
          break;
        case Instructions.INSTR_CHAR:
          {
            int chr = get_protected_quad(state.bytecode_offset + 4);
            Action p = new Action();
            p.type = Action.TYPE_REPLACE_CHAR;
            p.offset = state.input_offset;
            p.chr = chr;
            state.actions.push(p);
          }
          state.bytecode_offset += state.instrsize;
          break;
        case Instructions.INSTR_QUAD:
          for (int i=0; i < 4; i++) {
            int chr = (int)(bytecode[ state.bytecode_offset + 4 + i ]);
            Action p = new Action();
            p.type = Action.TYPE_REPLACE_CHAR;
            p.offset = state.input_offset;
            p.chr = chr;
            state.actions.push(p);
          }
          state.bytecode_offset += state.instrsize;
          break;
        case Instructions.INSTR_VAR:
          int varslot = get_protected_quad(state.bytecode_offset + 4);
          byte[] var = get_variable(state, varslot);
          if (var == null) {
            throw new NaigamaBytecodeException("Unreferenceable variable (" + slot + ") in var");
          }
          for (int i=0; i < var.length; i++) {
            int chr = (int)var[ i ];
            Action p = new Action();
            p.type = Action.TYPE_REPLACE_CHAR;
            p.offset = state.input_offset;
            p.chr = chr;
            state.actions.push(p);
          }
          state.bytecode_offset += state.instrsize;
          break;
        case Instructions.INSTR_ENDREPLACE:
          endreplace = true;
          state.bytecode_offset += state.instrsize;
          break;
        }
      }
    } else {
      state.bytecode_offset = offset;
    }
  }

  private void process_ret
    (EngineState state)
    throws NaigamaException
  {
    StackElt e = state.stack.pop();
    if (e.type == StackElt.TYPE_CLL) {
      state.bytecode_offset = e.offset;
    } else {
      throw new NaigamaStackException("Expected CLL type in ret");
    }
  }

  private void process_set
    (EngineState state)
  {
    if (state.input_offset == state.input.length) {
      state.fail = true;
    } else {
      int setoff = state.bytecode_offset + 4;
      int bitoff = state.input[ state.input_offset ];
      if (((bytecode[ setoff + (bitoff / 8) ] >> (bitoff % 8)) & 0x01) == 0x01)
      {
        ++(state.input_offset);
        state.bytecode_offset += state.instrsize;
      } else {
        state.fail = true;
      }
    }
  }

  private void process_skip
    (EngineState state)
  {
    int steps = get_protected_quad(state.bytecode_offset + 4);
    if (state.input_offset >= state.input.length - steps) {
      state.fail = true;
    } else {
      state.input_offset += steps;
      state.bytecode_offset += state.instrsize;
    }
  }

  private void process_span
    (EngineState state)
  {
    while (state.input_offset < state.input.length) {
      int setoff = state.bytecode_offset + 4;
      int bitoff = state.input[ state.input_offset ];
      if (((bytecode[ setoff + (bitoff / 8) ] >> (bitoff % 8)) & 0x01) == 0x01)
      {
        ++(state.input_offset);
      } else {
        break;
      }
    }
    state.bytecode_offset += state.instrsize;
  }

  private void process_testany
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    if (state.input_offset == state.input.length) {
      state.bytecode_offset = offset;
    } else {
      ++(state.input_offset);
      state.bytecode_offset += state.instrsize;
    }
  }

  private void process_testchar
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    int chr = get_protected_quad(state.bytecode_offset + 8);
    if (state.input_offset == state.input.length) {
      state.bytecode_offset = offset;
    } else {
      if (state.input[ state.input_offset ] == (byte)chr) {
        ++(state.input_offset);
        state.bytecode_offset += state.instrsize;
      } else {
        state.bytecode_offset = offset;
      }
    }
  }

  private void process_testquad
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    if (state.input_offset > state.input.length - 4) {
      state.bytecode_offset = offset;
    } else {
      if (state.input[ state.input_offset ] == bytecode[ state.bytecode_offset + 8 ]
          && state.input[ state.input_offset + 1 ] == bytecode[ state.bytecode_offset + 9 ]
          && state.input[ state.input_offset + 2 ] == bytecode[ state.bytecode_offset + 10 ]
          && state.input[ state.input_offset + 3 ] == bytecode[ state.bytecode_offset + 11 ])
      {
        state.input_offset += 4;
        state.bytecode_offset += state.instrsize;
      } else {
        state.bytecode_offset = offset;
      }
    }
  }

  private void process_testset
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    if (state.input_offset == state.input.length) {
      state.bytecode_offset = offset;
    } else {
      int setoff = state.bytecode_offset + 8;
      int bitoff = state.input[ state.input_offset ];
      if (((bytecode[ setoff + (bitoff / 8) ] >> (bitoff % 8)) & 0x01) == 0x01)
      {
        ++(state.input_offset);
        state.bytecode_offset += state.instrsize;
      } else {
        state.bytecode_offset = offset;
      }
    }
  }

  private byte[] get_variable
    (EngineState state, int slot)
  {
    for (int i = state.actions.size(); i > 0; i--) {
      Action p1 = state.actions.elementAt(i-1);
      if (p1.type == Action.TYPE_CAPTURE_CLOSE && p1.slot == slot) {
        int end = p1.offset;
        for (--i; i > 0; i--) {
          Action p0 = state.actions.elementAt(i-1);
          if (p0.type == Action.TYPE_CAPTURE_OPEN && p0.slot == slot) {
            int begin = p0.offset;
            int length = end - begin;
            byte[] result = new byte[ length ];
            System.arraycopy(state.input, begin, result, 0, length);
            return result;
          }
        }
      }
    }
    return null;
  }

  private void process_var
    (EngineState state)
    throws NaigamaException
  {
    int slot = get_protected_quad(state.bytecode_offset + 4);
    byte[] var = get_variable(state, slot);
    if (var == null) {
      throw new NaigamaBytecodeException("Unreferenceable variable (" + slot + ") in var");
    }
    if (var.length == 0) {
      state.fail = true;
    } else if (state.input_offset + var.length <= state.input.length) {
      for (int i=0; i < var.length; i++) {
        if (var[ i ] != state.input[ state.input_offset + i ]) {
          state.fail = true;
          return;
        }
      }
      state.input_offset += var.length;
      state.bytecode_offset += state.instrsize;
    } else {
      state.fail = true;
    }
  }

  private static String stack_string
    (EngineState state)
  {
    String result = "";
    for (int i=0; i < state.stack.size(); i++) {
      StackElt e = state.stack.elementAt(i);
      if (e.type == StackElt.TYPE_CLL) {
        result += "CLL; off=" + e.offset + "; ";
      } else if (e.type == StackElt.TYPE_ALT) {
        result += "ALT; off=" + e.offset + "; ";
      }
    }
    return result;
  }

  private static Vector<Capture> pins_to_captures
    (EngineState state)
  {
    Vector<Capture> result = new Vector<Capture>();
    for (int i=0; i < state.actions.size(); i++) {
      Action p0 = state.actions.elementAt(i);
      if (p0.type == Action.TYPE_CAPTURE_OPEN) {
        int level = 1;
        for (int j=i+1; j < state.actions.size(); j++) {
          Action p1 = state.actions.elementAt(j);
          if (p1.type == Action.TYPE_CAPTURE_OPEN) {
            ++level;
          } else if (p1.type == Action.TYPE_CAPTURE_CLOSE) {
            if (--level == 0) {
              result.addElement(
                new Capture(
                  Capture.TYPE_CAPTURE,
                  p0.offset,
                  p1.offset - p0.offset,
                  p0.slot
                )
              );
              break;
            }
          }
        }
      }
    }
    return result;
  }
}

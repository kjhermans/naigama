package lib.naigama;

public class Engine
{
  byte[] bytecode = null;

  public Engine
    (byte[] bc)
  {
    if (bc == null) {
      throw new NullPointerException("Bytecode must not be null");
    }
    bytecode = bc;
  }

  public Outcome run
    (byte[] in)
    throws NaigamaException
  {
    if (in == null) {
      throw new NullPointerException("Bytecode must not be null");
    }
    EngineState state = new EngineState(in);
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
      case Instructions.INSTR_ENDREPLACE:
      case Instructions.INSTR_FAIL: state.fail = true; break;
      case Instructions.INSTR_FAILTWICE: process_failtwice(state); break;
      case Instructions.INSTR_JUMP: process_jump(state); break;
      case Instructions.INSTR_MASKEDCHAR:
      case Instructions.INSTR_NOOP: state.bytecode_offset += state.instrsize; break;
      case Instructions.INSTR_OPENCAPTURE: process_opencapture(state); break;
      case Instructions.INSTR_PARTIALCOMMIT: process_partialcommit(state); break;
      case Instructions.INSTR_QUAD:
      case Instructions.INSTR_RANGE:
      case Instructions.INSTR_REPLACE:
      case Instructions.INSTR_RET: process_ret(state); break;
      case Instructions.INSTR_SET:
      case Instructions.INSTR_SKIP:
      case Instructions.INSTR_SPAN:
      case Instructions.INSTR_TESTANY:
      case Instructions.INSTR_TESTCHAR:
      case Instructions.INSTR_TESTQUAD:
      case Instructions.INSTR_TESTSET:
      case Instructions.INSTR_TRAP:
      case Instructions.INSTR_VAR:
        break;
      }
      if (state.fail) {
        fail(state);
      }
    }
    return null;
  }

  private int get_protected_quad
    (int off)
  {
    return bytecode[ off+1 ] << 16 |
           bytecode[ off+2 ] << 8 |
           bytecode[ off+3 ];
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
        state.pinpoints.setSize(e.pp_size);
        state.fail = false;
      }
    }
    if (state.stack.size() == 0) {
      throw new NaigamaFailure();
    }
  }

  private int counter_resolve
    (EngineState state, int counter)
  {
    Integer value = state.counters.get(new Integer(counter));
    if (value != null) {
      value--;
      state.counters.put(new Integer(counter), new Integer(value));
      return value;
    }
    return 0;
  }

  private void counter_push
    (EngineState state, int counter, int value)
  {
    state.counters.put(new Integer(counter), new Integer(value));
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
  {
    StackElt e = state.stack.pop();
    if (e.type == StackElt.TYPE_ALT) {
      state.bytecode_offset = e.offset;
      state.input_offset = e.input_offset;
      state.pinpoints.setSize(e.pp_size);
    } else { 
      //.. throw new NaigamaStackCompositionException();
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
    e.pp_size = state.pinpoints.size();
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
    Pinpoint p = new Pinpoint();
    p.type = Pinpoint.TYPE_CAPTURE_CLOSE;
    p.slot = slot;
    p.offset = state.input_offset;
    state.bytecode_offset += state.instrsize;
  }

  private void process_commit
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    StackElt e = state.stack.pop();
    if (e.type == StackElt.TYPE_ALT) {
      state.bytecode_offset = offset;
    } else {
      //.. stack corrupt
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

  private void process_failtwice
    (EngineState state)
  {
    StackElt e = state.stack.pop();
    if (e.type == StackElt.TYPE_ALT) {
      state.fail = true;
    } else {
      //.. stack corrupt
    }
  }

  private void process_jump
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    state.bytecode_offset = offset;
  }

  private void process_opencapture
    (EngineState state)
  {
    int slot = get_protected_quad(state.bytecode_offset + 4);
    Pinpoint p = new Pinpoint();
    p.type = Pinpoint.TYPE_CAPTURE_OPEN;
    p.slot = slot;
    p.offset = state.input_offset;
    state.bytecode_offset += state.instrsize;
  }

  private void process_partialcommit
    (EngineState state)
  {
    int offset = get_protected_quad(state.bytecode_offset + 4);
    StackElt e = state.stack.peek();
    e.input_offset = state.input_offset;
    e.pp_size = state.pinpoints.size();
    state.bytecode_offset = offset;
  }

  private void process_ret
    (EngineState state)
  {
    StackElt e = state.stack.pop();
    if (e.type == StackElt.TYPE_CLL) {
      state.bytecode_offset = e.offset;
    }
  }
}

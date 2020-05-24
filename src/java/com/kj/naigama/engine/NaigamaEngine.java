package com.kj.naigama.engine;

import com.kj.naigama.general.*;

public class NaigamaEngine
{
  private byte[] bytecode;

  public NaigamaEngine
    (byte[] bc)
  {
    if (bc == null) {
      throw new NullPointerException("Bytecode is null");
    }
    bytecode = bc;
  }

  public int nwo32
    (byte[] bytes, int offset)
  {
    int result =
      bytes[ offset ] << 24 |
      bytes[ offset+1 ] << 16 |
      bytes[ offset+2 ] << 8 |
      bytes[ offset+3 ];
    return result;
  }

  public NaigamaEngineResult run
    (byte[] input)
    throws NaigamaEngineException
  {
    int inputpos = 0;
    int bytecodepos = 0;
    NaigamaEngineStack stack = new NaigamaEngineStack();
    NaigamaEngineActions actions = new NaigamaEngineActions();

    if (input == null) {
      throw new NullPointerException("Bytecode is null");
    }
    while (true) {
      boolean fail = false;
      if (bytecodepos > bytecode.length - 4) {
        throw new NaigamaEngineException(
          "Bytcode position overflow (" + bytecodepos + " & " +
          bytecode.length + ")"
        );
      }
      int opcode = nwo32(bytecode, bytecodepos);
      switch (opcode) {

      case NaigamaInstructions.OPCODE_NOOP:
        {
          bytecodepos += 4;
        }
        break;

      case NaigamaInstructions.OPCODE_ANY:
        {
          if (inputpos == input.length) {
            fail = true;
          } else {
            ++inputpos;
            bytecodepos += 4;
          }
        }
        break;

      case NaigamaInstructions.OPCODE_SKIP:
        {
          int amount = nwo32(bytecode, bytecodepos + 4);
          if (inputpos <= input.length - amount) {
            inputpos += amount;
            bytecodepos += 8;
          } else {
            fail = true;
          }
        }
        break;

      case NaigamaInstructions.OPCODE_CHAR:
        {
          if (inputpos == input.length
              || input[ inputpos ] != bytecode[ bytecodepos+7 ])
          {
            fail = true;
          } else {
            ++inputpos;
            bytecodepos += 8;
          }
        }
        break;

      case NaigamaInstructions.OPCODE_MASKEDCHAR:
        {
          if (inputpos == input.length) {
            fail = true;
          } else {
            int match = nwo32(bytecode, bytecodepos + 4);
            int mask = nwo32(bytecode, bytecodepos + 8);
            if ((input[ inputpos ] & mask) == match) {
              bytecodepos += 12;
            } else {
              fail = true;
            }
          }
        }
        break;

      case NaigamaInstructions.OPCODE_QUAD:
        {
          if (inputpos <= input.length - 4) {
            if (bytecode[ bytecodepos + 4 ] == input[ inputpos ] &&
                bytecode[ bytecodepos + 5 ] == input[ inputpos + 1 ] &&
                bytecode[ bytecodepos + 6 ] == input[ inputpos + 2 ] &&
                bytecode[ bytecodepos + 7 ] == input[ inputpos + 3 ])
            {
              inputpos += 4;
              bytecodepos += 8;
            } else {
              fail = true;
            }
          } else {
            fail = true;
          }
        }
        break;

      case NaigamaInstructions.OPCODE_SET:
        {
          if (inputpos == input.length) {
            fail = true;
          } else {
            int match = input[ inputpos ];
            if ((bytecode[ bytecodepos + 4 + (match / 8) ] & (1 << (match % 8))) != 0) {
              ++inputpos;
              bytecodepos += 36;
            } else {
              fail = true;
            }
          }
        }
        break;

      case NaigamaInstructions.OPCODE_TESTANY:
        {
        }
        break;

      case NaigamaInstructions.OPCODE_TESTCHAR:
        {
        }
        break;

      case NaigamaInstructions.OPCODE_TESTQUAD:
        {
        }
        break;

      case NaigamaInstructions.OPCODE_TESTSET:
        {
        }
        break;

      case NaigamaInstructions.OPCODE_SPAN:
        {
        }
        break;

      case NaigamaInstructions.OPCODE_CALL:
        {
          int ret = bytecodepos + 8;
          bytecodepos = nwo32(bytecode, bytecodepos + 4);
          stack.push(new NaigamaEngineCall(ret));
        }
        break;

      case NaigamaInstructions.OPCODE_RET:
        {
          NaigamaEngineStackEntry entry = stack.pop();
          if (entry.getType() == NaigamaEngineStackEntry.CALL) {
            NaigamaEngineCall call = (NaigamaEngineCall)entry;
            bytecodepos = call.getBytecodepos();
          } else {
            throw new NaigamaEngineException("Stack corrupt");
          }
        }
        break;

      case NaigamaInstructions.OPCODE_END:
        {
          int endcode = nwo32(bytecode, bytecodepos + 4);
          NaigamaEngineResult result = new NaigamaEngineResult(endcode);
          return result;
        }

      case NaigamaInstructions.OPCODE_JUMP:
        {
          bytecodepos = nwo32(bytecode, bytecodepos + 4);
        }
        break;

      case NaigamaInstructions.OPCODE_CATCH:
        {
          int alt = nwo32(bytecode, bytecodepos + 4);
          stack.push(new NaigamaEngineCatch(inputpos, actions.size(), alt));
          bytecodepos += 8;
        }
        break;

      case NaigamaInstructions.OPCODE_COMMIT:
        {
          NaigamaEngineStackEntry entry = stack.pop();
          if (entry.getType() != NaigamaEngineStackEntry.CATCH) {
            throw new NaigamaEngineException("Stack corrupt");
          }
        }
        break;

      case NaigamaInstructions.OPCODE_BACKCOMMIT:
        {
          int jump = nwo32(bytecode, bytecodepos + 4);
          NaigamaEngineStackEntry entry = stack.pop();
          if (entry.getType() == NaigamaEngineStackEntry.CATCH) {
            NaigamaEngineCatch ctch = (NaigamaEngineCatch)entry;
            inputpos = ctch.getInputpos();
            actions.setSize(ctch.getActionlength());
            bytecodepos = jump;
          } else {
            throw new NaigamaEngineException("Stack corrupt");
          }
        }
        break;

      case NaigamaInstructions.OPCODE_PARTIALCOMMIT:
        {
          int jump = nwo32(bytecode, bytecodepos + 4);
          NaigamaEngineStackEntry entry = stack.pop();
          if (entry.getType() == NaigamaEngineStackEntry.CATCH) {
            NaigamaEngineCatch ctch = (NaigamaEngineCatch)entry;
            stack.push(new NaigamaEngineCatch(inputpos, actions.size(), ctch.getBytecodepos()));
            bytecodepos = jump;
          } else {
            throw new NaigamaEngineException("Stack corrupt");
          }
        }
        break;

      case NaigamaInstructions.OPCODE_FAIL:
        {
          fail = true;
        }
        break;

      case NaigamaInstructions.OPCODE_FAILTWICE:
        {
          while (stack.size() > 0) {
            NaigamaEngineStackEntry entry = stack.pop();
            if (entry.getType() == NaigamaEngineStackEntry.CATCH) {
              break;
            }
          }
          fail = true;
        }
        break;

      case NaigamaInstructions.OPCODE_VAR:
        {
        }
        break;

      case NaigamaInstructions.OPCODE_COUNTER:
        {
        }
        break;

      case NaigamaInstructions.OPCODE_CONDJUMP:
        {
        }
        break;

      case NaigamaInstructions.OPCODE_TRAP:
        {
          throw new NaigamaEngineException("Trapped at " + bytecodepos);
        }

      default:
        {
          throw new NaigamaEngineException("Unknown opcode " + opcode);
        }
      }

      if (fail) {
        boolean success = false;
        while (stack.size() > 0) {
          NaigamaEngineStackEntry entry = stack.pop();
          if (entry.getType() == NaigamaEngineStackEntry.CATCH) {
            NaigamaEngineCatch ctch = (NaigamaEngineCatch)entry;
            inputpos = ctch.getInputpos();
            actions.setSize(ctch.getActionlength());
            bytecodepos = ctch.getBytecodepos();
            success = true;
            break;
          }
        }
        fail = false;
        if (!success) {
          break;
        }
      }
    }
    return new NaigamaEngineResult(false);
  }
}

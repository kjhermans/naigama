package lib.naigama.assembler;

import lib.naigama.Instructions;
import lib.naigama.NaigamaException;
import lib.naigama.engine.Engine;
import lib.naigama.engine.Outcome;
import lib.naigama.engine.TreeNode;

public class Assembler
{
  private TreeNode treenode;
  private AssemblerOptions options;

  public Assembler
    (String assembly, AssemblerOptions op)
    throws NaigamaException
  {
    Engine e = new Engine(Grammar.bytecode);
    Outcome o = e.run(assembly.getBytes());
    treenode = o.getCaptureTree();
    options = op;
  }

  public byte[] assemble
    ()
    throws NaigamaException
  {
    AssemblerState state = new AssemblerState();
    state.options = options;
    top(treenode, state);
    return state.output;
  }

  private void top
    (TreeNode t, AssemblerState state)
    throws NaigamaException
  {
    fp(t, state);
    sp(t, state);
  }

  private void fp
    (TreeNode t, AssemblerState state)
    throws NaigamaException
  {
    int offset = 0;
    for (int i=0; i < t.getChildCount(); i++) {
      switch(t.getChild(i).getChild(0).getSlot()) {
      case Slotmap.SLOT_ANYINSTR_ANY:
        offset += Instructions.getSize(Instructions.INSTR_ANY);
        break;
      case Slotmap.SLOT_BACKCOMMITINSTR_BACKCOMMIT:
        offset += Instructions.getSize(Instructions.INSTR_BACKCOMMIT);
        break;
      case Slotmap.SLOT_CALLINSTR_CALL:
        offset += Instructions.getSize(Instructions.INSTR_CALL);
        break;
      case Slotmap.SLOT_CATCHINSTR_CATCH:
        offset += Instructions.getSize(Instructions.INSTR_CATCH);
        break;
      case Slotmap.SLOT_CHARINSTR_CHAR:
        offset += Instructions.getSize(Instructions.INSTR_CHAR);
        break;
      case Slotmap.SLOT_CLOSECAPTUREINSTR_CLOSECAPTURE:
        offset += Instructions.getSize(Instructions.INSTR_CLOSECAPTURE);
        break;
      case Slotmap.SLOT_COMMITINSTR_COMMIT:
        offset += Instructions.getSize(Instructions.INSTR_COMMIT);
        break;
      case Slotmap.SLOT_CONDJUMPINSTR_CONDJUMP:
        offset += Instructions.getSize(Instructions.INSTR_CONDJUMP);
        break;
      case Slotmap.SLOT_COUNTERINSTR_COUNTER:
        offset += Instructions.getSize(Instructions.INSTR_COUNTER);
        break;
      case Slotmap.SLOT_ENDINSTR_END:
        offset += Instructions.getSize(Instructions.INSTR_END);
        break;
      case Slotmap.SLOT_ENDREPLACEINSTR_ENDREPLACE:
        offset += Instructions.getSize(Instructions.INSTR_ENDREPLACE);
        break;
      case Slotmap.SLOT_FAILINSTR_FAIL:
        offset += Instructions.getSize(Instructions.INSTR_FAIL);
        break;
      case Slotmap.SLOT_FAILTWICEINSTR_FAILTWICE:
        offset += Instructions.getSize(Instructions.INSTR_FAILTWICE);
        break;
      case Slotmap.SLOT_JUMPINSTR_JUMP:
        offset += Instructions.getSize(Instructions.INSTR_JUMP);
        break;
      case Slotmap.SLOT_MASKEDCHARINSTR_MASKEDCHAR:
        offset += Instructions.getSize(Instructions.INSTR_MASKEDCHAR);
        break;
      case Slotmap.SLOT_NOOPINSTR_NOOP:
        offset += Instructions.getSize(Instructions.INSTR_NOOP);
        break;
      case Slotmap.SLOT_OPENCAPTUREINSTR_OPENCAPTURE:
        offset += Instructions.getSize(Instructions.INSTR_OPENCAPTURE);
        break;
      case Slotmap.SLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT:
        offset += Instructions.getSize(Instructions.INSTR_PARTIALCOMMIT);
        break;
      case Slotmap.SLOT_QUADINSTR_QUAD:
        offset += Instructions.getSize(Instructions.INSTR_QUAD);
        break;
      case Slotmap.SLOT_RANGEINSTR_RANGE:
        offset += Instructions.getSize(Instructions.INSTR_RANGE);
        break;
      case Slotmap.SLOT_REPLACEINSTR_REPLACE:
        offset += Instructions.getSize(Instructions.INSTR_REPLACE);
        break;
      case Slotmap.SLOT_RETINSTR_RET:
        offset += Instructions.getSize(Instructions.INSTR_RET);
        break;
      case Slotmap.SLOT_SETINSTR_SET:
        offset += Instructions.getSize(Instructions.INSTR_SET);
        break;
      case Slotmap.SLOT_SKIPINSTR_SKIP:
        offset += Instructions.getSize(Instructions.INSTR_SKIP);
        break;
      case Slotmap.SLOT_SPANINSTR_SPAN:
        offset += Instructions.getSize(Instructions.INSTR_SPAN);
        break;
      case Slotmap.SLOT_TESTANYINSTR_TESTANY:
        offset += Instructions.getSize(Instructions.INSTR_TESTANY);
        break;
      case Slotmap.SLOT_TESTCHARINSTR_TESTCHAR:
        offset += Instructions.getSize(Instructions.INSTR_TESTCHAR);
        break;
      case Slotmap.SLOT_TESTQUADINSTR_TESTQUAD:
        offset += Instructions.getSize(Instructions.INSTR_TESTQUAD);
        break;
      case Slotmap.SLOT_TESTSETINSTR_TESTSET:
        offset += Instructions.getSize(Instructions.INSTR_TESTSET);
        break;
      case Slotmap.SLOT_TRAPINSTR_TRAP:
        offset += Instructions.getSize(Instructions.INSTR_TRAP);
        break;
      case Slotmap.SLOT_VARINSTR_VAR:
        offset += Instructions.getSize(Instructions.INSTR_VAR);
        break;
      case Slotmap.SLOT_INSTRUCTION_LABELDEF:
        if (state.options.debug) {
          System.err.println("Label '" + t.getChild(i).getChild(0).getChild(0).getContent() + "' -> " + offset);
        }
        state.labelSet(t.getChild(i).getChild(0).getChild(0).getContent(), offset);
        break;
      }
    }
  }

  private void sp
    (TreeNode t, AssemblerState state)
    throws NaigamaException
  {
    for (int i=0; i < t.getChildCount(); i++) {
      switch(t.getChild(i).getChild(0).getSlot()) {
      case Slotmap.SLOT_ANYINSTR_ANY:
        state.output_add_instr(Instructions.INSTR_ANY);
        break;
      case Slotmap.SLOT_BACKCOMMITINSTR_BACKCOMMIT:
        state.output_add_instr(Instructions.INSTR_BACKCOMMIT);
        {
          String label = t.getChild(i).getChild(1).getContent();
          int offset = label.equals("__NEXT__") ? state.output.length + Instructions.getSize(Instructions.INSTR_BACKCOMMIT) - 4 : state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_CALLINSTR_CALL:
        state.output_add_instr(Instructions.INSTR_CALL);
        {
          String label = t.getChild(i).getChild(1).getContent();
          int offset = state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_CATCHINSTR_CATCH:
        state.output_add_instr(Instructions.INSTR_CATCH);
        {
          String label = t.getChild(i).getChild(1).getContent();
          int offset = state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_CHARINSTR_CHAR:
        state.output_add_instr(Instructions.INSTR_CHAR);
        {
          int value = Integer.valueOf(t.getChild(i).getChild(1).getContent(), 16);
          state.output_add_int(value);
        }
        break;
      case Slotmap.SLOT_CLOSECAPTUREINSTR_CLOSECAPTURE:
        state.output_add_instr(Instructions.INSTR_CLOSECAPTURE);
        {
          int slot = Integer.parseInt(t.getChild(i).getChild(1).getContent());
          state.output_add_int(slot);
        }
        break;
      case Slotmap.SLOT_COMMITINSTR_COMMIT:
        state.output_add_instr(Instructions.INSTR_COMMIT);
        {
          String label = t.getChild(i).getChild(1).getContent();
          int offset = label.equals("__NEXT__") ? state.output.length + Instructions.getSize(Instructions.INSTR_COMMIT) - 4 : state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_CONDJUMPINSTR_CONDJUMP:
        state.output_add_instr(Instructions.INSTR_CONDJUMP);
        {
          int reg = Integer.valueOf(t.getChild(i).getChild(1).getContent());
          state.output_add_int(reg);
          String label = t.getChild(i).getChild(2).getContent();
          int offset = label.equals("__NEXT__") ? state.output.length + Instructions.getSize(Instructions.INSTR_CONDJUMP) - 4 : state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_COUNTERINSTR_COUNTER:
        state.output_add_instr(Instructions.INSTR_COUNTER);
        {
          int reg = Integer.valueOf(t.getChild(i).getChild(1).getContent());
          state.output_add_int(reg);
          int value = Integer.valueOf(t.getChild(i).getChild(2).getContent());
          state.output_add_int(value);
        }
        break;
      case Slotmap.SLOT_ENDINSTR_END:
        state.output_add_instr(Instructions.INSTR_END);
        {
          int code = Integer.parseInt(t.getChild(i).getChild(1).getContent());
          state.output_add_int(code);
        }
        break;
      case Slotmap.SLOT_ENDREPLACEINSTR_ENDREPLACE:
        state.output_add_instr(Instructions.INSTR_ENDREPLACE);
        break;
      case Slotmap.SLOT_FAILINSTR_FAIL:
        state.output_add_instr(Instructions.INSTR_FAIL);
        break;
      case Slotmap.SLOT_FAILTWICEINSTR_FAILTWICE:
        state.output_add_instr(Instructions.INSTR_FAILTWICE);
        break;
      case Slotmap.SLOT_JUMPINSTR_JUMP:
        state.output_add_instr(Instructions.INSTR_JUMP);
        {
          String label = t.getChild(i).getChild(1).getContent();
          int offset = state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_MASKEDCHARINSTR_MASKEDCHAR:
        state.output_add_instr(Instructions.INSTR_MASKEDCHAR);
        {
          int mask = Integer.valueOf(t.getChild(i).getChild(1).getContent(), 16);
          state.output_add_int(mask);
          int value = Integer.valueOf(t.getChild(i).getChild(2).getContent(), 16);
          state.output_add_int(value);
        }
        break;
      case Slotmap.SLOT_NOOPINSTR_NOOP:
        state.output_add_instr(Instructions.INSTR_NOOP);
        break;
      case Slotmap.SLOT_OPENCAPTUREINSTR_OPENCAPTURE:
        state.output_add_instr(Instructions.INSTR_OPENCAPTURE);
        {
          int slot = Integer.parseInt(t.getChild(i).getChild(1).getContent());
          state.output_add_int(slot);
        }
        break;
      case Slotmap.SLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT:
        state.output_add_instr(Instructions.INSTR_PARTIALCOMMIT);
        {
          String label = t.getChild(i).getChild(1).getContent();
          int offset = label.equals("__NEXT__") ? state.output.length + Instructions.getSize(Instructions.INSTR_PARTIALCOMMIT) - 4 : state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_QUADINSTR_QUAD:
        state.output_add_instr(Instructions.INSTR_QUAD);
        {
          byte[] set = new byte[ 4 ];
          for (int j=0; j < set.length; j++) {
            set[ j ] = (byte)(Integer.valueOf(t.getChild(i).getChild(1).getContent().substring(j*2, j*2+2), 16).intValue());
          }
          state.output_add_bytes(set);
        }
        break;
      case Slotmap.SLOT_RANGEINSTR_RANGE:
        state.output_add_instr(Instructions.INSTR_RANGE);
        {
          int from = Integer.parseInt(t.getChild(i).getChild(1).getContent());
          int until = Integer.parseInt(t.getChild(i).getChild(2).getContent());
          state.output_add_int(from);
          state.output_add_int(until);
        }
        break;
      case Slotmap.SLOT_REPLACEINSTR_REPLACE:
        state.output_add_instr(Instructions.INSTR_REPLACE);
        {
          int slot = Integer.parseInt(t.getChild(i).getChild(1).getContent());
          state.output_add_int(slot);
          String label = t.getChild(i).getChild(2).getContent();
          int offset = state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_RETINSTR_RET:
        state.output_add_instr(Instructions.INSTR_RET);
        break;
      case Slotmap.SLOT_SETINSTR_SET:
        state.output_add_instr(Instructions.INSTR_SET);
        {
          byte[] set = new byte[ 32 ];
          String setstring = t.getChild(i).getChild(1).getContent();
          for (int j=0; j < set.length; j++) {
            set[ j ] = (byte)(Integer.valueOf(setstring.substring(j*2, j*2+2), 16).intValue());
          }
          state.output_add_bytes(set);
        }
        break;
      case Slotmap.SLOT_SKIPINSTR_SKIP:
        state.output_add_instr(Instructions.INSTR_SKIP);
        {
          int steps = Integer.parseInt(t.getChild(i).getChild(1).getContent());
          state.output_add_int(steps);
        }
        break;
      case Slotmap.SLOT_SPANINSTR_SPAN:
        state.output_add_instr(Instructions.INSTR_SPAN);
        {
          byte[] set = new byte[ 32 ];
          for (int j=0; j < set.length; j++) {
            set[ j ] = (byte)(Integer.valueOf(t.getChild(i).getChild(1).getContent().substring(j*2, j*2+2), 16).intValue());
          }
          state.output_add_bytes(set);
        }
        break;
      case Slotmap.SLOT_TESTANYINSTR_TESTANY:
        state.output_add_instr(Instructions.INSTR_TESTANY);
        {
          String label = t.getChild(i).getChild(1).getContent();
          int offset = label.equals("__NEXT__") ? state.output.length + Instructions.getSize(Instructions.INSTR_TESTANY) - 4 : state.labelGet(label);
          state.output_add_int(offset);
        }
        break;
      case Slotmap.SLOT_TESTCHARINSTR_TESTCHAR:
        state.output_add_instr(Instructions.INSTR_TESTCHAR);
        {
          String label = t.getChild(i).getChild(2).getContent();
          int offset = label.equals("__NEXT__") ? state.output.length + Instructions.getSize(Instructions.INSTR_TESTCHAR) - 4 : state.labelGet(label);
          state.output_add_int(offset);
          int value = Integer.valueOf(t.getChild(i).getChild(1).getContent(), 16);
          state.output_add_int(value);
        }
        break;
      case Slotmap.SLOT_TESTQUADINSTR_TESTQUAD:
        state.output_add_instr(Instructions.INSTR_TESTQUAD);
        {
          String label = t.getChild(i).getChild(2).getContent();
          int offset = label.equals("__NEXT__") ? state.output.length + Instructions.getSize(Instructions.INSTR_TESTQUAD) - 4 : state.labelGet(label);
          state.output_add_int(offset);
          byte[] set = new byte[ 4 ];
          for (int j=0; j < set.length; j++) {
            set[ j ] = (byte)(Integer.valueOf(t.getChild(i).getChild(1).getContent().substring(j*2, j*2+2), 16).intValue());
          }
          state.output_add_bytes(set);
        }
        break;
      case Slotmap.SLOT_TESTSETINSTR_TESTSET:
        state.output_add_instr(Instructions.INSTR_TESTSET);
        {
          String label = t.getChild(i).getChild(2).getContent();
          int offset = label.equals("__NEXT__") ? state.output.length + Instructions.getSize(Instructions.INSTR_TESTSET) - 4 : state.labelGet(label);
          state.output_add_int(offset);
          byte[] set = new byte[ 32 ];
          for (int j=0; j < set.length; j++) {
            set[ j ] = (byte)(Integer.valueOf(t.getChild(i).getChild(1).getContent().substring(j*2, j*2+2), 16).intValue());
          }
          state.output_add_bytes(set);
        }
        break;
      case Slotmap.SLOT_TRAPINSTR_TRAP:
        state.output_add_instr(Instructions.INSTR_TRAP);
        break;
      case Slotmap.SLOT_VARINSTR_VAR:
        state.output_add_instr(Instructions.INSTR_VAR);
        {
          int slot = Integer.parseInt(t.getChild(i).getChild(1).getContent());
          state.output_add_int(slot);
        }
        break;
      }
    }
  }
}

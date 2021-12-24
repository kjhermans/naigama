package lib.naigama.assembler;

import lib.naigama.Instructions;
import lib.naigama.NaigamaException;
import lib.naigama.engine.Engine;
import lib.naigama.engine.Outcome;
import lib.naigama.engine.TreeNode;

public class Assembler
{
  public Assembler
    (String assembly, StringBuffer bytecode, AssemblerOptions options)
    throws NaigamaException
  {
    Engine e = new Engine(Grammar.bytecode);
    Outcome o = e.run(assembly.getBytes());
    TreeNode t = o.getCaptureTree();
    assemble(t, bytecode, options);
  }

  private void assemble
    (TreeNode t, StringBuffer out, AssemblerOptions options)
    throws NaigamaException
  {
    AssemblerState state = new AssemblerState();
    state.options = options;
    top(t, state, out);
  }

  private void top
    (TreeNode t, AssemblerState state, StringBuffer out)
    throws NaigamaException
  {
    fp(t, state, out);
    sp(t, state, out);
  }

  private void fp
    (TreeNode t, AssemblerState state, StringBuffer out)
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
      case Slotmap.SLOT_LABELDEF_LABEL:
        if (state.options.debug) {
          System.err.println("Label '" + t.getChild(i).getChild(0).getChild(0).getContent() + "' -> " + offset);
        }
        state.labelSet(t.getChild(i).getChild(0).getChild(0).getContent(), offset);
        break;
      }
    }
  }

  private void sp
    (TreeNode t, AssemblerState state, StringBuffer out)
    throws NaigamaException
  {
    for (int i=0; i < t.getChildCount(); i++) {
      switch(t.getChild(i).getChild(0).getSlot()) {
      case Slotmap.SLOT_ANYINSTR_ANY:
        state.output_instr(Instructions.INSTR_ANY);
        break;
      case Slotmap.SLOT_BACKCOMMITINSTR_BACKCOMMIT:
        state.output_instr(Instructions.INSTR_BACKCOMMIT);
        break;
      case Slotmap.SLOT_CALLINSTR_CALL:
        state.output_instr(Instructions.INSTR_CALL);
        {
          String label = t.getChild(i).getChild(1).getContent();
          int offset = state.labelGet(label);
          state.output_int(offset);
        }
        break;
      case Slotmap.SLOT_CATCHINSTR_CATCH:
        state.output_instr(Instructions.INSTR_CATCH);
        break;
      case Slotmap.SLOT_CHARINSTR_CHAR:
        state.output_instr(Instructions.INSTR_CHAR);
        break;
      case Slotmap.SLOT_CLOSECAPTUREINSTR_CLOSECAPTURE:
        state.output_instr(Instructions.INSTR_CLOSECAPTURE);
        break;
      case Slotmap.SLOT_COMMITINSTR_COMMIT:
        state.output_instr(Instructions.INSTR_COMMIT);
        break;
      case Slotmap.SLOT_CONDJUMPINSTR_CONDJUMP:
        state.output_instr(Instructions.INSTR_CONDJUMP);
        break;
      case Slotmap.SLOT_COUNTERINSTR_COUNTER:
        state.output_instr(Instructions.INSTR_COUNTER);
        break;
      case Slotmap.SLOT_ENDINSTR_END:
        state.output_instr(Instructions.INSTR_END);
        break;
      case Slotmap.SLOT_ENDREPLACEINSTR_ENDREPLACE:
        state.output_instr(Instructions.INSTR_ENDREPLACE);
        break;
      case Slotmap.SLOT_FAILINSTR_FAIL:
        state.output_instr(Instructions.INSTR_FAIL);
        break;
      case Slotmap.SLOT_FAILTWICEINSTR_FAILTWICE:
        state.output_instr(Instructions.INSTR_FAILTWICE);
        break;
      case Slotmap.SLOT_JUMPINSTR_JUMP:
        state.output_instr(Instructions.INSTR_JUMP);
        break;
      case Slotmap.SLOT_MASKEDCHARINSTR_MASKEDCHAR:
        state.output_instr(Instructions.INSTR_MASKEDCHAR);
        break;
      case Slotmap.SLOT_NOOPINSTR_NOOP:
        state.output_instr(Instructions.INSTR_NOOP);
        break;
      case Slotmap.SLOT_OPENCAPTUREINSTR_OPENCAPTURE:
        state.output_instr(Instructions.INSTR_OPENCAPTURE);
        break;
      case Slotmap.SLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT:
        state.output_instr(Instructions.INSTR_PARTIALCOMMIT);
        break;
      case Slotmap.SLOT_QUADINSTR_QUAD:
        state.output_instr(Instructions.INSTR_QUAD);
        break;
      case Slotmap.SLOT_RANGEINSTR_RANGE:
        state.output_instr(Instructions.INSTR_RANGE);
        break;
      case Slotmap.SLOT_REPLACEINSTR_REPLACE:
        state.output_instr(Instructions.INSTR_REPLACE);
        break;
      case Slotmap.SLOT_RETINSTR_RET:
        state.output_instr(Instructions.INSTR_RET);
        break;
      case Slotmap.SLOT_SETINSTR_SET:
        state.output_instr(Instructions.INSTR_SET);
        break;
      case Slotmap.SLOT_SKIPINSTR_SKIP:
        state.output_instr(Instructions.INSTR_SKIP);
        break;
      case Slotmap.SLOT_SPANINSTR_SPAN:
        state.output_instr(Instructions.INSTR_SPAN);
        break;
      case Slotmap.SLOT_TESTANYINSTR_TESTANY:
        state.output_instr(Instructions.INSTR_TESTANY);
        break;
      case Slotmap.SLOT_TESTCHARINSTR_TESTCHAR:
        state.output_instr(Instructions.INSTR_TESTCHAR);
        break;
      case Slotmap.SLOT_TESTQUADINSTR_TESTQUAD:
        state.output_instr(Instructions.INSTR_TESTQUAD);
        break;
      case Slotmap.SLOT_TESTSETINSTR_TESTSET:
        state.output_instr(Instructions.INSTR_TESTSET);
        break;
      case Slotmap.SLOT_TRAPINSTR_TRAP:
        state.output_instr(Instructions.INSTR_TRAP);
        break;
      case Slotmap.SLOT_VARINSTR_VAR:
        state.output_instr(Instructions.INSTR_VAR);
        break;
      }
    }
  }
}

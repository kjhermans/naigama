package lib.naigama.compiler;

import lib.naigama.NaigamaException;
import lib.naigama.compiler.Grammar;
import lib.naigama.engine.Engine;
import lib.naigama.engine.Outcome;
import lib.naigama.engine.TreeNode;

public class Compiler
{
  public Compiler
    (String grammar, StringBuffer assembly, CompilerOptions options)
    throws NaigamaException
  {
    Engine e = new Engine(Grammar.bytecode);
    Outcome o = e.run(grammar.getBytes());
    TreeNode t = o.getCaptureTree();
    t.eviscerate(Slotmap.SLOT_S);
    t.eviscerate(Slotmap.SLOT_COMMENT);
    t.eviscerate(Slotmap.SLOT_END);
    t.eviscerate(Slotmap.SLOT_LEFTARROW);
    compile(t, assembly, options);
  }

  private void compile
    (TreeNode t, StringBuffer out, CompilerOptions options)
  {
    CompilerState state = new CompilerState();
    state.options = options;
    if (t.getChildCount() == 1 && t.getChild(0).getSlot() == Slotmap.SLOT_GRAMMAR) {
      t = t.getChild(0);
    }
    fp(t, state);
    sp(t, state, out);
  }

  private void fp
    (TreeNode t, CompilerState state)
  {
    for (int i=0; i < t.getChildCount(); i++) {
      TreeNode child = t.getChild(i);
      if (child.getSlot() == Slotmap.SLOT_DEFINITION) {
        fp_definition(child, state);
      }
    }
  }

  private void sp
    (TreeNode t, CompilerState state, StringBuffer out)
  {
    for (int i=0; i < t.getChildCount(); i++) {
      TreeNode child = t.getChild(i);
      if (child.getSlot() == Slotmap.SLOT_DEFINITION) {
        sp_definition(child, state, out);
      }
    }
  }

  private void fp_definition
    (TreeNode t, CompilerState state)
  {
    if (t.getChildCount() == 1 && t.getChild(0).getSlot() == Slotmap.SLOT_RULE) {
      fp_rule(t.getChild(0), state);
    }
  }

  private void fp_rule
    (TreeNode t, CompilerState state)
  {
    String rulename = t.getChild(0).getContent();
    if (state.options.generate_captureperrule) {
      state.addCapture(t);
    }
  }

  private void sp_definition
    (TreeNode t, CompilerState state, StringBuffer out)
  {
    if (t.getChildCount() == 1 && t.getChild(0).getSlot() == Slotmap.SLOT_RULE) {
      sp_rule(t.getChild(0), state, out);
    }
  }

  private void sp_rule
    (TreeNode t, CompilerState state, StringBuffer out)
  {
    int rulecapture = -1;
    String rulename = t.getChild(0).getContent();
    TreeNode expression = t.getChild(1);
    if (state.options.generate_traps) {
      out.append("  trap\n");
    }
    out.append("__RULE_" + rulename.toUpperCase() + ":\n");
    if (state.options.generate_captureperrule) {
      rulecapture = state.getCapture(t);
      out.append("  opencapture " + rulecapture + "\n");
    }
    state.currentrule = t;
    sp_expression(expression, state, out);
    if (state.options.generate_captureperrule) {
      out.append("  closecapture " + rulecapture + "\n");
    }
    out.append("  ret -- from rule " + rulename + "\n");
    if (state.options.generate_traps) {
      out.append("  trap\n");
    }
    out.append("\n");
  }

  private void sp_expression
    (TreeNode t, CompilerState state, StringBuffer out)
  {
out.append(t.toString());
  }
}

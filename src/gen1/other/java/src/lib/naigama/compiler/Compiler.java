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
    compile(t, assembly, options);
  }

  private void compile
    (TreeNode t, StringBuffer out, CompilerOptions options)
  {
    CompilerState state = new CompilerState();
    if (t.getChildCount() == 1 && t.getChild(0).getSlot() == Slotmap.SLOT_GRAMMAR) {
      t = t.getChild(0);
    }
    firstpass(t, state);
    secondpass(t, state, out, options);
  }

  private void firstpass
    (TreeNode t, CompilerState state)
  {
    for (int i=0; i < t.getChildCount(); i++) {
      TreeNode child = t.getChild(i);
      if (child.getSlot() == Slotmap.SLOT_DEFINITION) {
        firstpass_definition(child, state);
      }
    }
  }

  private void secondpass
    (TreeNode t, CompilerState state, StringBuffer out, CompilerOptions options)
  {
    for (int i=0; i < t.getChildCount(); i++) {
    }
  }

  private void firstpass_definition
    (TreeNode t, CompilerState state)
  {
    if (t.getChildCount() == 1 && t.getChild(0).getSlot() == Slotmap.SLOT_RULE) {
      firstpass_rule(t.getChild(0), state);
    }
  }

  private void firstpass_rule
    (TreeNode t, CompilerState state)
  {
    String rulename = t.getChild(0).getContent();
System.err.println("RULE '" + rulename + "'");
  }
}

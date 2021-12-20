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
    t.eviscerate(Slotmap.SLOT_OR);
    t.eviscerate(Slotmap.SLOT_BOPEN);
    t.eviscerate(Slotmap.SLOT_BCLOSE);
    t.eviscerate(Slotmap.SLOT_GROUP_BCLOSE);
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
    if (t.getChildCount() == 2 && t.getChild(0).getSlot() == Slotmap.SLOT_EXPRESSION_TERMS_1) {
      String label1 = "__" + state.currentrule.getChild(0).getContent() + "_catch_" + (++(state.counter));
      String label2 = "__" + state.currentrule.getChild(0).getContent() + "_out_" + (++(state.counter));
      out.append("  catch " + label1 + "\n");
      sp_terms(t.getChild(0).getChild(0), state, out);
      out.append("  commit " + label2 + "\n");
      out.append(label1 + "\n");
      sp_expression(t.getChild(1), state, out);
      out.append(label2 + "\n");
    } else if (t.getChildCount() == 1 && t.getChild(0).getSlot() == Slotmap.SLOT_EXPRESSION_TERMS_2) {
      sp_terms(t.getChild(0).getChild(0), state, out);
    } else {
      System.err.println("Unexpected token in sp_expression " + t);
    }
  }

  private void sp_terms
    (TreeNode t, CompilerState state, StringBuffer out)
  {
    for (int i=0; i < t.getChildCount(); i++) {
      sp_term(t.getChild(i), state, out);
    }
  }

  private void sp_term
    (TreeNode t, CompilerState state, StringBuffer out)
  {
    t = t.getChild(0).getChild(0).getChild(0);
    if (t.getChildCount() == 2) {
      if (t.getChild(0).getSlot() == Slotmap.SLOT_ENDOWEDMATCHER_NOTAND) {
        sp_matcher(t.getChild(1), state, out);
      } else if (t.getChild(1).getSlot() == Slotmap.SLOT_ENDOWEDMATCHER_QUANTIFIER) {
        sp_matcher(t.getChild(0), state, out);
      }
    } else {
      sp_matcher(t.getChild(0), state, out);
    }
  }

  private void sp_matcher
    (TreeNode t, CompilerState state, StringBuffer out)
  {
    switch (t.getChild(0).getSlot()) {
    case Slotmap.SLOT_MATCHER_ANY:
      out.append("  any\n");
      break;
    case Slotmap.SLOT_MATCHER_SET:
      break;
    case Slotmap.SLOT_MATCHER_STRING:
      byte[] b = t.getChild(0).getContent().getBytes();
      //.. todo: unescape the string
      for (int i=1; i < b.length - 1; i++) {
        out.append("  char " + String.format("%02x ", b[i]) + "\n");
      }
      break;
    case Slotmap.SLOT_MATCHER_BITMASK:
      break;
    case Slotmap.SLOT_MATCHER_HEXLITERAL:
      break;
    case Slotmap.SLOT_MATCHER_VARCAPTURE:
      break;
    case Slotmap.SLOT_MATCHER_CAPTURE:
      break;
    case Slotmap.SLOT_MATCHER_GROUP:
      sp_expression(t.getChild(0).getChild(0).getChild(0), state, out);
      break;
    case Slotmap.SLOT_MATCHER_MACRO:
      break;
    case Slotmap.SLOT_MATCHER_VARREFERENCE:
      break;
    case Slotmap.SLOT_MATCHER_REFERENCE:
      out.append("  " + t.getChild(0).getContent() + "\n");
      break;
    }
  }
}

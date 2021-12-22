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
    t.eviscerate(Slotmap.SLOT_CBOPEN);
    t.eviscerate(Slotmap.SLOT_CBCLOSE);
    t.eviscerate(Slotmap.SLOT_CAPTURE_CBCLOSE);
    t.eviscerate(Slotmap.SLOT_ABOPEN);
    t.eviscerate(Slotmap.SLOT_ABCLOSE);
    t.eviscerate(Slotmap.SLOT_SET_ABCLOSE);
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
    //fp(t, state);
    sp(t, state, out);
  }

/*
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
*/

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

/*
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
*/

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
//System.err.println("EXPRESSION\n" + t);
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
      if (t.getChild(i).getSlot() == Slotmap.SLOT_TERMS_TERM) {
        sp_term(t.getChild(i), state, out);
      }
    }
  }

  private int[] resolve_quantifier
    (TreeNode t)
  {
    if (t.getContent().equals("+")) {
      return new int[]{ 1, -1 };
    } else if (t.getContent().equals("*")) {
      return new int[]{ 0, -1 };
    } else if (t.getContent().equals("?")) {
      return new int[]{ 0, 1 };
    } else {
      if (t.getChild(0).getChildCount() == 2) {
        return new int[]{
          Integer.parseInt(t.getChild(0).getChild(0).getContent()),
          Integer.parseInt(t.getChild(0).getChild(1).getContent())
        };
      } else {
        switch (t.getChild(0).getChild(0).getSlot()) {
        case Slotmap.SLOT_QUANTIFIER_3: // until
          return new int[]{ 0, Integer.parseInt(t.getChild(0).getChild(0).getContent()) };
        case Slotmap.SLOT_QUANTIFIER_4: // from
          return new int[]{ Integer.parseInt(t.getChild(0).getChild(0).getContent()), -1 };
        case Slotmap.SLOT_QUANTIFIER_5: // abs
          return new int[]{
            Integer.parseInt(t.getChild(0).getChild(0).getContent()),
            Integer.parseInt(t.getChild(0).getChild(0).getContent())
          };
        }
      }
      return null; /* shouldn't happen */
    }
  }

  private void sp_term
    (TreeNode t, CompilerState state, StringBuffer out)
  {
//System.err.println("TERM\n" + t);
    t = t.getChild(0).getChild(0).getChild(0);
    if (t.getChildCount() == 2) {
      if (t.getChild(0).getSlot() == Slotmap.SLOT_ENDOWEDMATCHER_NOTAND) {
        sp_matcher(t.getChild(1), state, out);
      } else if (t.getChild(1).getSlot() == Slotmap.SLOT_ENDOWEDMATCHER_QUANTIFIER) {
        int[] quant = resolve_quantifier(t.getChild(1));
        switch (quant[ 0 ]) {
        case 0: break;
        case 1: sp_matcher(t.getChild(0), state, out); break;
        default:
          if (state.options.writeloops) {
            for (int i=0; i < quant[ 0 ]; i++) {
              sp_matcher(t.getChild(0), state, out);
            }
          } else {
            int reg = state.reg++;
            int lab = state.counter++;
            out.append("  counter " + reg + " " + quant[ 0 ] + "\n");
            out.append("__loop_" + lab + ":\n");
            sp_matcher(t.getChild(0), state, out);
            out.append("  condjump " + reg + " __loop_" + lab + "\n");
          }
        }
        if (quant[ 1 ] == -1) {
          int fgv = state.counter++;
          int lab = state.counter++;
          out.append("  catch __forgive_" + fgv + "\n");
          out.append("__loop_" + lab + ":\n");
          sp_matcher(t.getChild(0), state, out);
          out.append("  partialcommit __loop_" + lab + "\n");
          out.append("__forgive_" + fgv + ":\n");
          out.append("  commit __NEXT\n");
        } else {
          int diff = quant[ 1 ] - quant[ 0 ];
          if (diff < 0) {
            //.. error
          }
          if (diff > 0) {
            int fgv = state.counter++;
            out.append("  catch __forgive_" + fgv + "\n");
            if (diff == 1) {
              sp_matcher(t.getChild(0), state, out);
            } else {
              if (state.options.writeloops) {
                for (int i=0; i < diff; i++) {
                  sp_matcher(t.getChild(0), state, out);
                }
              } else {
                int reg = state.reg++;
                int lab = state.counter++;
                out.append("  counter " + reg + " " + diff + "\n");
                out.append("__loop_" + lab + ":\n");
                sp_matcher(t.getChild(0), state, out);
                out.append("  condjump " + reg + " __loop_" + lab + "\n");
              }
            }
            out.append("  commit __forgive_" + fgv + "\n");
            out.append("__forgive_" + fgv + ":\n");
          }
        }
      }
    } else {
      sp_matcher(t.getChild(0), state, out);
    }
  }

  private void bitmap_set
    (byte[] map, int from, int until)
  {
    for (; from < until+1; from++) {
      map[ from/8 ] |= (byte)(1<<(from%8));
    }
  }

  private void sp_set
    (TreeNode t, CompilerState state, StringBuffer out)
  {
    int i=0;
    boolean invert = false;
    byte[] map = new byte[ 32 ];

    if (t.getChild(0).getSlot() == Slotmap.SLOT_SET_SETNOT) {
      if (t.getChild(0).getContent().equals("^")) {
        invert = true;
        ++i;
      }
    }
    for (; i < t.getChildCount(); i++) {
      if (t.getChild(i).getSlot() == Slotmap.SLOT_SET_NRTV) {
        String from = t.getChild(i++).getContent();
        String until = t.getChild(i).getContent();
        bitmap_set(map, (int)(from.charAt(0)), (int)(until.charAt(0)));
      } else if (t.getChild(i).getSlot() == Slotmap.SLOT_SET_NRTV_2) {
        String chr = t.getChild(i).getContent();
        bitmap_set(map, (int)(chr.charAt(0)), (int)(chr.charAt(0)));
      }
    }
    if (invert) {
      for (i=0; i < map.length; i++) {
        map[ i ] = (byte)((~map[ i ]) & 0xff);
      }
    }
    for (i=0; i < map.length; i++) {
      out.append(String.format("%02x", map[i]));
    }
  }

  private void sp_matcher
    (TreeNode t, CompilerState state, StringBuffer out)
  {
    t = t.getChild(0);
    switch (t.getSlot()) {
    case Slotmap.SLOT_MATCHER_ANY:
      out.append("  any\n");
      break;
    case Slotmap.SLOT_MATCHER_SET:
      out.append("  set ");
      sp_set(t.getChild(0), state, out);
      out.append("\n");
      break;
    case Slotmap.SLOT_MATCHER_STRING:
      byte[] b = t.getContent().getBytes();
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
      {
        int slot = state.getCapture(t);
        out.append("  opencapture " + slot + "\n");
        sp_expression(t.getChild(0).getChild(0), state, out);
        out.append("  closecapture " + slot + "\n");
      }
      break;
    case Slotmap.SLOT_MATCHER_GROUP:
      sp_expression(t.getChild(0).getChild(0), state, out);
      break;
    case Slotmap.SLOT_MATCHER_MACRO:
      break;
    case Slotmap.SLOT_MATCHER_VARREFERENCE:
      break;
    case Slotmap.SLOT_MATCHER_REFERENCE:
      out.append("  " + t.getContent() + "\n");
      break;
    }
  }
}

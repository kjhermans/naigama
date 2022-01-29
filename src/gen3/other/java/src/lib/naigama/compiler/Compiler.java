package lib.naigama.compiler;

import lib.naigama.NaigamaException;
import lib.naigama.compiler.Grammar;
import lib.naigama.compiler.NaigamaCompilerError;
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
    t.eviscerate(Slotmap.SLOT_S_);
    t.eviscerate(Slotmap.SLOT___PREFIX_);
    t.eviscerate(Slotmap.SLOT_COMMENT_);
    t.eviscerate(Slotmap.SLOT_END_);
    t.eviscerate(Slotmap.SLOT_LEFTARROW_);
    t.eviscerate(Slotmap.SLOT_OR_);
    t.eviscerate(Slotmap.SLOT_BOPEN_);
    t.eviscerate(Slotmap.SLOT_BCLOSE_);
    t.eviscerate(Slotmap.SLOT_CBOPEN_);
    t.eviscerate(Slotmap.SLOT_CBCLOSE_);
    t.eviscerate(Slotmap.SLOT_ABOPEN_);
    t.eviscerate(Slotmap.SLOT_ABCLOSE_);
    t.eviscerate(Slotmap.SLOT_COLON_);
    compile(t, assembly, options);
  }

  private void compile
    (TreeNode t, StringBuffer out, CompilerOptions options)
    throws NaigamaException
  {
    CompilerState state = new CompilerState();
    state.options = options;
    if (t.getChildCount() == 1
        && t.getChild(0).getSlot() == Slotmap.SLOT_GRAMMAR_)
    {
      t = t.getChild(0);
    }
    top(t, state, out);
    if (state.firstrule != null) {
      out.insert(0, "  call __RULE_" + state.firstrule + "\n  end 0\n\n");
    }
    out.append("  end 0\n");
  }

  private void top
    (TreeNode t, CompilerState state, StringBuffer out)
    throws NaigamaException
  {
    for (int i=0; i < t.getChildCount(); i++) {
      TreeNode child = t.getChild(i);
      if (child.getSlot() == Slotmap.SLOT_DEFINITION_) {
        definition(child, state, out);
      } else if (child.getSlot() == Slotmap.SLOT_SINGLE_EXPRESSION_) {
        state.currentrule = "DEFAULT";
        expression(child.firstChild(), state, out);
      }
    }
  }

  private void definition
    (TreeNode t, CompilerState state, StringBuffer out)
    throws NaigamaException
  {
    if (t.getChildCount() == 1
        && t.getChild(0).getSlot() == Slotmap.SLOT_RULE_)
    {
      rule(t.getChild(0), state, out);
    }
  }

  private void rule
    (TreeNode t, CompilerState state, StringBuffer out)
    throws NaigamaException
  {
    int rulecapture = -1;
    String rulename = t.getChild(0).getContent();
    if (state.firstrule == null) {
      state.firstrule = rulename;
    }
    TreeNode expression = t.getChild(1);
    if (state.options.generate_traps) {
      out.append("  trap\n");
    }
    out.append("__RULE_" + rulename + ":\n");
    if (state.options.generate_captureperrule) {
      rulecapture = state.getCapture(t);
      out.append("  opencapture " + rulecapture + "\n");
    }
    state.currentrule = t.firstChild().getContent();
    expression(expression, state, out);
    if (state.options.generate_captureperrule) {
      out.append("  closecapture " + rulecapture + "\n");
    }
    out.append("  ret -- from rule " + rulename + "\n");
    if (state.options.generate_traps) {
      out.append("  trap\n");
    }
    out.append("\n");
  }

  private void expression
    (TreeNode t, CompilerState state, StringBuffer out)
    throws NaigamaException
  {
    if (state.options.debug) {
      System.err.println("EXPRESSION\n" + t);
    }
    if (t.firstChild().getSlot() == Slotmap.SLOT_ALTERNATIVES_)
    {
      String label1 = "__" + state.currentrule + "_catch_" +(++(state.counter));
      String label2 = "__" + state.currentrule + "_out_" + (++(state.counter));
      out.append("  catch " + label1 + "\n");
      terms(t.firstChild().firstChild(), state, out);
      out.append("  commit " + label2 + "\n");
      out.append(label1 + ":\n");
      expression(t.firstChild().lastChild(), state, out);
      out.append(label2 + ":\n");
    } else if (t.getChildCount() == 1
               && t.getChild(0).getSlot() == Slotmap.SLOT_TERMS_)
    {
      terms(t.getChild(0), state, out);
    } else {
      System.err.println("Unexpected token in expression ("
        + t.getChild(0).getSlot() + ")" + t
      );
    }
  }

  private void terms
    (TreeNode t, CompilerState state, StringBuffer out)
    throws NaigamaException
  {
    if (state.options.debug) {
      System.err.println("TERMS\n" + t);
    }
    for (int i=0; i < t.getChildCount(); i++) {
      if (t.getChild(i).getSlot() == Slotmap.SLOT_TERM_) {
        term(t.getChild(i), state, out);
      }
    }
  }

  private void term
    (TreeNode t, CompilerState state, StringBuffer out)
    throws NaigamaException
  {
    if (state.options.debug) {
      System.err.println("TERM\n" + t);
    }
    t = t.firstChild();
    if (t.getSlot() == Slotmap.SLOT_SCANMATCHER_) {
      int lab = (state.counter++);
      out.append("  catch __scan_" + lab + "\n");
      matcher(t.getChild(1), state, out);
      if (t.getChild(0).getContent().equals("&")) {
        out.append("  backcommit __scan_out_" + lab + "\n");
        out.append("__scan_" + lab + ":\n");
        out.append("  fail\n");
        out.append("__scan_out_" + lab + ":\n");
      } else {
        out.append("  failtwice\n");
        out.append("__scan_" + lab + ":\n");
      }
    } else if (t.lastChild().getSlot()
               == Slotmap.SLOT_QUANTIFIER_)
    {
      int[] quant = resolve_quantifier(t.lastChild());
      switch (quant[ 0 ]) {
      case 0: break;
      case 1: matcher(t.firstChild(), state, out); break;
      default:
        if (state.options.writeloops) {
          for (int i=0; i < quant[ 0 ]; i++) {
            matcher(t.getChild(0), state, out);
          }
        } else {
          int reg = state.reg++;
          int lab = state.counter++;
          out.append("  counter " + reg + " " + quant[ 0 ] + "\n");
          out.append("__loop_" + lab + ":\n");
          matcher(t.getChild(0), state, out);
          out.append("  condjump " + reg + " __loop_" + lab + "\n");
        }
      }
      if (quant[ 1 ] == -1) {
        int fgv = state.counter++;
        int lab = state.counter++;
        out.append("  catch __forgive_" + fgv + "\n");
        out.append("__loop_" + lab + ":\n");
        matcher(t.getChild(0), state, out);
        out.append("  partialcommit __loop_" + lab + "\n");
        out.append("__forgive_" + fgv + ":\n");
      } else {
        int diff = quant[ 1 ] - quant[ 0 ];
        if (diff < 0) {
          throw new NaigamaCompilerError("Quantifier range invalid");
        }
        if (diff > 0) {
          int fgv = state.counter++;
          out.append("  catch __forgive_" + fgv + "\n");
          if (diff == 1) {
            matcher(t.getChild(0), state, out);
          } else {
            if (state.options.writeloops) {
              for (int i=0; i < diff; i++) {
                matcher(t.getChild(0), state, out);
              }
            } else {
              int reg = state.reg++;
              int lab = state.counter++;
              out.append("  counter " + reg + " " + diff + "\n");
              out.append("__loop_" + lab + ":\n");
              matcher(t.getChild(0), state, out);
              out.append("  partialcommit __NEXT__\n");
              out.append("  condjump " + reg + " __loop_" + lab + "\n");
            }
          }
          out.append("  commit __forgive_" + fgv + "\n");
          out.append("__forgive_" + fgv + ":\n");
        }
      }
    } else {
      matcher(t.getChild(0), state, out);
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
System.err.println(t);
      if (t.firstChild().getChildCount() == 2) {
        return new int[]{
          Integer.parseInt(t.getChild(0).getChild(0).getContent()),
          Integer.parseInt(t.getChild(0).getChild(1).getContent())
        };
      } else {
        switch (t.firstChild().getSlot()) {
        case Slotmap.SLOT_Q_UNTIL_: // until
          return new int[]{
            0,
            Integer.parseInt(t.firstChild().firstChild().getContent())
          };
        case Slotmap.SLOT_Q_FROM_: // from
          return new int[]{
            Integer.parseInt(t.firstChild().firstChild().getContent()),
            -1
          };
        case Slotmap.SLOT_Q_SPECIFIC_: // abs
          return new int[]{
            Integer.parseInt(t.firstChild().firstChild().getContent()),
            Integer.parseInt(t.firstChild().firstChild().getContent())
          };
        }
      }
      return null;
    }
  }

  private void bitmap_set
    (byte[] map, int from, int until)
  {
    for (; from < until+1; from++) {
      map[ from/8 ] |= (byte)(1<<(from%8));
    }
  }

  private void bitmap_set
    (byte[] map, int from)
  {
    bitmap_set(map, from, from);
  }

  private int set_unescape
    (String atom)
    throws NaigamaException
  {
    if (atom.length() == 1) {
      return (int)(atom.charAt(0));
    } else if (atom.charAt(0) == '\\') {
      if (atom.equals("\\\\")) {
        return 92;
      } else if (atom.equals("\\]")) {
        return 93;
      } else if (atom.equals("\\n")) {
        return 10;
      } else if (atom.equals("\\r")) {
        return 13;
      } else if (atom.equals("\\t")) {
        return 9;
      } else if (atom.equals("\\v")) {
        return 11;
      } else {
//.. TODO The numeric escapes
      }
    }
    throw new NaigamaCompilerError(
      "Unknown escape sequence in set atom '" + atom + "'"
    );
  }

  private void set
    (TreeNode t, CompilerState state, StringBuffer out)
    throws NaigamaException
  {
    int i=0;
    boolean invert = false;
    byte[] map = new byte[ 32 ];

    if (state.options.debug) {
      System.err.println("SET\n" + t);
    }
    if (t.getChild(0).getSlot() == Slotmap.SLOT_SETNOT_) {
      if (t.getChild(0).getContent().equals("^")) {
        invert = true;
        ++i;
      }
    }
    for (; i < t.getChildCount(); i++) {
      if (t.getChild(i).getSlot() == Slotmap.SLOT_SET_NRTV) {
        int from = set_unescape(t.getChild(i++).getContent());
        int until = set_unescape(t.getChild(i).getContent());
        bitmap_set(map, from, until);
      } else if (t.getChild(i).getSlot() == Slotmap.SLOT_SET_NRTV_2) {
        int chr = set_unescape(t.getChild(i).getContent());
        bitmap_set(map, chr, chr);
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

  private void string
    (byte[] str, int len, StringBuffer out, boolean caseinsensitive)
    throws NaigamaException
  {
    for (int i=1; i < len; i++) {
      if ((char)(str[ i ]) == '\\') {
        switch ((char)(str[ i+1 ])) {
        case 'n': out.append("  char 0a\n"); break;
        case 'r': out.append("  char 0d\n"); break;
        case 't': out.append("  char 09\n"); break;
        case 'v': out.append("  char 0b\n"); break;
        case '\'': out.append("  char 27\n"); break;
        case '\\': out.append("  char 5c\n"); break;
        default:
          throw new NaigamaCompilerError(
            "Unknown escape \\" + (char)(str[ i+1 ])
          );
        }
        ++i;
      } else {
        if (caseinsensitive && str[ i ] >= 65 && str[ i ] <= 90) {
          byte[] map = new byte[ 32 ];
          bitmap_set(map, str[ i ]);
          bitmap_set(map, str[ i ] + 32);
          out.append("  set ");
          for (i=0; i < map.length; i++) {
            out.append(String.format("%02x", map[i]));
          }
          out.append("\n");
        } else if (caseinsensitive && str[ i ] >= 97 && str[ i ] <= 122) {
          byte[] map = new byte[ 32 ];
          bitmap_set(map, str[ i ]);
          bitmap_set(map, str[ i ] - 32);
          out.append("  set ");
          for (i=0; i < map.length; i++) {
            out.append(String.format("%02x", map[i]));
          }
          out.append("\n");
        } else {
          out.append("  char " + String.format("%02x ", str[ i ]) + "\n");
        }
      }
    }
  }

  private void matcher
    (TreeNode t, CompilerState state, StringBuffer out)
    throws NaigamaException
  {
    t = t.firstChild();
    if (state.options.debug) {
      System.err.println("MATCHER\n" + t);
    }
    switch (t.getSlot()) {
    case Slotmap.SLOT_ANY_:
      out.append("  any\n");
      break;
    case Slotmap.SLOT_SET_:
      out.append("  set ");
      set(t, state, out);
      out.append("\n");
      break;
    case Slotmap.SLOT_STRING_:
      byte[] b = t.getContent().getBytes();
      if (b[ b.length - 1 ] == (byte)'i') {
        string(b, b.length-2, out, true);
      } else {
        string(b, b.length-1, out, false);
      }
      break;
    case Slotmap.SLOT_BITMASK_:
      out.append(
        "  maskedchar " + t.getContent().substring(1, 3) +
        " " + t.getContent().substring(4, 6) + "\n"
      );
      break;
    case Slotmap.SLOT_HEXLITERAL_:
      out.append("  char " + t.getContent().substring(2, 4) + "\n");
      break;
    case Slotmap.SLOT_VARCAPTURE_:
      {
        String var = t.getChild(0).getChild(0).getContent();
        int slot = state.getCapture(t);
        state.varPut(var, slot);
        out.append("  opencapture " + slot + "\n");
        expression(t.getChild(0).getChild(1), state, out);
        out.append("  closecapture " + slot + "\n");
      }
      break;
    case Slotmap.SLOT_CAPTURE_:
      {
        int slot = state.getCapture(t);
        out.append("  opencapture " + slot + "\n");
        expression(t.getChild(0).getChild(0), state, out);
        out.append("  closecapture " + slot + "\n");
      }
      break;
    case Slotmap.SLOT_GROUP_:
      expression(t.getChild(0).getChild(0), state, out);
      break;
    case Slotmap.SLOT_MACRO_:
      {
        String macro = t.getChild(0).getContent();
        byte[] set = new byte[ 32 ];
        if (macro.equals("%s")) {
          bitmap_set(set, 9, 13);
          bitmap_set(set, 32, 32);
        } else if (macro.equals("%w")) {
          bitmap_set(set, 65, 90);
          bitmap_set(set, 97, 122);
        } else if (macro.equals("%n")) {
          bitmap_set(set, 48, 57);
        } else if (macro.equals("%a")) {
          bitmap_set(set, 48, 57);
          bitmap_set(set, 65, 90);
          bitmap_set(set, 97, 122);
        } else {
          throw new NaigamaCompilerError("Unknown macro '" + macro + "'");
        }
        out.append("  set ");
        for (int i=0; i < set.length; i++) {
          out.append(String.format("%02x", set[i]));
        }
        out.append("\n");
      }
      break;
    case Slotmap.SLOT_VARREFERENCE_:
      {
        String var = t.getChild(0).getChild(0).getContent();
        int slot = state.varGet(var);
        out.append("  var " + slot + "\n");
      }
      break;
    case Slotmap.SLOT_REFERENCE_:
      out.append("  call __RULE_" + t.getContent() + "\n");
      break;
    }
  }
}

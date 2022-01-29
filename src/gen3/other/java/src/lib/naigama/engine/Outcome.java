package lib.naigama.engine;

import java.util.Vector;

public class Outcome
{
  byte[]           input;
  int              exitcode;
  Vector<Capture>  captures;

  public int getExitCode
    ()
  {
    return exitcode;
  }

  public Vector<Capture> getCaptures
    ()
  {
    return captures;
  }

  public TreeNode getCaptureTree
    ()
  {
    return captures_to_tree(input, captures);
  }

  private static TreeNode captures_to_tree
    (byte[] input, Vector<Capture> captures)
  {
    TreeNode top = new TreeNode();
    top.slot = -1;
    top.offset = 0;
    top.content = new byte[ input.length ];
    System.arraycopy(input, 0, top.content, 0, input.length);
    _captures_to_tree(input, top, captures, 0);
    return top;
  }

  private static int _captures_to_tree
    (byte[] input, TreeNode parent, Vector<Capture> captures, int i)
  {
    for (; i < captures.size(); i++) {
      Capture c0 = captures.elementAt(i);
      if (c0.offset >= parent.offset + parent.content.length) { return i; }
      if (c0.type != Capture.TYPE_CAPTURE) { continue; }
      if (c0.offset >= parent.offset && c0.length <= parent.content.length) {
        TreeNode child = new TreeNode();
        child.parent = parent;
        child.slot = c0.slot;
        child.offset = c0.offset;
        child.content = new byte[ c0.length ];
        System.arraycopy(input, c0.offset, child.content, 0, c0.length);
        if (parent.children == null) {
          parent.children = new Vector<TreeNode>();
        }
        parent.children.addElement(child);
        i = _captures_to_tree(input, child, captures, ++i);
        --i;
      }
    }
    return i;
  }

  public String toString
    ()
  {
    String result = "Exitcode: " + exitcode + "\n";
    for (int i=0; i < captures.size(); i++) {
      Capture c = captures.elementAt(i);
      result += "#" + i + "; " + c + "\n";
    }
    return result;
  }
}

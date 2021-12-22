package lib.naigama.engine;

import java.util.Vector;

public class TreeNode
{
  int               slot;
  int               offset;
  byte[]            content = null;
  TreeNode          parent = null;
  Vector<TreeNode>  children = null;
  public String     assoc = null;

  public int getSlot() { return slot; }
  public int getOffset() { return offset; }
  public String getContent() { try { return new String(content, "ISO-8859-1"); } catch (Exception e) { return ""; } }
  public int getChildCount() { return children.size(); }
  public TreeNode getChild(int i) { return children.elementAt(i); }

  public void eviscerate
    (int slot)
  {
    if (children == null) { return; }
    for (int i=0; i < children.size(); i++) {
      TreeNode child = children.elementAt(i);
      if (child.slot == slot && child.children == null) {
        children.removeElementAt(i);
        --i;
      } else {
        child.eviscerate(slot);
      }
    }
  }

  public String toString
    ()
  {
    return _to_string(0, this);
  }

  String _to_string
    (int indent, TreeNode node)
  {
    String result = "";
    for (int i=0; i < indent; i++) { result += "  "; }
    result += "slt=" + node.slot + "; off=" + node.offset + "; " + node.getContent();
    if (node.children != null) {
      for (int i=0; i < node.children.size(); i++) {
        result += "\n" + node.children.elementAt(i)._to_string(indent + 1, node.children.elementAt(i));
      }
    }
    return result;
  }
}

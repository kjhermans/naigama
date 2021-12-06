package lib.naigama.compiler;

import java.util.Hashtable;

import lib.naigama.engine.TreeNode;

class CompilerState
{
  CompilerOptions               options;
  TreeNode                      currentrule;
  int                           currentcapture = 0;
  Hashtable<TreeNode,Integer>   capturemap = new Hashtable<TreeNode,Integer>();

  void addCapture
    (TreeNode t)
  {
    capturemap.put(t, new Integer(currentcapture));
    ++currentcapture;
  }

  int getCapture
    (TreeNode t)
  {
    return capturemap.get(t).intValue();
  }
}

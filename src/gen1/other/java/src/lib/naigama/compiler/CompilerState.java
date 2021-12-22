package lib.naigama.compiler;

import java.util.Hashtable;

import lib.naigama.engine.TreeNode;

class CompilerState
{
  CompilerOptions               options;
  int                           counter = 0;
  int                           slot = 0;
  int                           reg = 0;
  TreeNode                      currentrule;
  int                           currentcapture = 0;
  Hashtable<TreeNode,Integer>   capturemap = new Hashtable<TreeNode,Integer>();

  int getCapture
    (TreeNode t)
  {
    Integer i = capturemap.get(t);
    if (i == null) {
      i = new Integer(currentcapture++);
      capturemap.put(t, i);
    }
    return i.intValue();
  }
}

package lib.naigama.compiler;

import java.util.Hashtable;

import lib.naigama.engine.TreeNode;
import lib.naigama.NaigamaException;

class CompilerState
{
  CompilerOptions                     options;
  int                                 counter = 0;
  int                                 reg = 0;
  String                              currentrule = null;
  String                              firstrule = null;

  private int                         currentcapture = 0;
  private Hashtable<TreeNode,Integer> capturemap = new Hashtable<TreeNode,Integer>();
  private Hashtable<String,Integer>   varmap = new Hashtable<String,Integer>();

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

  void varPut
    (String varname, int slot)
  {
    varmap.put(varname, new Integer(slot));
  }

  int varGet
    (String varname)
    throws NaigamaException
  {
    Integer i = varmap.get(varname);
    if (i == null) {
      throw new NaigamaCompilerError("Cannot resolve variable reference '" + varname + "'");
    }
    return i.intValue();
  }
}

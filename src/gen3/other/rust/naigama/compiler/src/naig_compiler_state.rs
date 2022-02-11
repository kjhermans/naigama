use std::collections::HashMap;

use libnaie::naig_captree::NaigCapTree;
use crate::naig_compiler_options::NaigCompilerOptions;

pub struct NaigCompilerState
{
  pub counter     : u32,
  pub reg         : u32,
  pub slot        : u32,
  pub currentrule : String,
  pub firstrule   : String,
  pub output      : String,
  pub options     : NaigCompilerOptions,
  pub slotmap     : HashMap< usize, u32 >,
  pub varmap      : HashMap< String, u32 >,
  pub prefix      : bool,
}

impl NaigCompilerState
{
  pub fn new
    (options : NaigCompilerOptions)
    -> Self
  {
    Self {
      counter     : 0,
      reg         : 0,
      slot        : 0,
      currentrule : String::new(),
      firstrule   : String::new(),
      output      : String::new(),
      options     : options,
      slotmap     : HashMap::new(),
      varmap      : HashMap::new(),
      prefix      : false,
    }
  }

  pub fn append
    (& mut self, s : & str)
  {
    self.output = format!("{}{}", self.output, s.to_string());
  }

  pub fn append_string
    (& mut self, s : String)
  {
    self.output = format!("{}{}", self.output, s);
  }

  pub fn capture
    (& mut self, tree : & NaigCapTree)
    -> u32
  {
    let key = tree.id;
    let opt = self.slotmap.get(& key);
    match opt
    {
      Some(val) => return *val,
      None => {
        let myslot = self.slot;
        self.slot += 1;
        self.slotmap.insert(key, myslot);
        return myslot;
      }
    }
  }

  pub fn var_put
    (& mut self, varname : String, slot : u32)
  {
    self.varmap.insert(varname, slot);
  }

  pub fn var_get
    (& self, varname : String)
    -> Option< u32 >
  {
    let opt = self.varmap.get(& varname);
    match opt
    {
      Some(ret) => return Some(*ret),
      None => return None,
    }
  }
}

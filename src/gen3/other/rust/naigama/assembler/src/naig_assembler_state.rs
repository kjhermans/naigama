use std::collections::HashMap;

use libnaig::instructions::NaigInstruction;
use libnaig::naig_error::NaigError;

pub struct NaigAssemblerState
{
  pub labelmap : HashMap< String, u32 >,
  pub output   : Vec< u8 >,
}

impl NaigAssemblerState
{
  pub fn new
    ()
    -> Self
  {
    Self {
      labelmap : HashMap::new(),
      output   : Vec::new(),
    }
  }

  pub fn label_set
    (& mut self, label : String, offset : u32)
  {
    self.labelmap.insert(label, offset);
  }

  pub fn label_get
    (& self, label : String)
    -> Result< u32, NaigError >
  {
    let opt = self.labelmap.get(& label);
    match opt
    {
      Some(offset) => { return Ok( *offset ); },
      None => { return Err(NaigError::assembler(format!("Label '{}' not found", label))); },
    }
  }

  pub fn append_instr
    (& mut self, instr : NaigInstruction)
  {
    let i = instr as u32;
    self.append_unsigned(i);
  }

  pub fn append_unsigned
    (& mut self, i : u32)
  {
    let mut c : Vec<u8> = vec![ 0, 0, 0, 0 ];
    c[ 0 ] = ((i >> 24) & 0xff) as u8;
    c[ 1 ] = ((i >> 16) & 0xff) as u8;
    c[ 2 ] = ((i >> 8) & 0xff) as u8;
    c[ 3 ] = (i & 0xff) as u8;
    self.output.append(& mut c);
  }
}

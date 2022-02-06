use crate::naig_capture::NaigCapture;

pub struct NaigCapTree
{
  pub slot               : u32,
  pub id                 : usize,
  pub offset             : usize,
  pub content            : Vec< u8 >,
  pub children           : Vec< NaigCapTree >,
}

impl NaigCapTree
{
  pub fn new
    (input: & Vec< u8 >, caps: & Vec< NaigCapture >)
    -> NaigCapTree
  {
    let mut result = NaigCapTree {
      id       : 0,
      slot     : u32::MAX,
      content  : input.to_vec(),
      offset   : 0,
      children : Vec::new(),
    };
    let mut idcounter : usize = 1;
    NaigCapTree::_caps_to_tree(input, caps, 0, & mut result, & mut idcounter);
    return result;
  }

  fn _caps_to_tree
    (
      input     : & Vec< u8 >,
      caps      : & Vec< NaigCapture >,
      start     : usize,
      tree      : & mut NaigCapTree,
      idcounter : & mut usize,
    )
  {
    let mut last = tree.offset;

    for i in start .. caps.len()
    {
      if caps[ i ].offset >= tree.offset + tree.content.len()
      {
        return;
      }
      if caps[ i ].offset >= last
      {
        let cl = tree.children.len();

        tree.children.push(
          NaigCapTree {
            id       : *idcounter,
            slot     : caps[ i ].slot,
            offset   : caps[ i ].offset,
            content  : input[
                         caps[ i ].offset ..
                         caps[ i ].offset + caps[ i ].length
                       ].to_vec(),
            children : Vec::new(),
          }
        );
        *idcounter += 1;
        NaigCapTree::_caps_to_tree(
          input,
          caps,
          i+1,
          & mut tree.children[ cl ],
          idcounter,
        );
        last = caps[ i ].offset + caps[ i ].length;
      }
    }
  }

  pub fn debug
    (& self)
  {
    self._debug(0);
  }

  fn _debug
    (& self, indentlevel: usize)
  {
    for _i in 0 .. indentlevel
    {
      eprint!("  ");
    }
    eprint!("{} {}\n", self.slot, self.to_string());
    for i in 0 .. self.children.len()
    {
      self.children[ i ]._debug(indentlevel + 1);
    }
  }

  pub fn remove
    (& mut self, slot: u32)
  {
    let mut i=0;

    while i < self.children.len()
    {
      if self.children[ i ].slot == slot
         && self.children[ i ].children.len() == 0
      {
        self.children.remove(i);
      } else {
        self.children[ i ].remove(slot);
        i += 1;
      }
    }
  }

  pub fn first_child
    (& self)
    -> & NaigCapTree
  {
    return & self.children[ 0 ];
  }

  pub fn last_child
    (& self)
    -> & NaigCapTree
  {
    let l = self.children.len();
    return & self.children[ l-1 ];
  }

  pub fn to_string
    (& self)
    -> String
  {
    let mut result = String::new();
    for i in 0 .. self.content.len()
    {
      result.push( self.content[ i ] as char);
    }
    return result;
  }
}

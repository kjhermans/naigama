use crate::naig_capture::NaigCapture;

pub struct NaigCapTree
{
  pub slot               : u32,
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
      slot     : u32::MAX,
      content  : input.to_vec(),
      offset   : 0,
      children : Vec::new(),
    };

    NaigCapTree::_caps_to_tree(input, caps, 0, & mut result);
    return result;
  }

  fn _caps_to_tree
    (
      input: & Vec< u8 >,
      caps: & Vec< NaigCapture >,
      start: usize,
      tree: & mut NaigCapTree
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
            slot     : caps[ i ].slot,
            offset   : caps[ i ].offset,
            content  : input[
                         caps[ i ].offset ..
                         caps[ i ].offset + caps[ i ].length
                       ].to_vec(),
            children : Vec::new(),
          }
        );
        NaigCapTree::_caps_to_tree(
          input,
          caps,
          i+1,
          & mut tree.children[ cl ],
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
    eprint!("{} ", self.slot);
    for i in 0 .. self.content.len()
    {
      if self.content[ i ] >= 32 && self.content[ i ] < 127 {
        eprint!("{}", self.content[ i ] as char);
      } else {
//..
      }
    }
    eprint!("\n");
    for i in 0 .. self.children.len()
    {
      self.children[ i ]._debug(indentlevel + 1);
    }
  }

/*
  fn _pins_to_tree
    (
      input: & Vec< u8 >,
      pins: & Vec< NaigPinpoint >,
      start: usize,
      stop: usize,
      tree: & mut NaigCapTree
    )
  {
    let mut i = start;

    while i < stop {
      if pins[ i ].pintype
          == crate::naig_capture::NAIG_CAPTURE_OPEN
      {
        let mut j = i + 1;
        let mut l = 1;
        while j < pins.len() {
          if pins[ j ].pintype
              == crate::naig_capture::NAIG_CAPTURE_OPEN
          {
            l += 1;
          } else if pins[ j ].pintype
                     == crate::naig_capture::NAIG_CAPTURE_CLOSE
          {
            l -= 1;
            if l == 0 {
              let cl = tree.children.len();
              tree.children.push(
                NaigCapTree {
                  slot : pins[ i ].slot,
                  offset : pins[ i ].offset,
                  content : input[
                    pins[ i ].offset ..
                    pins[ j ].offset - pins[ i ].offset
                  ].to_vec(),
                  children : Vec::new(),
                }
              );
              NaigCapTree::_pins_to_tree(
                input,
                pins,
                i+1,
                j,
                & mut tree.children[ cl ],
              );
              break;
            }
          }
          j += 1;
        }
      }
      i += 1;
    }
  }
*/
}

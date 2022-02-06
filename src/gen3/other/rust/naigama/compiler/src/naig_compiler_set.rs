pub struct NaigCompilerSet
{
  bits : [ u8; 32 ],
}

impl NaigCompilerSet
{
  pub fn new
    ()
    -> Self
  {
    return Self {
      bits : [ 0; 32 ],
    };
  }

  pub fn set
    (& mut self, offset : usize)
  {
    self.bits[ offset / 8 ] |= 1 << (offset % 8);
  }

  pub fn set_range
    (& mut self, start : usize, stop : usize)
  {
    for i in start .. stop+1
    {
      self.set(i);
    }
  }

  pub fn invert
    (& mut self)
  {
    for i in 0 .. 32
    {
      self.bits[ i ] = !(self.bits[ i ]);
    }
  }

  pub fn to_string
    (& self)
    -> String
  {
    let mut result = "".to_string();
    for i in 0 .. 32
    {
      result = format!("{}{:2x}", result, self.bits[ i ]);
    }
    return result;
  }
}

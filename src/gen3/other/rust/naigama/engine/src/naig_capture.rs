pub struct NaigCapture
{
  pub captype            : u32,
  pub slot               : u32,
  pub offset             : usize,
  pub length             : usize,
}

pub const NAIG_CAPTURE_OPEN  : u32 = 1;
pub const NAIG_CAPTURE_CLOSE : u32 = 2;

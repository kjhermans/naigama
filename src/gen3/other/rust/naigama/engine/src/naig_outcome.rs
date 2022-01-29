use crate::naig_capture::NaigCapture;

pub struct NaigOutcome
{
  pub exitcode           : i32,
  pub captures           : Vec< NaigCapture >,
  pub instrcounter       : usize,
}

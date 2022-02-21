pub struct NaigCompilerOptions
{
  pub generate_traps : bool,
  pub capture_per_rule : bool,
}

impl NaigCompilerOptions
{
  pub fn new
    ()
    -> Self
  {
    Self {
      generate_traps : false,
      capture_per_rule : false,
    }
  }
}

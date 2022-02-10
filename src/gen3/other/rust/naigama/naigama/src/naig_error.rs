#![allow(non_upper_case_globals)]

pub struct NaigError
{
  pub code : i32,
  pub message : String,
}

impl NaigError
{
  pub fn simple
    (code: i32)
    -> Self
  {
    return Self {
      code : code,
      message : "".to_string(),
    };
  }

  pub fn new
    (code: i32, message: String)
    -> Self
  {
    return Self {
      code : code,
      message : message
    };
  }
 
  pub fn compiler
    (message: String)
    -> Self
  {
    return Self {
      code : NaigError::ErrCompiler,
      message : message
    };
  }
 
  pub fn assembler
    (message: String)
    -> Self
  {
    return Self {
      code : NaigError::ErrAssembler,
      message : message
    };
  }
 
  pub const ErrFailure       : i32 =  1;

  pub const ErrBadOpcode     : i32 = -1;
  pub const ErrOutOfRange    : i32 = -2;
  pub const ErrStack         : i32 = -3;
  pub const ErrState         : i32 = -4;
  pub const ErrTrapped       : i32 = -5;
  pub const ErrBytecode      : i32 = -6;
  pub const ErrVar           : i32 = -7;

  pub const ErrCompiler      : i32 = -33;

  pub const ErrAssembler     : i32 = -65;
}

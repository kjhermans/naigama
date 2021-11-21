
use crate::errors::NaigError;

#[allow(non_camel_case_types)]

pub enum NaigInstruction {

  INSTR_ANY = 0x000003e4,
  INSTR_BACKCOMMIT = 0x000403c0,
  INSTR_CALL = 0x00040382,
  INSTR_CATCH = 0x00040393,
  INSTR_CHAR = 0x000403d7,
  INSTR_CLOSECAPTURE = 0x00040300,
  INSTR_COMMIT = 0x00040336,
  INSTR_CONDJUMP = 0x00080321,
  INSTR_COUNTER = 0x00080356,
  INSTR_END = 0x000400d8,
  INSTR_ENDREPLACE = 0x00000399,
  INSTR_FAIL = 0x0000034b,
  INSTR_FAILTWICE = 0x00000390,
  INSTR_JUMP = 0x00040333,
  INSTR_MASKEDCHAR = 0x00080365,
  INSTR_NOOP = 0x00000000,
  INSTR_OPENCAPTURE = 0x0004039c,
  INSTR_PARTIALCOMMIT = 0x000403b4,
  INSTR_QUAD = 0x0004037e,
  INSTR_RANGE = 0x000803bd,
  INSTR_REPLACE = 0x00080348,
  INSTR_RET = 0x000003a0,
  INSTR_SET = 0x002003ca,
  INSTR_SKIP = 0x00040330,
  INSTR_SPAN = 0x002003e1,
  INSTR_TESTANY = 0x00040306,
  INSTR_TESTCHAR = 0x0008039a,
  INSTR_TESTQUAD = 0x000803db,
  INSTR_TESTSET = 0x00240363,
  INSTR_TRAP = 0xff00ffff,
  INSTR_VAR = 0x000403ee,


}

impl NaigInstruction {

  pub fn from_usize
    (n: usize)
    -> Result<NaigInstruction, NaigError>
  {
    match n {
      0x000003e4 => { return Ok(NaigInstruction::INSTR_ANY); },
      0x000403c0 => { return Ok(NaigInstruction::INSTR_BACKCOMMIT); },
      0x00040382 => { return Ok(NaigInstruction::INSTR_CALL); },
      0x00040393 => { return Ok(NaigInstruction::INSTR_CATCH); },
      0x000403d7 => { return Ok(NaigInstruction::INSTR_CHAR); },
      0x00040300 => { return Ok(NaigInstruction::INSTR_CLOSECAPTURE); },
      0x00040336 => { return Ok(NaigInstruction::INSTR_COMMIT); },
      0x00080321 => { return Ok(NaigInstruction::INSTR_CONDJUMP); },
      0x00080356 => { return Ok(NaigInstruction::INSTR_COUNTER); },
      0x000400d8 => { return Ok(NaigInstruction::INSTR_END); },
      0x00000399 => { return Ok(NaigInstruction::INSTR_ENDREPLACE); },
      0x0000034b => { return Ok(NaigInstruction::INSTR_FAIL); },
      0x00000390 => { return Ok(NaigInstruction::INSTR_FAILTWICE); },
      0x00040333 => { return Ok(NaigInstruction::INSTR_JUMP); },
      0x00080365 => { return Ok(NaigInstruction::INSTR_MASKEDCHAR); },
      0x00000000 => { return Ok(NaigInstruction::INSTR_NOOP); },
      0x0004039c => { return Ok(NaigInstruction::INSTR_OPENCAPTURE); },
      0x000403b4 => { return Ok(NaigInstruction::INSTR_PARTIALCOMMIT); },
      0x0004037e => { return Ok(NaigInstruction::INSTR_QUAD); },
      0x000803bd => { return Ok(NaigInstruction::INSTR_RANGE); },
      0x00080348 => { return Ok(NaigInstruction::INSTR_REPLACE); },
      0x000003a0 => { return Ok(NaigInstruction::INSTR_RET); },
      0x002003ca => { return Ok(NaigInstruction::INSTR_SET); },
      0x00040330 => { return Ok(NaigInstruction::INSTR_SKIP); },
      0x002003e1 => { return Ok(NaigInstruction::INSTR_SPAN); },
      0x00040306 => { return Ok(NaigInstruction::INSTR_TESTANY); },
      0x0008039a => { return Ok(NaigInstruction::INSTR_TESTCHAR); },
      0x000803db => { return Ok(NaigInstruction::INSTR_TESTQUAD); },
      0x00240363 => { return Ok(NaigInstruction::INSTR_TESTSET); },
      0xff00ffff => { return Ok(NaigInstruction::INSTR_TRAP); },
      0x000403ee => { return Ok(NaigInstruction::INSTR_VAR); },
      _ => { return Err(crate::errors::NaigError::ErrBadOpcode); }
    };
  }

  pub fn get_size
    (n: usize)
    -> Result<u32, NaigError>
  {
    match n {
      0x000003e4 => { return Ok(4); },
      0x000403c0 => { return Ok(8); },
      0x00040382 => { return Ok(8); },
      0x00040393 => { return Ok(8); },
      0x000403d7 => { return Ok(8); },
      0x00040300 => { return Ok(8); },
      0x00040336 => { return Ok(8); },
      0x00080321 => { return Ok(12); },
      0x00080356 => { return Ok(12); },
      0x000400d8 => { return Ok(8); },
      0x00000399 => { return Ok(4); },
      0x0000034b => { return Ok(4); },
      0x00000390 => { return Ok(4); },
      0x00040333 => { return Ok(8); },
      0x00080365 => { return Ok(12); },
      0x00000000 => { return Ok(4); },
      0x0004039c => { return Ok(8); },
      0x000403b4 => { return Ok(8); },
      0x0004037e => { return Ok(8); },
      0x000803bd => { return Ok(12); },
      0x00080348 => { return Ok(12); },
      0x000003a0 => { return Ok(4); },
      0x002003ca => { return Ok(36); },
      0x00040330 => { return Ok(8); },
      0x002003e1 => { return Ok(36); },
      0x00040306 => { return Ok(8); },
      0x0008039a => { return Ok(12); },
      0x000803db => { return Ok(12); },
      0x00240363 => { return Ok(40); },
      0xff00ffff => { return Ok(4); },
      0x000403ee => { return Ok(8); },
      _ => { return Err(crate::errors::NaigError::ErrBadOpcode); }
    };
  }
}

pub const _INSTR_SIZE_ANY: usize = 4;
pub const _INSTR_SIZE_BACKCOMMIT: usize = 8;
pub const _INSTR_SIZE_CALL: usize = 8;
pub const _INSTR_SIZE_CATCH: usize = 8;
pub const _INSTR_SIZE_CHAR: usize = 8;
pub const _INSTR_SIZE_CLOSECAPTURE: usize = 8;
pub const _INSTR_SIZE_COMMIT: usize = 8;
pub const _INSTR_SIZE_CONDJUMP: usize = 12;
pub const _INSTR_SIZE_COUNTER: usize = 12;
pub const _INSTR_SIZE_END: usize = 8;
pub const _INSTR_SIZE_ENDREPLACE: usize = 4;
pub const _INSTR_SIZE_FAIL: usize = 4;
pub const _INSTR_SIZE_FAILTWICE: usize = 4;
pub const _INSTR_SIZE_JUMP: usize = 8;
pub const _INSTR_SIZE_MASKEDCHAR: usize = 12;
pub const _INSTR_SIZE_NOOP: usize = 4;
pub const _INSTR_SIZE_OPENCAPTURE: usize = 8;
pub const _INSTR_SIZE_PARTIALCOMMIT: usize = 8;
pub const _INSTR_SIZE_QUAD: usize = 8;
pub const _INSTR_SIZE_RANGE: usize = 12;
pub const _INSTR_SIZE_REPLACE: usize = 12;
pub const _INSTR_SIZE_RET: usize = 4;
pub const _INSTR_SIZE_SET: usize = 36;
pub const _INSTR_SIZE_SKIP: usize = 8;
pub const _INSTR_SIZE_SPAN: usize = 36;
pub const _INSTR_SIZE_TESTANY: usize = 8;
pub const _INSTR_SIZE_TESTCHAR: usize = 12;
pub const _INSTR_SIZE_TESTQUAD: usize = 12;
pub const _INSTR_SIZE_TESTSET: usize = 40;
pub const _INSTR_SIZE_TRAP: usize = 4;
pub const _INSTR_SIZE_VAR: usize = 8;



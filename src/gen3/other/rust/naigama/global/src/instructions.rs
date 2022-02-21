
use crate::naig_error::NaigError;

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
  INSTR_ENDISOLATE = 0x00003005,
  INSTR_ENDREPLACE = 0x00000399,
  INSTR_FAIL = 0x0000034b,
  INSTR_FAILTWICE = 0x00000390,
  INSTR_INTRPCAPTURE = 0x0008000f,
  INSTR_ISOLATE = 0x00043003,
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
      0x00003005 => { return Ok(NaigInstruction::INSTR_ENDISOLATE); },
      0x00000399 => { return Ok(NaigInstruction::INSTR_ENDREPLACE); },
      0x0000034b => { return Ok(NaigInstruction::INSTR_FAIL); },
      0x00000390 => { return Ok(NaigInstruction::INSTR_FAILTWICE); },
      0x0008000f => { return Ok(NaigInstruction::INSTR_INTRPCAPTURE); },
      0x00043003 => { return Ok(NaigInstruction::INSTR_ISOLATE); },
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
      _ => { return Err(NaigError::simple(NaigError::ErrBadOpcode)); }
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
      0x00003005 => { return Ok(4); },
      0x00000399 => { return Ok(4); },
      0x0000034b => { return Ok(4); },
      0x00000390 => { return Ok(4); },
      0x0008000f => { return Ok(12); },
      0x00043003 => { return Ok(8); },
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
      _ => { return Err(NaigError::simple(NaigError::ErrBadOpcode)); }
    };
  }

  pub fn get_string
    (n: & NaigInstruction)
    -> &'static str
  {
    match n {
      NaigInstruction::INSTR_ANY => { return "any"; },
      NaigInstruction::INSTR_BACKCOMMIT => { return "backcommit"; },
      NaigInstruction::INSTR_CALL => { return "call"; },
      NaigInstruction::INSTR_CATCH => { return "catch"; },
      NaigInstruction::INSTR_CHAR => { return "char"; },
      NaigInstruction::INSTR_CLOSECAPTURE => { return "closecapture"; },
      NaigInstruction::INSTR_COMMIT => { return "commit"; },
      NaigInstruction::INSTR_CONDJUMP => { return "condjump"; },
      NaigInstruction::INSTR_COUNTER => { return "counter"; },
      NaigInstruction::INSTR_END => { return "end"; },
      NaigInstruction::INSTR_ENDISOLATE => { return "endisolate"; },
      NaigInstruction::INSTR_ENDREPLACE => { return "endreplace"; },
      NaigInstruction::INSTR_FAIL => { return "fail"; },
      NaigInstruction::INSTR_FAILTWICE => { return "failtwice"; },
      NaigInstruction::INSTR_INTRPCAPTURE => { return "intrpcapture"; },
      NaigInstruction::INSTR_ISOLATE => { return "isolate"; },
      NaigInstruction::INSTR_JUMP => { return "jump"; },
      NaigInstruction::INSTR_MASKEDCHAR => { return "maskedchar"; },
      NaigInstruction::INSTR_NOOP => { return "noop"; },
      NaigInstruction::INSTR_OPENCAPTURE => { return "opencapture"; },
      NaigInstruction::INSTR_PARTIALCOMMIT => { return "partialcommit"; },
      NaigInstruction::INSTR_QUAD => { return "quad"; },
      NaigInstruction::INSTR_RANGE => { return "range"; },
      NaigInstruction::INSTR_REPLACE => { return "replace"; },
      NaigInstruction::INSTR_RET => { return "ret"; },
      NaigInstruction::INSTR_SET => { return "set"; },
      NaigInstruction::INSTR_SKIP => { return "skip"; },
      NaigInstruction::INSTR_SPAN => { return "span"; },
      NaigInstruction::INSTR_TESTANY => { return "testany"; },
      NaigInstruction::INSTR_TESTCHAR => { return "testchar"; },
      NaigInstruction::INSTR_TESTQUAD => { return "testquad"; },
      NaigInstruction::INSTR_TESTSET => { return "testset"; },
      NaigInstruction::INSTR_TRAP => { return "trap"; },
      NaigInstruction::INSTR_VAR => { return "var"; },

    }
  }
}

pub const _INSTR_SIZE_ANY: u32 = 4;
pub const _INSTR_SIZE_BACKCOMMIT: u32 = 8;
pub const _INSTR_SIZE_CALL: u32 = 8;
pub const _INSTR_SIZE_CATCH: u32 = 8;
pub const _INSTR_SIZE_CHAR: u32 = 8;
pub const _INSTR_SIZE_CLOSECAPTURE: u32 = 8;
pub const _INSTR_SIZE_COMMIT: u32 = 8;
pub const _INSTR_SIZE_CONDJUMP: u32 = 12;
pub const _INSTR_SIZE_COUNTER: u32 = 12;
pub const _INSTR_SIZE_END: u32 = 8;
pub const _INSTR_SIZE_ENDISOLATE: u32 = 4;
pub const _INSTR_SIZE_ENDREPLACE: u32 = 4;
pub const _INSTR_SIZE_FAIL: u32 = 4;
pub const _INSTR_SIZE_FAILTWICE: u32 = 4;
pub const _INSTR_SIZE_INTRPCAPTURE: u32 = 12;
pub const _INSTR_SIZE_ISOLATE: u32 = 8;
pub const _INSTR_SIZE_JUMP: u32 = 8;
pub const _INSTR_SIZE_MASKEDCHAR: u32 = 12;
pub const _INSTR_SIZE_NOOP: u32 = 4;
pub const _INSTR_SIZE_OPENCAPTURE: u32 = 8;
pub const _INSTR_SIZE_PARTIALCOMMIT: u32 = 8;
pub const _INSTR_SIZE_QUAD: u32 = 8;
pub const _INSTR_SIZE_RANGE: u32 = 12;
pub const _INSTR_SIZE_REPLACE: u32 = 12;
pub const _INSTR_SIZE_RET: u32 = 4;
pub const _INSTR_SIZE_SET: u32 = 36;
pub const _INSTR_SIZE_SKIP: u32 = 8;
pub const _INSTR_SIZE_SPAN: u32 = 36;
pub const _INSTR_SIZE_TESTANY: u32 = 8;
pub const _INSTR_SIZE_TESTCHAR: u32 = 12;
pub const _INSTR_SIZE_TESTQUAD: u32 = 12;
pub const _INSTR_SIZE_TESTSET: u32 = 40;
pub const _INSTR_SIZE_TRAP: u32 = 4;
pub const _INSTR_SIZE_VAR: u32 = 8;



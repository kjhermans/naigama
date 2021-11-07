#![allow(unused_parens)]

mod instructions;
mod errors;

use instructions::NaigInstruction;
use errors::NaigError;

pub struct NaigEngine
{
  bytecode        : Vec< u8 >
}

pub struct NaigCapture
{
  offset          : usize,
  offsettype      : usize
}

pub struct NaigOutcome
{
  input_offset    : usize,
  bytecode_offset : usize,
  captures        : Vec< NaigCapture >
}

struct NaigEngineState
{
  engine          : & NaigEngine,
  input           : & Vec< u8 >,
  outcome         : & NaigOutcome,
  done            : bool
}

impl NaigEngine {

  pub fn new
    (bytecode: Vec< u8 >)
    -> NaigEngine
  {
    return NaigEngine {
      bytecode
    };
  }

  pub fn run
    (&self, input: & Vec< u8 >)
    -> Result<NaigOutcome, NaigError>
  {
    let mut outcome = NaigOutcome {
      input_offset: 0,
      bytecode_offset: 0,
      captures: Vec::new(),
    };
    let mut state = NaigEngineState {
      engine: self,
      input: input,
      outcome : & outcome,
      done: false
    };
    while (!(outcome.done)) {
      let r = NaigEngine::decode_opcode(
                & self.bytecode,
                outcome.bytecode_offset
              );
      match r
      {
        Ok(opcode) => match opcode
        {
          NaigInstruction::INSTR_ANY
            => NaigEngine::handle_any(input, & outcome),
          NaigInstruction::INSTR_BACKCOMMIT
            => NaigEngine::handle_backcommit(input, & outcome),
          NaigInstruction::INSTR_CALL
            => NaigEngine::handle_call(input, & outcome),
          NaigInstruction::INSTR_CATCH
            => NaigEngine::handle_catch(input, & outcome),
          NaigInstruction::INSTR_CHAR
            => NaigEngine::handle_char(input, & outcome),
          NaigInstruction::INSTR_CLOSECAPTURE
            => NaigEngine::handle_closecapture(input, & outcome),
          NaigInstruction::INSTR_COMMIT
            => NaigEngine::handle_commit(input, & outcome),
          NaigInstruction::INSTR_CONDJUMP
            => NaigEngine::handle_condjump(input, & outcome),
          NaigInstruction::INSTR_COUNTER
            => NaigEngine::handle_counter(input, & outcome),
          NaigInstruction::INSTR_END
            => NaigEngine::handle_end(input, & mut outcome),
          NaigInstruction::INSTR_ENDREPLACE
            => NaigEngine::handle_endreplace(input, & outcome),
          NaigInstruction::INSTR_FAIL
            => NaigEngine::handle_fail(input, & outcome),
          NaigInstruction::INSTR_FAILTWICE
            => NaigEngine::handle_failtwice(input, & outcome),
          NaigInstruction::INSTR_JUMP
            => NaigEngine::handle_jump(input, & outcome),
          NaigInstruction::INSTR_MASKEDCHAR
            => NaigEngine::handle_maskedchar(input, & outcome),
          NaigInstruction::INSTR_NOOP
            => NaigEngine::handle_noop(input, & outcome),
          NaigInstruction::INSTR_OPENCAPTURE
            => NaigEngine::handle_opencapture(input, & outcome),
          NaigInstruction::INSTR_PARTIALCOMMIT
            => NaigEngine::handle_partialcommit(input, & outcome),
          NaigInstruction::INSTR_QUAD
            => NaigEngine::handle_quad(input, & outcome),
          NaigInstruction::INSTR_RANGE
            => NaigEngine::handle_range(input, & outcome),
          NaigInstruction::INSTR_REPLACE
            => NaigEngine::handle_replace(input, & outcome),
          NaigInstruction::INSTR_RET
            => NaigEngine::handle_ret(input, & outcome),
          NaigInstruction::INSTR_SET
            => NaigEngine::handle_set(input, & outcome),
          NaigInstruction::INSTR_SKIP
            => NaigEngine::handle_skip(input, & outcome),
          NaigInstruction::INSTR_SPAN
            => NaigEngine::handle_span(input, & outcome),
          NaigInstruction::INSTR_TESTANY
            => NaigEngine::handle_testany(input, & outcome),
          NaigInstruction::INSTR_TESTCHAR
            => NaigEngine::handle_testchar(input, & outcome),
          NaigInstruction::INSTR_TESTQUAD
            => NaigEngine::handle_testquad(input, & outcome),
          NaigInstruction::INSTR_TESTSET
            => NaigEngine::handle_testset(input, & outcome),
          NaigInstruction::INSTR_TRAP
            => NaigEngine::handle_trap(input, & outcome),
          NaigInstruction::INSTR_VAR
            => NaigEngine::handle_var(input, & outcome)
        },
        Err(error) => { return Err(error); }
      };
    }
    return Ok(outcome);
  }

  fn decode_opcode
    (ar: & Vec< u8 >, off: usize)
    -> Result<NaigInstruction, NaigError>
  {
    let n = NaigEngine::decode_quad(ar, off);
    match n
    {
      Ok(opcode) => {
        let o = NaigInstruction::from_usize(opcode);
        match o
        {
          Ok(foo) => { return Ok(foo); },
          Err(foo) => { return Err(foo); }
        };
      },
      Err(error) => { return Err(error); }
    };
  }

  /**
   * 
   */
  fn decode_quad
    (ar: & Vec< u8 >, off: usize)
    -> Result<usize, NaigError>
  {
    if (off < ar.len() - 4) {
      let r:usize = (
          ( usize::from(ar[ off+1 ]) << 16 )
        | ( usize::from(ar[ off+2 ]) << 8 )
        | ( usize::from(ar[ off+3 ]) << 0 )
      );
      return Ok(r);
    } else {
      return Err(NaigError::ErrOutOfRange);
    }
  }

  fn handle_any
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_backcommit
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_call
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_catch
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_char
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_closecapture
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_commit
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_condjump
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_counter
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_end
    (input: & Vec< u8 >, outcome: & mut NaigOutcome)
    -> Result<bool, NaigError>
  {
    outcome.done = true;
    return Ok(true);
  }

  fn handle_endreplace
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_fail
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_failtwice
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_jump
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_maskedchar
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_noop
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_opencapture
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_partialcommit
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_quad
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_range
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_replace
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_ret
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_set
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_skip
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_span
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_testany
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_testchar
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_testquad
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_testset
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_trap
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_var
    (input: & Vec< u8 >, outcome: & NaigOutcome)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }



}

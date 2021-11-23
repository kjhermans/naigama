#![allow(unused_parens)]

mod instructions;
mod errors;

use instructions::NaigInstruction;
use errors::NaigError;

const STACKELT_TYPE_CLL: u32 = 1;
const STACKELT_TYPE_ALT: u32 = 2;

const NAIG_CAPTURE_OPEN: u32 = 1;
const NAIG_CAPTURE_CLOSE: u32 = 2;

pub struct NaigEngine
{
  bytecode        : Vec< u8 >
}

pub struct NaigCapture
{
  pub captype         : u32,
  pub slot            : u32,
  pub offset          : usize,
  pub length          : usize
}

pub struct NaigPinpoint
{
  pintype         : u32,
  slot            : u32,
  offset          : usize
}

pub struct NaigOutcome
{
  pub exitcode        : i32,
  pub captures        : Vec< NaigCapture >
}

struct NaigStackElt
{
  elttype         : u32,
  offset          : usize,
  ioffset         : usize,
  plength         : usize,
}

struct NaigCounter
{
  reg             : u32,
  value           : u32
}

struct NaigEngineState
<'a>
{
  engine          : &'a NaigEngine,
  bytecode_offset : usize,
  input           : &'a Vec< u8 >,
  input_offset    : usize,
  stack           : Vec< NaigStackElt >,
  counters        : Vec< NaigCounter >,
  pinpoints       : Vec< NaigPinpoint >,
  fail            : bool,
  done            : bool,
  exitcode        : i32,
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
    let mut instrcounter = 0;
    let mut outcome = NaigOutcome {
      exitcode : 0,
      captures : Vec::new()
    };
    let mut state = NaigEngineState {
      engine          : self,
      bytecode_offset : 0,
      input           : input,
      input_offset    : 0,
      stack           : Vec::new(),
      counters        : Vec::new(),
      pinpoints       : Vec::new(),
      fail            : false,
      done            : false,
      exitcode        : 0,
    };
    eprintln!("Running loop");
    while (!(state.done)) {
      instrcounter += 1;
eprint!("Instr #{} @{}: ", instrcounter, state.bytecode_offset);
      let r = NaigEngine::decode_opcode(
        & self.bytecode,
        state.bytecode_offset
      );
      match r
      {
        Ok(opcode) => match opcode
        {
          NaigInstruction::INSTR_ANY
            => NaigEngine::handle_any(& mut state),
          NaigInstruction::INSTR_BACKCOMMIT
            => NaigEngine::handle_backcommit(& mut state),
          NaigInstruction::INSTR_CALL
            => NaigEngine::handle_call(& mut state),
          NaigInstruction::INSTR_CATCH
            => NaigEngine::handle_catch(& mut state),
          NaigInstruction::INSTR_CHAR
            => NaigEngine::handle_char(& mut state),
          NaigInstruction::INSTR_CLOSECAPTURE
            => NaigEngine::handle_closecapture(& mut state),
          NaigInstruction::INSTR_COMMIT
            => NaigEngine::handle_commit(& mut state),
          NaigInstruction::INSTR_CONDJUMP
            => NaigEngine::handle_condjump(& mut state),
          NaigInstruction::INSTR_COUNTER
            => NaigEngine::handle_counter(& mut state),
          NaigInstruction::INSTR_END
            => NaigEngine::handle_end(& mut state),
          NaigInstruction::INSTR_ENDREPLACE
            => NaigEngine::handle_endreplace(& state),
          NaigInstruction::INSTR_FAIL
            => NaigEngine::handle_fail(& mut state),
          NaigInstruction::INSTR_FAILTWICE
            => NaigEngine::handle_failtwice(& mut state),
          NaigInstruction::INSTR_JUMP
            => NaigEngine::handle_jump(& mut state),
          NaigInstruction::INSTR_MASKEDCHAR
            => NaigEngine::handle_maskedchar(& state),
          NaigInstruction::INSTR_NOOP
            => NaigEngine::handle_noop(& mut state),
          NaigInstruction::INSTR_OPENCAPTURE
            => NaigEngine::handle_opencapture(& mut state),
          NaigInstruction::INSTR_PARTIALCOMMIT
            => NaigEngine::handle_partialcommit(& mut state),
          NaigInstruction::INSTR_QUAD
            => NaigEngine::handle_quad(& mut state),
          NaigInstruction::INSTR_RANGE
            => NaigEngine::handle_range(& mut state),
          NaigInstruction::INSTR_REPLACE
            => NaigEngine::handle_replace(& state),
          NaigInstruction::INSTR_RET
            => NaigEngine::handle_ret(& mut state),
          NaigInstruction::INSTR_SET
            => NaigEngine::handle_set(& mut state),
          NaigInstruction::INSTR_SKIP
            => NaigEngine::handle_skip(& mut state),
          NaigInstruction::INSTR_SPAN
            => NaigEngine::handle_span(& mut state),
          NaigInstruction::INSTR_TESTANY
            => NaigEngine::handle_testany(& state),
          NaigInstruction::INSTR_TESTCHAR
            => NaigEngine::handle_testchar(& state),
          NaigInstruction::INSTR_TESTQUAD
            => NaigEngine::handle_testquad(& state),
          NaigInstruction::INSTR_TESTSET
            => NaigEngine::handle_testset(& state),
          NaigInstruction::INSTR_TRAP
            => NaigEngine::handle_trap(& state),
          NaigInstruction::INSTR_VAR
            => NaigEngine::handle_var(& state)
        },
        Err(error) => {
          eprintln!("Error decoding opcode quad at {}", state.bytecode_offset);
          return Err(error);
        }
      };
      if (state.fail) {
eprintln!("FAIL!");
        while (state.stack.len() > 0) {
          if let Some(e) = state.stack.pop() {
            if (e.elttype == STACKELT_TYPE_ALT) {
              state.bytecode_offset = e.offset;
              state.input_offset = e.ioffset;
              state.fail = false;
              while state.pinpoints.len() > e.plength { state.pinpoints.pop(); }
              break;
            }
          }
        }
        if (state.stack.len() == 0) {
          return Err(NaigError::ErrFailure); // parsing failed.
        }
      }
    }
    outcome.exitcode = state.exitcode;
    NaigEngine::pins_to_captures(& state.pinpoints, & mut outcome.captures);
    return Ok(outcome);
  }

  fn pins_to_captures
    (pins: & Vec< NaigPinpoint >, caps: & mut Vec< NaigCapture >)
  {
    let mut i = 0;
eprintln!("Number of pinpoints: {}", pins.len());
    while (i < pins.len()) {
      if (pins[ i ].pintype == NAIG_CAPTURE_OPEN) {
        let mut j = i + 1;
        let mut l = 1;
        while (j < pins.len()) {
          if (pins[ j ].pintype == NAIG_CAPTURE_OPEN) {
            l += 1;
          } else if (pins[ j ].pintype == NAIG_CAPTURE_CLOSE) {
            l -= 1;
            if (l == 0) {
              caps.push(
                NaigCapture{
                  captype : NAIG_CAPTURE_OPEN,
                  slot    : pins[ i ].slot,
                  offset  : pins[ i ].offset,
                  length  : pins[ j ].offset - pins[ i ].offset,
                }
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
    if (off <= ar.len() - 4) {
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

  fn decode_quads
    (ar: & Vec< u8 >, off: usize, number: usize)
    -> Result<Vec<usize>, NaigError>
  {
    let mut result : Vec<usize> = Vec::new();
    let mut o = off;
    let mut n = number;

    while (n > 0) {
      if (o <= ar.len() - 4) {
        let r:usize = (
            ( usize::from(ar[ o+1 ]) << 16 )
          | ( usize::from(ar[ o+2 ]) << 8 )
          | ( usize::from(ar[ o+3 ]) << 0 )
        );
        result.push(r);
      } else {
        return Err(NaigError::ErrOutOfRange);
      }
      o += 4;
      n -= 1;
    }
    Ok(result)
  }

  fn handle_any
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("ANY");
    if (state.input_offset < state.input.len()) {
      state.input_offset += 1;
      state.bytecode_offset += instructions::_INSTR_SIZE_ANY;
    } else {
      state.fail = true;
    }
    return Ok(true);
  }

  fn handle_backcommit
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("BACKCOMMIT");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        if let Some(e) = state.stack.pop() {
          if (e.elttype == STACKELT_TYPE_ALT) {
            state.input_offset = e.ioffset;
            state.bytecode_offset = offset;
            while state.pinpoints.len() > e.plength { state.pinpoints.pop(); }
          } else {
            return Err(NaigError::ErrStack);
          }
        } else {
          return Err(NaigError::ErrStack);
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_call
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("CALL");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        state.stack.push(
          NaigStackElt{
            elttype : STACKELT_TYPE_CLL,
            offset  : state.bytecode_offset + instructions::_INSTR_SIZE_CALL,
            ioffset : 0,
            plength : state.pinpoints.len(),
          }
        );
        state.bytecode_offset = offset;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_catch
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("CATCH");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        state.stack.push(
          NaigStackElt{
            elttype : STACKELT_TYPE_ALT,
            offset  : offset,
            ioffset : state.input_offset,
            plength : state.pinpoints.len(),
          }
        );
        state.bytecode_offset += instructions::_INSTR_SIZE_CATCH;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_char
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("CHAR");
    if (state.input_offset >= state.input.len()) {
      state.fail = true;
    } else {
      let n = NaigEngine::decode_quad(
                & state.engine.bytecode,
                state.bytecode_offset + 4
              );
      match n
      {
        Ok(chr) => {
          if (state.input[ state.input_offset ] == chr as u8) {
            state.input_offset += 1;
            state.bytecode_offset += instructions::_INSTR_SIZE_CHAR;
          } else {
            state.fail = true;
          }
        },
        Err(error) => { return Err(error); }
      };
    }
    return Ok(true);
  }

  fn handle_closecapture
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("CLOSECAPTURE");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(slot) => {
        state.pinpoints.push(
          NaigPinpoint {
            pintype : NAIG_CAPTURE_CLOSE,
            slot    : slot as u32,
            offset  : state.input_offset
          }
        );
      },
      Err(error) => { return Err(error); }
    };
    state.bytecode_offset += instructions::_INSTR_SIZE_CLOSECAPTURE;
    return Ok(true);
  }

  fn handle_commit
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("COMMIT");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        if let Some(e) = state.stack.pop() {
          if (e.elttype == STACKELT_TYPE_ALT) {
            state.bytecode_offset = offset;
          } else {
            return Err(NaigError::ErrState);
          }
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn counter_push
    (state: & mut NaigEngineState, reg : usize, value : usize)
  {
    state.counters.insert(
      0,
      NaigCounter{ reg: reg as u32, value: value as u32}
    );
  }

  fn counter_resolve
    (state: & mut NaigEngineState, reg: usize)
    -> Result<usize, NaigError>
  {
    for i in 0 .. state.counters.len() {
      if state.counters[ i ].reg == reg as u32 {
        state.counters[ i ].value -= 1;
        return Ok(state.counters[ i ].value as usize);
      }
    }
    return Err(NaigError::ErrState);
  }

  fn handle_condjump
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("CONDJUMP");
    let n = NaigEngine::decode_quads(
              & state.engine.bytecode,
              state.bytecode_offset + 4,
              2
            );
    match n
    {
      Ok(params) => {
        let c = NaigEngine::counter_resolve(state, params[ 0 ]);
        match c
        {
          Ok(counter) => {
            if (counter > 0) {
              state.bytecode_offset = params[ 1 ];
            } else {
              state.bytecode_offset += instructions::_INSTR_SIZE_CONDJUMP;
            }
          },
          Err(error) => { return Err(error); }
        }
      },
      Err(error) => { return Err(error); }
    }
    return Ok(true);
  }

  fn handle_counter
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("COUNTER");
    let n = NaigEngine::decode_quads(
              & state.engine.bytecode,
              state.bytecode_offset + 4,
              2
            );
    match n
    {
      Ok(params) => {
        NaigEngine::counter_push(state, params[ 0 ], params[ 1 ]);
        state.bytecode_offset += instructions::_INSTR_SIZE_COUNTER;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_end
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("END");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(code) => {
        state.exitcode = code as i32;
        state.done = true;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_endreplace
    (state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("ENDREPLACE");
    return Ok(true);
  }

  fn handle_fail
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("FAIL");
    state.fail = true;
    return Ok(true);
  }

  fn handle_failtwice
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("FAILTWICE");
    if let Some(e) = state.stack.pop() {
      if (e.elttype == STACKELT_TYPE_ALT) {
        state.fail = true;
      } else {
        return Err(NaigError::ErrState);
      }
    }
    return Ok(true);
  }

  fn handle_jump
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("JUMP");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        state.bytecode_offset = offset;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_maskedchar
    (state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("MASKEDCHAR");
    return Ok(true);
  }

  fn handle_noop
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("NOOP");
    state.bytecode_offset += instructions::_INSTR_SIZE_NOOP;
    return Ok(true);
  }

  fn handle_opencapture
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("OPENCAPTURE");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(slot) => {
        state.pinpoints.push(
          NaigPinpoint {
            pintype : NAIG_CAPTURE_OPEN,
            slot    : slot as u32,
            offset  : state.input_offset
          }
        );
      },
      Err(error) => { return Err(error); }
    };
    state.bytecode_offset += instructions::_INSTR_SIZE_OPENCAPTURE;
    return Ok(true);
  }

  fn handle_partialcommit
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("PARTIALCOMMIT");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        let lastelt = state.stack.last_mut().unwrap(); // rewrite, no panic
        if (lastelt.elttype != STACKELT_TYPE_ALT) {
          return Err(NaigError::ErrStack);
        }
        lastelt.ioffset = state.input_offset;
        lastelt.plength = state.pinpoints.len();
        state.bytecode_offset = offset;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_quad
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("QUAD");
    if (state.bytecode_offset + instructions::_INSTR_SIZE_QUAD
        > state.engine.bytecode.len())
    {
      return Err(NaigError::ErrBytecode);
    }
    if (state.input_offset >= state.input.len() - 3) {
      state.fail = true;
    } else {
      for i in 0..3 {
        if state.input[ state.input_offset + i ]
           != state.engine.bytecode[ state.bytecode_offset + 4 + i ]
        {
          state.fail = true;
          break;
        }
      }
      if !state.fail {
        state.input_offset += 4;
        state.bytecode_offset += instructions::_INSTR_SIZE_QUAD;
      }
    }
    return Ok(true);
  }

  fn handle_range
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("RANGE");
    let n = NaigEngine::decode_quads(
              & state.engine.bytecode,
              state.bytecode_offset + 4,
              2
            );
    match n
    {
      Ok(params) => {
        if state.input_offset < state.input.len()
           && state.input[ state.input_offset ] >= params[ 0 ] as u8
           && state.input[ state.input_offset ] <= params[ 1 ] as u8
        {
          state.input_offset += 1;
          state.bytecode_offset += instructions::_INSTR_SIZE_RANGE;
        } else {
          state.fail = true;
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_replace
    (state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("REPLACE");
    return Ok(true);
  }

  fn handle_ret
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("RET");
    if let Some(e) = state.stack.pop() {
      if (e.elttype == STACKELT_TYPE_CLL) {
        state.bytecode_offset = e.offset;
      } else {
        return Err(NaigError::ErrState);
      }
    }
    return Ok(true);
  }

  fn handle_set
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("SET");
    if (state.input_offset >= state.input.len()) {
      state.fail = true;
      return Ok(true);
    }

    let setoff = state.bytecode_offset + 4;
    let bitoff = state.input[ state.input_offset ] as usize;

    if (state.bytecode_offset + instructions::_INSTR_SIZE_SET
        > state.engine.bytecode.len())
    {
      return Err(NaigError::ErrBytecode);
    }
    if (((state.engine.bytecode[ setoff + (bitoff / 8) ]
        >> (bitoff % 8)) & 0x01) == 0x01)
    {
      state.input_offset += 1;
      state.bytecode_offset += instructions::_INSTR_SIZE_SET;
    } else {
      state.fail = true;
    }
    return Ok(true);
  }

  fn handle_skip
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("SKIP");
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        if (state.input_offset <= state.input.len() - offset) {
          state.input_offset += offset;
          state.bytecode_offset += instructions::_INSTR_SIZE_SKIP;
        } else {
          state.fail = true;
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_span
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("SPAN");
    let setoff = state.bytecode_offset + 4;
    let bitoff = state.input[ state.input_offset ] as usize;

    if (state.bytecode_offset + instructions::_INSTR_SIZE_SPAN
        > state.engine.bytecode.len())
    {
      return Err(NaigError::ErrBytecode);
    }
    while (state.input_offset < state.input.len()
           && (((state.engine.bytecode[ setoff + (bitoff / 8) ]
               >> (bitoff % 8)) & 0x01) == 0x01))
    {
      state.input_offset += 1;
    }
    state.bytecode_offset += instructions::_INSTR_SIZE_SPAN;
    return Ok(true);
  }

  fn handle_testany
    (state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("TESTANY");
    return Ok(true);
  }

  fn handle_testchar
    (state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("TESTCHAR");
    return Ok(true);
  }

  fn handle_testquad
    (state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("TESTQUAD");
    return Ok(true);
  }

  fn handle_testset
    (state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("TESTSET");
    if (state.bytecode_offset + instructions::_INSTR_SIZE_TESTSET
        > state.engine.bytecode.len())
    {
      return Err(NaigError::ErrBytecode);
    }
    return Ok(true);
  }

  fn handle_trap
    (_state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
    return Err(NaigError::ErrTrapped);
  }

  fn handle_var
    (state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
eprintln!("VAR");
    return Ok(true);
  }
}

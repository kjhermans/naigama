use crate::instructions::NaigInstruction;
use crate::errors::NaigError;
use crate::naig_pinpoint::NaigPinpoint;
use crate::naig_capture::NaigCapture;
use crate::naig_outcome::NaigOutcome;

const STACKELT_TYPE_CLL  : u32 = 1;
const STACKELT_TYPE_ALT  : u32 = 2;

pub struct NaigEngine
{
  bytecode               : Vec< u8 >,
}

struct NaigStackElt
{
  elttype                : u32,
  offset                 : usize,
  ioffset                : usize,
  plength                : usize,
}

struct NaigCounter
{
  reg                    : u32,
  value                  : u32,
}

struct NaigEngineState
<'a>
{
  engine                 : &'a NaigEngine,
  bytecode_offset        : usize,
  input                  : &'a Vec< u8 >,
  input_offset           : usize,
  stack                  : Vec< NaigStackElt >,
  counters               : Vec< NaigCounter >,
  pinpoints              : Vec< NaigPinpoint >,
  fail                   : bool,
  done                   : bool,
  exitcode               : i32,
}

impl NaigEngine
{
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
      exitcode     : 0,
      captures     : Vec::new(),
      instrcounter : 0,
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

    #[cfg(debug_assertions)]
    eprintln!("Running loop");

    while !(state.done) {
      outcome.instrcounter += 1;
      let r = NaigEngine::decode_opcode(
        & self.bytecode,
        state.bytecode_offset
      );
      match r
      {
        Ok(opcode) => {

          #[cfg(debug_assertions)]
          eprintln!(
            "{:06}: byc={:06}, inp={:06}, {}"
            , outcome.instrcounter
            , state.bytecode_offset
            , state.input_offset
            , NaigInstruction::get_string(& opcode)
          );

          match opcode {
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
            NaigInstruction::INSTR_ENDISOLATE
              => NaigEngine::handle_endisolate(& mut state),
            NaigInstruction::INSTR_ENDREPLACE
              => NaigEngine::handle_endreplace(& mut state),
            NaigInstruction::INSTR_FAIL
              => NaigEngine::handle_fail(& mut state),
            NaigInstruction::INSTR_FAILTWICE
              => NaigEngine::handle_failtwice(& mut state),
            NaigInstruction::INSTR_INTRPCAPTURE
              => NaigEngine::handle_intrpcapture(& mut state),
            NaigInstruction::INSTR_ISOLATE
              => NaigEngine::handle_isolate(& mut state),
            NaigInstruction::INSTR_JUMP
              => NaigEngine::handle_jump(& mut state),
            NaigInstruction::INSTR_MASKEDCHAR
              => NaigEngine::handle_maskedchar(& mut state),
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
              => NaigEngine::handle_replace(& mut state),
            NaigInstruction::INSTR_RET
              => NaigEngine::handle_ret(& mut state),
            NaigInstruction::INSTR_SET
              => NaigEngine::handle_set(& mut state),
            NaigInstruction::INSTR_SKIP
              => NaigEngine::handle_skip(& mut state),
            NaigInstruction::INSTR_SPAN
              => NaigEngine::handle_span(& mut state),
            NaigInstruction::INSTR_TESTANY
              => NaigEngine::handle_testany(& mut state),
            NaigInstruction::INSTR_TESTCHAR
              => NaigEngine::handle_testchar(& mut state),
            NaigInstruction::INSTR_TESTQUAD
              => NaigEngine::handle_testquad(& mut state),
            NaigInstruction::INSTR_TESTSET
              => NaigEngine::handle_testset(& mut state),
            NaigInstruction::INSTR_TRAP
              => NaigEngine::handle_trap(& state),
            NaigInstruction::INSTR_VAR
              => NaigEngine::handle_var(& mut state),
          }
        },
        Err(error) => {
          eprintln!("Error decoding opcode quad at {}", state.bytecode_offset);
          return Err(error);
        }
      };
      if state.fail {
        if NaigEngine::do_catch(& mut state) {
          state.fail = false;
        } else {
          return Err(NaigError::ErrFailure); // parsing failed.
        }
      }
    }
    outcome.exitcode = state.exitcode;
    NaigEngine::pins_to_captures(& state.pinpoints, & mut outcome.captures);
    return Ok(outcome);
  }

  fn do_catch
    (state: & mut NaigEngineState)
    -> bool
  {
    while state.stack.len() > 0
    {
      if let Some(e) = state.stack.pop()
      {
        if e.elttype == STACKELT_TYPE_ALT
        {
          state.bytecode_offset = e.offset;
          state.input_offset = e.ioffset;
          while state.pinpoints.len() > e.plength
          {
            state.pinpoints.pop();
          }
          return true;
        }
      }
    }
    return false;
  }

  fn pins_to_captures
    (pins: & Vec< NaigPinpoint >, caps: & mut Vec< NaigCapture >)
  {
    let mut i = 0;

    while i < pins.len()
    {
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
            if l == 0
            {
              caps.push(
                NaigCapture{
                  captype : crate::naig_capture::NAIG_CAPTURE_OPEN,
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
    if off <= ar.len() - 4
    {
      let r:usize =
          ( usize::from(ar[ off+1 ]) << 16 )
        | ( usize::from(ar[ off+2 ]) << 8 )
        | ( usize::from(ar[ off+3 ]) << 0 );
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

    while n > 0
    {
      if o <= ar.len() - 4
      {
        let r:usize =
            ( usize::from(ar[ o+1 ]) << 16 )
          | ( usize::from(ar[ o+2 ]) << 8 )
          | ( usize::from(ar[ o+3 ]) << 0 );
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
    if state.input_offset < state.input.len()
    {
      state.input_offset += 1;
      state.bytecode_offset += crate::instructions::_INSTR_SIZE_ANY;
    } else {
      state.fail = true;
    }
    return Ok(true);
  }

  fn handle_backcommit
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        if let Some(e) = state.stack.pop()
        {
          if e.elttype == STACKELT_TYPE_ALT
          {
            state.input_offset = e.ioffset;
            state.bytecode_offset = offset;
            while state.pinpoints.len() > e.plength
            {
              state.pinpoints.pop();
            }
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
            offset  : state.bytecode_offset
                        + crate::instructions::_INSTR_SIZE_CALL,
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
        state.bytecode_offset += crate::instructions::_INSTR_SIZE_CATCH;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_char
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    if state.input_offset >= state.input.len()
    {
      state.fail = true;
    } else {
      let n = NaigEngine::decode_quad(
                & state.engine.bytecode,
                state.bytecode_offset + 4
              );
      match n
      {
        Ok(chr) => {
          if state.input[ state.input_offset ] == chr as u8
          {
            state.input_offset += 1;
            state.bytecode_offset += crate::instructions::_INSTR_SIZE_CHAR;
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
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(slot) => {
        state.pinpoints.push(
          NaigPinpoint {
            pintype : crate::naig_capture::NAIG_CAPTURE_CLOSE,
            slot    : slot as u32,
            offset  : state.input_offset
          }
        );
      },
      Err(error) => { return Err(error); }
    };
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_CLOSECAPTURE;
    return Ok(true);
  }

  fn handle_commit
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        if let Some(e) = state.stack.pop() {
          if e.elttype == STACKELT_TYPE_ALT
          {
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
            if counter > 0
            {
              state.bytecode_offset = params[ 1 ];
            } else {
              state.bytecode_offset
                += crate::instructions::_INSTR_SIZE_CONDJUMP;
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
    let n = NaigEngine::decode_quads(
              & state.engine.bytecode,
              state.bytecode_offset + 4,
              2
            );
    match n
    {
      Ok(params) => {
        NaigEngine::counter_push(state, params[ 0 ], params[ 1 ]);
        state.bytecode_offset += crate::instructions::_INSTR_SIZE_COUNTER;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_end
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
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

  fn handle_endisolate
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_endreplace
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_ENDREPLACE;
    return Ok(true);
  }

  fn handle_fail
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.fail = true;
    return Ok(true);
  }

  fn handle_failtwice
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    if let Some(e) = state.stack.pop() {
      if e.elttype == STACKELT_TYPE_ALT {
        state.fail = true;
      } else {
        return Err(NaigError::ErrState);
      }
    } else {
      return Err(NaigError::ErrStack);
    }
    return Ok(true);
  }

  fn handle_intrpcapture
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_isolate
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    return Ok(true);
  }

  fn handle_jump
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
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
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_MASKEDCHAR;
    return Ok(true);
  }

  fn handle_noop
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_NOOP;
    return Ok(true);
  }

  fn handle_opencapture
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(slot) => {
        state.pinpoints.push(
          NaigPinpoint {
            pintype : crate::naig_capture::NAIG_CAPTURE_OPEN,
            slot    : slot as u32,
            offset  : state.input_offset
          }
        );
      },
      Err(error) => { return Err(error); }
    };
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_OPENCAPTURE;
    return Ok(true);
  }

  fn handle_partialcommit
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        let lastelt = state.stack.last_mut().unwrap(); // rewrite, no panic
        if lastelt.elttype != STACKELT_TYPE_ALT
        {
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
    if state.bytecode_offset + crate::instructions::_INSTR_SIZE_QUAD
        > state.engine.bytecode.len()
    {
      return Err(NaigError::ErrBytecode);
    }
    if state.input_offset >= state.input.len() - 3
    {
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
        state.bytecode_offset += crate::instructions::_INSTR_SIZE_QUAD;
      }
    }
    return Ok(true);
  }

  fn handle_range
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
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
          state.bytecode_offset += crate::instructions::_INSTR_SIZE_RANGE;
        } else {
          state.fail = true;
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(true);
  }

  fn handle_replace
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_REPLACE;
    return Ok(true);
  }

  fn handle_ret
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    if let Some(e) = state.stack.pop()
    {
      if e.elttype == STACKELT_TYPE_CLL
      {
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
    if state.input_offset >= state.input.len()
    {
      state.fail = true;
      return Ok(true);
    }

    let setoff = state.bytecode_offset + 4;
    let bitoff = state.input[ state.input_offset ] as usize;

    if state.bytecode_offset + crate::instructions::_INSTR_SIZE_SET
        > state.engine.bytecode.len()
    {
      return Err(NaigError::ErrBytecode);
    }
    if ((state.engine.bytecode[ setoff + (bitoff / 8) ]
        >> (bitoff % 8)) & 0x01) == 0x01
    {
      state.input_offset += 1;
      state.bytecode_offset += crate::instructions::_INSTR_SIZE_SET;
    } else {
      state.fail = true;
    }
    return Ok(true);
  }

  fn handle_skip
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        if state.input_offset <= state.input.len() - offset
        {
          state.input_offset += offset;
          state.bytecode_offset += crate::instructions::_INSTR_SIZE_SKIP;
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
    let setoff = state.bytecode_offset + 4;
    let bitoff = state.input[ state.input_offset ] as usize;

    if state.bytecode_offset + crate::instructions::_INSTR_SIZE_SPAN
        > state.engine.bytecode.len()
    {
      return Err(NaigError::ErrBytecode);
    }
    while state.input_offset < state.input.len()
          && (((state.engine.bytecode[ setoff + (bitoff / 8) ]
             >> (bitoff % 8)) & 0x01) == 0x01)
    {
      state.input_offset += 1;
    }
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_SPAN;
    return Ok(true);
  }

  fn handle_testany
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_TESTANY;
    return Ok(true);
  }

  fn handle_testchar
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_TESTCHAR;
    return Ok(true);
  }

  fn handle_testquad
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_TESTQUAD;
    return Ok(true);
  }

  fn handle_testset
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    if state.bytecode_offset + crate::instructions::_INSTR_SIZE_TESTSET
        > state.engine.bytecode.len()
    {
      return Err(NaigError::ErrBytecode);
    }
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_TESTSET;
    return Ok(true);
  }

  fn handle_trap
    (_state: & NaigEngineState)
    -> Result<bool, NaigError>
  {
    return Err(NaigError::ErrTrapped);
  }

  fn handle_var
    (state: & mut NaigEngineState)
    -> Result<bool, NaigError>
  {
    state.bytecode_offset += crate::instructions::_INSTR_SIZE_VAR;
    return Ok(true);
  }
}

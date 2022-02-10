use libnaig::naig_error::NaigError;
use libnaig::instructions::NaigInstruction;
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
  offset                 : u32,
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
  bytecode_offset        : u32,
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
    if bytecode.len() >= std::u32::MAX as usize
    {
      panic!("Bytecode too long.");
    }
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
      let r = NaigEngine::decode_opcode(& self.bytecode, state.bytecode_offset);
      let opcode : NaigInstruction;
      match r
      {
        Ok(o) => {

#[cfg(debug_assertions)]
eprintln!(
  "{:06}: byc={:06}, inp={:06}, {}"
  , outcome.instrcounter
  , state.bytecode_offset
  , state.input_offset
  , NaigInstruction::get_string(& o)
);

          opcode = o;
        },
        Err(error) => {
          eprintln!("Error decoding opcode at {}", state.bytecode_offset);
          return Err(error);
        }
      };
      let h = NaigEngine::handle_opcode(& mut state, opcode);
      match h
      {
        Ok(h) => h,
        Err(h) => {
          eprintln!("Error handling opcode at {}", state.bytecode_offset);
          return Err(h);
        }
      };
      if state.fail {
        if NaigEngine::do_catch(& mut state) {
          state.fail = false;
        } else {
          return Err(NaigError::simple(NaigError::ErrFailure)); // parsing failed.
        }
      }
    }
    outcome.exitcode = state.exitcode;
    NaigEngine::pins_to_captures(& state.pinpoints, & mut outcome.captures);
    return Ok(outcome);
  }

  fn handle_opcode
    (state : & mut NaigEngineState, opcode : NaigInstruction)
    -> Result< (), NaigError>
  {
    match opcode {
      NaigInstruction::INSTR_ANY
        => NaigEngine::handle_any(state),
      NaigInstruction::INSTR_BACKCOMMIT
        => NaigEngine::handle_backcommit(state),
      NaigInstruction::INSTR_CALL
        => NaigEngine::handle_call(state),
      NaigInstruction::INSTR_CATCH
        => NaigEngine::handle_catch(state),
      NaigInstruction::INSTR_CHAR
        => NaigEngine::handle_char(state),
      NaigInstruction::INSTR_CLOSECAPTURE
        => NaigEngine::handle_closecapture(state),
      NaigInstruction::INSTR_COMMIT
        => NaigEngine::handle_commit(state),
      NaigInstruction::INSTR_CONDJUMP
        => NaigEngine::handle_condjump(state),
      NaigInstruction::INSTR_COUNTER
        => NaigEngine::handle_counter(state),
      NaigInstruction::INSTR_END
        => NaigEngine::handle_end(state),
      NaigInstruction::INSTR_ENDISOLATE
        => NaigEngine::handle_endisolate(state),
      NaigInstruction::INSTR_ENDREPLACE
        => NaigEngine::handle_endreplace(state),
      NaigInstruction::INSTR_FAIL
        => NaigEngine::handle_fail(state),
      NaigInstruction::INSTR_FAILTWICE
        => NaigEngine::handle_failtwice(state),
      NaigInstruction::INSTR_INTRPCAPTURE
        => NaigEngine::handle_intrpcapture(state),
      NaigInstruction::INSTR_ISOLATE
        => NaigEngine::handle_isolate(state),
      NaigInstruction::INSTR_JUMP
        => NaigEngine::handle_jump(state),
      NaigInstruction::INSTR_MASKEDCHAR
        => NaigEngine::handle_maskedchar(state),
      NaigInstruction::INSTR_NOOP
        => NaigEngine::handle_noop(state),
      NaigInstruction::INSTR_OPENCAPTURE
        => NaigEngine::handle_opencapture(state),
      NaigInstruction::INSTR_PARTIALCOMMIT
        => NaigEngine::handle_partialcommit(state),
      NaigInstruction::INSTR_QUAD
        => NaigEngine::handle_quad(state),
      NaigInstruction::INSTR_RANGE
        => NaigEngine::handle_range(state),
      NaigInstruction::INSTR_REPLACE
        => NaigEngine::handle_replace(state),
      NaigInstruction::INSTR_RET
        => NaigEngine::handle_ret(state),
      NaigInstruction::INSTR_SET
        => NaigEngine::handle_set(state),
      NaigInstruction::INSTR_SKIP
        => NaigEngine::handle_skip(state),
      NaigInstruction::INSTR_SPAN
        => NaigEngine::handle_span(state),
      NaigInstruction::INSTR_TESTANY
        => NaigEngine::handle_testany(state),
      NaigInstruction::INSTR_TESTCHAR
        => NaigEngine::handle_testchar(state),
      NaigInstruction::INSTR_TESTQUAD
        => NaigEngine::handle_testquad(state),
      NaigInstruction::INSTR_TESTSET
        => NaigEngine::handle_testset(state),
      NaigInstruction::INSTR_TRAP
        => NaigEngine::handle_trap(& state),
      NaigInstruction::INSTR_VAR
        => NaigEngine::handle_var(state),
    }
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
    (ar: & Vec< u8 >, off: u32)
    -> Result<NaigInstruction, NaigError>
  {
    let n = NaigEngine::decode_quad(ar, off);
    match n
    {
      Ok(opcode) => {
        let o = NaigInstruction::from_usize(opcode as usize);
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
    (ar: & Vec< u8 >, off: u32)
    -> Result<u32, NaigError>
  {
    let o = off as usize;
    if o <= ar.len() - 4
    {
      let r:u32 =
          ( u32::from(ar[ o+1 ]) << 16 )
        | ( u32::from(ar[ o+2 ]) << 8 )
        | ( u32::from(ar[ o+3 ]) << 0 );
      return Ok(r);
    } else {
      return Err(NaigError::simple(NaigError::ErrOutOfRange));
    }
  }

  fn decode_quads
    (ar: & Vec< u8 >, off: u32, number: usize)
    -> Result<Vec<u32>, NaigError>
  {
    let mut result : Vec<u32> = Vec::new();
    let mut o = off as usize;
    let mut n = number;

    while n > 0
    {
      if o <= ar.len() - 4
      {
        let r:u32 =
            ( u32::from(ar[ o+1 ]) << 16 )
          | ( u32::from(ar[ o+2 ]) << 8 )
          | ( u32::from(ar[ o+3 ]) << 0 );
        result.push(r);
      } else {
        return Err(NaigError::simple(NaigError::ErrOutOfRange));
      }
      o += 4;
      n -= 1;
    }
    Ok(result)
  }

  fn handle_any
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    if state.input_offset < state.input.len()
    {
      state.input_offset += 1;
      state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_ANY;
    } else {
      state.fail = true;
    }
    return Ok(());
  }

  fn handle_backcommit
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
            return Err(NaigError::simple(NaigError::ErrStack));
          }
        } else {
          return Err(NaigError::simple(NaigError::ErrStack));
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn handle_call
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
                        + libnaig::instructions::_INSTR_SIZE_CALL,
            ioffset : 0,
            plength : state.pinpoints.len(),
          }
        );
        state.bytecode_offset = offset;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn handle_catch
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
        state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_CATCH;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn handle_char
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
            state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_CHAR;
          } else {
            state.fail = true;
          }
        },
        Err(error) => { return Err(error); }
      };
    }
    return Ok(());
  }

  fn handle_closecapture
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_CLOSECAPTURE;
    return Ok(());
  }

  fn handle_commit
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
            return Err(NaigError::simple(NaigError::ErrState));
          }
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn counter_push
    (state: & mut NaigEngineState, reg : u32, value : u32)
  {
    state.counters.insert(
      0,
      NaigCounter{ reg: reg, value: value }
    );
  }

  fn counter_resolve
    (state: & mut NaigEngineState, reg: u32)
    -> Result<usize, NaigError>
  {
    for i in 0 .. state.counters.len() {
      if state.counters[ i ].reg == reg as u32 {
        state.counters[ i ].value -= 1;
        if state.counters[ i ].value == 0
        {
          state.counters.remove(i);
          return Ok(0);
        } else {
          return Ok(state.counters[ i ].value as usize);
        }
      }
    }
    return Err(NaigError::simple(NaigError::ErrState));
  }

  fn handle_condjump
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
                += libnaig::instructions::_INSTR_SIZE_CONDJUMP;
            }
          },
          Err(error) => { return Err(error); }
        }
      },
      Err(error) => { return Err(error); }
    }
    return Ok(());
  }

  fn handle_counter
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
        state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_COUNTER;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn handle_end
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
    return Ok(());
  }

  fn handle_endisolate
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_ENDISOLATE;
    return Ok(());
  }

  fn handle_endreplace
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_ENDREPLACE;
    return Ok(());
  }

  fn handle_fail
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.fail = true;
    return Ok(());
  }

  fn handle_failtwice
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    if let Some(e) = state.stack.pop() {
      if e.elttype == STACKELT_TYPE_ALT {
        state.fail = true;
      } else {
        return Err(NaigError::simple(NaigError::ErrState));
      }
    } else {
      return Err(NaigError::simple(NaigError::ErrStack));
    }
    return Ok(());
  }

  fn handle_intrpcapture
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_INTRPCAPTURE;
    return Ok(());
  }

  fn handle_isolate
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(slot) => {
        let mut i = state.pinpoints.len();
        while i > 0
        {
          if state.pinpoints[ i-1 ].slot == slot as u32 &&
             state.pinpoints[ i-1 ].pintype
              == crate::naig_capture::NAIG_CAPTURE_CLOSE
          {
            let mut j = i-1;
            while j > 0
            {
              if state.pinpoints[ j-1 ].slot == slot as u32 &&
                 state.pinpoints[ j-1 ].pintype
                  == crate::naig_capture::NAIG_CAPTURE_OPEN
              {
                //..
              }
              j -= 1;
            }
          }
          i -= 1;
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn handle_jump
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
    return Ok(());
  }

  fn handle_maskedchar
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_MASKEDCHAR;
    return Ok(());
  }

  fn handle_noop
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_NOOP;
    return Ok(());
  }

  fn handle_opencapture
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_OPENCAPTURE;
    return Ok(());
  }

  fn handle_partialcommit
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
          return Err(NaigError::simple(NaigError::ErrStack));
        }
        lastelt.ioffset = state.input_offset;
        lastelt.plength = state.pinpoints.len();
        state.bytecode_offset = offset;
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn handle_quad
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    if state.bytecode_offset + libnaig::instructions::_INSTR_SIZE_QUAD
        > state.engine.bytecode.len() as u32
    {
      return Err(NaigError::simple(NaigError::ErrBytecode));
    }
    if state.input_offset >= state.input.len() - 3
    {
      state.fail = true;
    } else {
      for i in 0..3 {
        if state.input[ state.input_offset + i ]
           != state.engine.bytecode[ state.bytecode_offset as usize + 4 + i ]
        {
          state.fail = true;
          break;
        }
      }
      if !state.fail {
        state.input_offset += 4;
        state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_QUAD;
      }
    }
    return Ok(());
  }

  fn handle_range
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
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
          state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_RANGE;
        } else {
          state.fail = true;
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn handle_replace
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_REPLACE;
    return Ok(());
  }

  fn handle_ret
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    if let Some(e) = state.stack.pop()
    {
      if e.elttype == STACKELT_TYPE_CLL
      {
        state.bytecode_offset = e.offset;
      } else {
        return Err(NaigError::simple(NaigError::ErrState));
      }
    }
    return Ok(());
  }

  fn handle_set
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    if state.input_offset >= state.input.len()
    {
      state.fail = true;
      return Ok(());
    }

    let setoff = state.bytecode_offset + 4;
    let bitoff = state.input[ state.input_offset ] as usize;

    if state.bytecode_offset + libnaig::instructions::_INSTR_SIZE_SET
        > state.engine.bytecode.len() as u32
    {
      return Err(NaigError::simple(NaigError::ErrBytecode));
    }
    if ((state.engine.bytecode[ setoff as usize + (bitoff / 8) ]
        >> (bitoff % 8)) & 0x01) == 0x01
    {
      state.input_offset += 1;
      state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_SET;
    } else {
      state.fail = true;
    }
    return Ok(());
  }

  fn handle_skip
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(offset) => {
        if state.input_offset <= state.input.len() - offset as usize
        {
          state.input_offset += offset as usize;
          state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_SKIP;
        } else {
          state.fail = true;
        }
      },
      Err(error) => { return Err(error); }
    };
    return Ok(());
  }

  fn handle_span
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    let setoff = state.bytecode_offset + 4;
    let bitoff = state.input[ state.input_offset ] as usize;

    if state.bytecode_offset + libnaig::instructions::_INSTR_SIZE_SPAN
        > state.engine.bytecode.len() as u32
    {
      return Err(NaigError::simple(NaigError::ErrBytecode));
    }
    while state.input_offset < state.input.len()
          && (((state.engine.bytecode[ setoff as usize + (bitoff / 8) ]
             >> (bitoff % 8)) & 0x01) == 0x01)
    {
      state.input_offset += 1;
    }
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_SPAN;
    return Ok(());
  }

  fn handle_testany
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_TESTANY;
    return Ok(());
  }

  fn handle_testchar
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_TESTCHAR;
    return Ok(());
  }

  fn handle_testquad
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_TESTQUAD;
    return Ok(());
  }

  fn handle_testset
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
    if state.bytecode_offset + libnaig::instructions::_INSTR_SIZE_TESTSET
        > state.engine.bytecode.len() as u32
    {
      return Err(NaigError::simple(NaigError::ErrBytecode));
    }
    state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_TESTSET;
    return Ok(());
  }

  fn handle_trap
    (_state: & NaigEngineState)
    -> Result< (), NaigError>
  {
    return Err(NaigError::simple(NaigError::ErrTrapped));
  }

  fn variable_get
    (state: & mut NaigEngineState, slot : u32)
    -> Result< Vec< u8 >, NaigError >
  {
    let mut i = state.pinpoints.len();
    while i > 0
    {
      let p1 = & state.pinpoints[ i-1 ];
      if p1.pintype == crate::naig_capture::NAIG_CAPTURE_CLOSE
         && p1.slot == slot
      {
        let end = p1.offset;
        while i > 0
        {
          let p0 = & state.pinpoints[ i-1 ];
          if p0.pintype == crate::naig_capture::NAIG_CAPTURE_OPEN
             && p0.slot == slot
          {
            let begin = p0.offset;
            let slice = & state.input[ begin .. end ];
            return Ok(slice.to_vec());
          }
          i -= 1;
        }
      }
      i -= 1;
    }
    return Err(NaigError::simple(NaigError::ErrVar));
  }

  fn handle_var
    (state: & mut NaigEngineState)
    -> Result< (), NaigError>
  {
        let n = NaigEngine::decode_quad(
              & state.engine.bytecode,
              state.bytecode_offset + 4
            );
    match n
    {
      Ok(slot) => {
        let res = NaigEngine::variable_get(state, slot);
        match res
        {
          Ok(var) => {
            if var.len() == 0
            {
              state.fail = true;
              return Ok(());
            }
            else if state.input_offset + var.len() <= state.input.len()
            {
              for i in 0 .. var.len()
              {
                if state.input[ state.input_offset + i ] != var[ i ]
                {
                  state.fail = true;
                  return Ok(());
                }
              }
              state.bytecode_offset += libnaig::instructions::_INSTR_SIZE_VAR;
              state.input_offset += var.len();
              return Ok(());
            }
            else
            {
              state.fail = true;
              return Ok(());
            }
          },
          Err(e) => { return Err(e); },
        }
      },
      Err(e) => { return Err(e); },
    };
  }
}

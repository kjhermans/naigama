use libnaie::naig_engine::NaigEngine;
use libnaie::naig_captree::NaigCapTree;
use libnaig::naig_error::NaigError;
use libnaig::instructions::NaigInstruction;
use crate::naig_assembler_state::NaigAssemblerState;

pub struct NaigAssembler
{
  engine : NaigEngine,
}

impl NaigAssembler
{
  pub fn new
    ()
    -> NaigAssembler
  {
    let bytes = include_bytes!("assembly.byc").to_vec();
    return NaigAssembler {
      engine : NaigEngine::new(bytes),
    };
  }

  pub fn assemble
    (& self, assembly : & String)
    -> Result< Vec<u8>, NaigError >
  {
    let bytes = assembly.as_bytes().to_vec();
    let r = self.engine.run(& bytes);
    match r {
      Ok(outcome) => {
        let mut state = NaigAssemblerState::new();
        let mut tree = NaigCapTree::new(& bytes, & outcome.captures);
        tree.remove(crate::naig_slotmap::_ASMSLT_S_);
        tree.remove(crate::naig_slotmap::_ASMSLT_COMMENT_);
        tree.remove(crate::naig_slotmap::_ASMSLT_MULTILINECOMMENT_);
        tree.remove(crate::naig_slotmap::_ASMSLT___PREFIX_);
        match NaigAssembler::assemble_top(& tree, & mut state)
        {
          Ok(_) => (), Err(e) => { return Err(e); }
        }
        return Ok(state.output);
      },
      Err(error) => { return Err(error); },
    }
  }

  fn assemble_top
    (tree : & NaigCapTree, state : & mut NaigAssemblerState)
    -> Result< (), NaigError >
  {
    let child = tree.first_child();
    match NaigAssembler::fp(child, state) { Ok(_) => (), Err(e) => { return Err(e); }}
    match NaigAssembler::sp(child, state) { Ok(_) => (), Err(e) => { return Err(e); }}
    return Ok(());
  }

  fn fp
    (tree : & NaigCapTree, state : & mut NaigAssemblerState)
    -> Result< (), NaigError >
  {
    let mut offset : u32 = 0;
    let child = tree.first_child();
    for i in 0 .. child.children.len()
    {
      let node = child.children[ i ].first_child().first_child().first_child();
      match node.slot
      {
        crate::naig_slotmap::_ASMSLT_ANYINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_ANY;
        },
        crate::naig_slotmap::_ASMSLT_BACKCOMMITINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_BACKCOMMIT;
        },
        crate::naig_slotmap::_ASMSLT_CALLINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_CALL;
        },
        crate::naig_slotmap::_ASMSLT_CATCHINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_CATCH;
        },
        crate::naig_slotmap::_ASMSLT_CHARINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_CHAR;
        },
        crate::naig_slotmap::_ASMSLT_CLOSECAPTUREINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_CLOSECAPTURE;
        },
        crate::naig_slotmap::_ASMSLT_COMMITINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_COMMIT;
        },
        crate::naig_slotmap::_ASMSLT_CONDJUMPINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_CONDJUMP;
        },
        crate::naig_slotmap::_ASMSLT_COUNTERINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_COUNTER;
        },
        crate::naig_slotmap::_ASMSLT_ENDINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_END;
        },
        crate::naig_slotmap::_ASMSLT_ENDISOLATEINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_ENDISOLATE;
        },
        crate::naig_slotmap::_ASMSLT_ENDREPLACEINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_ENDREPLACE;
        },
        crate::naig_slotmap::_ASMSLT_FAILINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_FAIL;
        },
        crate::naig_slotmap::_ASMSLT_FAILTWICEINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_FAILTWICE;
        },
        crate::naig_slotmap::_ASMSLT_INTRPCAPTUREINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_INTRPCAPTURE;
        },
        crate::naig_slotmap::_ASMSLT_ISOLATEINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_ISOLATE;
        },
        crate::naig_slotmap::_ASMSLT_JUMPINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_JUMP;
        },
        crate::naig_slotmap::_ASMSLT_MASKEDCHARINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_MASKEDCHAR;
        },
        crate::naig_slotmap::_ASMSLT_NOOPINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_NOOP;
        },
        crate::naig_slotmap::_ASMSLT_OPENCAPTUREINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_OPENCAPTURE;
        },
        crate::naig_slotmap::_ASMSLT_PARTIALCOMMITINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_PARTIALCOMMIT;
        },
        crate::naig_slotmap::_ASMSLT_QUADINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_QUAD;
        },
        crate::naig_slotmap::_ASMSLT_RANGEINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_RANGE;
        },
        crate::naig_slotmap::_ASMSLT_REPLACEINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_REPLACE;
        },
        crate::naig_slotmap::_ASMSLT_RETINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_RET;
        },
        crate::naig_slotmap::_ASMSLT_SETINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_SET;
        },
        crate::naig_slotmap::_ASMSLT_SKIPINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_SKIP;
        },
        crate::naig_slotmap::_ASMSLT_SPANINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_SPAN;
        },
        crate::naig_slotmap::_ASMSLT_TESTANYINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_TESTANY;
        },
        crate::naig_slotmap::_ASMSLT_TESTCHARINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_TESTCHAR;
        },
        crate::naig_slotmap::_ASMSLT_TESTQUADINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_TESTQUAD;
        },
        crate::naig_slotmap::_ASMSLT_TESTSETINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_TESTSET;
        },
        crate::naig_slotmap::_ASMSLT_TRAPINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_TRAP;
        },
        crate::naig_slotmap::_ASMSLT_VARINSTR_ => {
          offset += libnaig::instructions::_INSTR_SIZE_VAR;
        },
        crate::naig_slotmap::_ASMSLT_LABEL_ => {
          let label = node.first_child().to_string();
          state.label_set(label, offset);
        },
        _ => panic!("Token error; {}", node.slot),
      }
    }
    return Ok(());
  }

  fn sp_translate_label
    (
      node : & NaigCapTree,
      state : & mut NaigAssemblerState,
      indx : usize,
      nxt : usize,
    )
    -> Result< (), NaigError >
  {
    let label = node.children[ indx ].to_string();
    if nxt != 0 && label.eq("__NEXT__")
    {
      let offset = state.output.len() + nxt;
      state.append_unsigned(offset as u32);
    }
    else
    {
      match state.label_get(label)
      {
        Ok(offset) => { state.append_unsigned(offset); },
        Err(e) => { return Err(e); },
      }
    }
    return Ok(());
  }

  fn sp_instr_offsetlabel
    (
      node : & NaigCapTree,
      state : & mut NaigAssemblerState,
      instr : NaigInstruction,
    )
    -> Result< (), NaigError >
  {
    state.append_instr(instr);
    NaigAssembler::sp_translate_label(node, state, 1, 4)
  }

  fn sp_translate_decimal
    (
      node : & NaigCapTree,
      state : & mut NaigAssemblerState,
      indx : usize,
    )
    -> Result< (), NaigError >
  {
    let dec = node.children[ indx ].to_string();
    match u32::from_str_radix(& dec, 10)
    {
      Ok(num) => { state.append_unsigned(num); },
      Err(e) => return Err(NaigError::assembler(e.to_string())),
    }
    return Ok(());
  }

  fn sp_instr_decimal
    (
      node : & NaigCapTree,
      state : & mut NaigAssemblerState,
      instr : NaigInstruction
    )
    -> Result< (), NaigError >
  {
    state.append_instr(instr);
    NaigAssembler::sp_translate_decimal(node, state, 1)
  }

  fn sp_translate_set
    (
      node : & NaigCapTree,
      state : & mut NaigAssemblerState,
      indx : usize,
    )
    -> Result< (), NaigError >
  {
    let mut chr : u8;
    for i in 0 .. 32
    {
      match node.children[ indx ].content[ i*2 ]
      {
        b'a' ..= b'f' => chr = node.children[ indx ].content[ i*2 ] + 10 - b'a',
        b'A' ..= b'F' => chr = node.children[ indx ].content[ i*2 ] + 10 - b'A',
        b'0' ..= b'9' => chr = node.children[ indx ].content[ i*2 ] - b'0',
        _ => return Err(NaigError::assembler(format!("Unknown set character '{}'", node.children[ indx ].content[ i*2 ]))),
      }
      chr <<= 4;
      match node.children[ indx ].content[ i*2+1 ]
      {
        b'a' ..= b'f' => chr |= node.children[ indx ].content[ i*2+1 ] + 10 - b'a',
        b'A' ..= b'F' => chr |= node.children[ indx ].content[ i*2+1 ] + 10 - b'A',
        b'0' ..= b'9' => chr |= node.children[ indx ].content[ i*2+1 ] - b'0',
        _ => return Err(NaigError::assembler(format!("Unknown set character '{}'", node.children[ indx ].content[ i*2+1 ]))),
      }
      state.output.push(chr);
    }
    return Ok(());
  }

  fn sp
    (tree : & NaigCapTree, state : & mut NaigAssemblerState)
    -> Result< (), NaigError >
  {
    let child = tree.first_child();
    for i in 0 .. child.children.len()
    {
      let node = child.children[ i ].first_child().first_child().first_child();
      match node.slot
      {
        crate::naig_slotmap::_ASMSLT_ANYINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_ANY);
        },
        crate::naig_slotmap::_ASMSLT_BACKCOMMITINSTR_ => {
          match NaigAssembler::sp_instr_offsetlabel(node, state, NaigInstruction::INSTR_BACKCOMMIT, )
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_CALLINSTR_ => {
          match NaigAssembler::sp_instr_offsetlabel(node, state, NaigInstruction::INSTR_CALL)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_CATCHINSTR_ => {
          match NaigAssembler::sp_instr_offsetlabel(node, state, NaigInstruction::INSTR_CATCH)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_CHARINSTR_ => {
          let hex = node.children[ 1 ].to_string();
          match u32::from_str_radix(& hex, 16)
          {
            Ok(chr) => {
              state.append_instr(NaigInstruction::INSTR_CHAR);
              state.append_unsigned(chr);
            },
            Err(e) => return Err(NaigError::assembler(e.to_string())),
          }
        },
        crate::naig_slotmap::_ASMSLT_CLOSECAPTUREINSTR_ => {
          match NaigAssembler::sp_instr_decimal(node, state, NaigInstruction::INSTR_CLOSECAPTURE)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_COMMITINSTR_ => {
          match NaigAssembler::sp_instr_offsetlabel(node, state, NaigInstruction::INSTR_COMMIT)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_CONDJUMPINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_CONDJUMP);
          match NaigAssembler::sp_translate_decimal(node, state, 1)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
          match NaigAssembler::sp_translate_label(node, state, 2, 4)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_COUNTERINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_COUNTER);
          match NaigAssembler::sp_translate_decimal(node, state, 1)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
          match NaigAssembler::sp_translate_decimal(node, state, 2)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_ENDINSTR_ => {
          match NaigAssembler::sp_instr_decimal(node, state, NaigInstruction::INSTR_END)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_ENDISOLATEINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_ENDISOLATE);
        },
        crate::naig_slotmap::_ASMSLT_ENDREPLACEINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_ENDREPLACE);
        },
        crate::naig_slotmap::_ASMSLT_FAILINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_FAIL);
        },
        crate::naig_slotmap::_ASMSLT_FAILTWICEINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_FAILTWICE);
        },
        crate::naig_slotmap::_ASMSLT_INTRPCAPTUREINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_ISOLATEINSTR_ => {
          match NaigAssembler::sp_instr_decimal(node, state, NaigInstruction::INSTR_ISOLATE)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_JUMPINSTR_ => {
          match NaigAssembler::sp_instr_offsetlabel(node, state, NaigInstruction::INSTR_JUMP)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_MASKEDCHARINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_NOOPINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_NOOP);
          
        },
        crate::naig_slotmap::_ASMSLT_OPENCAPTUREINSTR_ => {
          match NaigAssembler::sp_instr_decimal(node, state, NaigInstruction::INSTR_OPENCAPTURE)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_PARTIALCOMMITINSTR_ => {
          match NaigAssembler::sp_instr_offsetlabel(node, state, NaigInstruction::INSTR_PARTIALCOMMIT)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_QUADINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_RANGEINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_REPLACEINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_RETINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_RET);
        },
        crate::naig_slotmap::_ASMSLT_SETINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_SET);
          match NaigAssembler::sp_translate_set(node, state, 1)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_SKIPINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_SPANINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_TESTANYINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_TESTCHARINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_TESTQUADINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_TESTSETINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_TRAPINSTR_ => {
          state.append_instr(NaigInstruction::INSTR_TRAP);
        },
        crate::naig_slotmap::_ASMSLT_VARINSTR_ => {
          match NaigAssembler::sp_instr_decimal(node, state, NaigInstruction::INSTR_VAR)
          {
            Ok(_) => (),
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_LABEL_ => { },
        _ => panic!("Token error; {}", node.slot),
      }
    }
    return Ok(());
  }
}
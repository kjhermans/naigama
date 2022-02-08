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
        tree.remove(crate::naig_slotmap::_ASMSLT___PREFIX_);
        tree.remove(crate::naig_slotmap::_ASMSLT_COMMENT_);
        tree.remove(crate::naig_slotmap::_ASMSLT_MULTILINECOMMENT_);
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
        crate::naig_slotmap::_ASMSLT_LABEL_AZAZ => {
          let label = tree.children[ i ].first_child().to_string();
          state.label_set(label, offset);
        },
        _ => panic!("Token error"),
      }
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
        },
        crate::naig_slotmap::_ASMSLT_CALLINSTR_ => {
          let label = child.children[ 1 ].to_string();
          match state.label_get(label)
          {
            Ok(offset) => { state.append_unsigned(offset); },
            Err(e) => { return Err(e); },
          }
        },
        crate::naig_slotmap::_ASMSLT_CATCHINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_CHARINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_CLOSECAPTUREINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_COMMITINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_CONDJUMPINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_COUNTERINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_ENDINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_ENDISOLATEINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_ENDREPLACEINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_FAILINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_FAILTWICEINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_INTRPCAPTUREINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_ISOLATEINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_JUMPINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_MASKEDCHARINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_NOOPINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_OPENCAPTUREINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_PARTIALCOMMITINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_QUADINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_RANGEINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_REPLACEINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_RETINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_SETINSTR_ => {
          
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
          
        },
        crate::naig_slotmap::_ASMSLT_VARINSTR_ => {
          
        },
        crate::naig_slotmap::_ASMSLT_LABEL_AZAZ => { },
        _ => panic!("Token error"),
      }
    }
    return Ok(());
  }
}

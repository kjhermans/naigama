use libnaie::naig_engine::NaigEngine;
use libnaie::naig_captree::NaigCapTree;
use libnaie::errors::NaigError;
use crate::naig_slotmap::NaigCompilerSlotmap;

pub struct NaigCompiler
{
  engine : NaigEngine,
}

impl NaigCompiler
{
  pub fn new
    ()
    -> NaigCompiler
  {
    let bytes = include_bytes!("grammar.byc").to_vec();
    return NaigCompiler {
      engine : NaigEngine::new(bytes),
    };
  }

  pub fn compile
    (&self, grammar : & String)
    -> Result<String, NaigError>
  {
    let bytes = grammar.as_bytes().to_vec();
    let r = self.engine.run(& bytes);
    match r {
      Ok(outcome) => {
        let tree = NaigCapTree::new(& bytes, & outcome.captures);
        tree.debug();
        return Ok("".to_string());
      },
      Err(error) => { return Err(error); },
    }
  }
}

use libnaic::naig_compiler::NaigCompiler;
use libnaic::naig_compiler_options::NaigCompilerOptions;
use libnaia::naig_assembler::NaigAssembler;
use libnaie::naig_engine::NaigEngine;
use libnaie::naig_outcome::NaigOutcome;
use libnaig::naig_error::NaigError;

pub fn naig_execute
  (grammar : & String, input : & Vec< u8 >)
  -> Result< NaigOutcome, NaigError >
{
  let compiler = NaigCompiler::new();
  let options = NaigCompilerOptions::new();
  let assembly = compiler.compile(& grammar, options)?;
  let assembler = NaigAssembler::new();
  let bytecode = assembler.assemble(& assembly)?;
  let engine = NaigEngine::new(bytecode);
  engine.run(input)
}

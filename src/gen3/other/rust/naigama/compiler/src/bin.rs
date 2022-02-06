use std::env;
use std::fs;

mod naig;

use libnaic::naig_compiler::NaigCompiler;
use libnaic::naig_compiler_options::NaigCompilerOptions;

pub fn main
  ()
{
  let mut grammar = String::new();
  let args: Vec< String > = env::args().collect();
  let mut skip = false;
  let mut outputfile = "-";
  let mut options = NaigCompilerOptions {
    generate_traps : false,
    capture_per_rule : false,
  };

  eprintln!(
    "This is naic, the Naigama compiler, Rust version {}",
    naig::RELEASE
  );
  for i in 0..args.len() {
    if skip {
      skip = false;
    } else {
      let arg = & args[ i ];
      if arg.eq("-i") {
        let filename = & args[ i + 1 ];
        eprintln!("Input file = {}", filename);
        grammar = fs::read_to_string(filename).expect("File error");
        skip = true;
      } else if arg.eq("-o") {
        outputfile = & args[ i + 1 ];
        eprintln!("Output file = {}", outputfile);
        skip = true;
      } else if arg.eq("-t") {
        options.generate_traps = true;
      } else if arg.eq("-C") {
        options.capture_per_rule = true;
      }
    }
  }
  let compiler = NaigCompiler::new();
  let assembly;
  let compilation = compiler.compile(& grammar, options);
  match compilation {
    Ok(a) => {
      assembly = a;
    },
    Err(error) => {
      eprintln!("Error code {} message '{}'", error.code, error.message);
      return;
    },
  }
  if outputfile.eq("-") {
    println!("{}", assembly);
  } else {
    fs::write(outputfile, assembly).expect("Could not write output.");
  }
}

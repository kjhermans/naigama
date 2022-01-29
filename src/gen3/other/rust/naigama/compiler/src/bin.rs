use std::env;
use std::fs;
use std::fs::File;
use std::io::Read;
use std::io::Stdout;

mod naig;

use libnaic::naig_compiler::NaigCompiler;

pub fn main
  ()
{
  let mut grammar = String::new();
  let args: Vec< String > = env::args().collect();
  let mut skip = false;
  let mut outputfile = "-";

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
      }
    }
  }
  let compiler = NaigCompiler::new();
  let assembly;
  let compilation = compiler.compile(& grammar);
  match compilation {
    Ok(a) => {
      assembly = a;
    },
    Err(error) => {
      eprintln!("Error");
      return;
    },
  }
  if (outputfile.eq("-")) {
  } else {
    fs::write(outputfile, assembly);
  }
}

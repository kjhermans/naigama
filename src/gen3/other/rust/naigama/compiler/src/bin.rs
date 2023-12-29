use std::env;
use std::fs;
use std::io;
use std::io::Read;
use std::process::exit;

mod naig;

use libnaic::naig_compiler::NaigCompiler;
use libnaic::naig_compiler_options::NaigCompilerOptions;

pub fn main
  ()
{
  let grammar;
  let args: Vec< String > = env::args().collect();
  let mut skip = false;
  let mut inputfile = "-";
  let mut outputfile = "-";
  let slotmapfile;
  let mut options = NaigCompilerOptions {
    generate_traps : false,
    capture_per_rule : false,
  };

  eprintln!(
    "This is naic, the Naigama compiler, Rust version release {}",
    naig::RELEASE
  );
  for i in 1..args.len() {
    if skip {
      skip = false;
    } else {
      let arg = & args[ i ];
      if arg.eq("-i") {
        inputfile = & args[ i+1 ];
        skip = true;
      } else if arg.eq("-o") {
        outputfile = & args[ i+1 ];
        skip = true;
      } else if arg.eq("-t") {
        options.generate_traps = true;
      } else if arg.eq("-s") {
        slotmapfile = & args[ i+1 ];
        skip = true;
      } else if arg.eq("-C") {
        options.capture_per_rule = true;
      } else if arg.eq("-?") || arg.eq("-h") {
        eprintln!(
"Usage {} [options]
Options:
-i <path>   Provide grammar input path (default '-' is standard input).
-o <path>   Provide assembly output path (default '-' is standard output).
-s <path>   Provide slotmap output path.
-C          Generate default captures for every rule
-t          Generate trap instructions.
", args[ 0 ]
        );
        exit(0);
      }
    }
  }

  if inputfile.eq("-") {
    let mut bytes : Vec< u8 > = vec![];
    io::stdin().read_to_end(& mut bytes).expect("Stdin error");
    grammar = String::from_utf8(bytes).expect("UTF-8 encoding error");
  } else {
    grammar = fs::read_to_string(inputfile).expect("File error");
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
      std::process::exit(-1);
    },
  }
  if outputfile.eq("-") {
    println!("{}", assembly);
  } else {
    fs::write(outputfile, assembly).expect("Could not write output.");
  }
}

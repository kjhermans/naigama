use std::env;
use std::fs;
use std::io::{self, Write};

mod naig;

use libnaia::naig_assembler::NaigAssembler;

pub fn main
  ()
{
  let mut outputfile = "-";
  let mut inputfile = "-";
  let args: Vec< String > = env::args().collect();
  let mut skip = false;

  eprintln!(
    "This is naia, the Naigama assembler, Rust version {}",
    naig::RELEASE
  );
  for i in 0..args.len() {
    if skip {
      skip = false;
    } else {
      let arg = & args[ i ];
      if arg.eq("-o") {
        outputfile = & args[ i + 1 ];
        eprintln!("Output file = {}", outputfile);
        skip = true;
      } else if arg.eq("-i") {
        inputfile = & args[ i + 1 ];
        eprintln!("Input file = {}", inputfile);
        skip = true;
      }
    }
  }
  let mut input : String = String::new();
  if inputfile.eq("-")
  {
    loop
    {
      let mut line = String::new();
      let res = io::stdin().read_line(&mut line);
      match res
      {
        Ok(0) => break,
        Ok(_) => { input = format!("{}{}", input, line); },
        Err(e) => { eprintln!("Error reading stdin: {}", e); return; },
      }
    }
  }
  else
  {
    input = fs::read_to_string(inputfile).expect(format!("Error reading {}", inputfile).as_str());
  }
  let assembler = NaigAssembler::new();
  let opt = assembler.assemble(& input);
  match opt
  {
    Ok(bytecode) => {
      if outputfile.eq("-") {
        io::stdout().write_all(& bytecode).expect("Could not write output.");
      } else {
        fs::write(outputfile, bytecode).expect("Could not write output.");
      }
    },
    Err(e) => {
      eprintln!("Error {} '{}'", e.code, e.message);
    },
  }
}

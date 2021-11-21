use std::env;
use std::fs;
use std::fs::File;
use std::io::Read;

use naigama::NaigEngine;

fn get_file_as_byte_vec
  (filename: &String)
  -> Vec<u8>
{
  let mut f = File::open(&filename).expect("no file found");
  let metadata = fs::metadata(&filename).expect("unable to read metadata");
  let mut buffer = vec![0; metadata.len() as usize];
  f.read(&mut buffer).expect("buffer overflow");

  buffer
}

pub fn main
  ()
{
  let mut bytecode : Vec<u8> = Vec::new();
  let mut input : Vec<u8> = Vec::new();
  let args: Vec< String > = env::args().collect();
  let mut skip = false;

  eprintln!("This is naie, Rust version");
  for i in 0..args.len() {
    if skip {
      skip = false;
    } else {
      let arg = & args[ i ];
      if arg.eq("-c") {
        let filename = & args[ i + 1 ];
        eprintln!("Input file = {}", filename);
        bytecode = get_file_as_byte_vec(filename);
        skip = true;
      } else if arg.eq("-i") {
        let filename = & args[ i + 1 ];
        eprintln!("Bytecode file = {}", filename);
        input = get_file_as_byte_vec(filename);
        skip = true;
      }
    }
  }
  eprintln!("Bytecode {} bytes, input {} bytes.", bytecode.len(), input.len());
  if (bytecode.len() > 0) {
    let engine = NaigEngine::new(bytecode);
    let result = engine.run(& input);
  } else {
    eprintln!("No bytecode. Not executing.");
  }
}

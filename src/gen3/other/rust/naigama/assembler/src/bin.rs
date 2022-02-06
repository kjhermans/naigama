use std::env;
use std::fs;
use std::fs::File;
use std::io::Read;

mod naig;

use libnaie::naig_engine::NaigEngine;

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

fn capture_string
  (inp : & Vec< u8 >, offset : usize, length : usize)
  -> String
{
  let mut result = "".to_owned();

  for i in offset .. offset + length {
    if inp[ i ] >= 32 && inp[ i ] < 127 {
      if inp[ i ] == 34 || inp[ i ] == 92 {
        result.push('\\');
      }
      result.push(inp[ i ] as char);
    } else {
      result.push_str(& format!("\\x{}", inp[ i ]));
    }
  }

  result
}

pub fn main
  ()
{
  let mut bytecode : Vec<u8> = Vec::new();
  let mut input : Vec<u8> = Vec::new();
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
  if bytecode.len() == 0 {
    eprintln!("No bytecode. Not executing.");
  }
  let engine = NaigEngine::new(bytecode);
  let result = engine.run(& input);
  match result {
    Ok(r) => {
      eprintln!("Exit code {}", r.exitcode);
      for i in 0 .. r.captures.len() {
        eprintln!(
          "Action #{}: slt={}, off={}->{}: \"{}\""
          , i
          , r.captures[ i ].slot
          , r.captures[ i ].offset
          , r.captures[ i ].length
          , capture_string(& input, r.captures[i].offset, r.captures[i].length)
        );
      }
    },
    Err(r) => { eprintln!("Error code {} message '{}'", r.code, r.message); }
  }
}

use std::env;
use std::fs;
use std::fs::File;
use std::io::Read;

mod naig;

use libnaie::NaigEngine;

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
  let mut grammar : Vec<u8> = Vec::new();
  let mut output : Vec<u8> = Vec::new();
  let args: Vec< String > = env::args().collect();
  let mut skip = false;

  let bytes = include_bytes!("grammar.byc").to_vec();

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
        grammar = get_file_as_byte_vec(filename);
        skip = true;
      } else if arg.eq("-o") {
        let filename = & args[ i + 1 ];
        eprintln!("Output file = {}", filename);
        output = get_file_as_byte_vec(filename);
        skip = true;
      }
    }
  }
  let engine = NaigEngine::new(bytes);
  let result = engine.run(& grammar);
  match result {
    Ok(r) => { },
    Err(r) => { eprintln!("Error"); }
  }
}

package lib.naigama.engine;

import java.io.File;
import java.nio.file.Files;
import java.io.IOException;

import lib.naigama.NaigamaException;

public class Main
{
  private static byte[] load_file
    (String path)
  {
    try {
      byte[] result = Files.readAllBytes(new File(path).toPath());
      return result;
    } catch (IOException ioe) {
      return null;
    }
  }

  /**
   *
   */
  public static void main
    (String[] args)
  {
    byte[] bytecode = null;
    byte[] input = null;
    Engine engine;
    EngineOptions options = new EngineOptions();
    Outcome outcome;

    {
      for (int i=0; i < args.length; i++) {
        if (args[ i ].equals("-i")) {
          input = load_file(args[ i+1 ]);
        } else if (args[ i ].equals("-c")) {
          bytecode = load_file(args[ i+1 ]);
        } else if (args[ i ].equals("-D")) {
          options.debug = true;
        }
      }
    }
    if (bytecode == null) {
      throw new NullPointerException("Bytecode not set");
    }
    if (input == null) {
      throw new NullPointerException("Input not set");
    }
    engine = new Engine(bytecode, options);
    try {
      outcome = engine.run(input);
      System.out.println(outcome);
    } catch (NaigamaException naige) {
      System.err.println("Exception: " + naige);
      System.exit(-1);
    }
  }
}

package lib.naigama.compiler;

import java.io.File;
import java.nio.file.Files;
import java.io.FileOutputStream;
import java.io.OutputStream;
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
    String grammar = null;
    OutputStream assemblyfile = System.out;
    StringBuffer assembly = new StringBuffer();
    CompilerOptions options = new CompilerOptions();

    {
      for (int i=0; i < args.length; i++) {
        if (args[ i ].equals("-i")) {
          byte[] input = load_file(args[ i+1 ]);
          try {
            grammar = new String(input, "ISO-8859-1");
          } catch (Exception e) { }
        } else if (args[ i ].equals("-o")) {
          try {
            assemblyfile = new FileOutputStream(new File(args[ i+1 ]));
          } catch (IOException ioe) {
            System.err.println(ioe);
            System.exit(-1);
          }
        }
      }
    }
    if (grammar == null) {
      grammar = "";
      int c;
      try {
        while ((c = System.in.read()) >= 0) {
          grammar = grammar + (char)c;
        }
      } catch (IOException ioe) {
        System.err.println(ioe);
        System.exit(-1);
      }
    }
    Compiler compiler;
    try {
      compiler = new Compiler(grammar, assembly, options);
    } catch (NaigamaException naige) {
      System.err.println(naige);
      System.exit(-1);
    }
  }
}

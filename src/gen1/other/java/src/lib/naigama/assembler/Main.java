package lib.naigama.assembler;

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
    String assembly = null;
    OutputStream bytecodefile = System.out;
    StringBuffer bytecode = new StringBuffer();
    AssemblerOptions options = new AssemblerOptions();

    {
      for (int i=0; i < args.length; i++) {
        if (args[ i ].equals("-i")) {
          byte[] input = load_file(args[ i+1 ]);
          try {
            assembly = new String(input, "ISO-8859-1");
          } catch (Exception e) { }
        } else if (args[ i ].equals("-o")) {
          try {
            bytecodefile = new FileOutputStream(new File(args[ i+1 ]));
          } catch (IOException ioe) {
            System.err.println(ioe);
            System.exit(-1);
          }
        } else if (args[ i ].equals("-?") || args[ i ].equals("-h")) {
          System.err.println(
"Usage: <INVOCATION> [options]\n" +
"Options:\n"
);
          System.exit(0);
        } else if (args[ i ].equals("-D")) {
          options.debug = true;
        }
      }
    }
    if (assembly == null) {
      assembly = "";
      int c;
      try {
        while ((c = System.in.read()) >= 0) {
          assembly = assembly + (char)c;
        }
      } catch (IOException ioe) {
        System.err.println(ioe);
        System.exit(-1);
      }
    }
    Assembler assembler;
    try {
      assembler = new Assembler(assembly, bytecode, options);
      bytecodefile.write(bytecode.toString().getBytes());
    } catch (NaigamaException naige) {
      System.err.println("Assembler error: " + naige);
      System.exit(-1);
    } catch (IOException ioe) {
      System.err.println(ioe);
      System.exit(-1);
    }
  }
}

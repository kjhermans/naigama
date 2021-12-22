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
        } else if (args[ i ].equals("-?") || args[ i ].equals("-h")) {
          System.err.println(
"Usage: <INVOCATION> [options]\n" +
"Options:\n" +
"-? / -h    Display this message\n" +
"-i <path>  Input grammar file (- for stdin)\n" +
"-o <path>  Output assembly file (- for, or otherwise stdout)\n" +
"-b         Incorporate the assembler and output bytecode at -o\n" +
"-a <path>  Emit bytecode at -o, and assembly at -a\n" +
"-m <path>  Output slotmap file (optional)\n" +
"-M <path>  Output slotmap.h file (optional)\n" +
"-l <path>  Labelmap path (only works when -a or -b is given).\n" +
"-D         Debug (prepare for a lot of data on stderr)\n" +
"-t         Generate traps\n" +
"-T         'Traditional' output (LPEG compatible)\n" +
"-s         Generate reduced instruction set\n" +
"-w         Write out loops instead of using counters\n" +
"-C         Produce a default capture for every rule\n"
);
          System.exit(0);
        } else if (args[ i ].equals("-t")) {
          options.generate_traps = true;
        } else if (args[ i ].equals("-w")) {
          options.writeloops = true;
        } else if (args[ i ].equals("-C")) {
          options.generate_captureperrule = true;
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
      assemblyfile.write(assembly.toString().getBytes());
    } catch (NaigamaException naige) {
      System.err.println(naige);
      System.exit(-1);
    } catch (IOException ioe) {
      System.err.println(ioe);
      System.exit(-1);
    }
  }
}

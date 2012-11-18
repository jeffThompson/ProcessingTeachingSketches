/*
 * RUN UNIX COMMANDS IN PROCESSING
 * Jeff Thompson
 * Adapted and annotated from code by Wharfie
 * http://www.computing.net/answers/unix/run-unix-command-thr-java-program-/5887.html
 * July 2011
 *
 * Runs Unix commands from within Processing.  This can be *super* helpful for
 * doing complex operations on folders such as copying or compressing multiple 
 * files.  A simple command can make quick work of what would otherwise be a 
 * cumbersome task in Processing and will likely be much quicker than any Java 
 * implementation of the same process.
 *
 * You will likely need to specify the full path where you want to work, unless your
 * location is relative to your sketch.  For example: /Users/jeffthompson/Desktop
 *
 * Suggestions to try:
 *   whoami                            prints username currently logged on
 *   ls                                this lists all files in the particular location
 *   wc -w filename.extension          this counts words in a particular file
 *   cp sourcefile.ext destfile.txt    makes a copy of a file to a new one
 *   ./yourBashScript.sh               run a bash script (allowing nested and more complex commands)
 *
 * For more ideas, look at the excellent SS64 site: http://ss64.com/bash
 * 
 * www.jeffreythompson.org
 */

void setup() {

  // what command to run
  String commandToRun = "whoami";
  // String commandToRun = "ls";
  // String commandToRun = "wc -w sourcefile.extension";
  // String commandToRun = "cp sourcefile.extension destinationfile.extension";
  // String commandToRun = "./yourBashScript.sh";

  File workingDir = new File(sketchPath(""));   // where to do it - should be full path
  String returnedValues;                        // value to return any results

  // give us some info:
  println("Running command: " + commandToRun);
  println("Location:        " + workingDir);
  println("---------------------------------------------\n");

  // run the command!
  try {
    
    // complicated!  basically, we have to load the exec command within Java's Runtime
    // exec asks for 1. command to run, 2. null which essentially tells Processing to 
    // inherit the environment settings from the current setup (I am a bit confused on
    // this so it seems best to leave it), and 3. location to work (full path is best)
    Process p = Runtime.getRuntime().exec(commandToRun, null, workingDir);

    // variable to check if we've received confirmation of the command
    int i = p.waitFor();

    // if we have an output, print to screen
    if (i == 0) {

      // BufferedReader used to get values back from the command
      BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));

      // read the output from the command
      while ( (returnedValues = stdInput.readLine ()) != null) {
        println(returnedValues);
      }
    }

    // if there are any error messages but we can still get an output, they print here
    else {
      BufferedReader stdErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));

      // if something is returned (ie: not null) print the result
      while ( (returnedValues = stdErr.readLine ()) != null) {
        println(returnedValues);
      }
    }
  }

  // if there is an error, let us know
  catch (Exception e) {
    println("Error running command!");  
    println(e);
    // e.printStackTrace();    // a more verbose debug, if needed
  }

  // when done running command, quit
  println("\n---------------------------------------------");
  println("DONE!");
  exit();
}


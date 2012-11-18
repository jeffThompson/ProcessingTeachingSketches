/*
MAKE LOTS OF TEXT FILES REALLY FAST
 Jeff Thompson
 June 2011
 
 Utility to make a whole lot of files really quickly.
 
 www.jeffreythompson.org
 */


int numFiles = 552;           // how many files to make (in this case, one hour-long segments)
int leadingZeroes = 3;        // how many leading zeroes, if any


void setup() {
  
  println("WRITING LOTS AND LOTS OF TEXT FILES:\n");

  // ITERATE TO CREATE ALL FILES
  for (int i=0; i<numFiles; i++) {

    // NAME the FILE
    String textFileName = nfs(i,leadingZeroes);

    // CREATE the FILES
    try {
      File file = new File(textFileName + ".txt");       // create new file
      boolean success = file.createNewFile();            // test if we've been successful

      if (success) {
        println("Creating file " + (i+1) + "/" + numFiles + "...");    // let us know how we're doing
      }
    }
    // IF AN ERROR, PRINT and QUIT
    catch (IOException e) {
      println("Problem writing file!\nQuitting...");
      exit();
    }
  }

  // LET US KNOW WE'RE DONE and QUIT
  println("\n---------\nFINISHED!");
  exit();
}


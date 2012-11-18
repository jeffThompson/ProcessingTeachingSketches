
// AN ARRAY OF PrintWriter INSTANCES
PrintWriter[] multiOutput = new PrintWriter[20];


void setup() {

  // INITIALIZE EACH PrintWriter TO AN OUTPUT FILE
  println("WRITING TO " + multiOutput.length + " FILES:");
  println("\nInitializing PrintWriter instances...");
  for (int i=0; i<multiOutput.length; i++) {
    multiOutput[i] = createWriter(nfs(i, 2) + ".txt");
  }

  // WRITE SOME TEXT TO THE FILES
  println("\nWriting pass one:");
  for (int i=0; i<multiOutput.length; i++) {
    multiOutput[i].println("This is a line of text...");
    println("File #" + (i+1));
  }

  println("\nWriting pass two:");
  for (int i=0; i<multiOutput.length; i++) {
    multiOutput[i].println("A second line of text...");
    println("File #" + (i+1));
  }

  // FLUSH AND CLOSE ALL PrintWriter INSTANCES
  for (int i=0; i<multiOutput.length; i++) {
    multiOutput[i].flush();
    multiOutput[i].close();
  }

  println("\nDONE!");
  exit();
}


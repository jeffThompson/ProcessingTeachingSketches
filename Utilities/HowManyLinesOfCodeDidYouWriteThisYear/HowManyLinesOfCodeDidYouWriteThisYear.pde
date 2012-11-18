/*
HOW MANY LINES OF CODE DID YOU WRITE THIS YEAR?
 Jeff Thompson
 January 2012
 
 Well, how many did you write?
 
 www.jeffreythompson.org
 */

int whichYear = 2011;    // what year do you want to report?

String sketchbook;
int numFiles = 0;
int lineCount = 0;
int totalLines = 0;
BufferedReader reader;

void setup() {

  // get sketchbook folder
  sketchbook = sketchPath.substring(0, sketchPath.lastIndexOf(File.separator));
  println("Reading in: " + sketchbook);

  // write list of all folders to a File array
  File folder = new File(sketchbook);
  File[] listOfSketches = folder.listFiles();
  println(listOfSketches.length + " total sketches in your sketchbook");

  // go through each folder
  println("\nChecking for files written in " + whichYear + "...");
  for (int i=0; i<listOfSketches.length; i++) {

    // get date modified of the folder
    long timestamp = listOfSketches[i].lastModified();
    Date whenModified = new Date(timestamp);
    SimpleDateFormat yr = new SimpleDateFormat("yyyy");
    yr.setTimeZone(TimeZone.getDefault());

    // if the date matches the year we're looking for
    if (int(yr.format(whenModified)) == whichYear) {

      // get filename
      String s = listOfSketches[i].getName();
      print("  " + s + ": ");

      // get all files in that folder
      File[] filesInside = listOfSketches[i].listFiles();
      for (int f=0; f<filesInside.length; f++) {
        String[] checkForPDE = match(filesInside[f].getName(), ".pde");

        if (checkForPDE != null) {

          // ok, if we're here, it means the file is a .pde file (whew)
          // read the whole file and get the number of lines in it
          lineCount = 0;    // reset
          try {
            reader = createReader(sketchbook + "/" + s + "/" + filesInside[f].getName());
            while (reader.readLine () != null) {
              lineCount++;
            }
            print(lineCount + " ");
            totalLines += lineCount;
            numFiles++;
          }
          catch (IOException e) {
            println("Error!  Quitting...");
            exit();
          }
        }
      }
      print("\n");
    }
  }

  println("\nIN " + whichYear + " YOU WROTE:");
  println(numFiles + " files, for a total of " + totalLines + " lines!");
  println("(congrats!)");
  exit();
}


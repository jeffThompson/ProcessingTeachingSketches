/*
PARSING MULTIPLE FILES
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Need to use 2 or 3 data files? It's probably easier to mash them
 together in Excel or a text editor. Need to use hundreds or
 thousands? We can load them one-by-one in Processing.
 
 This example loads random CSV files from a folder, opens them one-by-one,
 processes each line, and saves the result to an folder of image files.

 */

String folderWithData = "dataFiles";  // folder where your files are stored
File[] dataFiles;                     // list of data files

void setup() {

  size(800, 800);
  createRandomFiles(10, 10);          // create some random data to work with (10 files at 10 lines each)

  // get a list of all files in the data folder
  File dir = new File(sketchPath("") + folderWithData);
  if (dir.isDirectory()) {
    dataFiles = dir.listFiles();
    println(dataFiles);
  }
  else {
    println("Not a folder!");
    exit();
  }

  // go through the list file-by-file
  for (File f : dataFiles) {
    String[] data = loadStrings(f.getAbsolutePath());  // load each data file

    // go through each line in the file
    background(0);                                     // reset the background each file
    for (String line : data) {

      // do something with your data! 
      
      // here we parse random circles from the files
      String[] s = split(line, ",");
      noStroke();
      fill(Integer.parseInt(s[2]), Integer.parseInt(s[3]), Integer.parseInt(s[4]));
      ellipse(Integer.parseInt(s[0]), Integer.parseInt(s[1]), 50, 50);
    }

    // after we read each file, save as an image to a folder called 'outputImages'
    save("outputImages/" + f.getName() + ".tiff");
  }
}


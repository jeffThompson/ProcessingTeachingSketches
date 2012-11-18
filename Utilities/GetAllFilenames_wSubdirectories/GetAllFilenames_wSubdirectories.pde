void setup() {

  // Path
  String path = sketchPath.substring(0, sketchPath.lastIndexOf(File.separator));

  println("\nListing info about all files in a directory and all subdirectories: ");
  ArrayList allFiles = listFilesRecursive(path);

  for (int i = 0; i < allFiles.size(); i++) {
    
    // File f = (File) allFiles.get(i);
    String correctFileExtension = allFiles.get(i);  

    // String currentFilename = str(f.getName());
    String[] correctFileExtension = match(currentFilename, ".pde | .PDE");
    
    if (correctFileExtension != null) {

      println(currentFilename);

      // println("+ " + f.getName());
      // println("Size: " + f.length() + "kb");
      // println("Full path: " + f.getAbsolutePath());
      // println("-----------------------");
    }
  }

  noLoop();
}

// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()
void draw() {

  println("\n\nDONE!");
  exit();
}


// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list of all files in a directory and all subdirectories
ArrayList listFilesRecursive(String dir) {
  ArrayList fileList = new ArrayList(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // a.add(file);                                   // list (or don't) folders and subdirectories
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      recurseDir(a, subfiles[i].getAbsolutePath());   // get all files in this subdirectory
    }
  }
  else {
    a.add(file);
  }
}


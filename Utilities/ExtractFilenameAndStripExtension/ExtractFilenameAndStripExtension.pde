
/*
EXTRACT FILENAME FROM FULL PATH
 Jeff Thompson | 2012 | www.jeffreythompson.org
 
 Gets the filename from a full path, including stripping
 the file extension.  Great for saving files from within
 subfolders to new locations with a new file extension.
 
 The code below is also included formatted as a function (in
 a separate .pdf file), allowing it to copied into other sketche
 folders and used directly.   
 */

void setup() {
  
  String s = "path/to/file.txt";         // Mac file path
  // String s = "path\to\file.txt";      // works on Windows paths too!
  
  s = s.substring(s.lastIndexOf('/')+1, s.length());
  println("Split for Mac:\t" + s);

  s = s.substring(s.lastIndexOf('\\')+1, s.length());
  println("Split for Windows:\t" + s);

  s = s.substring(0, s.lastIndexOf('.'));              // remove to keep file extension
  println("Remove extension:\t" + s);
  
  // String s = stripFilename(s);                      // or use as a function in a separate tab!
  
  exit();
}


/*
READ USING BufferedReader
 Jeff Thompson | 2013 | www.jeffreythompson
 
 Read an external file line-by-line using Java's BufferedReader method - more
 powerful and memory-friendly (a requirement for larger input files) but a bit
 less concise than Processing-based methods.
 
 Here we simply count the # of lines in the file, but you could of course do
 much fancier, more exciting things! :)
 
 For a simpler version, see the "LoadExternalTextFile" example.
 
 */

// variables
String filename = "WarOfTheWorlds.txt";      // name (or full path) for file to load
String currentLine;                          // variable to store current line from file - note it is left blank here
int lineCount = 0;                           // count number of lines in the file

// we must run this code in a 'try' statement to catch errors
// Processing allows us to skip this part with the loadStrings method
try {
  
  // setup our BufferedReader with the filename specified above
  BufferedReader reader = createReader(filename);
  
  // a bit complicated! essentially: run through the file until we hit the end!
  // 1. set 'currentLine' to the next line in the file (using BufferedReader's readLine method)
  // 2. if this line exists (ie: not null), read it - if it does NOT exist (ie: null), exit the while loop
  while ( (currentLine = reader.readLine ()) != null) {
    lineCount++;                                            // add 1 each time we read a line of text
  }
}

// if there's a problem loading or reading the file, let us know ('catch' is the pair for 'try')
// NOTE: here we use the general form (just 'exception'), though we can also look for specific errors as well
catch (Exception e) {
  println("Problem loading/reading file!");
}

// when done, print the # of lines and quit
println("Number of lines in the file: " + lineCount);
exit();


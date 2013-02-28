/*
READ CSV FILE USING BufferedReader
Jeff Thompson
Fall 2011

Reads a comma-separated-values (.csv) file - a machine-readable format that
allows for easy(er) data visualizations.

The example file is filled with scores for various teams, in this column format:
Team,Score1,Score2...
Red,1,3...

Using a BufferedReader, we can read line-by-line through the file.  No matter what
is stored, it will be read in as Strings so we'll need to convert to apply math, etc.

If you need to read more than one file simultaneously, multiple BufferedReaders can
be created.  Either specify them individually, or create an array of them like this:

BufferedReader[] readers = new BufferedReader[numberOfReaders];

www.jeffreythompson.org
*/

// DATA READING VARIABLES
String filename = "scores.csv";          // file to read (must be in data folder)
BufferedReader reader;                   // function that actually reads the file*
String tempLine;                         // string to store the line read in (all files are read as strings)
int numLines = 0;                        // count the number of lines as we go

// * acts just like a the PFont function, which is to say it is essentially a variable-type
// called BufferedReader; can be named anything, in this case 'reader' to be easy to remember

// VISUALIZATION VARIABLES
int xPos, yPos;            // position to draw lines
int prevXPos, prevYPos;    // store previous position (to draw lines)
int minData = 0;           // minimum value in the file (a smarter system might programatically adapt)
int maxData = 10;          // ditto max value


void setup() {

  // BASIC SETUP
  size(500, 500);
  background(255);    // white background
  strokeWeight(2);    // thicker lines that we can see easier
  smooth();           // smooth the lines for a nicer look

  // SETUP READER OBJECT
  reader = createReader(filename);    // load the file specified earlier

  // READ THE FILE!
  // everything must be in a 'try' statement: will give an 'unhandled exception'
  // error if you don't - must also include a 'catch' below
  try {
    
    // so long as there is data (not null), set tempLine to the string read in
    // you cannot specify a line to read, so each time the readLine function is called
    // the next line is read
    while ( (tempLine = reader.readLine ()) != null) {

      // the first line is likely column headers - skip it
      // if NOT 0, then do the following:
      if (numLines != 0) {
        
        println(tempLine);    // print so we can see it (not recommended for large files)

        // SPLIT INTO USEABLE VALUES
        String[] splitValues = split(tempLine, ',');  // splits at the comma > save to an array
        
        // get number of values in the line (this way we can be flexible as the file may
        // not be consistent throughout; we'll use this to evenly divide the screen
        int divisor = width/(splitValues.length-2);   // ignore first value (team name)

        // ITERATE THROUGH THE DATA, VISUALIZE!
        for (int i=0; i<splitValues.length; i++) {  // run length of array

          // skip first value (team name) - otherwise, get value and draw
          if (i >= 1) {

            // count by divisors (i-1 since we're skipping the first) across screen
            xPos = (i-1) * divisor;
            
            // map the value to the height of the screen
            yPos = int(map(int(splitValues[i]), minData, maxData, 20, height-20));

            // since we're drawing lines, for the first value we won't have a previous point;
            // for the first line, set the previous to the current position
            if (i==1) {
              prevXPos = xPos;
              prevYPos = yPos;
            }

            // DRAW!
            stroke(0, 100);                        // semi-transparent lines
            line(prevXPos, prevYPos, xPos, yPos);  // line
            noStroke();
            fill(255,0,0);
            ellipse(xPos,yPos, 8,8);

            // finally, update previous to current and repeat
            prevXPos = xPos;
            prevYPos = yPos;
          }
        }
      }

      numLines++;    // increment so that we can find out how many lines the file had later
    }
  }

  // LOOK FOR ERRORS
  // the other half of a 'try' statement, catch returns specified types of errors (required
  // by certain functions) - 'IO' is input/output, 'e' is a variable to store and list more
  // specific error messages; try changing the filename to a non-existent one and see what happens
  catch (IOException e) {
    println("ERROR! Can't read file");  // let us know what happened
    println(e);                         // print a more specific message
  }

  // WHEN DONE, PRINT THE NUMBER OF LINES
  // formatted nicely...
  println("---\nNumber of lines: " + numLines);
}


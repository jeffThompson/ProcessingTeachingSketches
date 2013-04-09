/*
PIXEL-LEVEL BIG DATA
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 There is a lot of talk about "big data", but one thing is certain: working
 with big data requires strategies beyond line graphs and pie charts!
 
 Pixel-level display allows us to see patterns in vast data - each pixel is
 a single data-point, color-coded and placed side-by-side.
 
 We use Java's BufferedReader class to read files line-by-line, rather than
 the having to read the entire file into memory - very important for files
 this size!
 
 The data used here is chromosome #01 from the Human Genome
 Project, downloaded from Project Gutenberg:
 http://www.gutenberg.org/ebooks/11775
 
 The set is truncated to the size of your screen, but is SIGNIFICANTLY
 larger than what is shown.
 
 A NOTE ABOUT COLOR CODING DATA:
 It's important to keep in mind that somewhere around 10% of the population is
 red/green color-blind, meaning that they will have trouble distinguishing
 reds from greens. When color-coding data, it is best to avoid colors that are
 hard for these people to distinguish.
 
 Not color blind? Want to see what it's like? Try the "Colorblind Web Page Filter",
 which lets you surf websites under various forms of colorblindness:
 http://colorfilter.wickline.org
 
 CHALLENGE:
 1. First iterate the data set and count the number of data points (hint: you
 will need to re-create the 'reader' object; you may also need a larger
 number than an int such as a long). Then resize the screen to fit the entire
 set, draw the data, and save to file! 
 */

String filename = "HumanGenome_Chromosome1.txt";    // file to read in
BufferedReader reader;                              // object to read data
String entry;                                       // line in the file
int x = 0;                                          // x/y coords to address
int y = 0;
color px;                                           // color for each pixel
 

void setup() {

  // set the sketch size to your screen - the data is MUCH larger than this :)
  size(displayWidth, displayHeight);
  // size(15895, 15895);                // read the entire file; total of 252,644,000 data points
  println("Displaying " + nfc(width*height) + " data points!"); 
  
  loadPixels();                            // load screen pixels so we can access them in our loop

  try {                                    // must run in a 'try' statement
    reader = createReader(filename);       // open file in reader

    // read line-by-line until end of file (null) or we run out of screen
    while ( (entry = reader.readLine ()) != null && y < height-1) {
      entry = entry.toLowerCase();            // convert data to lowercase
      for (int i=0; i<entry.length(); i++) {  // iterate each character in the line
        char digit = entry.charAt(i);         // get individual character
        switch(digit) {                       // color depending on the data
        case 'a':
          px = color(255, 150, 0);            // orange
          break;
        case 'c': 
          px = color(0,150,255);              // light blue
          break;
        case 'g':
          px = color(0);                      // black
          break;
        case 't':
          px = color(255);                    // white
          break;
        default: 
          continue;                           // if the data is not ACGT, skip (error catching, essentially)
        }

        // update pixel position     
        if (x == width) {
          x = 0;
          y++;
        }
        else {
          x++;
        }

        // display the pixel! formula converts x/y to position in linear pixel array
        pixels[y*width + x] = px;
      }
    }
  }
  catch (IOException ioe) {                   // errors reading the file?
    println("Error reading file...");
  }

  // finally, update the pixel array to display!
  updatePixels();
}

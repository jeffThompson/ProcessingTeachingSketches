/*
READ CSV FILE - BASIC
Jeff Thompson | 2013 | www.jeffreythompson.org

Read a comma-separated-values (CSV) data file, split each line into,
respective data points, and visualize the results!

CHALLENGE:
1. Can you map the score or color values to the circle's position on
   the screen?
2. Can you use another shape (rectangle, line, etc) in place of the
   circles? For examples, look in the Processing reference.
*/

// name of file to load (stored in the sketch folder or full path)
String filename = "teams.csv";

void setup() {
  
  // basic setup - set window size and background to white
  size(600,600);
  background(255);
  
  // load the file into an array (list) of lines
  String[] file = loadStrings(filename);

  // go through all lines in the file using a 'for loop'
  for (int i=0; i<file.length; i++) {
    println(file[i]);      // print each line in the file
  }
  
  // a little more complex example: retrieve values and draw them to screen
  // NOTE: start at line 1 to avoid reading the header!
  for (int i=1; i<file.length; i++) {
    
    // split the line at commas into an array (list) of the parts
    String[] reading = split(file[i], ',');
    
    // convert items from string to numbers (integer) for color
    int r = Integer.parseInt(reading[1]);
    int g = Integer.parseInt(reading[2]);
    int b = Integer.parseInt(reading[3]);
    color c = color(r,g,b, 180);                                           // create a color from the values with transparency!
    
    // visualize score as circles of loaded color
    int score = Integer.parseInt(reading[4]);
    fill(c);                                                               // set fill based on data file
    noStroke();                                                            // no outline
    ellipse(random(100,width-100), random(100,height-100), score, score);  // draw circle at random position
  } 
}

import java.util.Arrays;      // used to see if a preferred font is in the array of choices

/*
GET AND CREATE FONTS
Jeff Thompson | 2013 | www.jeffreythompson.org

Android prefers us load create fonts from available fonts, rather
than store a font in the VLW format used in normal sketches.

First, we generate a list of available fonts, then choose from
that list.

CHALLENGE:
1. How might you set the font size based on the screen's resolution?
*/

int fontSize = 72;
String preferredFont = "Serif-Bold";
PFont font;

void setup() {
  
  // basic setup
  orientation(PORTRAIT);
  background(255);
  smooth();
  
  // get list of available fonts, both as an array and a printable string
  String[] fonts = PFont.list();    // get all fonts
  String fontList = "";             // blank string to format for display
  for (String font : fonts) {       // iterate all available fonts
    fontList += font + "\n";        // add each font with a newline character
  }
  
  // create the display font - if available, set to our preferred, otherwise
  // go with a default system font
  if (Arrays.asList(fonts).contains(preferredFont)) {    // if the array of fonts contains the preferred..
    font = createFont(preferredFont, fontSize);          // create the font
  }
  else {
   font = createFont("SansSerif", fontSize);             // otherwise, specify a default font
  }
  
  // print the font list in the specified typeface!
  fill(0);
  textFont(font);
  textAlign(CENTER, CENTER);
  text(fontList, width/2, height/2);  
} 

/*
ORIENTATION
Jeff Thompson | 2013 | www.jeffreythompson.org

Android sketches can either be variable orientation (home buttons
switch as the device is rotated) or fixed.

no orientation set        switch as device is rotated
orientation(LANDSCAPE)    fixed in horizontal direction
orientation(PORTRAIT)     fixed in vertical direction

We also get the orientation from the display (by getting the built-in
width/height variables) - other parameters that can be queried directly
from the display; details are available here:
http://developer.android.com/reference/android/view/Display.html

CHALLENGE:
1. Try making your finger control the orientation of the screen!
2. Try getting other parameters
*/

boolean fixedOrientation = false;    // allow the orientation to be changed?
PFont font;                          // font for display of orientation

void setup() {
  
  // if we've specified a fixd display, set to landscape
  if (fixedOrientation) {
    orientation(LANDSCAPE);
  }
  
  // create font for display
  font = createFont("SansSerif", 72);
  textFont(font);
  textAlign(CENTER, CENTER);
  noStroke();
  fill(255);
}

void draw() {
  background(255,150,0);
  
  // display the orientation of the device
  if (width == height) {
    text("SQUARE (LIKE A DONUT)", width/2,height/2);
  }
  else if (width < height) {
    text("PORTRAIT (LIKE A HAMBURGER)", width/2,height/2);
  }
  else {
    text("LANDSCAPE (LIKE A HOTDOG)", width/2,height/2);
  }
}

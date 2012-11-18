/*
RESIZE WINDOW (and set window title)
 Jeff Thompson
 February 2012
 
 Uses Java's Frame class to allow for dynamically-sized windows, either by
 click-and-drag in the lower corner or with the maximize/minimize buttons.
 
 www.jeffreythompson.org
 */

int squareSize;

void setup() {

  size(500, 500);      // initial size
  rectMode(CENTER);    // draw rectangles from the center
  noStroke();

  // allow frame to be resized (and change title while we're at it!)
  frame.setResizable(true);
  frame.setTitle("This window can be resized!");
}

void draw() {

  // redraw each frame
  background(100);

  // determine smaller dimension, set size of square to 1/3 of that
  if (width < height) {     // if width is smaller
    squareSize = width/3;
  }
  else {                    // if height is smaller
    squareSize = height/3;
  }

  // draw square in center of screen
  fill(255);
  rect(width/2, height/2, squareSize, squareSize);
}


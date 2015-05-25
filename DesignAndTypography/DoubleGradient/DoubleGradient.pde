/*
DOUBLE GRADIENT
Jeff Thompson | 2013 | www.jeffreythompson.org

A gradient changes seamlessly with the cursor, but instead of 
simply mapping from one color to another, here we transition
between two gradients as well!

This example is meant to mimic sunrise/sunset.
*/

int midpoint = 350;  // where the transition between the two gradients occurs
color start, end;    // variables to set start (top) and end (bottom) colors

void setup() {
  size(500, 500);
}

void draw() {

  // if the cursor is in the top half of the screen, create one gradient
  if (mouseY < midpoint) {
    start = color(map(mouseY, 0, midpoint, 0, 2), map(mouseY, 0, midpoint, 10, 88), map(mouseY, 0, midpoint, 255, 189));
    end = color(map(mouseY, 0, midpoint, 255, 255), map(mouseY, 0, midpoint, 255, 150), map(mouseY, 0, midpoint, 255, 0));
  }
  // create a different gradient for the bottom
  else {
    start = color(map(mouseY, midpoint, height, 2, 0), map(mouseY, midpoint, height, 88, 0), map(mouseY, midpoint, height, 189, 0));
    end = color(map(mouseY, midpoint, height, 255, 0), map(mouseY, midpoint, height, 150, 0), 0);
  }

  // use lerpColor() to create the gradient!
  for (int y=0; y<height; y++) {
    float lerpInterval = map(y, 0, height, 0, 1);
    color s = lerpColor(start, end, lerpInterval);
    stroke(s);
    line(0, y, width, y);
  }
}


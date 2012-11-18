/*
ELASTIC BALL
Jeff Thompson
August 2011

*/

int focusX, focusY;
int gravity = 10;
int focusSize = 8;
int slideX;

void setup() {

  size(800, 800);
  smooth();
}

void draw() {

  background(0);

  if (mousePressed) {
    focusX = mouseX;
    focusY = mouseY;
  }
  else {
    fall();
  }

  fill(255);
  ellipse(focusX, focusY, focusSize, focusSize);

  noFill();
  stroke(255);
  for (int i=0; i<=width; i+=100) {
    line(i, height, focusX, focusY);
  }
}

void mouseReleased () {
  gravity = (height-focusY)/15;
  
  if (focusX >= width/2) {
    slideX = -1;
  }
  else {
    slideX = 1;
  }
}

void fall() {

  if (focusY <= height-focusSize) {
    focusX += slideX;
    focusY += gravity;
  }
  else {
    focusY = height-focusSize+1;    // +1 so it doesn't flip-flop over and over...
  }
}


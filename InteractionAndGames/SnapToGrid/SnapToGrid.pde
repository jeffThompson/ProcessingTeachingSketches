
/*
SNAP TO GRID
Jeff Thompson | 2013 | www.jeffreythompson.org

Surprisingly simple system for snapping an object to
a grid - rounding! By dividing the position by the grid
size (as an integer) and multiplying back into place
by the grid size, objects snap to the gridlines!
*/

int gridSize = 50;  // grid size in pixels
int x, y;           // x/y coordinates for a rectangle


void setup() {
  size(500,500);
}


void draw() {  
  background(255);
  
  // draw gridlines
  stroke(0,150,255, 50);
  for (int x=0; x<width; x+=gridSize) {
    line(x,0, x,height);
  }
  for (int y=0; y<width; y+=gridSize) {
    line(0,y, width,y);
  }
  
  // set location of rectangle using mouse
  x = (mouseX/gridSize) * gridSize;    // this snaps to the grid along the x axis
  y = (mouseY/gridSize) * gridSize;    // ditto y axis
  
  // draw the rectangle!
  noStroke();
  fill(255,0,0);
  rect(x,y, gridSize,gridSize);
}




/*
PARALLEL LINES
Jeff Thompson | 2012 | www.jeffreythompson.org

Draws parallel lines using an offset.

*/

int offset =     5;        // how far apart to draw the lines

float x, y, pX, pY;        // line variables (x,y, previous x,y)


void setup() {
  size(600,600);
  
  background(255);       // set background once so drawing accumulates
}

void draw() {
    
  // set x/y to mouse coordinates
  x = mouseX;
  y = mouseY;
  
  // move origin to x,y location and find length of line
  pushMatrix();
  translate(x, y);
  float d = dist(x, y, pX, pY);
      
  // calculate angle between current and previous
  float a = atan2(pY-y, pX-x);
  
  // rotate by 90º so the line faces the direction of movement
  rotate(a - HALF_PI);
  
  // draw the main line
  stroke(0, 100);
  line(0,0, 0,d);
  
  // draw the parallel line
  stroke(0, 255, 0, 100);
  line(offset,0, offset,d);
  
  popMatrix();
  
  // set current coords to previous
  pX = x;
  pY = y;
}



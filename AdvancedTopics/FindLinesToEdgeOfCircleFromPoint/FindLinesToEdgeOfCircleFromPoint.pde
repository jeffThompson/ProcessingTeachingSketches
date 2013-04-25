
/*
FIND LINES TO EDGE OF CIRCLE FROM POINT
Jeff Thompson | 2013 | www.jeffreythompson

Given a point and the center of a circle, find the
two outer points of the circle.

Click-and-drag the circle to move it around the screen.
*/

float radius = 100;    // circle's radius
float cx,cy;           // circle x/y
float px,py;           // point x/y

void setup() {
  
  // basic setup
  size(400, 400);
  strokeWeight(2);

  // set circle in center, point towards the bottom
  cx = width/2;
  cy = height/2;
  px = width/2;
  py = height-30;
}

void draw() {

  background(80);
  noStroke();

  // draw the circle
  fill(255);
  ellipse(cx, cy, radius*2, radius*2);

  // draw the point
  fill(0);
  ellipse(px, py, 10, 10);

  // draw a line between the two
  stroke(0);
  line(px, py, cx, cy);

  // calculate the tangents!
  float angle = atan2(cy-py, cx-px);            // angle between the point and circle

  float lx = cx + radius * cos(angle-HALF_PI);  // lefthand-side point is -90º from the line
  float ly = cy + radius * sin(angle-HALF_PI);
  line(px, py, lx, ly);

  float rx = cx + radius * cos(angle+HALF_PI);  // righthand-side is 90º from line
  float ry = cy + radius * sin(angle+HALF_PI);
  line(px, py, rx, ry);
}

// click-and-drag circle to move!
void mouseDragged() {
  if (mouseX > cx - radius && mouseX < cx+radius && mouseY > cy-radius && mouseY < cy+radius) {
    cx = mouseX;
    cy = mouseY;
  }
}


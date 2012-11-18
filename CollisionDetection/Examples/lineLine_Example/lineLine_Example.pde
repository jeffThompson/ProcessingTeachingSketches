/*
LINE/LINE COLLISION DETECTION
 Jeff Thompson
 Fall 2011
 
 www.jeffreythompson.org
 */

// requires all position values be floats - will NOT work with ints
float youStartX, youStartY;      // x,y position of "you" - fixed starting point
float youX, youY;                // x,y position - this moves based on the mouse

float lineX1, lineY1, lineX2, lineY2;

void setup() {

  // BASIC SETUP STUFF
  size(400, 400);
  smooth();
  noCursor();
  strokeWeight(3);    // makes seeing things a little easier

  // PLACE FIXED "YOU" POINT IN UPPER-LEFT CORNER
  youStartX = 0;
  youStartY = 0;

  // POSITION FIXED LINE ACROSS THE SCREEN
  lineX1 = 0;
  lineY1 = height;
  lineX2 = width;
  lineY2 = 0;
}

void draw() {

  // REDRAW EACH FRAME
  background(255);

  // DRAW "YOU"
  youX = mouseX;
  youY = mouseY;
  stroke(255, 0, 0);
  line(youStartX, youStartY, youX, youY);

  // TEST FOR COLLISION
  // returns true if hit, false if not
  if (lineLine(youX, youY, youStartX, youStartY, lineX1, lineY1, lineX2, lineY2) == true) {
    stroke(0, 200);
  }
  else {
    stroke(200);
  }

  // DRAW STATIC LINE
  line(lineX1, lineY1, lineX2, lineY2);
}

/* 
 LINE/LINE COLLISION FUNCTION
 Based on the tutorial by Paul Bourke (thanks!):
 http://paulbourke.net/geometry/lineline2d
 ... and Ibackstrom (thanks!)
 http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=geometry2
 
 Takes 8 arguments:
 + x,y positions of start and end of one line (in this case, the moving one)
 + x,y positions of start and end of the other line (in this case, the fixed one)
 
 Note: all values must be floats, otherwise rounding from ints will cause
 errors on one side of the line
 */

boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // find uA and uB
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // note: if the below equations is true, the lines are parallel
  // ... this is the denominator of the above equations
  // (y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)

  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // find intersection point, if desired
    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));
    noStroke();
    fill(0);
    ellipse(intersectionX, intersectionY, 10,10);

    return true;
  }
  else {
    return false;
  }
}


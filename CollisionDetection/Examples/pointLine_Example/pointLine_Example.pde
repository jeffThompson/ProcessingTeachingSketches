/*
POINT/LINE COLLISION DETECTION
 Jeff Thompson
 Fall 2011
 
 www.jeffreythompson.org
 */

// requires all position values be floats - will NOT work with ints
float youX, youY;      // x,y position of "you"
int speed = 2;         // speed to move you around
// note no size since a point has no width or height

float lineX1, lineY1, lineX2, lineY2;

void setup() {

  // BASIC SETUP STUFF
  size(400, 400);
  smooth();
  strokeWeight(3);    // makes seeing things a little easier

  // PLACE "YOU" IN THE UPPER-LEFT QUADRANT
  youX = width/4;
  youY = height/4;

  // POSITION LINE ACROSS THE SCREEN
  lineX1 = 0;
  lineY1 = height;
  lineX2 = width;
  lineY2 = 0;
}

void draw() {

  // REDRAW EACH FRAME
  background(255);

  // TEST FOR COLLISION
  // returns true if hit, false if not
  if (pointLine(youX,youY, lineX1,lineY1, lineX2,lineY2) == true) {
    stroke(0);
  }
  else {
    stroke(200);
  }

  // DRAW STATIC BALL
  line(lineX1,lineY1, lineX2,lineY2);

  // DRAW "YOU"
  stroke(255, 0, 0);
  point(youX, youY);

  // IF ARROW KEYS ARE PRESSED, UPDATE "YOU" POSITION
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        youX -= speed;
      }
      if (keyCode == RIGHT) {
        youX += speed;
      }
      if (keyCode == UP) {
        youY -= speed;
      }
      if (keyCode == DOWN) {
        youY += speed;
      }
    }
  }
}

/* 
 POINT/LINE COLLISION FUNCTION
 
 Takes 6 arguments:
 + x,y position of the point
 + start x,y and end x,y of the line
 
 Note: all values must be floats, otherwise rounding from ints will cause
 errors on one side of the line
 */

boolean pointLine(float px, float py, float lx1, float ly1, float lx2, float ly2) {
  
  // get the slope of the entire line
  float lineSlope = (ly2-ly1)/(lx2-lx1);
  
  // get slope from one end of the line to the point
  float pointSlope = (ly2-py)/(lx2-px);
  
  // if the slopes are the same, then the point is on the line!
  if (lineSlope == pointSlope) {
    return true;
  }
  else {
    return false;
  }
  
}


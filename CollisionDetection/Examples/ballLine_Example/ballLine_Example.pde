/*
BALL/LINE COLLISION DETECTION
 Jeff Thompson
 Fall 2011
 
 Based on a post by Philip Nicoletti (thanks!)
 http://www.codeguru.com/forum/showthread.php?threadid=194400
 
 www.jeffreythompson.org
 */

// requires all position values be floats - will NOT work with ints
float youX, youY;      // x,y position of "you"
int youSize = 30;      // diameter of ball
int speed = 2;         // speed to move you around

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

  // DRAW "YOU"
  noStroke();
  fill(255, 0, 0);
  ellipse(youX, youY, youSize, youSize);

  // TEST FOR COLLISION
  // returns true if hit, false if not
  if (ballLine(youX, youY, youSize, lineX1, lineY1, lineX2, lineY2) == true) {
    stroke(0, 100);
  }
  else {
    stroke(200);
  }

  // DRAW STATIC LINE
  line(lineX1, lineY1, lineX2, lineY2);

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
 BALL/LINE COLLISION FUNCTION
 Based on the example by Philip Nicoletti
 http://www.codeguru.com/forum/showthread.php?threadid=194400
 
 Takes 7 arguments:
 + x,y position of the point
 + diameter of ball (assumes a circle - ellipse collision is REALLY hard)
 + start x,y and end x,y of the line
 
 Note: all values must be floats, otherwise rounding from ints will cause
 errors on one side of the line
 */

boolean ballLine(float bx, float by, int d, float lx1, float ly1, float lx2, float ly2) {

  // first get the length of the line using the Pythagorean theorem
  float distX = lx1-lx2;
  float distY = ly1-ly2;
  float lineLength = sqrt((distX*distX) + (distY*distY));

  // then solve for r
  float r = (((bx-lx1)*(lx2-lx1))+((by-ly1)*(ly2-ly1)))/pow(lineLength, 2);

  // get x,y points of the closest point
  float closestX = lx1 + r*(lx2-lx1);
  float closestY = ly1 + r*(ly2-ly1);

  // to get the length of the line, use the Pythagorean theorem again
  float distToPointX = closestX - bx;
  float distToPointY = closestY - by;
  float distToPoint = sqrt(pow(distToPointX, 2) + pow(distToPointY, 2));

  // for explanation purposes, draw a line to the ball from the closest point
  strokeWeight(1);
  stroke(255,0,0);
  line(closestX, closestY, bx, by);
  strokeWeight(3);

  // if that distance is less than the radius of the ball: collision
  if (distToPoint <= d/2) {
    return true;
  }
  else {
    return false;
  }
}


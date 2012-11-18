/*
RECT/BALL COLLISION DETECTION
 Jeff Thompson
 Fall 2011
 
 Built from this fantastic example by Matt Worden:
 http://vband3d.tripod.com/visualbasic/tut_mixedcollisions.htm
 
 www.jeffreythompson.org
 */

int youX, youY;        // x,y position of "you"
int youW = 50;         // width
int youH = 50;         // height
int speed = 2;         // speed to move you around

int ballX, ballY;      // x,y position of the ball - will be randomly placed in the setup
int ballSize = 30;    // assumes a circle - elliptical collision is VERY complicated


void setup() {

  // BASIC SETUP STUFF
  size(400, 400);
  smooth();
  noStroke();
  rectMode(CENTER);  // draw from center

  // PLACE "YOU" IN THE CENTER
  youX = width/2;
  youY = height/2;

  // STATIC BALL IN RANDOM POSITION ON SCREEN
  ballX = int(random(ballSize, width-ballSize));
  ballY = int(random(ballSize, height-ballSize));
}

void draw() {

  // REDRAW EACH FRAME
  background(255);

  // TEST FOR COLLISION
  // returns true if hit, false if not
  if (rectBall(youX, youY, youW, youH, ballX, ballY, ballSize) == true) {
    fill(0);
  }
  else {
    fill(200);
  }

  // DRAW STATIC BALL
  ellipse(ballX, ballY, ballSize, ballSize);

  // DRAW "YOU"
  fill(255, 0, 0);
  rect(youX, youY, youW, youH);

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
 RECT/BALL COLLISION FUNCTION
 Actually quite a bit harder than it looks!
 Built from an example by Matt Worden (http://vband3d.tripod.com/visualbasic/tut_mixedcollisions.htm)
 
 Takes 7 arguments:
 + x,y position of the first ball - in this case "you"
 + width and height of rect
 + x,y position of the second ball
 + diameter of second ball
 
 */

boolean rectBall(int rx, int ry, int rw, int rh, int bx, int by, int d) {

  // first test the edges (this is necessary if the rectangle is larger
  // than the ball) - do this with the Pythagorean theorem

  // if ball entire width position is between rect L/R sides
  if (bx+d/2 >= rx-rw/2 && bx-d/2 <= rx+rw/2 && abs(ry-by) <= d/2) {
    return true;
  }
  // if not, check if ball's entire height is between top/bottom of the rect
  else if (by+d/2 >= ry-rh/2 && by-d/2 <= ry+rh/2 && abs(rx-bx) <= d/2) {
    return true;
  }

  // if that doesn't return a hit, find closest corner
  // this is really just a point, so we can test if we've hit it 
  // upper-left
  float xDist = (rx-rw/2) - bx;  // same as ball/ball, but first value defines point, not center
  float yDist = (ry-rh/2) - by;
  float shortestDist = sqrt((xDist*xDist) + (yDist * yDist));

  // upper-right
  xDist = (rx+rw/2) - bx;
  yDist = (ry-rh/2) - by;
  float distanceUR = sqrt((xDist*xDist) + (yDist * yDist));
  if (distanceUR < shortestDist) {  // if this new distance is shorter...
    shortestDist = distanceUR;      // ... update
  }

  // lower-right
  xDist = (rx+rw/2) - bx;
  yDist = (ry+rh/2) - by;
  float distanceLR = sqrt((xDist*xDist) + (yDist * yDist));
  if (distanceLR < shortestDist) {
    shortestDist = distanceLR;
  }

  // lower-left
  xDist = (rx-rw/2) - bx;
  yDist = (ry+rh/2) - by;
  float distanceLL = sqrt((xDist*xDist) + (yDist * yDist));
  if (distanceLL < shortestDist) {
    shortestDist = distanceLL;
  }

  // test for collision
  if (shortestDist < d/2) {  // if less than radius
    return true;             // return true
  }
  else {                     // otherwise, return false
    return false;
  }
}


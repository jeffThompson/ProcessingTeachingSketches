/*
BALL/BALL COLLISION DETECTION
 Jeff Thompson
 Fall 2011
 
 www.jeffreythompson.org
 */

int youX, youY;        // x,y position of "you"
int youSize = 30;      // assumes a circle - elliptical collision is VERY complicated
int speed = 2;         // speed to move you around

int ballX, ballY;      // x,y position of the ball - will be randomly placed in the setup
int ballSize = 100;    // assumes a circle - elliptical collision is VERY complicated


void setup() {

  // BASIC SETUP STUFF
  size(400, 400);
  smooth();
  noStroke();

  // PLACE "YOU" IN THE CENTER
  youX = width/2;
  youY = height/2;

  // STATIC RECTANGLE IN RANDOM POSITION ON SCREEN
  ballX = int(random(ballSize, width-ballSize));
  ballY = int(random(ballSize, height-ballSize));
}

void draw() {

  // REDRAW EACH FRAME
  background(255);

  // TEST FOR COLLISION
  // returns true if hit, false if not
  if (ballBall(youX, youY, youSize, ballX, ballY, ballSize) == true) {
    fill(0);
  }
  else {
    fill(200);
  }

  // DRAW STATIC BALL
  ellipse(ballX, ballY, ballSize, ballSize);

  // DRAW "YOU"
  fill(255, 0, 0);
  ellipse(youX, youY, youSize,youSize);

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
 BALL/BALL COLLISION FUNCTION
 Takes 6 arguments:
 + x,y position of the first ball - in this case "you"
 + diameter of first ball - elliptical collision is VERY difficult
 + x,y position of the second ball
 + diameter of second ball
 
 */
boolean ballBall(int x1, int y1, int d1, int x2, int y2, int d2) {

  // find distance between the two objects
  float xDist = x1-x2;                                   // distance horiz
  float yDist = y1-y2;                                   // distance vert
  float distance = sqrt((xDist*xDist) + (yDist*yDist));  // diagonal distance

  // test for collision
  if (d1/2 + d2/2 > distance) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}


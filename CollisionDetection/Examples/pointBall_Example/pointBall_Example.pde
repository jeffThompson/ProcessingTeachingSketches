/*
POINT/BALL COLLISION DETECTION
Jeff Thompson
Fall 2011

A bit more difficult than point/rectangle, since we need to use
the Pythagorean theorem to find the distance between the two objects.

www.jeffreythompson.org
*/

int youX, youY;        // x,y position of "you"
int speed = 2;         // speed to move you around
// note there is no size, since a point is assumed to be infinitely small

int ballX, ballY;      // x,y position of the ball - will be randomly placed in the setup
int ballSize = 100;    // assumes a circle - elliptical collision is VERY complicated


void setup() {

  // BASIC SETUP STUFF
  size(400, 400);
  smooth();
  strokeWeight(3);   // we'll make the point a bit bigger so it is easy to see

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
  if (pointBall(youX, youY, ballX, ballY, ballSize) == true) {
    fill(0);
  }
  else {
    fill(200);
  }
  
  // DRAW STATIC BALL
  ellipse(ballX, ballY, ballSize,ballSize);
  
  // DRAW "YOU"
  stroke(255, 0, 0);
  point(youX, youY);
  noStroke();

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
POINT/BALL COLLISION FUNCTION
Takes 5 arguments:
  + x,y position of the point - in this case "you"
  + x,y position of the ball
  + diameter of ball - elliptical collision is VERY difficult
*/
boolean pointBall(int px, int py, int bx, int by, int bSize) {
  
  // find distance between the two objects
  float xDist = px-bx;                                   // distance horiz
  float yDist = py-by;                                   // distance vert
  float distance = sqrt((xDist*xDist) + (yDist*yDist));  // diagonal distance
  
  // test for collision
  if (bSize/2 > distance) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}


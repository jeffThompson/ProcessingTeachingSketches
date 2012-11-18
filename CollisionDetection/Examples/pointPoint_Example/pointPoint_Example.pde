/*
POINT/POINT COLLISION DETECTION
Jeff Thompson
Fall 2011

Note: it's VERY hard to actually hit two points together, since to do so they
would need to share a single pixel.

www.jeffreythompson.org
*/

int youX, youY;        // x,y position of "you"
int speed = 1;         // speed to move you around
int pointX, pointY;    // x,y position of other point - will be randomly placed in the setup
// note there are no sizes, since a point is assumed to be infinitely small


void setup() {

  // BASIC SETUP STUFF
  size(200, 200);
  smooth();
  strokeWeight(3);  // we'll make it a bit bigger so it is easy to see

  // PLACE "YOU" IN THE CENTER
  youX = width/2;
  youY = height/2;

  // STATIC POINT IN RANDOM POSITION ON SCREEN
  pointX = int(random(2, width-2));
  pointY = int(random(2, height-2));
}

void draw() {

  // REDRAW EACH FRAME
  background(255);

  // TEST FOR COLLISION
  // returns true if hit, false if not
  if (pointPoint(youX, youY, pointX, pointY) == true) {
    println("It's a hit!");    // print to let us know, since the objects are too small to see color changes
  }
  
  // DRAW STATIC POINT
  stroke(0);
  point(pointX, pointY);
  
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
POINT/POINT COLLISION FUNCTION
Takes 4 arguments:
  + x,y position of point 1 - in this case "you"
  + x,y position of point 2 - in this case the static point 
*/
boolean pointPoint(int x1, int y1, int x2, int y2) {
  
  // test for collision
  if (x1 == x2 && y1 == y2) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}


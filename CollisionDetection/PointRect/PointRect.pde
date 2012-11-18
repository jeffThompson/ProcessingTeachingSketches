/*
POINT/RECT COLLISION DETECTION
Jeff Thompson
Fall 2011

www.jeffreythompson.org
*/

int youX, youY;        // x,y position of "you"
int speed = 1;         // speed to move you around
// note there is no size, since a point is assumed to be infinitely small

int rectX, rectY;      // x,y position of the rectangle - will be randomly placed in the setup
int rectW = 100;
int rectH = 100;


void setup() {

  // BASIC SETUP STUFF
  size(400, 400);
  smooth();
  rectMode(CENTER);  // draw rectangle from center out
  strokeWeight(3);   // we'll make the point a bit bigger so it is easy to see

  // PLACE "YOU" IN THE CENTER
  youX = width/2;
  youY = height/2;

  // STATIC RECTANGLE IN RANDOM POSITION ON SCREEN
  rectX = int(random(rectW, width-rectW));
  rectY = int(random(rectH, height-rectH));
}

void draw() {

  // REDRAW EACH FRAME
  background(255);

  // TEST FOR COLLISION
  // returns true if hit, false if not
  if (pointRect(youX, youY, rectX, rectY, rectW, rectH) == true) {
    fill(0);
  }
  else {
    fill(200);
  }
  
  // DRAW STATIC RECT
  rect(rectX, rectY, rectW,rectH);
  
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
POINT/RECT COLLISION FUNCTION
Takes 6 arguments:
  + x,y position of point 1 - in this case "you"
  + x,y position of point 2 - in this case the static rectangle
  + width and height of rectangle
*/
boolean pointRect(int px, int py, int rx, int ry, int rw, int rh) {
  
  // test for collision
  if (px >= rx-rw/2 && px <= rx+rw/2 && py >= ry-rh/2 && py <= ry+rh/2) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}


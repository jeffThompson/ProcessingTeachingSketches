/*
RECT/RECT COLLISION DETECTION
Jeff Thompson
Fall 2011

www.jeffreythompson.org
*/

int youX, youY;        // x,y position of "you"
int youSize = 10;      // size - assumes square, though that isn't necessary in the code
int speed = 2;         // speed to move you around

int rectX, rectY;      // x,y position of rectangle - will be randomly placed in the setup
int rectW = 50;        // width of rectangle to test
int rectH = 50;        // height of rectangle to test


void setup() {

  // BASIC SETUP STUFF
  size(400, 400);
  noStroke();
  smooth();
  rectMode(CENTER);  // draw rectangles from the center out

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
  if (rectRect(youX, youY, youSize, youSize, rectX, rectY, rectW, rectH) == true) {
    fill(0);                           // if hit, fill black
  }
  else {                               // otherwise, fill light gray
    fill(200);
  }
  
  // DRAW STATIC RECTANGLE
  rect(rectX, rectY, rectW, rectH);
  
  // DRAW "YOU"
  fill(255, 0, 0);
  rect(youX, youY, youSize, youSize);

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
RECT/RECT COLLISION FUNCTION
Takes 8 arguments:
  + x,y position of object 1 - in this case "you"
  + width and height of object 1 - also "you"
  + x,y position of object 2 - in this case the static rectangle
  + width and height of object 2
  
*/
boolean rectRect(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
  
  // test for collision
  if (x1+w1/2 >= x2-w2/2 && x1-w1/2 <= x2+w2/2 && y1+h1/2 >= y2-h2/2 && y1-h1/2 <= y2+h2/2) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}



/*
PARALLEL LINES
Jeff Thompson | 2012 | www.jeffreythompson.org

Draws parallel lines - hold down spacebar to draw!
*/

int offset = 5;          // how far apart to draw the lines
float x, y, pX, pY;      // line variables (x,y, previous x,y)
boolean drawIt = false;  // drawing on/off

void setup() {
  size(640, 480);
  smooth();
  background(255);       // set background once so drawing accumulates
}

void draw() {

  if (drawIt) {
    
    // set variables (easier to deal with)
    x = mouseX;
    y = mouseY;

    // move to x,y location and find length of line
    pushMatrix();
    translate(x, y);
    float d = dist(x, y, pX, pY);
        
    // calculate angle between current and previous
    float a = atan2(pY-y, pX-x);
    rotate(a - HALF_PI);            // a hack, but necesssary for correct angle
  
    // draw the main line
    stroke(0, 100);
    line(0, 0, 0, d);

    // draw the parallel line
    stroke(0, 255, 0, 100);
    line(offset,0, offset, d);

    // reset matrix and set previous x,y to current
    popMatrix();
    pX = x;
    pY = y;
  }
}

// if spacebar is pressed - draw; if released, don't
void keyPressed() {
  if (key == 32) {        // 32 = spacebar in ASCII
    drawIt = true;
  }
}
void keyReleased() {
  if (key == 32) {
    drawIt = false;
  }
}


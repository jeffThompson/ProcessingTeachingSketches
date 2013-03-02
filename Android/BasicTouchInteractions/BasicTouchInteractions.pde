/*
BASIC TOUCH INTERACTIONS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Basic touch interaction is handled through Processing's built-in
 mouseX and mouseY variables.
 
 CHALLENGE:
 1. The previous mouse position can be called using pmouseX and pmouseY
 variables - can you use those to find the trajectory of the mouse
 movement and toss the ball around the screen? Can you add bouncing
 when the ball hits the sides?
 */

void setup() {
  smooth();
  noStroke();

  mouseX = width/2;    // set mouse to center - if we don't do this,
  mouseY = height/2;   // the cursor will start in the corner!
}

void draw() {
  background(70, 150, 0);

  // draw a circle at the mouse position; change color when touching
  // the screen!
  if (mousePressed == true) {
    fill(255);
  }
  else {
    fill(0);
  }
  ellipse(mouseX, mouseY, 250, 250);
}

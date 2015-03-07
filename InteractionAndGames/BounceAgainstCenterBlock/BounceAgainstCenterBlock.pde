
/*
BOUNCE AGAINST CENTER BLOCK
 Jeff Thompson | 2015 | www.jeffreythompson.org
 
 Bouncing off an object on the sides of the window is
 easy - we just reverse the direction depending on
 whether it's the top/bottom or left/right.
 
 But what about an object in the center?
 
 In this simplified example, we can think of the box as
 a set of four triangles:
 
 +--+
 |\/| <-- O
 |/\|
 +--+
 
 If we check for the ball colliding with each triangle,
 we know which side is hit!
 
 */

int ballSize =     10;    // diameter of the ball
float ballX =      20;    // starting position
float ballY =      10;
float ballSpeedX = 2;     // speed
float ballSpeedY = 2;

int rectX =        300;   // center of square
int rectY =        300;
int rectSize =     100;   // size of square


void setup() {
  size(600, 600);
}


void draw() {
  background(230);

  // draw square in the center
  fill(255, 150, 0);
  stroke(0, 100);
  rectMode(CENTER);
  rect(rectX, rectY, rectSize, rectSize);
  line(rectX-rectSize/2, rectY-rectSize/2, rectX+rectSize/2, rectY+rectSize/2);
  line(rectX+rectSize/2, rectY-rectSize/2, rectX-rectSize/2, rectY+rectSize/2);

  // draw ball
  fill(0);
  noStroke();
  ellipse(ballX, ballY, ballSize, ballSize);

  // update ball position
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  // bounce off edges of the window
  if (ballX - ballSize/2 < 0 || ballX + ballSize/2 > width) ballSpeedX *= -1;
  if (ballY - ballSize/2 < 0 || ballY + ballSize/2 > height) ballSpeedY *= -1;

  // bounce off square in center, using a custom function that returns "true" if it hits, then reverses direction

  // top edge
  if (hitEdge(rectX, rectY, rectX-rectSize/2, rectY-rectSize/2, rectX+rectSize/2, rectY-rectSize/2, int(ballX), int(ballY))) {
    ballSpeedY *= -1;
  }

  // bottom edge
  else if (hitEdge(rectX, rectY, rectX-rectSize/2, rectY+rectSize/2, rectX+rectSize/2, rectY+rectSize/2, int(ballX), int(ballY))) {
    ballSpeedY *= -1;
  }

  // right edge
  else if (hitEdge(rectX, rectY, rectX+rectSize/2, rectY-rectSize/2, rectX+rectSize/2, rectY+rectSize/2, int(ballX), int(ballY))) {
    ballSpeedX *= -1;
  }

  // left edge
  else if (hitEdge(rectX, rectY, rectX-rectSize/2, rectY-rectSize/2, rectX-rectSize/2, rectY+rectSize/2, int(ballX), int(ballY))) {
    ballSpeedX *= -1;
  }
}


// function to determine if a point (the ball's position) is colliding
// with a triangle (the side of the square)
// if it is, it returns "true", if not then "false"
boolean hitEdge(int x1, int y1, int x2, int y2, int x3, int y3, int px, int py) {
  int a0 = abs((x2-x1)*(y3-y1)-(x3-x1)*(y2-y1));
  int a1 = abs((x1-px)*(y2-py)-(x2-px)*(y1-py));
  int a2 = abs((x2-px)*(y3-py)-(x3-px)*(y2-py));
  int a3 = abs((x3-px)*(y1-py)-(x1-px)*(y3-py));
  return abs(a1+a2+a3 - a0) <= 1/256;
}


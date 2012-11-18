/*
 PONG
 Jeff Thompson
 October 2010
 
 A version of "Pong" for one person.
 
 Includes the basic game with a few extras:
   - Keeps score graphically
   - Paddle gets smaller with every successful volley
 
 www.jeffreythompson.org
 */

// BALL
float ballX, ballY;
float ballSpeedX = 5.0;
float dirX = 1;
float ballSpeedY = 2.0;
float dirY = 1;
int ballSize = 5;

// PADDLE
int paddleWidth = 5;
int paddleHeight = 30;
int hit = 0;
float paddleLeftEdge;

// OTHER VARIABLES
int maxScore = 100;


void setup()
{
  size(1000,300);
  smooth();
  frameRate(30);
  ellipseMode(RADIUS);  // draw all ellipses from center out
  rectMode(RADIUS);     // same for rectangles
  strokeCap(SQUARE);    // make all lines have square ends
}

void draw()
{
  // IF THE FIRST FRAME DO THE FOLLOWING
  if(frameCount <= 1) { 
  ballX = width/2; ballY = height/2;                   // start ball in center*
  paddleLeftEdge = width - paddleWidth - ballSize;     // ... and declare variable for the left edge of the paddle*
  }                                                    // ** these have to be defined here because "size" is in setup
  
  // CLEAR THE WINDOW TO REDRAW EACH FRAME, DRAW DIVIDER, TALLY SCORE
  fill(100,100,100);                  // fill color (4 values makes "trails")
  rect(0,0, width,height);            // clear the screen to redraw
  
  rectMode(CORNER);                   // draw from the corner, not the center
  fill(255);                          // make white
  rect(0,0, 5,(height/maxScore)*hit);      // draw a vertical rectangle for score; scaled for variable window size to a max of 100pts
  rectMode(RADIUS);                   // set back to "radius" mode
  
  noFill();                           // no fill, stroke parameters for dividing line
  strokeWeight(2);
  stroke(255);
  for (int i=0; i<=height; i+=20){    // automatically draw the dividing line; for a 10px gap increment length + gap = 20px
    line(width/2, i, width/2, i+10);  // draw lines down the middle that are 10px long
  }

  // UPDATE PADDLE
  fill(255);
  float paddleY = constrain(mouseY, paddleHeight, height-paddleHeight);  // create a variable that follows the mouse's Y position
  rect(width-paddleWidth,paddleY, paddleWidth,paddleHeight);             // ... then draw the paddle along the left-hand side

  // TEST IF BALL HITS RIGHT SIDE
  if(ballX > width+ballSize) {                 // if ball is past right side...
    ballX = width/2;                           // place it at the center...
    ballY = height/2;
    ballSpeedX = 5;                            // and reset speeds for X and Y directions
    ballSpeedY = 2;
    // ballX = random(0, width-ballSize);      // ... or place the ball in a random spot
    // ballY = random(0, height-ballSize);
    paddleHeight = 30;                         // reset ball size (only for decreasing ball size below)
    hit = 0;                                   // and reset "hit"
    println(hit);                              // print score
  }

  // TEST IF BALL HITS TOP or BOTTOM
  if(ballY < 0 || ballY > height-ballSize) {   // if ball is above the top (0) or below the bottom
    dirY *= -1;                                // reverse the Y direction
  }

  // TEST IF BALL HITS LEFT SIDE
  if(ballX < 0) {                              // if ball is past right side (0)
    dirX *= -1;                                // reverse the X direction
  }

  // TEST IF BALL HAS HIT PADDLE
  // this is a complicated way to see if the point is within a range of points
  if(ballX == paddleLeftEdge                            // if ball has crossed the left edge of the paddle
  && ballY > paddleY - (paddleHeight) - ballSize        // and the ball's Y position is greater than the bottom of the paddle
  && ballY < paddleY + (paddleHeight) + ballSize) {     // and is less than the top of the paddle
    dirX *= -1;                                         // then reverse direction
    hit = hit+1;                                        // variable to record hits (used for scoring)
    println(hit);                                       // print score

    if(mouseY != pmouseY) {                    // if, at the same time, the current mouse position is not equal to the previous frame
      ballSpeedY = (mouseY - pmouseY)/2.0;     // ... change Y speed to (current mouse - previous mouse)/2
      if(ballSpeedY > 5.0) {                   // if speed is larger than 5 (maximum we decide on, can be changed)
        ballSpeedY = 5.0;                      // set to max...
      }
      if(ballSpeedY < -5.0) {                  // .. or do the opposite if below -5
        ballSpeedY = -5.0;
      }
    }
    if(paddleHeight > 5);            // fancy code to shink paddle when ball hits (so long as it's larger than 5px)
    paddleHeight = paddleHeight-2;   // ... shrink the paddle by 1px
  }

  // UPDATE BALL VARIABLES
  ballX = ballX + (ballSpeedX * dirX);        // make the ball's X coordinate = to it's current coord + (the speed x direction)
  ballY = ballY + (ballSpeedY * dirY);

  // DRAW BALL
  fill(255);                                  // ball color, etc
  noStroke();
  ellipse(ballX, ballY, ballSize, ballSize);  // draw ball centered on X,Y coords at the size determined at the top
  
  // RESET AT MAX SCORE
  if(hit > maxScore) { hit = 0; }

}


/*
INCREMENTAL MOVEMENT and BASIC KEYBOARD INTERACTION
 Jeff Thompson
 April 2011
 
 Uses keyPressed commands to move a circle using the arrow keys and bounces
 a red ball, reversing direction when it hits the sides of the screen.
 
 www.jeffreythompson.org
  
 */

// "YOU" VARIABLES
float youX,youY;        // floats (as opposed to ints) allows slower than 1px movement
float youSpeed = 0.5;
int youSize = 10;       // diameter of "you" in pixels

// BOUNCING BALL VARIABLES
float ballX,ballY;
float ballSpeedX = 2;
float ballSpeedY = 5;
int ballSize = 5;       // diamter of the ball in pixels


void setup() {
  
  // basic setup stuff
  size(500,500);
  smooth();
  noStroke();
  
  // start "you" and ball in the center of the screen
  youX = width/2;
  youY = height/2;
  ballX = width/2;
  ballY = height/2;
  
}

void draw() {

  // fill the screen on re-draw
  fill(0,10);                        // black with alpha, leaving nice trails behind
  rect(0,0, width,height);           // fill the screen solid
  
  
  // BOUNCE THE RED BALL 
  
  // update position based on current speed x and y
  ballX += ballSpeedX;
  ballY += ballSpeedY;
  
  // if the ball has hit the sides of the screen, reverse direction
  if (ballX <= 0 || ballX >= width) {    // if at right OR left side
    ballSpeedX *= -1;                    // multiply by -1, reversing direction
  }
  if (ballY <=0 || ballY >= height) {    // if at top OR bottom
    ballSpeedY *= -1;                    // do the same
  }
  
  // draw the ball itself
  fill(255,0,0);
  ellipse(ballX,ballY, ballSize,ballSize);
  
  
  
  // UPDATE "YOU" WHEN ARROW KEYS ARE PRESSED
  
  // check if keys are pressed, and if so which?
  if (keyPressed) {
    if (key == CODED) {                      // arrow keys are special, considered "coded"

      if (keyCode == RIGHT && youX<width) {  // if right and we're not offscreen, update the direction
        youX += youSpeed;                       // increment position to the right
      }
      if (keyCode == LEFT && youX>0) {       // etc
        youX -= youSpeed;
      }
      if (keyCode == UP && youY>0) {         // etc
        youY -= youSpeed;
      }
      if (keyCode == DOWN && youY<height) {  // etc
        youY += youSpeed;
      }
    }
  }
  
  // draw "you" as a circle at x,y
  fill(255);
  ellipse(youX,youY, youSize,youSize);
  
}


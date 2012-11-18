/*
ARRAY for MULTIPLE OBJECT MOVEMENT
 Jeff Thompson
 April 2011
 
 Not the most effective method (especially when the numbers get
 larger, but an easier way to move multiple objects) using arrays. 
 */

int howManyBalls = 100;                          // how many balls to draw
int ballSize = 10;                               // how large are the balls

float [] balls = new float[howManyBalls * 4];    // x4 for x,y, xDirection, yDirection


void setup() {

  size(500,500);
  smooth();
  noStroke();

  // use a for loop to set all balls to random positions and speeds
  // +=4 to step ball by ball (each with 4 values)
  for (int i=0; i<balls.length; i+=4) {    // balls.length returns the # of items in array

    balls[i]    = random(0,width);         // x position
    balls[i+1]  = random(0,height);        // y position

    // simple method for setting x,y speed
    /*
    balls[i+2]  = random(-5,5);            // x speed
    balls[i+3]  = random(-5,5);            // y speed
    */
    
    // alternatively, make speed between -5 and -2, or 2 and 5 (nothing less in either direction)
    // first, generate a value that will make the direction either positive or negative
    int randDirX = int(random(0,2));  // local variable, returns a value of either 0 or 1
    int randDirY = int(random(0,2));  // same for y direction
    
    // uses an if statement to change to -1 or 1 
    if (randDirX == 0) {
      randDirX = -1;
    }
    else { randDirX = 1; }
    if (randDirY == 0) {
      randDirY = -1;
    }
    else { randDirY = 1; }
    
    balls[i+2] = random(2,8) * randDirX;    // multiply by -1/1
    balls[i+3] = random(2,8) * randDirY;    
  }
  
}

void draw() {

  // FILL BACKGROUND ON EACH FRAME
  fill(255);
  rect(0,0, width,height);

  // USE ANOTHER FOR LOOP TO CHECK BALL POSITION, UPDATE POSITION
  fill(0,255,0);
  for (int i=0; i<balls.length; i+=4) {

    // update ball position
    balls[i] += balls[i+2];     // x position + speed x
    balls[i+1] += balls[i+3];   // y position + speed y

    // if the ball has hit the sides of the screen, reverse direction
    if (balls[i] <= 0 || balls[i] >= width) {      // if at right OR left side
      balls[i+2] *= -1;                            // multiply by -1, reversing direction
    }
    if (balls[i+1] <=0 || balls[i+1] >= height) {  // if at top OR bottom
      balls[i+3] *= -1;                            // do the same
    }

    ellipse(balls[i], balls[i+1], ballSize,ballSize);
  }
}



/*
BALL TO MULTI-BALL COLLISION
 Jeff Thompson
 April 2011
 
 Click-and-drag to toss the red ball.
 
 Draw lots of balls using an array; check for collision with the Pythagorean Theorem for
 higher accuracy.
 
 www.jeffreythompson.org
 */

// "you" variables
float youX, youY;
int youSize = 100;                       // diameter in px
int clickBox = 40;                       // smaller box for click testing/drsgging
color youColor = color(255,0,0, 200);
int youR = youSize/2;                    // radius
boolean clickOn = false;                 // used for better interaction; see code below
float youSpX = 0;                        // speed in x direction; start still
float youSpY = 0;                        // speed in y direction

// balls
int numBalls = 1000;                     // how many balls?
int ballSize = 20;                       // how big are they?
float[] balls = new float[numBalls*2];   // create an array with x,y coords for all balls
int ballR = ballSize/2;                  // radius
color ballColor = color(255,127,0, 150);

// collision variables
float distX, distY, distance;           // find distance with Pythagorean Theorem
boolean collision = false;              // store when the two hit each other
float friction = 0.1;                   // how much to decrease speed with each collision

// movement variables
int moveThresh = 1;        // threshold to be considered "moving"; if above you will bounce
boolean autoMove = false;  // automatically move "you" or not

void setup() {

  size(500,500);
  // size(screen.width, screen.height);
  
  smooth();
  noStroke();

  // you in center
  youX = width-100;
  youY = height-100;

  // balls randomly around the screen
  for (int i=0; i<balls.length; i+=2) {

    balls[i] = random(0, width);
    balls[i+1] = random(0, height);    
  }
  
}

void draw() {

  // fill screen
  fill(255);
  rect(0,0, width,height);


  // if clicked on, allow to drag around
  if (mousePressed &&             // click
  mouseX >= youX-clickBox &&      // left
  mouseX <= youX+clickBox &&      // right
  mouseY >= youY-clickBox &&      // top
  mouseY <= youY+clickBox) {      // bottom

    clickOn = true;    // set to true, this will switch back when the mouse is released
  } 
  // if clickOn is true
  if (clickOn) {
    youX = mouseX;
    youY = mouseY;

    // draw Pythagorean coordinates
    /*
    stroke(0, 100);
     noFill();    
     for (int i=0; i<balls.length; i+=2) {
     line(youX,youY, balls[i],balls[i+1]);       // angle
     }
     */

    noStroke();
  }
  // when released, set to false; this is triggered in the mouseReleased function below

  // check for collision and draw balls
  for (int i=0; i<balls.length; i+=2) {

    // find distance between
    distX = abs(youX - balls[i]);
    distY = abs(youY - balls[i+1]);
    distance = sqrt(distX*distX + distY*distY);

    // check for collision based on radii
    // if so, make the balls yellow
    if (youR + ballR > distance) {          // if the size of the two balls is larger than the distance
      ballColor = color(225,240,0, 200);    // change balls to yellow
      
      // friction
      /*
      if (youSpX > 0) {            // subtract amount each time there is a hit, down to 0
        youSpX -= friction;
        println("Speed X: " + youSpX);
      }
      else { 
        youSpX = 0; 
      }
      if (youSpY > 0) {
        youSpY -= friction;
        println("Speed Y: " + youSpY);
      }
      else { 
        youSpY = 0;
      }
      */
    }
    else {
      ballColor = color (255,127,0, 200);   // otherwise, change back to orange
    }


    // draw balls
    fill(ballColor);
    ellipse(balls[i],balls[i+1], ballSize,ballSize);
    // crosshairs
    stroke(0, 100);
    noFill();
    line(balls[i]-ballSize/10,balls[i+1], balls[i]+ballSize/10,balls[i+1]);
    line(balls[i],balls[i+1]-ballSize/10, balls[i],balls[i+1]+ballSize/10);
    noStroke();
  }


  // draw you
  fill(youColor);
  ellipse(youX,youY, youSize,youSize);
  // crosshairs
  stroke(0, 100);
  noFill();
  line(youX-youSize/10,youY, youX+youSize/10,youY);
  line(youX,youY-youSize/10, youX,youY+youSize/10);
  noStroke();

  
  if (clickOn) {
    youSpX = mouseX-pmouseX;    // speed = difference between current and prev mouse coords
    youSpY = mouseY-pmouseY;    // same for y
  }
  
    youX += youSpX;
    youY += youSpY;
  
  
  // check for hitting edges
  if (youX-youR <= 0 || youX+youR >= width) {
    youSpX *= -1;
  }
  if (youY-youR <= 0 || youY+youR >= width) {
    youSpY *= -1;
  }
  
}


void mouseReleased() {     // turn off dragging when the mouse is released
  clickOn = false;
}


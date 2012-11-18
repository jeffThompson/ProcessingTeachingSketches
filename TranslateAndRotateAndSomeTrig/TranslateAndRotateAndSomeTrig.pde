/*
TRANSLATE and ROTATE (aka "Some Trigonometry")
 Jeff Thompson
 April 2011
 
 DESCRIPTION:
 Use the right/down or left/up arrow keys to turn an arrow around in circles.
 
 The slope is calculated from the angle and length of the arrow; x and y
 of the slope are given both as actual pixel sizes as well as scaled from 0-1
 for trajectory.
 
 Pressing the spacebar shoots a small "bullet" out the end of the arrow,
 demonstrating how this can be used for aiming in game design.
 
 
 HOW DOES IT WORK?
 Two simple trigonometric formulas allow us to determine the "rise" and "run"
 of the angle, given the angle in degrees and the length of the hypotenuse ("you").
 
   Rise (x) = youLength * sin(angle in radians)
   Run  (y) = youLength * cos(angle in radians)
   
 
 www.jeffreythompson.org
 */

// ARROW VARIABLES
int youX, youY;                  // starting pt of the line (to be in center of screen)
int youLength = 200;             // length of line
int rotation = 45;               // rotation angle in degrees (start at 45º)

// DISTANCE CALCULATION VARIABLES
float distanceX, distanceY;      // x,y distances scaled for trajectory
float actualDistX, actualDistY;  // actual distance from start to tip (x,y)

// BULLET VARIABLES
int bulletSize = 10;             // diameter in px
float bulletX = -bulletSize;     // start location offscreen (x)
float bulletY = -bulletSize;     // ditto (y)
float bulletSpeedX = 0;          // start still
float bulletSpeedY = 0;
boolean bulletFired = false;

// FONT
PFont font;                      // font for labeling sides


void setup() {

  size(600,600);
  smooth();

  youX = width/2;                       // start line at center x
  youY = youLength+50;                  // slightly off-center (looks nicer)

  font = loadFont("OratorStd-16.vlw");  // load font
  textFont(font, 16);                   // and set at 16pt
}

void draw() {

  // REDRAW OVER EVERY FRAME
  fill(0);
  noStroke();
  rect(0,0, width,height);


  // TEST FOR ARROW KEYS TO ROTATE
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == RIGHT || keyCode == UP) {
        rotation -= 1;          // decrease rotation angle by 1 (counter-clockwise)
      }
      if (keyCode == LEFT || keyCode == DOWN) {
        rotation += 1;          // increase rotation angle by 1 (clockwise)
      }
    }
    else if (key == 32) {       // check for spacebar (ASCII code 32)
      bulletFired = true;       // if pressed, start new bullet
    }
  }

  // IF ROTATION IS PAST TOP, RESET FOR "NICE" NUMBERS
  // this can be removed if you want angles to go below 0 or above 360
  if (rotation < 0) {
    rotation = 360;
  }
  else if (rotation > 360) {
    rotation = 0;
  }
  

  // DRAW THE ARROW
  stroke(255);
  fill(255);
  
  pushMatrix();                          // make a "local" transformation
  translate(youX,youY);                  // put in center
  rotate(radians(rotation));             // rotate
  
  line(0,0, 0,-youLength);               // main angled line
  line(0,-youLength, -5,-youLength+5);   // L arrowhead
  line(0,-youLength, 5,-youLength+5);    // R arrowhead
  ellipse(0,0, 5,5);                     // center dot
  
  popMatrix();                           // reset transformation to draw other shapes


  // FIND RISE and RUN, SCALED FOR TRAJECTORY
  // thank you www.visualtrig.com!
  // first, scale the rise and run for use with speed/trajectory
  distanceX = sin(radians(rotation));                   // must be angle in radians!
  distanceY = -cos(radians(rotation));
  
  if (distanceX < -youLength) {      // 0, 90, 180, 270º returns an very low number
    distanceX = 0;                   // compensate for that (not sure why this happens)
  }
  if (distanceY < -youLength) {
    distanceY = 0;
  }
  
  // then, find actual distance of the lines
  actualDistX = youLength * sin(radians(rotation));     // must be angle in radians!
  actualDistY = -youLength * cos(radians(rotation));
  
  if (actualDistX < -youLength) {      // 0, 90, 180, 270º returns an error # below 0
    actualDistX = 0;                   // compensate for that (not sure why this happens)
  }
  if (actualDistY < -youLength) {
    actualDistY = 0;
  }

  // DRAW RISE and RUN
  stroke(255,50);
  line(youX,youY, youX+actualDistX,youY);                           // horizontal line
  line(youX+actualDistX,youY, youX+actualDistX,youY+actualDistY);   // vertical line
  

  // SHOW INFO ON SCREEN
  noStroke();
  fill(255);
  // formatted string to print, with all pertinent information
  String printStr = "angle:    " + rotation + "º\nactual:   " + actualDistX + "x, " + actualDistY + "y\nscaled:   " + distanceX + "x, " + distanceY +"y";
  text(printStr, 40,height-80);        // write to screen
  text("use arrow keys to rotate, press spacebar to \"shoot\"", 40,40);
  
  // IF FIRED, SET THE BULLET VARIABLES
  if (bulletFired) {                   // if true

    // set variables
    bulletX = youX+actualDistX;        // set to tip of arrow (x)
    bulletY = youY+actualDistY;        // ditto (y)
    bulletSpeedX = distanceX;          // set to scaled trajectory speed
    bulletSpeedY = distanceY;

    // and reset the fired value to avoid retriggering
    bulletFired = false;
  }
  
  
  // DRAW THE ACTUAL BULLET, UPDATE VARIABLES
  fill(255,0,0, 150);
  ellipse(bulletX,bulletY, bulletSize,bulletSize);    // draw bullet
   
  // update position
  bulletX += bulletSpeedX;
  bulletY += bulletSpeedY;

}

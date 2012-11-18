import processing.serial.*;    // load necessary libraries for serial
import cc.arduino.*;           // ... and Arduino communication

/*
ARDUINO CONTROLLED GAME (aka "Shoot a Bunch of Balls")
 Jeff Thompson
 April 2011
 
 Selectively read three of the Arduino's digital pins to control a simple game.  Requires
 the StandardFirmata sketch to be uploaded to the Arduino in order to work (found in the 
 Arduino IDE under File, Examples, StandardFirmata...)
 
 FYI, also runs with arrow keys and spacebar if you don't have an Arduino set up or
 want to experiment on the go.
 
 
 CIRCUIT DIAGRAM:
 Three switches, all wired the same.  
 For a detailed photo of the bread-boarded circuit, see:
 www.unl.edu/newgenres/images/aduinobasicgamecontroller.png
 
                 ____
                |____|
 Pin ___________|    |
                |    |
 Gnd __/\/\/\___|    |______ +5V
         1k*
 
 * resistor can really be any value, but 1-100k should work best
 
 
 NOTE:
 This may load a little more slowly than usual, as the Arduino communication
 must be established in addition to the usual loading stuff.
 
 EXTRA CREDIT:
 +  Try using a potentiometer (reading as an analog value) to control the ship, like
 in Pong; extra-extra credit would be to map the full rotation of the pot to the
 width of the screen, giving tactile AND visual feedback
 +  Multiple bullets in an array
 
 
 www.jeffreythompson.org
 */

// ship variables
int shipX, shipY;           // x,y position
int shipW = 5;              // width of the ship
int shipH = 20;             // height of the ship
int speed = 3;              // speed X

// bullet
int bullX, bullY;           // x,y position
int bulletSpeed = 10;       // speed up the screen
int bulletSize = 5;         // bullet diameter
int tempBulletSpeed = 0;    // temporary bullet speed, for keeping offscreen
boolean autoShoot = false;  // shot randomly?

// target variables
int numTargets = 10;                    // how many targets to draw at a time
int targetSize = 30;                    // diameter of the target
int[] targets = new int[numTargets*4];  // x4 = x,y, speed X, speed Y
boolean hit = false;                    // true/false for hit; prevents retriggering single hit
int explosion = 0;                      // explosions! (counts frames to draw explosion)
float explosionDuration = 200;          // how many frames does the explosion last? (float to decrease size)
int whereX, whereY;                     // where to put the explosion (x,y)
float[] particles = new float[80*5];    // explosion particles: # particles*5 = x,y, dirX, dirY, size
int whichTarget;                        // value for passing to custom object

// score
int score = 0;   // variable to hold the current score
PFont font;      // font for displaying the score

// create an Arduino object
Arduino arduino;


void setup() {

  size(screen.width, screen.height);
  // size(400,800);
  
  noStroke();
  smooth();
  rectMode(CENTER);  // draw from the center instead of upper-left corner
  noCursor();        // turn off cursor; not necessary but less distracting in fullscreen mode
  textAlign(RIGHT);  // keeps score tidy in upper right

  // start Arduino connection at 57600 baud rate
  arduino = new Arduino(this, Arduino.list()[0], 57600);

  // set digital pins 2, 11, and 12 to input
  arduino.pinMode(2, Arduino.INPUT);     // which pin, set to input
  arduino.pinMode(11, Arduino.INPUT);    // which pin, set to input
  arduino.pinMode(12, Arduino.INPUT);    // which pin, set to input

  // set ship to bottom-center
  shipX = width/2;
  shipY = height-50;

  // start all targets at random points offscreen
  for (int i=0; i<targets.length; i+=4) {
    whichTarget = i;      // set whichTarget to i; allows to be passed to function
    randomTarget();       // custom function (for cleanliness) to set random x,y, and speed for each
  }

  // start the bullet offscreen in a "safe" place; the lower right corner
  bullX = -bulletSize;
  bullY = height+bulletSize;

  // set up the font
  font = loadFont("CenturyGothic-72.vlw");   // load font from data folder
  textFont(font, 72);                         // set to 72pt
}

void draw() {

  // redraw background
  fill(0, 10);
  rect(width/2,height/2, width,height);


  // TARGETS
  // draw each target using a for loop, iterating by two at a time (x,y)
  for (int i=0; i<targets.length; i+=4) {

    // draw targets themselves
    fill(255,0,0);
    ellipse(targets[i],targets[i+1], targetSize,targetSize);

    // check if offscreen or hit by a bullet: if so, reset, otherwise update position
    if (targets[i] > width+targetSize || targets[i+1] > height) {
      whichTarget = i;      // same as in setup; set to random point offscreen
      randomTarget();
    }
    else if (bullX > targets[i]-targetSize/2 &&        // left edge
    bullX < targets[i]+targetSize/2 &&        // right edge
    bullY > targets[i+1]-targetSize/2 &&      // top edge
    bullY < targets[i+1]+targetSize/2) {      // bottom edge

      whichTarget = i;       // same as above, etc
      hit = true;            // set to true; prevents double-triggering
      explosion = 1;         // blow up the target!
      whereX = targets[i];   // where to put it (x)
      whereY = targets[i+1]; // ditto (y)
      randomTarget();        // ORDER MATTERS!  do this last, or the explosion will be offscreen
    }
    else {
      targets[i] += targets[i+2];       // update position
      targets[i+1] += targets[i+3];
    }

    if (explosion > 0) {
      explosion();                 // run explosion function
    }
    if (hit) {                     // if hit:
      score++;                     // increase score!
      // println("Score: " + score + ", Target X: " + targets[i] + ", Target Y: " + targets[i+1] + " | Bullet X: " + bullX + ", Bullet Y: " + bullY);
      bullX = -bulletSize;         // make bullet disappear
      bullY = height+ bulletSize;  // set low to not accidentally hit an offscreen target
      tempBulletSpeed = 0;         // stand still until called again
      hit = false;                 // and reset
    }
  }


  // SHIP
  // check for Arduino L/R buttons to move ship
  // if button is pressed AND we're not at the edge yet
  if (arduino.digitalRead(11) == Arduino.HIGH &&      // L button
  shipX - shipW >= 0) {                           // and not at left edge
    shipX -= speed;
  }
  if (arduino.digitalRead(12) == Arduino.HIGH &&      // R button
  shipX + shipW <= width) {                       // and not at right edge
    shipX += speed;
  }
  // or, see if the arrow keys are pressed
  testArrowKeys();        // separate function for cleanliness!

  // draw the ship (and give a nod to Asteroids)
  fill(255);
  // rect(shipX,shipY, shipW,shipH);  // rectangular ships are soooo last week
  triangle(shipX,shipY-shipH/2, shipX-shipW,shipY+shipH/2, shipX+shipW,shipY+shipH/2);


  // BULLETS
  // check for Arduino fire button to fire bullets
  if (arduino.digitalRead(2) == Arduino.HIGH) {
    // start bullet
    bullX = shipX;                         // set bullet to the tip of the ship
    bullY = shipY - shipH/2 + bulletSize;  // ditto
    tempBulletSpeed = bulletSpeed;         // set to bullet speed specified in the global variables
    // muzzle flash (because it's awesome)
    fill(255,125,0, 100);
    ellipse(shipX,shipY-shipH/2, shipW*3,shipW*3);
  }
  // check if spacebar is presed
  testSpacebar();  // similar to testArrowKeys, this is a custom function for neatness
  
  // shoot at random?
  if (autoShoot) {
    int randShot = int(random(0,50));
    if (randShot == 1) {
      // start bullet
      bullX = shipX;                         // set bullet to the tip of the ship
      bullY = shipY - shipH/2 + bulletSize;  // ditto
      tempBulletSpeed = bulletSpeed;         // set to bullet speed specified in the global variables
      // muzzle flash (because it's awesome)
      fill(255,125,0, 100);
      ellipse(shipX,shipY-shipH/2, shipW*3,shipW*3);
    }
  }

  // draw the bullet
  fill(255);
  ellipse(bullX,bullY, bulletSize,bulletSize);

  // update bullet variables unless offscreen
  if (bullY < -bulletSize) {        // if above top of screen
    bullX = -bulletSize;
    bullY = height+bulletSize;
    tempBulletSpeed = 0;            // stand still
  }
  else {
    bullY -= tempBulletSpeed;
  }


  // SCORE
  fill(255,50);
  text(score, width-25,75);    // draw upper right corner
}


void randomTarget() {

  // pass "whichTarget" variable from the for loop into this function

  targets[whichTarget] =   int(random(-width,-targetSize));  // x offscreen to left
  targets[whichTarget+1] = int(random(-height/4,height/2));  // y between -1/4 height and half height
  targets[whichTarget+2] = int(random(3,5));                 // x speed
  targets[whichTarget+3] = int(random(1,2));                 // y speed
}


void testArrowKeys() {

  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == LEFT && shipX - shipW >= 0) {
        shipX -= speed;
      }
      if (keyCode == RIGHT && shipX + shipW <= width) {
        shipX += speed;
      }
    }
  }
}


void testSpacebar() {

  if (keyPressed) {
    if (key == 32) {
      // start bullet
      bullX = shipX;                         // set bullet to the tip of the ship
      bullY = shipY - shipH/2 + bulletSize;  // ditto
      tempBulletSpeed = bulletSpeed;         // set to bullet speed specified in the global variables
      // muzzle flash (because it's awesome)
      fill(255,125,0, 100);
      ellipse(shipX,shipY-shipH/2, shipW*3,shipW*3);
    }
  }
}


void explosion() {

  // if first frame of the explosion
  // find center of explosion and set basic variables
  if (explosion == 1) {

    for (int i=0; i<particles.length; i+=5) {
      particles[i] =   whereX;               // x
      particles[i+1] = whereY;               // y
      particles[i+2] = int(random(-15,15));  // direction X
      particles[i+3] = int(random(-15,15));  // direction Y (to explode up only: max value = 0)
      particles[i+4] = int(random(3,8));     // diameter range
    }
  }

  fill(255,125,0);
  for (int i=0; i<particles.length; i+=5) {    // increment through particles

    // draw the particle  
    ellipse(particles[i],particles[i+1], particles[i+4],particles[i+4]);  // x,y, size,size

    // update position and shrink particles
    particles[i] += particles[i+2];
    particles[i+1] += particles[i+3];
    particles[i+4] *= 1-(explosionDuration/100);  // will be 0 on last frame; assumes < 100
  }

  // run until threshold of frames is reached
  if (explosion <= explosionDuration) {
    explosion++;          // increment to run again
  }
  else
  {
    explosion = 0;        // otherwise, turn off
  }
}

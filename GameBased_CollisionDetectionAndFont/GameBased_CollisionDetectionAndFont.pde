/*
GAME-BASED COLLISION DETECTION and FONT
 Jeff Thompson
 April 2011
 
 Shoot a bouncing ball and keep score. Move the gun left and right 
 with the arrow keys, shoot with the spacebar.
 
 EXTRA CREDIT:
 + constrain the gun to a certain distance
 + create blocks that the ball breaks; if it hits the bottom you die
 + multiple balls; use an array and for loop to check for collision with them all
 + bouncing bullet?
 + speed: how does a REALLY slow version play?
 
 www.jeffreythompson.org
 
 */

// ball
float ballX, ballY;        // x,y coords
float bsX = 2;             // speed X
float bsY = 4;             // speed Y
int ballSize = 50;         // diameter
int ballRad = ballSize/2;  // radius - used for collision detection

// bullet
float bullX = -1;          // x coord, start offscreen
float bullY = -1;          // y coord, also offscreen
float bullSx = 0;          // speed X
float bullSy = 0;          // speed Y
int bulletSize = 3;        // diameter
int bullRad = bulletSize/2;
int aimX = 0;
int aimY = 10;
boolean newBullet = false;

// score-keeping
int score = 0;          // keep score
PFont font;             // create a font in the system

// optional: title screen
boolean introScreen = true;
int blinkTime = 500;        // blink time in ms
int blinkOnOff = 1;
long prevMillis;


void setup() {

  size(800,800);
  noStroke();
  smooth();
  noCursor();

  // start ball at random coords
  ballX = random(0,width);
  ballY = random(0,height);

  // font setup
  font = loadFont("OratorStd-48.vlw");
  textFont(font,16);
  textAlign(CENTER);
}

void draw() {

  // extra credit: title screen!
  // check if introScreen is true, and if show show that
  if (introScreen) {
    title();          // another custom function
  }

  // otherwise, play as usual
  else {
    // cover previous screen
    fill(0);
    rect(0,0, width,height);

    // if at edge - bounce, then update ball variables and draw
    if (ballX-ballRad < 0 || ballX+ballRad > width) {
      bsX *= -1;
    }
    if (ballY-ballRad < 0 || ballY+ballRad > height) {
      bsY *= -1;
    }

    // update ball variables
    ballX += bsX;
    ballY += bsY;

    // ... and draw the ball
    fill(255,0,0);
    ellipse(ballX,ballY, ballSize,ballSize);


    // draw "gun"

    // test for movement L/R or fire
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == LEFT) {
          aimX -= 1;
        }
        if (keyCode == RIGHT) {
          aimX += 1;
        }
      }
      else if (key == 32) {    // fire = spacebar
        newBullet = true;      // turn on for bullet section below
      }
    }

    // draw the gun itself
    stroke(255);
    line(width/2,height, width/2+aimX,height-aimY);
    noStroke();

    // if fire is pressed, update aim of bullet
    if (newBullet) {
      bullX = width/2+aimX;
      bullY =height-aimY;
      bullSx = aimX;
      bullSy = -aimY;

      // muzzle flash!
      fill(220,255,0, 200);
      ellipse(bullX,bullY, 10,10);

      newBullet = false;      // prevent continuously retriggering
    }

    // draw the bullet
    fill(255);
    ellipse(bullX,bullY, bulletSize,bulletSize);
    
    // update bullet variables
    bullX += bullSx;
    bullY += bullSy;


    // collision detection
    if (bullX >= ballX - ballSize/2 && bullX <= ballX + ballSize/2
      && bullY > ballY -ballSize/2 && bullY <= ballY + ballSize/2) {
        
      score++;      // increase score        
      newBullet();  // custom function to reset and avoid multiple hits
    }

    // print current score to the screen 
    text("Score: " + score, width/2,20);  // show score onscreen
  }

}

void newBullet() {

  // create a new bullet offscreen that doesn't move
  bullX = -1;
  bullY = -1;
  bullSx = 0;
  bullSy = 0;
  
  // create a new ball at a random spot
  ballX = random(width/10,width-width/10);
  ballY = random(height/10,height-height/10);
 
  // set direction of ball to random value
  bsX = random(-5,5);
  bsY = random(-5,5);
  
  // extra credit: have max possible speed (-5/5) increase with every hit!
  
}

void title() {
  
  // fill screen black
  fill(0);
  rect(0,0, width,height);
  
  fill(255);
  text("SHOOT THE BALL\n\n\n\n(aka basic collision detection\n\nand using fonts)", width/2, height/4);
  
  // check if the blink time has passed, then turn on or off
  if (millis() >= prevMillis + blinkTime) {
    blinkOnOff *= -1;        // switch between -1 and 1
    prevMillis = millis();   // set for next time interval
  }
  if (blinkOnOff == 1) {     // if the blink is 1
      text("[ press return/enter to start ]", width/2, height/2);  // show the text
  }
  
  text("Jeff Thompson\n\n2011", width/2, height-height/4);
  
  // check if return/enter is pressed, and if so play the game!
  if (keyPressed) {
    if (key == ENTER || key == RETURN) {
      introScreen = false;
    }
  }
  
}


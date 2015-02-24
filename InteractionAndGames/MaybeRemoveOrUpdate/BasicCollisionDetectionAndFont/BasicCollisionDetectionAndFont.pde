/*
BASIC COLLISION DETECTION and FONT
 Jeff Thompson
 April 2011
 
 Shoot a bouncing ball and keep score.
 
 TO PLAY:
 + Move the gun left and right with the arrow keys.
 + Shoot using the spacebar, but be careful!  You have limited bullets!
 + When bullets are low, bank the bullet off the walls by holding down 'b'
 + When you hit the ball, your bullets are refilled. But!
 + Each time you hit the ball, it flies faster!
 
 Version 2.0 is more fully-featured; try adjusting:
 + constrained gun movement to a certain distance
 + create blocks that the ball breaks; if it hits the bottom you die
 + multiple balls; use an array and for loop to check for collision with them all
 + speed: how does a REALLY slow version play?
 
 www.jeffreythompson.org 
 */

// ball
float ballX, ballY;        // x,y coords
float bsX = 1;             // speed X (increments with each hit)
float bsY = 2;             // speed Y (increments with each hit)
int ballSize = 50;         // diameter
int ballRad = ballSize/2;  // radius - used for collision detection

// bullet
int numBullets = 10;          // limited bullets - use sparingly!
int bulletCount = numBullets;
float bullX = -5;             // x coord, start offscreen
float bullY = -5;             // y coord, also offscreen
float bullSx = 0;             // speed X
float bullSy = 0;             // speed Y
int bulletSize = 5;           // diameter
int bullRad = bulletSize/2;
int aimX = 0;
int aimY = 10;
boolean newBullet = false;
boolean bullBounce = false;

// gun
int constrainGun = 30;  // constrain horiz movement of the gun (px)

// blocks
// stored in an array and redrawn offscreen when broken
int numBlocks = 10;                   // how many blocks?
int[] blocks = new int[numBlocks];    // x only - y is constant
int blockW;                           // width of the blocks
int blockH = 10;                      // height of the blocks

// score-keeping
int score = 0;          // keep score
PFont infoFont;         // create a font in the system for score, etc

// optional: title screen
boolean introScreen = true;
int blinkTime = 1000;        // blink time in ms
int blinkOnOff = 1;
long prevMillis;

// death screen
boolean dead = false;   // check if the ball has hit the bottom


void setup() {

  size(800,800);
  // size(screen.width, screen.height);

  noStroke();
  smooth();
  noCursor();

  // start ball at random coords
  ballX = random(width/10,width-width/10);
  ballY = random(height/10,height-height/6);

  // font setup
  infoFont = loadFont("OratorStd-48.vlw");
  textFont(infoFont,16);
  textAlign(CENTER);

  // fill block array
  blockW = width/numBlocks;
  for (int i=0; i<blocks.length; i++) {     // write all x coords
    blocks[i] = i*blockW;                   // x start inc by block width
  }
}

void draw() {

  // extra credit: title screen!
  // check if introScreen is true
  if (introScreen) {
    title();          // custom function to display the title
  }

  // check it we're dead (!)
  else if (dead) {
    die();            // another custom function that draws the screen red, etc
  }

  // otherwise, play as usual
  else {

    // cover previous screen
    fill(0);
    rect(0,0, width,height);


    // draw the blocks
    fill(100);
    stroke(255);
    for (int i=0; i<blocks.length; i++) {
      rect(blocks[i],height-100, blockW,blockH);
    }
    noStroke();


    // if at edge - bounce, then update ball variables and draw
    if (ballX-ballRad < 0 || ballX+ballRad > width) {
      bsX *= -1;
    }
    /*
    // original bounce on bricks
     if (ballY-ballRad < 0 || ballY+ballRad > height-100) {
     bsY *= -1;
     }
     */
    // if at top
    if (ballY-ballRad < 0) {
      bsY *= -1;
    }
    // check if there's a block, if so bounce; if not, continue to the bottom
    for (int i=0; i<blocks.length; i++) {  // check to see if it has hit any blocks
        // past Y val for blocks        block is offscreen
     if (ballY+ballRad >= height-100 && blocks[i] <0) {
       bsY *= -1;
     }
    }
     

    // if we hit the bottom... die!
    if (ballY+ballRad >= height) {
      dead = true;                  // go to dead screen
    }


    ballX += bsX;
    ballY += bsY;

    fill(255,0,0);
    ellipse(ballX,ballY, ballSize,ballSize);


    // check for block collision
    for (int i=0; i<blocks.length; i++) {    // iterate blocks to check

      // check if x coords line up
      if (ballX >= blocks[i] && ballX < blocks[i]+blockW     // if between start and end of block
      && ballY+ballRad >= height-100) {                      // and at the block's y
        blocks[i] = -100;                                    // send offscreen
      }
    }


    // draw "gun"

    // test for movement L/R or fire
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == LEFT && width/2+aimX > width/2-constrainGun) {
          aimX -= 1;
        }
        if (keyCode == RIGHT && width/2+aimX < width/2+constrainGun) {
          aimX += 1;
        }
      }
      else if (key == 32 && bulletCount > 0) {    // fire = spacebar
        newBullet = true;
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
      // bulletCount -= 1;    // one less bullet left! - seems not to work here...

      // muzzle flash!
      fill(220,255,0, 200);
      ellipse(bullX,bullY, 10,10);

      newBullet = false;      // prevent continuously retriggering
    }


    // draw the bullet
    if (bullBounce) {
      fill(0,210,0);    // if bouncing, change color
    }
    else { 
      fill(255);
    } // otherwise fill with white
    ellipse(bullX,bullY, bulletSize,bulletSize);
    bullX += bullSx;
    bullY += bullSy;


    // bouncing bullet - press and hold 'b' key
    if (keyPressed) {
      if (key == 'b') {
        bullBounce = true;
      }
    }
    // tests for release under keyRelease() function

    if (bullBounce) {
      if (bullX <= 0 || bullX >= width) {
        bullSx *= -1;
      }
      if (bullY <=0 || bullY >= height) {
        bullSy *= -1;
      }
    }


    // collision detection
    if (bullX >= ballX - ballSize/2 && bullX <= ballX + ballSize/2
      && bullY > ballY -ballSize/2 && bullY <= ballY + ballSize/2) {

      score++;      // increase score        
      newBall();  // custom function to reset and avoid multiple hits
    }


    // print current score to the screen 
    fill(255);
    textAlign(LEFT);
    text("Score: " + score, 20,height-50);  // show score onscreen


    // show how many bullets you have left
    fill(255);
    for (int i=0; i<bulletCount; i++) {
      ellipse(25+(i*15), height-30, 10,10);
    }
    // show bullets shot
    fill(70);
    for (int i=0; i<numBullets-bulletCount; i++) {
      ellipse(25+(bulletCount*15)+(i*15), height-30, 10,10);
    }
    fill(0);                  // seems to do something funky, se we cheat...
    rect(0,height-40,20,20);  // ... cover up the extra left bullet
  }
}

void newBall() {

  // create a new bullet offscreen that doesn't move
  bullX = -1;
  bullY = -1;
  bullSx = 0;
  bullSy = 0;

  // create a new ball at a random spot
  ballX = random(width/10,width-width/10);
  ballY = random(height/10,height-height/6);

  // increment ball speed
  if (bsX >= 0) {          // if positive, add
    bsX++;
  }
  else { 
    bsX -= 1;
  }       // otherwise subtract
  if (bsY >= 0) {
    bsY++;
  }
  else { 
    bsY -= 1;
  }

  // redraw the bricks
  for (int i=0; i<blocks.length; i++) {
    blocks[i] = i*blockW;
  }

  // and refill the bullets!
  bulletCount = numBullets;
}

void title() {

  // fill screen black
  fill(0);
  rect(0,0, width,height);

  fill(255);
  textFont(infoFont, 48);
  text("SHOOT THE BALL", width/2,height/3);
  textFont(infoFont, 16);
  text("\n\n\n(aka basic collision detection\n\nand using fonts)", width/2, height/3);

  // check if the blink time has passed, then turn on or off
  if (millis() >= prevMillis + blinkTime) {
    blinkOnOff *= -1;        // switch between -1 and 1
    prevMillis = millis();   // set for next time interval
  }
  if (blinkOnOff == 1) {     // if the blink is 1
    text("[ press return/enter to start ]", width/2, height-height/3);  // show the text
  }

  text("Jeff Thompson\n\n2011", width/2, height-height/4);

  // check if return/enter is pressed, and if so play the game!
  if (keyPressed) {
    if (key == ENTER || key == RETURN) {
      introScreen = false;
      textAlign(LEFT);
    }
  }
}


void keyReleased() {      // stop bouncing when the 'b' key is released
  if (key == 'b') {
    bullBounce = false;
  }
  else if (key == 32) {
    bulletCount -= 1;    // one less bullet left!
  }
}


void die() {

  // fill the screen red
  fill(255,0,0);
  rect(0,0, width,height);

  fill(0);

  // skull!
  ellipse(width/2,height/2, 100,100);       // main part
  rect(width/2-30,height/2, 59,60);         // jaw
  for (int i=0; i<12; i++) {                // teeth with for loop
    rect(width/2-30+i*5, height/2, 4,65);
  }

  fill(255);
  ellipse(width/2-30,height/2, 10,10);      // L eye
  ellipse(width/2+30,height/2, 10,10);      // R eye

  ellipse(width/2-5,height/2+30, 5,5);      // L nostril
  ellipse(width/2+5,height/2+30, 5,5);      // R nostrill


  textAlign(CENTER);
  textFont(infoFont, 16);
  
  // check if the blink time has passed, then turn on or off
  if (millis() >= prevMillis + blinkTime) {
    blinkOnOff *= -1;        // switch between -1 and 1
    prevMillis = millis();   // set for next time interval
  }
  if (blinkOnOff == 1) {     // if the blink is 1
    text("[ return/enter to restart ]", width/2,height-height/3);  // show the text
  }

  if (keyPressed) {                       // if return/enter key is pressed...
    if (key == RETURN || key == ENTER) {  // do this to avoid gameplay keys from instantly restarting
      dead = false;                       // turn off dead...
      score = 0;                          // reset score etc, since this is done above the setup
      bulletCount = numBullets;
      bullX = -5;
      bullY = -5;

      setup();                            // ... and restart everything else
    }
  }
}


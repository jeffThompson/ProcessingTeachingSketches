import ddf.minim.*;    // requires the importation of the Minim library (see comments)

/*
SOUND EFFECTS
Jeff Thompson
April 2011

While not complex game audio, a little sound can go a long way.  Audio files
can be in either .aiff or .wav format (.mp3 works as well, but is uncompressed
when loaded, so memory is not saved.

To include audio, you must import the Minim library under Sketch, 
Import Library, Minim...

www.jeffreythompson.org
*/


// BOUNCING BALL VARIABLES
float ballX,ballY;         // position
int spX = 3;               // speed
int spY = 5;
int ballSize = 10;         // size

// AUDIO VARAIBLES
Minim minim;
AudioSample boink;    // an AudioSample is a small sound, triggered from memory (quick)


void setup() {
  
  size(300,300);
  noStroke();
  smooth();
  
  // BALL SETUP
  ballX = width/2;    // start in center
  ballY = height/2;
  
  // AUDIO SETUP
  // start Minim library
  minim = new Minim(this);
  
  // which file to load (like w. fonts), must be in data folder
  boink = minim.loadSample("boink.wav");
}

void draw(){
  
  // REDRAW BACKGROUND EACH FRAME
  fill(255);
  rect(0,0, width,height);
  
  // CHECK FOR EDGE COLLISION and PLAY "BOINK"
  if (ballX - ballSize/2 < 0 || ballX + ballSize/2 > width) {

    // reverse direction to bounce...
    spX *= -1;
    // ... and play "boink"
    boink.trigger();
  }
   else if (ballY - ballSize/2 < 0 || ballY + ballSize/2 > height) {

    // reverse direction to bounce
    spY *= -1;
    // play "boink"
    boink.trigger();
  }
  
  // DRAW THE BALL
  fill(255,0,0);
  ellipse(ballX,ballY, ballSize,ballSize);
  
  // UPDATE BALL VARIABLES
  ballX += spX;
  ballY += spY;
  
}
 
  
void stop() {
  
  // you must always stop all audio classes when closing, otherwise Processing/system
  // problems can occur
  
  boink.close();    // close file
  minim.stop();     // stop library
  super.stop();     // make sure everything else is stopped too
  
}

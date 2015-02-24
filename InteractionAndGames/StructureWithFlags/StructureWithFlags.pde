
/*
STRUCTURE WITH FLAGS
Jeff Thompson | 2015 | www.jeffreythompson.org

You've got a cool game, but how do you make it change levels,
show intro screens, etc? Using boolean variables called "flags",
we can control the structure of our program in a way that is
clear to read.

Here we show an intro screen for 5 seconds, then a main level
(which changes color, but you could do something cooler), and
goes to an end screen when the player hits the spacebar.

*/

// three "flags" to control our program
// start on intro screen
boolean intro =     true;
boolean mainLevel = false;
boolean end =       false;

// duration of intro in milliseconds (1000ms = 1 sec)
long introDuration = 5000;    // wait 5 seconds

PFont font;


void setup() {
  size(600,600);
  
  // setup font
  font = createFont("Helvetica", 72);
  textFont(font, 72);
  textAlign(CENTER);
}


void draw() {
  
  // here we use if statements to control the
  // sketch - note that for larger programs,
  // offloading to separate functions for
  // each section will keep our code cleaner
  
  if (intro) {
    background(0);
    fill(255);
    noStroke();
    text("INTRO", width/2, height/2);
  }
  else if (mainLevel) {
    background(frameCount%255, 150, 0);    // change bg color with the current frame
  }
  else if (end) {
    background(0);
    fill(255);
    noStroke();
    text("END", width/2, height/2);
  }
  
  // change section from intro to main based on time
  // millis() gives the # of milliseconds since the program started
  if (millis() > introDuration) {
    intro = false;        // no more intro...
    mainLevel = true;     // show main level
  }
}


// if we're in the main level AND the spacebar is 
// pressed, go to end screen
void keyPressed() {
  if (mainLevel && key == 32) {
    mainLevel = false;
    end = true;
  }
}



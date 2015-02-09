
import processing.sound.*;    // import the sound library

/*
SOUND
Jeff Thompson | 2015 | www.jeffreythompson.org

This is the most simple example of triggering a sound. The
Processing sound library can do some very cool things, include
synthesis, real-time effects, and listening to the microphone.

See the sound library documentation and examples for more info.

Supported file types:
AIFF, WAV, MP3

Resources for free sound files:
+ https://www.freesound.org/browse/tags/sound-effects/
+ http://soundbible.com/free-sound-effects-1.html

Blop sound via: http://soundbible.com/2067-Blop.html

*/

SoundFile blop;    // like PImage or PFont, the object for our sound

void setup() {
  size(600, 800);
  
  // load our sound from file - must be in the data folder, or specify a full path
  blop = new SoundFile(this, "Blop.wav");
}

void draw() {
  background(255);
  
  // wait for mouse click to trigger sound!
}

// play the sound!
void mousePressed() {
  float pan = map(mouseX, 0,width, 1.0,-1.0);    // set L/R panning to mouse position
  blop.pan(pan);                                 // set panning for sound*
  blop.play();                                   // then play
  
  // * note that panning only works for mono sound files, not stereo – use
  //   a free program like Audacity to convert your files if necessary
}


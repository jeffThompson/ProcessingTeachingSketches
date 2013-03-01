import android.content.Context;    // both imports required for vibration
import android.os.Vibrator;

/*
VIBRATION
Jeff Thompson | 2013 | www.jeffreythompson.org

When the mouse (your finger) is moved, vibrate and change the screen's
color. Alternatively, the Android API allows an array of values for
variable pulsing.

Note: you must add "VIBRATE" to the permissions for the sketch under
Android > Sketch Permissions...

More details and options at:
http://developer.android.com/reference/android/os/Vibrator.html

CHALLENGE:
1. Can you make the intensity of the vibration change based on the
   speed the mouse is moving? Hint: this will require pulsing using
   an array with changing values.
*/

int diffThresh = 5;                         // mouse position difference to trigger vibration
long vibeDuration = 100;                    // duration for vibration
long[] vibeList = { 0, 20, 20, 20, 20 };    // or specify on/off durations (first is off time)
Vibrator vibe;                              // Vibrator object

void setup() {
  
  // basic setup - no size = default to fullscreen
  smooth();
  noStroke();
  mouseX = width/2;    // default to the center of the screen
  mouseY = height/2;
  
  // create Vibrator object
  vibe = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
}

void draw() {
  background(255,150,0);
  
  // if the movement is enough, change the background and vibrate!
  if (abs(mouseX-pmouseX) > diffThresh || abs(mouseY-pmouseY) > diffThresh) {
    vibe.vibrate(vibeDuration);    // vibrate for specified duration
    // vibe.vibrate(v, -1);        // or use array of values (-1 = no repeat)
    background(0,150,255);
  }
  
  // circle at mouse position
  fill(255);
  ellipse(mouseX, mouseY, 250,250);
}

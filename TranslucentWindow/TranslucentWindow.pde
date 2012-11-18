/*
TRANSLUCENT WINDOW
 Jeff Thompson  |  2012  |  www.jeffreythompson.org
 
 Via:
 https://forum.processing.org/topic/translucen-window-in-processing
 
 */

import com.sun.awt.AWTUtilities;   // required for transparency

float opacity = 0.5;               // level of window opacity
boolean hideTitleBar = false;      // hide title bar? if true, will not be able to be dragged...

void setup() {

  size(500,500);
  background(255, 0, 0);

  // TRANSLUCENT WINDOW
  // run in a 'try' statement because fullscreen will cause the
  // sketch to freeze (if this does happen, esc will not exit
  // but command/control+Q will)
  try {
    frame.removeNotify();
    frame.setUndecorated(hideTitleBar);             // show the title bar?
    AWTUtilities.setWindowOpacity(frame, opacity);  // set opacity  
    //frame.addNotify();
  }
  catch (IllegalArgumentException iae) {
    println("Effects for full-screen windows are not supported, sorry!");
  }
}


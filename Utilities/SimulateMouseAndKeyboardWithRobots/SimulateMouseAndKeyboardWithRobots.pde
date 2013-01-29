import java.awt.Robot;            // for the basic Robot class
import java.awt.event.KeyEvent;   // to simulate key presses
import java.awt.AWTException;     // for relate exceptions

/*
SIMULATE MOUSE AND KEYBOAD WITH "ROBOTS"
Jeff Thompson | 2013 | www.jeffreythompson.org

Using Java's Robot class, we can simulate keystrokes, mouse movements and
clicks, etc!  Great for automation, or controlling other programs via Processing.
*/

Robot r;          // instance of the Robot class
String s = "";    // for simulating typing!

void setup() {
  size(400,400);
  smooth();
  noStroke();
  
  // creat the Robot - throws an exception so run in a 'try'
  try {
    r = new Robot();
  }
  catch (AWTException e) {
    e.printStackTrace();
  }
}

void draw() {
  background(0);
  fill(255);
  text(s, 30, height/2);    // display text as characters are added
}


void keyPressed() {
  // spacebar moves the move to random coordinates
  if (key == 32) {
    r.mouseMove(int(random(0,displayWidth)), int(random(0,displayHeight)));
  }
  
  // clicking the mouse simulates pressing the 'a' key and adds an 'a' to a string
  else if (key == 'a') {    // note: this isn't a "real" keypress!
    s += "a";
  }
}

// clicking the mouse types the letter a!
void mouseClicked() {
  r.keyPress(KeyEvent.VK_A);             // make a lowercase 'a'
  r.keyRelease(KeyEvent.VK_A);           // always release!
  
  // r.keyPress(KeyEvent.VK_SPACE);      // or, create a spacebar press to control iTunes!
  // r.keyRelease(KeyEvent.VK_SPACE);    // note: iTunes must be the focused window
}

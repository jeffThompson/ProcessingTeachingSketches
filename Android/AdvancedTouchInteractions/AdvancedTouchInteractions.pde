import android.view.MotionEvent;    // required import for fancy touch access

/*
ADVANCED TOUCH INTERACTION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 A more advanced (and deeper) access to touch events in Android; we
 can get the x/y coordinates as usual, but also the type of event,
 the pressure of press, and pointer size (scaled 0-1).
 
 Further MotionEvent documentation here:
 http://developer.android.com/reference/android/view/MotionEvent.html
 
 CHALLENGE:
 1. Using the action code, try making some parameters of the sketch change
 based on the interaction type.
 */

String touchEvent = "";    // string for touch event type
float pressure = 0.0;      // pressure and size variables
float pointerSize = 0.0;
PFont font;                // font to display stats

void setup() {
  smooth();
  noStroke();

  font = createFont("Monospaced", 72);
  textFont(font);
  textAlign(LEFT, CENTER);
}

void draw() {
  background(0, 75, 150);

  // display a circle at the cursor
  fill(255, 150);
  ellipse(mouseX, mouseY, 150, 150);

  // display the stats for the touch
  fill(255);
  text("EVENT TYPE:   " + touchEvent + "\nPRESSURE:     " + pressure + "\nPOINTER SIZE: " + pointerSize, 150, height/2);
}

// override the built-in method, getting data from it and passing the
// details on afterwards using the super.dispatchTouchEvent()
@Override
public boolean dispatchTouchEvent(MotionEvent event) {

  int action = event.getActionMasked();          // get code for action
  pressure = event.getPressure();                // get pressure and size
  pointerSize = event.getSize();

  switch (action) {                              // let us know which action code shows up
  case MotionEvent.ACTION_DOWN:
    touchEvent = "DOWN";
    break;
  case MotionEvent.ACTION_UP:
    touchEvent = "UP";
    pressure = pointerSize = 0.0;                // when up, set pressure/size to 0
    break;
  case MotionEvent.ACTION_MOVE:
    touchEvent = "MOVE";
    break;
  default:
    touchEvent = "OTHER (CODE " + action + ")";  // default text on other event
  }

  return super.dispatchTouchEvent(event);        // pass data along when done!
}


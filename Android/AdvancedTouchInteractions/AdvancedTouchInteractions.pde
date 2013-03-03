import android.view.MotionEvent;    // required import for fancy touch access

/*
ADVANCED TOUCH INTERACTION
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 A more advanced (and deeper) access to touch events in Android; we
 can get the x/y coordinates as usual, but also the type of event,
 the pressure of press, and pointer size (scaled 0-1).
 
 Multi-touch? That's a much harder nut to crack... :)
 
 Further MotionEvent documentation here:
 http://developer.android.com/reference/android/view/MotionEvent.html
 
 CHALLENGE:
 1. Using the action code, try making some parameters of the sketch change
 based on the interaction type.
 */

float x, y;
String touchEvent = "";    // string for touch event type
float pressure = 0.0;      // pressure and size variables
float pointerSize = 0.0;
PFont font;                // font to display stats

void setup() {
  smooth();
  noStroke();
  x = width/2;
  y = height/2;

  font = createFont("Monospaced", 72);
  textFont(font);
  textAlign(LEFT, CENTER);
}

void draw() {
  background(0, 75, 150);

  // display a circle at the cursor
  fill(255, 150);
  ellipse(x, y, 150, 150);    // could use mouseX/mouseY, but MotionEvent is more accurate*
  
  // * this is according Processing Wiki (http://wiki.processing.org/w/Android#Mouse.2C_Motion.2C_Keys.2C_and_Input)

  // display the stats for the touch
  fill(255);
  String details = "X POSITION:   " + x;
  details += "\nY POSITION:   " + y;
  details += "\nEVENT TYPE:   " + touchEvent;
  details += "\nPRESSURE:     " + pressure;
  details += "\nPOINTER SIZE: " + pointerSize;
  text(details, 150, height/2);
}

// override the built-in method, getting data from it and passing the
// details on afterwards using the super.dispatchTouchEvent()
@Override
public boolean dispatchTouchEvent(MotionEvent event) {

  x = event.getX();                              // get x/y coords of touch event
  y = event.getY();
  
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


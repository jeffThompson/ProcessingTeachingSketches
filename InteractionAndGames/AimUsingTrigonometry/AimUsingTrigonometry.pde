
/*
AIM USING TRIGONOMETRY
 Jeff Thompson | 2015 | www.jeffreythompson.org
 
 Don't be afraid: we're going to use a little bit of
 trigonometry to shoot a bullet in a direction set
 by the mouse.
 
 First, we calculate the angle between the mouse and
 the base of the arrow using atan2:
   float angle = atan2(diffY, diffX);
 
 Then, we use cos() and sin() to find the X/Y position
 of an object given only the rotation angle and distance:
   float x = cos(angle);
   float y = sin(angle);
 
 That's it!
 
 */

int arrowLen =  50;         // how long is the arrow?
float bulletX = -100;       // keep the bullet offscreen until fired
float bulletY = -100;
float bulletSpeed = 2.0;    // max speed for the bullet

int arrowX, arrowY;         // arrow position
float angle;                // angle of rotation
float run, rise;            // set by angle of the arrow


void setup() {
  size(600, 600);
  cursor(CROSS);         // use a crosshairs cursor

  arrowX = width/2;      // draw arrow from center
  arrowY = height/2;
}

void draw() {
  background(255);

  // calculate the rotation angle
  int xDist = mouseX - arrowX;
  int yDist = mouseY - arrowY;
  angle = atan2(yDist, xDist);

  // draw the arrow
  pushMatrix();                      // go into "local" drawing mode
  translate(arrowX, arrowY);         // move to arrow's center
  rotate(angle);                     // and rotate
  stroke(0);
  fill(0);
  line(0, 0, arrowLen, 0);           // arrow shaft
  line(arrowLen, 0, arrowLen-5, 5);  // arrowhead lines
  line(arrowLen, 0, arrowLen-5, -5);
  ellipse(0, 0, 5, 5);               // center dot
  popMatrix();

  // draw the bullet, update it's position
  fill(255, 0, 0);
  noStroke();
  ellipse(bulletX, bulletY, 15, 15);
  bulletX += run;
  bulletY += rise;
}


// when the mouse is pressed, "respawn" the bullet at the arrow's point
void mousePressed() {

  // calculate a new run (X dir) and rise (Y dir)
  // cos() and sin() return values from -1 to 1, so we
  // multiply by the bullet's speed to get usable numbers
  run = cos(angle) * bulletSpeed;
  rise = sin(angle) * bulletSpeed;     // same as X but using sine

  // put the bullet at the arrow's tip
  bulletX = arrowX + (arrowLen * cos(angle));
  bulletY = arrowY + (arrowLen * sin(angle));
}


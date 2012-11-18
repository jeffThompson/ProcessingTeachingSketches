
boolean arrowDirect = true;    // if on, arrow will move bullet as it flies

int x, y;
int len = 50;
float bullX = -100;
float bullY = -100;
float rot, rise, run;

void setup() {

  size(600, 600);
  smooth();
  cursor(CROSS);
  ellipseMode(CENTER);

  x = width/2;
  y = height/2;
}

void draw() {

  background(0);

  pushMatrix();
  translate(x, y);

  int xDist = -(x - mouseX);     // dist from center
  int yDist = -(y - mouseY);     // - to allow us to draw in that dir
  float hypotenuse = sqrt((xDist*xDist)+(yDist*yDist));

  // TRIANGULAR GUIDES (mostly for debugging, but also cool)
  /*
  stroke(50);
   line(0, 0, xDist, 0);            // horiz guide
   line(xDist, 0, xDist, yDist);    // vert guide
   line(0, 0, xDist, yDist);        // angle
   */

  // there probably is a more elegant way to do this...
  if (mouseY <= y) {                      // if above the start pt
    rot = (asin(xDist/hypotenuse))+PI;
  }
  else if (mouseY > y) {                  // if below...
    rot = -asin(xDist/hypotenuse);
  }
  rotate(rot);                            // rotate arrow by this amount

  stroke(255);
  line(0, 0, 0, len);            // line itself
  line(0, len, -5, len-5);       // arrowhead
  line(0, len, 5, len-5);        // ditto...

  // ARROW DOT
  fill(255);
  noStroke();
  ellipse(0, 0, 5, 5);

  // END ROTATION
  popMatrix();


  // BULLET
  // if on, arrow can direct the bullet in flight
  if (arrowDirect) {
    run = map(len * sin(rot), -50, 50, 2, -2);
    rise = map(len * cos(rot), -50, 50, -2, 2);
  }

  bullX += run;    // update variables
  bullY += rise;

  fill(255, 0, 0, 100);
  ellipse(bullX, bullY, 15, 15);    // draw bullet
  noFill();

  if (mousePressed) {
    newBullet();
  }
}


void newBullet() {


  // calculate rise/run
  run = map(len * sin(rot), -50, 50, 2, -2);
  rise = map(len * cos(rot), -50, 50, -2, 2);
  bullX = x - (len * sin(rot));
  bullY = y + (len * cos(rot));
}


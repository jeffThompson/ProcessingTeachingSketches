
/*
DRAW BOX BETWEEN TWO POINTS
Jeff Thompson | 2015 | www.jeffreythompson.org

Drawing lines between two points in 3D space is easy. Drawing
a box between them is much harder! Here we convert Cartesian
coordinates into polar ones, which gives us the rotation in
Y and Z axes, plus the distance between the two.

Unintuitively, just these two rotations is enough to point us
from one point to another!

*/


PVector start = new PVector(0, 0, 0);        // start and end points
PVector end =   new PVector(200, 50, 100);
float rx, ry;                                // rotation for interface


void setup() {
  size(600, 600, OPENGL);
  rx = ry = 0;              // set initial model rotation to 0
}

void draw() {
  background(50);
  lights();

  // rotate overall model
  translate(width/2, height/2, 0);
  rotateX(rx);
  rotateY(ry);

  // draw the points
  fill(255, 100);
  noStroke();
  pushMatrix();
  translate(start.x, start.y, start.z);
  sphere(10);
  popMatrix();

  pushMatrix();
  translate(end.x, end.y, end.z);
  sphere(10);
  popMatrix();

  // drawing a line between two points is easy!
  stroke(255);
  strokeWeight(3);
  line(start.x, start.y, start.z, end.x, end.y, end.z);

  // to draw a box, we need to get the angle and distance between 
  // the two points – we do this with the function below
  PVector polar = cartesianToPolar(PVector.sub(start, end));

  // we also need the halfway point, since box() is draw from
  // the center out
  PVector halfway = PVector.add(start, end);   // add the two points...
  halfway.div(2);                              // and divide by two

  // draw it!
  pushMatrix();
  translate(halfway.x, halfway.y, halfway.z);  // move to halfway point
  rotateY(polar.y);                            // rotate Y and Z
  rotateZ(polar.z);
  noStroke();
  fill(255, 150, 0, 100);
  box(polar.x, 10, 10);                        // draw with x as length
  popMatrix();
}


// convert 3D Cartesian coordinates to polar coords
// x = length, y = angleY, z = angleZ
PVector cartesianToPolar(PVector input) {
  PVector output = new PVector();
 output.x = input.mag();
  if (output.x > 0) {
    output.y = -atan2(input.z, input.x);
    output.z = asin(input.y / output.x);
  } else {
    output.y = 0;
    output.z = 0;
  }
  return output;
}


// rotate model
void mouseDragged() {
  rx += (pmouseY-mouseY) * 0.05;
  ry += (pmouseX-mouseX) * -0.05;
}


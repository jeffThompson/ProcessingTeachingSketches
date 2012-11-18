
/*
FIND DIRECTION OF A TRIANGLE'S NORMAL
Jeff Thompson  |  2012  |  www.jeffreythompson.org

Finds the direction a triangle is facing (the direction
of it's 'normal') based on the right-hand rule:
http://en.wikipedia.org/wiki/Right-hand_rule

Essentially, by taking the cross-product of two corners in
counter-clockwise order, you get the direction of the face.

This is useful when parsing an STL file that does not
list the normal's directions - the STL specification is
that the order of the vertices is meaningful (ie: you
can use the method below to find the direction of 
each face).

For further info, see:
http://www.kindohm.com/technical/WPF3DTutorial.htm

*/

// three corners, stored as vectors for convenience
// the three values are x, y, and z coordinates
PVector a = new PVector(200, -200, 0);
PVector b = new PVector(0, 200, 0);
PVector c = new PVector(-200, -200, 0);

// other variables
float rotX, rotY, ctrX, ctrY, ctrZ;
PVector rh, lh;
PFont font;

void setup() {
  size(500, 500, P3D);
  smooth();

  // find the center of the triangle
  ctrX = (a.x + b.x + c.x)/3;
  ctrY = (a.y + b.y + c.y)/3;
  ctrZ = (a.z + b.z + c.z)/3;

  font = loadFont("SansSerif-48.vlw");
  textFont(font, 48);
  
  // find the direction of the normal! using
  // right-to-left (counter-clockwise as you 
  // look at the face, ie: A>B, B>C, or C>A)
  rh = a.cross(b);      // returns the same result with other two combinations
  // rh.normalize();    // scale vector 0-1, optioal
  
  // result will be opposite if we reverse the
  // order of points (C>B, B>A, or A>C)
  lh = b.cross(a);
  // lh.normalize();
  
  println("RIGHT-HAND: " + rh.x + ", " + rh.y + ", " + rh.z);
  println("LEFT-HAND:  " + lh.x + ", " + lh.y + ", " + lh.z);
}

void draw() {
  
  // basic drawing stuff
  background(150);
  lights();
  translate(width/2, height/2, 0);
  rotateX(rotY + QUARTER_PI);
  rotateY(rotX + 0.1);

  // draw triangle
  fill(255, 150, 0);
  stroke(0);
  beginShape();
  vertex(a.x, a.y, a.z);
  vertex(b.x, b.y, b.z);
  vertex(c.x, c.y, c.z);
  endShape(CLOSE);

  // label corners
  fill(0);
  text("A", a.x, a.y-50, a.z);
  text("B", b.x+50, b.y, b.z);
  text("C", c.x, c.y-50, c.z);

  // identify the center
  pushMatrix();
  translate(ctrX, ctrY, ctrZ);
  fill(0);
  noStroke();
  sphere(10);
  
  // draw right- and left-hand normals
  stroke(255,0,0);
  line(0,0,0, rh.x, rh.y, rh.z);
  stroke(0,0,255);
  line(0,0,0, lh.x, lh.y, lh.z);
  popMatrix();
}


// rotate with mouse, spacebar resets view
void mouseDragged() {
  rotX += (mouseX - pmouseX) * 0.01;
  rotY -= (mouseY - pmouseY) * 0.01;
}
void keyPressed() {
  if (key == 32) {
    rotX = 0;
    rotY = 0;
  }
}


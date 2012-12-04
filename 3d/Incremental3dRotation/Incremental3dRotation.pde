/*
INCREMENTAL 3D ROTATION
Jeff Thompson | 2012 | www.jeffreythompson.org

Rather than just map mouse position to rotation, this sketch allows you
to incrementally rotate over many mouse drags.
*/

int boxSize = 600;                    // size for 3d box
float inc = 0.05;                     // increment to rotate during drag
color orange = color(212, 124, 23);   // fill color
float rx, ry;                         // keep track of rotation x/y

void setup() {
  size(500,500, OPENGL);
  strokeWeight(20);
  
  // initial rotation
  rx = radians(-25);
  ry = radians(45);
}

void draw() {
  background(0);
  
  // rotate from center
  translate(width/2, height/2, -boxSize*5);
  rotateX(rx);
  rotateY(ry);
  
  // box!
  stroke(0);
  fill(orange);
  box(boxSize); 
  
  // directional lines
  pushMatrix();
  translate(-boxSize*2, boxSize/2, boxSize/2);
  stroke(255,0,0);
  line(0,0,0, boxSize, 0, 0);
  stroke(0,255,0);
  line(0,0,0, 0, -boxSize,0);
  stroke(0,0,255);
  line(0,0,0, 0,0,-boxSize);
  popMatrix(); 
}


// the magic happens here!
void mouseDragged() {
  
  // normally we'd do something like this
  // ry = map(mouseX, 0,width, 0,TWO_PI);
  // rx = map(mouseY, 0,height, 0,TWO_PI);
  
  // drag in x direction, rotate y
  if (mouseX > pmouseX) {
    ry += inc;
  }
  else if (mouseX < pmouseX) {
    ry -= inc;
  }
  
  // ditto y
  if (mouseY > pmouseY) {
    rx -= inc;
  }
  else if (mouseY < pmouseY) {
    rx += inc;
  }
}


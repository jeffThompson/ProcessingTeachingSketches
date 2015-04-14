
/*
WIND
Jeff Thompson | 2015 | www.jeffreythompson.org

A simple simulation of wind blowing a tree. This is essentially
Brownian Motion applied to an angle – the angle of the tree (which
is bent by the wind) moves back-and-forth randomly, just like
an ant wandering around.

A fancier version, commented out, using a recursive function to
draw a Pythagoras Tree.

CHALLENGES:
+  How might you visualize the wind onscreen?
+  Can you draw grass or other elements that are effected by the
   same global wind?

*/

float trunkLen =    150;    // length of the trunk
float angle =       0;      // starting wind angle

// for Pythagoras Tree version
float branchAngle = 30;     // angle between branches
int minSize =       10;     // minimum size of branches


void setup() {
  size(800, 600);
  
  // nothing else here!
}


void draw() {
  background(50);
  
  // draw a simple tree
  pushMatrix();
  translate(width/2, height);
  rotate(radians(angle));
  stroke(10);
  line(0,0, 0,-trunkLen);
  fill(255, 100);
  noStroke();
  ellipse(0,-trunkLen, trunkLen,trunkLen); 
  popMatrix();
  
  // or a fancier "Pythagoras Tree" - a kind
  // of fractal pattern using a recursive function
  /*
  translate(width/2, height);
  rotate(radians(angle));
  stroke(255);
  line(0,0, 0,-trunkLen);
  branch(trunkLen);
  */
  
  // update angle with random wind speed
  angle += random(-0.5,0.5);
  if (angle > 45) angle = 45;      // don't go too far
  else if (angle < 0) angle = 0;
}


// a "recursive" function to draw the tree
void branch (float s) {
 
  // store previous and reduce branch length
  float prevS = s;
  s *= 0.5 * sqrt(2);    // experiment with changing and see what happens
  
  // add some twist based on the wind speed
  float twist = map(angle, 0,45, 0,30);
  
  // keep going until the branches are too small
  if (s > minSize) {
    
    // draw left branches
    pushMatrix();                             // local mode
    translate(0, -prevS);                     // move up to top of prev branch
    rotate(radians(-branchAngle + twist));    // rotate to new position + twist from wind*
    stroke(255);
    line(0, 0, 0, -s);                        // draw as a line
    branch(s);                                // call again!
    popMatrix();

    // *NOTE: we only add twist to branches on the left side
    // it's more realistic but try it with both to see what happens

    // draw right branches too
    pushMatrix();
    translate(0, -prevS);
    rotate(radians(branchAngle));
    stroke(255);
    line(0, 0, 0, -s);
    branch(s);
    popMatrix();
  }
}



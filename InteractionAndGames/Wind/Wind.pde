
/*
WIND
Jeff Thompson | 2015 | www.jeffreythompson.org

A simple simulation of wind blowing a tree. The angle of the 
tree (which is bent by the "wind") moves back-and-forth randomly
using Perlin noise, a more realistic way to get random motion.

Invented in the 1980s by Ken Perlin, it has been used in movies
and games for 35+ years to generate clouds, terrain, and other
organic features.

Our "tree" is really just a line and a circle: a fancier version, 
commented out, using a recursive function to draw a Pythagoras 
Tree instead of a line-and-circle.

CHALLENGES:
+  How might you visualize the wind onscreen?
+  Can you draw grass or other elements that are effected by the
   same global wind?
+  Can you draw a leaf at the end of each branch? What about just
   the branches where recursion reaches the minimum length?

*/

float trunkLen =    150;        // length of the trunk
float windInc =     0.01;       // how quickly the wind changes speed (try changing)

// for Pythagoras Tree version
float branchAngle = 30;         // angle between two branches
int minSize =       10;         // minimum size of branches

float windSpeed =   0;          // speed, which will = angle of bend
float noisePos =    0;          // "position" in the Perlin noise


void setup() {
  size(800, 600);
  
  // nothing else here!
}


void draw() {
  background(50);
  
  // draw a simple tree
  pushMatrix();
  translate(width/2, height);
  rotate(radians(windSpeed));
  stroke(10);
  strokeWeight(5);
  line(0,0, 0,-trunkLen);
  fill(255, 100);
  noStroke();
  ellipse(0,-trunkLen, trunkLen,trunkLen); 
  popMatrix();
  
  // or a fancier "Pythagoras Tree" - a kind
  // of fractal pattern using a recursive function
  /* translate(width/2, height);
  stroke(255);
  strokeWeight(3);
  line(0,0, 0,-trunkLen);
  branch(trunkLen); */
  
  // update wind speed using 1D Perlin noise
  // noise() returns a value 0 to 1, so mult by 45 means
  // the wind speed will result in an angle of 0-45º
  windSpeed = noise(noisePos) * 45;
  noisePos += windInc;
  
  // random() will generate movement that is jerky and unrealistic
  // try this instead and see what happens
  // windSpeed += random(-0.6,0.5);
}


// a "recursive" function to draw the tree
// for more information on recursive functions, see Basics > Recursion
void branch (float len) {
 
  // store previous and reduce branch length
  float prevLen = len;
  len *= 0.5 * sqrt(2);    // experiment with changing this and see what happens
  
  // keep going until the branches are too small
  if (len > minSize) {
    
    // larger branches are stiffer than little ones
    float stiffness = map(len, minSize, trunkLen, 1.0, 0.2);
  
    // add some twist based on the wind speed and stiffness
    float twist = windSpeed * stiffness;
    
    // draw left branches
    pushMatrix();                             // local mode
    translate(0, -prevLen);                   // move up to top of prev branch
    rotate(radians(-branchAngle + twist));    // rotate to new position + twist from wind*
    stroke(255);
    line(0, 0, 0, -len);                      // draw as a line
    branch(len);                              // call again!
    popMatrix();

    // *NOTE: we only add twist to branches on the left side
    // it's more realistic but try it with both to see what happens

    // draw right branches too
    pushMatrix();
    translate(0, -prevLen);
    rotate(radians(branchAngle));
    stroke(255);
    line(0, 0, 0, -len);
    branch(len);
    popMatrix();
  }
}



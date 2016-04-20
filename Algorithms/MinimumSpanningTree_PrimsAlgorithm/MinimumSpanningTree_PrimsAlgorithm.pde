
/*
MINIMUM SPANNING TREE (PRIM'S ALGORITHM)
 Jeff Thompson | 2016 | jeffreythompson.org
 
 A version of Prim's Algorithm, which finds the
 shortest path between a set of points. Originally
 developed in 1930(!) by mathematician Vojtěch Jarník,
 it was later republished by Robert C Prim in 1957.
 
 Based on this tutorial by Daniel Shiffman:
 https://www.youtube.com/watch?v=BxabnKrOjT0
 
 More info:
 https://en.wikipedia.org/wiki/Prim's_algorithm
 
 CHALLENGE:
 + Can you modify the code so it steps through finding
   the shortest points, letting us see it step-by-step?
 + Right now, we're generating the path and drawing it,
   but the connections are lost. How might you store the
   points as objects so the path can be recalled?
 
 */


int numVertices = 30;            // how many points to draw?
ArrayList<PVector> vertices;     // store in an ArrayList


void setup() {
  size(600, 600);
  vertices = new ArrayList<PVector>();
}


void draw() {
  background(200);

  // generate random points
  fill(0);
  noStroke();
  vertices.clear();
  for (int i=0; i<numVertices; i++) {
    PVector v = new PVector(random(width), random(height));
    vertices.add(v);
    ellipse(v.x, v.y, 15, 15);
  }

  // create an ArrayList of unreached points (all vertices)
  ArrayList<PVector> unreached = new ArrayList<PVector>(vertices);

  // create an empty ArrayList of points we've reached
  // add one point from unreached
  ArrayList<PVector> reached = new ArrayList<PVector>();
  reached.add(unreached.get(0));
  unreached.remove(0);

  // run until every point has been reached!
  while (unreached.size() > 0) {

    // find the shortest distance (start w/ a really big number)
    float shortestDist = MAX_FLOAT;
    int rIndex = 0;        // keep track of record position
    int uIndex = 0;

    // go through every reached point...
    for (int i=0; i<reached.size(); i++) {

      // ...and compare with every unreached point
      for (int j=0; j<unreached.size(); j++) {

        // get the distance between – if shorter than
        // the record, update the record shortest points
        float d = reached.get(i).dist(unreached.get(j));
        if (d < shortestDist) {
          shortestDist = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }
    
    // draw line between two closest points
    // (do before modifying arrays below!)
    stroke(0);
    line(reached.get(rIndex).x, reached.get(rIndex).y,
         unreached.get(uIndex).x, unreached.get(uIndex).y);
    
    // add shortest dist to reached
    reached.add(unreached.get(uIndex));
    unreached.remove(uIndex);
  }

  // redraw when a key is pressed
  noLoop();
}


void keyPressed() {
  setup();      // reset random points
  redraw();     // draw again
}
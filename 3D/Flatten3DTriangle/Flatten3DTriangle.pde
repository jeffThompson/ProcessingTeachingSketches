
/*
FLATTEN 3D TRIANGLE
Jeff Thompson | 2015 | www.jeffreythompson.org

Takes a triangle in 3D space and translates its coordinates
to the 2D X/Y plane. Useful for things like extracting faces
from a 3D model for papercraft!

*/


void setup() {
  size(600, 600, OPENGL);
  
  // a right triangle starting in the center
  // we use cos/sin to create one point rotated by 45º in
  // the Z direction (mult by 30 to get actual position) 
  PVector[] pts = {
    new PVector(width/2, height/2, 0),
    new PVector(width/2, height/2+30, 0),
    new PVector(width/2 + (cos(QUARTER_PI)*30), height/2, sin(QUARTER_PI) * 30)
    
  };
  drawTri(pts);
  print("Original triangle: ");
  println(pts);
  
  // translate triangle so one vertex is at 0,0,0
  PVector diff = PVector.sub(new PVector(0,0,0), pts[0]);
  for (PVector pt : pts) {
    pt.add(diff);
  }
  print("Translated to origin: ");
  println(pts);
  
  // get three vertices in 2D space
  // via: http://stackoverflow.com/a/8051489/1167783
  float x0 = 0;
  float y0 = 0;
  float x1 = sqrt( pow(pts[1].x - pts[0].x, 2) + 
                   pow(pts[1].y - pts[0].y, 2) +
                   pow(pts[1].z - pts[0].z, 2) );
  float y1 = 0;
  
  float x2 = ( (pts[1].x - pts[0].x) * (pts[2].x - pts[0].x) + 
               (pts[1].y - pts[0].y) * (pts[2].y - pts[0].y) +
               (pts[1].z - pts[0].z) * (pts[2].z - pts[0].z) ) / x1;
  float y2 = sqrt( pow(pts[2].x - pts[0].x, 2) + 
                   pow(pts[2].y - pts[0].y, 2) +
                   pow(pts[2].z - pts[0].z, 2) - 
                   pow(x2, 2) );
  pts[0] = new PVector(x0, y0, 0);
  pts[1] = new PVector(x1, y1, 0);
  pts[2] = new PVector(x2, y2, 0);
  drawTri(pts);
  print("2D triangle: ");
  println(pts);
}


// a reusable function to draw a triangle
// given an array of three PVectors
void drawTri(PVector[] p) {
  stroke(0);
  fill(255);
  
  strokeWeight(5);
  point(p[0].x, p[0].y, p[0].z);
  
  strokeWeight(1);
  beginShape();
  vertex(p[0].x, p[0].y, p[0].z);
  vertex(p[1].x, p[1].y, p[1].z);
  vertex(p[2].x, p[2].y, p[2].z);
  endShape(CLOSE);
}



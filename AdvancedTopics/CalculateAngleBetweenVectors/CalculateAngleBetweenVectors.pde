
/*
CALCULATE ANGLE BETWEEN VECTORS
Jeff Thompson  |  2012  |  www.jeffreythompson.org

Both the hard way (so you can see what's happening) and the easy way.

Our two vectors would be drawn like this:
  
  b
  |
  | rise of 100
  |
  +---------- a
   run of 100
   
   ... making the angle between them 90º
   
*/

void setup() {
  size(800,800, P3D);

  // two vectors!
  PVector a = new PVector(100, 0, 0);
  PVector b = new PVector(0, 100, 0);
  
  // normalize into a 0-1 range (required)
  a.normalize();
  b.normalize();
  
  // calculate angle between in degrees - THE HARD WAY
  float angleHardWay = degrees(acos(a.dot(b)));
  println("Angle (the hard way):\t" + angleHardWay);
  
  // get angle - THE EASY WAY
  float angleEasyWay = degrees(PVector.angleBetween(a, b));
  println("Angle (the easy way):\t" + angleEasyWay);
  
  println("Yay!");  
  exit();
}


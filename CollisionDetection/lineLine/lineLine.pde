/* 
 LINE/LINE COLLISION FUNCTION
 Jeff Thompson // v0.9 // November 2011 // www.jeffreythompson.org
 
 Based on the tutorial by Paul Bourke (thanks!):
 http://paulbourke.net/geometry/lineline2d
 ... and Ibackstrom (thanks!)
 http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=geometry2
 
 Takes 8 arguments:
 + x,y positions of start and end of one line (in this case, the moving one)
 + x,y positions of start and end of the other line (in this case, the fixed one)
 
 Note: all values must be floats, otherwise rounding from ints will cause
 errors on one side of the line
 */

boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // find uA and uB
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // note: if the below equations is true, the lines are parallel
  // ... this is the denominator of the above equations
  // (y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)

  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // find intersection point, if desired
    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));
    noStroke();
    fill(0);
    ellipse(intersectionX, intersectionY, 10,10);

    return true;
  }
  else {
    return false;
  }
}


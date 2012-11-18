/* 
 BALL/LINE COLLISION FUNCTION
 Jeff Thompson // v0.9 // November 2011 // www.jeffreythompson.org
 
 Based on the example by Philip Nicoletti
 http://www.codeguru.com/forum/showthread.php?threadid=194400
 
 Takes 7 arguments:
 + x,y position of the point
 + diameter of ball (assumes a circle - ellipse collision is REALLY hard)
 + start x,y and end x,y of the line
 
 Note: all values must be floats, otherwise rounding from ints will cause
 errors on one side of the line
 */

boolean ballLine(float bx, float by, int d, float lx1, float ly1, float lx2, float ly2) {

  // first get the length of the line using the Pythagorean theorem
  float distX = lx1-lx2;
  float distY = ly1-ly2;
  float lineLength = sqrt((distX*distX) + (distY*distY));

  // then solve for r
  float r = (((bx-lx1)*(lx2-lx1))+((by-ly1)*(ly2-ly1)))/pow(lineLength, 2);

  // get x,y points of the closest point
  float closestX = lx1 + r*(lx2-lx1);
  float closestY = ly1 + r*(ly2-ly1);

  // to get the length of the line, use the Pythagorean theorem again
  float distToPointX = closestX - bx;
  float distToPointY = closestY - by;
  float distToPoint = sqrt(pow(distToPointX, 2) + pow(distToPointY, 2));

  // for explanation purposes, draw a line to the ball from the closest point
  strokeWeight(1);
  stroke(255,0,0);
  line(closestX, closestY, bx, by);
  strokeWeight(3);

  // if that distance is less than the radius of the ball: collision
  if (distToPoint <= d/2) {
    return true;
  }
  else {
    return false;
  }
}


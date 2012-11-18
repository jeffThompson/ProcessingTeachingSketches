/* 
 POINT/LINE COLLISION FUNCTION
 Jeff Thompson // v0.9 // November 2011 // www.jeffreythompson.org
 
 Takes 6 arguments:
 + x,y position of the point
 + start x,y and end x,y of the line
 
 Note: all values must be floats, otherwise rounding from ints will cause
 errors on one side of the line
 */

boolean pointLine(float px, float py, float lx1, float ly1, float lx2, float ly2) {
  
  // get the slope of the entire line
  float lineSlope = (ly2-ly1)/(lx2-lx1);
  
  // get slope from one end of the line to the point
  float pointSlope = (ly2-py)/(lx2-px);
  
  // if the slopes are the same, then the point is on the line!
  if (lineSlope == pointSlope) {
    return true;
  }
  else {
    return false;
  }
  
}


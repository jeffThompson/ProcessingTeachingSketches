/* 
POINT/POINT COLLISION FUNCTION
Jeff Thompson // v0.9 // November 2011 // www.jeffreythompson.org

Takes 4 arguments:
  + x,y position of point 1 - in this case "you"
  + x,y position of point 2 - in this case the static point 
*/
boolean pointPoint(int x1, int y1, int x2, int y2) {
  
  // test for collision
  if (x1 == x2 && y1 == y2) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}


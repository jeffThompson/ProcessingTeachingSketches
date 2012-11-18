/* 
POINT/BALL COLLISION FUNCTION
Jeff Thompson // v0.9 // November 2011 // www.jeffreythompson.org

Takes 5 arguments:
  + x,y position of the point - in this case "you"
  + x,y position of the ball
  + diameter of ball - elliptical collision is VERY difficult
*/
boolean pointBall(int px, int py, int bx, int by, int bSize) {
  
  // find distance between the two objects
  float xDist = px-bx;                                   // distance horiz
  float yDist = py-by;                                   // distance vert
  float distance = sqrt((xDist*xDist) + (yDist*yDist));  // diagonal distance
  
  // test for collision
  if (bSize/2 > distance) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}


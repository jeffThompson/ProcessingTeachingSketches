/*
FUNCTIONS and TABS
Jeff Thompson
April 2012

www.jeffreythompson.org
*/

// setup is a "function", size, rect, etc
void setup() {
  
  size(800,800);
  smooth();
  background(172, 216, 237);
  
  // use custom function to draw a square
  color squareColor = color(255,0,0);
  drawQuarterSquare(width/4,height/2, squareColor);
  
  // use custom function to do some addition
  int answer = addTheseNumbers(14, 28);
  println(answer);
  
}

int addTheseNumbers(int x, int y) { 
  // int tempAnswer = x + y;
  // return tempAnswer;
  return x+y;
}

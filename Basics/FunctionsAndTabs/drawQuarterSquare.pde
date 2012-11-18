void drawQuarterSquare(int x, int y, color squareColor) {
  
  fill(squareColor);
  // rectMode(CORNER);
  rectMode(CENTER);    // x,y of center, w,h
  rect(x,y, width/4, height/4); 
}

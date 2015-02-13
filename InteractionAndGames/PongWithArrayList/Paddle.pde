
// the Paddle class
class Paddle {
  float x, y;       // position
  float w = 15;     // width of paddle
  float h = 100;    // ditto height
 
  Paddle() {
    x = width - w;  // set along right wall in middle
    y = height/2;
  }
  
  // use mouse to control the paddle
  void update() {
    y = mouseY;
  }
  
  // draw it
  void display() {
    fill(255);
    noStroke();
    rect(x,y, w,h);
  }
}




// the Ball class
class Ball {
  int ballSize = 10;          // size of the ball
  float x, y;                 // position
  float speedX, speedY;       // speed/direction

  Ball() {
    x =      0;               // start balls in center-left wall
    y =      height/2;
    speedX = random(1, 5);    // random direction to the right  
    speedY = random(-5, 5);
  }

  // update the position, bounce
  void update() {
    x += speedX;
    y += speedY;

    // if we've hit the paddle, bounce back
    if (x + ballSize/2 > width - paddle.w && y > paddle.y && y < paddle.y + paddle.h) {
      speedX *= -1;
    }

    // bounce off left, top, and bottom walls (but NOT the right wall)
    if (x < 0) speedX *= -1;
    if (y < 0 || y > height) speedY *= -1;
  }
  
  // has the ball gone past the right wall?
  boolean checkHit() {
    if (x > width) {
      return true;
    }
    return false;
  }

  // draw the ball
  void display() {
    fill(255, 150, 0);
    noStroke();
    ellipse(x, y, ballSize, ballSize);
  }
}



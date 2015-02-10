
/*
PONG WITH ARRAY LIST
Jeff Thompson | 2015 | www.jeffreythompson.org

*/

int numBalls = 10;

ArrayList<Ball> balls = new ArrayList<Ball>();


void setup() {
  size(800, 600);
  
  for (int i=0; i<numBalls; i++) {
    Ball b = new Ball();
    balls.add(b);    
  }
}


void draw() {
  background(0);
  
  for (Ball b : balls) {
    b.update();
    b.display();
  }
  
}


class Ball {
  int ballSize = 10;
  float x, y;
  float speedX, speedY;
  
  Ball() {
    x = random(width);
    y = random(height);
    speedX = random(-15,15);
    speedY = random(-15,15);
  }
  
  void update() {
    x += speedX;
    y += speedY;
    if (x < 0 || x > width) speedX *= -1;
    if (y < 0 || y > height) speedY *= -1;
  }
  
  void display() {
    fill(255);
    noStroke();
    ellipse(x, y, ballSize, ballSize);    
  }
  
}



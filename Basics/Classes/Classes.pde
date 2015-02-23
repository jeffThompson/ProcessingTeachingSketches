
/*
CLASSES
Jeff Thompson | 2015 | www.jeffreythompson.org

"Object-oriented" programming languages, like Java which Processing
is built on, let us wrap up our code into smaller, reusable units
called "classes". Classes also help with naming variables and
processes. "Semantic" naming means that variables, functions, and
classes are called something that makes sense as spoken language.

For example: we could name a class "Thing" but clearer might be
"Ball". We could name a function in the class check() but a better
choice might be checkCollision().

In this example we build a simple bouncing ball – for a more complex
example, see PongWithArrayList in "Interaction and Games".

*/

Ball ball;      // declare an "instance" of our class, in this case a ball

// no other variables!
// position, speed, etc is all stored in the class

void setup() {
  size(600,600);
  
  // create the ball, passing arguments for the inital position
  // these arguments are set up in the class and can be anything
  ball = new Ball(width/2, height/2);    // start ball in center of screen
}

void draw() {
  background(230);    // clear every frame
  ball.update();      // update the position of the ball every frame
  ball.display();     // draw the ball
  
  // that's it!
  // everything else is handled in the class, which keeps our draw()
  // loop clean and easy to read
}


// our Ball class
class Ball {
  
  // variables for the ball
  int ballSize = 100;            // size of ball set here - this is "hard-coded"
  color c = color(255,150,0);    // same with fill color
  float x, y;                    // we pass initial x/y position as arguments
  float speedX, speedY;          // speed will be randomly set when we create the ball
  
  Ball(float _x, float _y) {     // pass arguments when the ball is created
    x = _x;                      // set x/y position
    y = _y; 
    speedX = random(-5,5);       // set random speed
    speedY = random(-5,5);
  }
  
  void update() {                // a function to move the ball + bounce off walls
    x += speedX;
    y += speedY;
    if (x < 0 || x > width) {    // if we've hit a wall...
      speedX *= -1;              // reverse direction
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }
  }
  
  void display() {                      // a function to draw the ball
    fill(c);                            // fill color using class variables
    noStroke();
    ellipse(x,y, ballSize,ballSize);    // same for drawing the ball
  }
  
}



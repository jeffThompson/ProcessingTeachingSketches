
/*
GRAVITY
Jeff Thompson | 2015 | www.jeffreythompson.org

Simulating physics can be pretty easy (like this gravity
example) or REALLY complicated. Here we move a ball using
gravity and control its "bounciness" with a friction
variable.

For an example with directional movement, see the "BouncingBubbles"
example in the "Motion" section of the Processing examples.

For REALLY fancy (but complicated) physics, try the Box2D
engine for Processing, explained in Daniel Shiffman's great
book "Nature of Code".

CHALLENGES:
+  Try moving this code to an object-oriented approach, randomly
   adding balls to an ArrayList and dropping them across the screen
   from random X coordinates like bouncing raindrops.
+  Instead of just the bottom of the screen, can you make the ball
   check its Y position off a box and bounce? What about an ArrayList
   of balls bouncing off an ArrayList of boxes?

*/

float dia =       50;      // size of the ball
float gravity =   0.3;     // strength of gravity - try changing!
float friction =  -0.4;    // "bounciness" of the ball - also change!

float x, y;                // position
float speed = 0;           // initial speed is 0


void setup() {
  size(800,800);
  
  x = width/2;             // start ball at top
  y = dia*2;
}


void draw() {
  background(50);
  
  // update position by incrementally adding
  // gravity - this makes the ball accelerate
  speed += gravity;
  y += speed;
  
  // bounce!
  // first we set the position of the ball to the 
  // bottom, otherwise it drifts down below the bottom
  // then we reverse the direction and reduce the speed
  // by multiplying it by friction
  if (y + dia/2 > height) {
    y = height-dia/2;
    speed *= friction;
  }
  
  // draw the ball
  fill(255);
  noStroke();
  ellipse(x, y, dia, dia);
}


// any key to drop the ball again
void keyPressed() {
  y = dia/2;          // reset position...
  speed = 0;          // and speed
}



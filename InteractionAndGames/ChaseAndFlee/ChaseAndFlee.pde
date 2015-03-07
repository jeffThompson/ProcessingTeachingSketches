
/*
CHASE AND FLEE
Jeff Thompson | 2015 | www.jeffreythompson.org

While many books have been written on game AI, this example
shows a VERY basic chase and flee behavior.

Here we use Processing's PVector class, which can store a 2D
position. We use it because it simplifies math, such as computing
the distance between two points. See the reference for all the
things it can do.

For more ideas, see Valentino Braitenberg's "vehicles", which
do things like seek light and hide from each other. 

http://en.wikipedia.org/wiki/Braitenberg_vehicle

See also 
Daniel Shiffman's excellent book "Nature of Code".


CHALLENGE:
+  Our chase ball bounces around when it hits you. Can you stop
   that behavior by checking if it's position is within the
   player's circle, and not updating if that's true?
+  Can you make the chase ball turn to face the player? Use a shape
   like a triangle and PVector's "angleBetween()" function. Hint:
   you'll need to use "pushMatrix()" and "popMatrix()" too.
+  Can you make the fleeing ball move faster or slower the close
   we get to it?

*/

float chaseSpeed = 2.0;       // speed to chase
float fleeSpeed =  0.5;       // try changing and see what happens

PVector player, chase, flee;  // position of the 3 elements


void setup() {
  size(600, 600);

  // set initial positions onscreen (x and y)
  player = new PVector(0,0);
  chase = new PVector(width/2 - 100, height/2);
  flee = new PVector(width/2 + 100, height/2);
}

void draw() {
  background(240);

  // player
  player.x = mouseX;
  player.y = mouseY;
  fill(255, 0, 0);
  noStroke();
  ellipse(player.x, player.y, 30, 30);

  // now for the AI!
  
  // the chasing ball checks which direction
  // the player is in, then moves incrementally
  // that direction
  PVector dir = PVector.sub(player, chase);  // easy!
  dir.normalize();                           // set to range of 0-1
  dir.mult(chaseSpeed);                      // scale by the speed
  chase.x += dir.x;                          // update the position
  chase.y += dir.y;
  fill(0);                                   // then draw!
  ellipse(chase.x, chase.y, 30, 30);
  
  // flee is basically like chase, except we subtract
  // the direction instead of add!
  // here we also only flee if the player is within
  // 100px, which gives a more natural interaction
  float distBetween = player.dist(flee);     // how far apart are we?
  if (distBetween < 100) {                   // if closer than 100px, flee!
    dir = PVector.sub(player, flee);         // same as chase above...
    dir.normalize();
    dir.mult(fleeSpeed);
    flee.x -= dir.x;                          // ...except subtract instead of add
    flee.y -= dir.y;
  }
  fill(0,150,255);                            // and draw
  ellipse(flee.x, flee.y, 30,30);
}


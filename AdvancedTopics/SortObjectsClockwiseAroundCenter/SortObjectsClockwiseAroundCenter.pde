import java.util.*;  // import Collections, Comparator, etc for sorting ArrayList

/*
SORT OBJECTS CLOCKWISE AROUND CENTER
Jeff Thompson | 2013 | www.jeffreythompson.org

Sorts an ArrayList of objects by their angle from a point in clockwise order.

Since the trig functions used require radians, the default 0º mark is the right side of
a circle - use the angleOffset variable to change the 0º mark (here we offset by
HALF_PI to make 0º at 12 o'clock.
*/

int radius = 300;                // radius of the circle
int numBalls = 5;                // how many balls to draw
float angleOffset = HALF_PI;     // offset for 0º in radians, 0 puts 0º at right side, HALF_PI allows 12 o'clock to be 0º

int ctrX, ctrY;                                   // center of screen (angle is measured from this point
ArrayList<Ball> balls = new ArrayList<Ball>();    // store objects in ArrayList (allows us to remove items as needed more easily)

void setup() {

  // basic setup
  size(800, 800);
  ctrX = width/2;
  ctrY = height/2;

  // create balls
  for (int i=0; i<numBalls; i++) {
    balls.add(new Ball());
  }
}

void draw() {
  
  // draw some basic graphics for the display
  background(0);
  fill(255,150,0, 70);
  ellipse(width/2,height/2, radius*2, radius*2);      // large circle
  
  stroke(255, 40);
  pushMatrix();                                       // popMatrix() to rotate 0º line based on angleOffset
  translate(width/2,height/2);
  rotate(angleOffset);
  line(0,0, -radius,0);                                // 0º line
  noStroke();
  fill(100);
  text("0º", -radius-20, 0);                           // 0º label
  popMatrix();
  
  fill(255);
  ellipse(width/2,height/2, 8,8);                      // center circle
  
  // update sorted order, update angle/position and display balls
  updateOrder();
  for (int i=balls.size()-1; i>=0; i--) {    // iterate by i so we can pass the order of balls to the display
    Ball b = balls.get(i);                   // retrieve from the ArrayList
    b.update();                              // update position and angle
    b.display(i);                            // pass order to display 
  }
}

// a function to do the actual sorting - placed here for 
// cleaninless and reusability; to sort by floats, you still must
// convert them to an integer (which doesn't work well for radians
// since they are from 0 to approx 6, which makes for lots of rounding
// errors - we convert to degrees instead...)
void updateOrder() {
  Collections.sort(balls, new Comparator<Ball>() {
    @Override public int compare(Ball ball1, Ball ball2) {
      return int(ball1.getAngleInDegrees() - ball2.getAngleInDegrees());
      
      // swap ball1 and ball2 to sort counter-clockwise!
      // return int(ball2.getAngleInDegrees() - ball1.getAngleInDegrees());
    }
  }
  );
}

class Ball {
  float x, y;
  float angle;
  float speed;

  Ball () {
    angle = random(0, TWO_PI);
    speed = random(-0.007, 0.007);
  }

  void display(int order) {
    stroke(255);
    line(width/2,height/2, x,y);                // line from center
    fill(255, 150, 0);
    noStroke();
    ellipse(x, y, 20, 20);                      // ball itself
    textAlign(CENTER, CENTER);
    fill(0);
    text(order, x, y);                          // order in list
    fill(255);
    text(getAngleInDegrees() + "º", x, y+30);   // angle in degrees
  }

  void update() {
    angle += speed;                     // increment angle by speed
    if (angle > TWO_PI) {               // if we've passed all the way around, reset angle to 0
      angle = 0;
    }
    else if (angle < 0) {               // reset other direction
      angle = TWO_PI;
    }
    x = width/2 + cos(angle-angleOffset)*radius;    // find x/y position using cos/sin
    y = height/2 + sin(angle-angleOffset)*radius;   // angleOffset allows us to set any angle as 0º!
  }
  
  int getAngleInDegrees() {
    return int(degrees(angle));         // returns int of angle for sorting
  }
}


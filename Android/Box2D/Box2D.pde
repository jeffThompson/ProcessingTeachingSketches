import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

/*
BOX2D
Jeff Thompsno | 2013 | www.jeffreythompson.org

[ to do: add accelerometer to change tilt of the X ]

Running the popular Box2D physics library on Android - click to make
new boxes appear, collide with a rotating structure and each other, the
fall offscreen!

Based on the fantastic examples by Daniel Shiffman!

*/

Vec2 boxStart = new Vec2(200,50);     // where to start the box "fountain"
color boxColor = color(0, 150, 150);

Vec2 gravity = new Vec2(0, -20);      // x/y direction - neg = down - 0,0 = no gravity

float rotationSpeed = radians(30);    // rotation in radians/second
float wallFriction = 5;               // 1 = "normal", higher = more friction
float wallRestitution = 0.01;         // 0.5 is normal; higher means explosive bounce!

PBox2D box2d;
ArrayList<Box> boxes = new ArrayList<Box>();
ArrayList<Surface> surfaces = new ArrayList<Surface>();

void setup() {

  // basic setup
  smooth();
  
  // setup world and physics in it
  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.setGravity(gravity.x, gravity.y);    // 0,0 would be NO gravity
  
  // create v-shaped walls
  int surfaceLen = min(width, height) - 100;
  
  // ctr x/y, width,height, rotation speed in radians/sec, restitution (bounce), fill color
  surfaces.add(new Surface(width/2, height/2, surfaceLen, 10, rotationSpeed, 0.0, color(0, 150)));
  surfaces.add(new Surface(width/2, height/2, 10, surfaceLen, rotationSpeed, 1.5, color(255, 150)));
}

void draw() {
  
  // update the world
  background(0, 100, 20);
  box2d.step();
  
  // display boxes - if they go offscreen, delete them
  for (Box b : boxes) {
    b.display();
  }
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
  
  // draw the the X pieces
  for (Surface s : surfaces) {
    s.update();
    s.display();
  }
}

// drag the mouse to draw new boxes
void mouseDragged() {
  Box b = new Box(mouseX, mouseY, boxColor);
  boxes.add(b);
}

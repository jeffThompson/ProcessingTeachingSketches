
import java.awt.event.*;    // required to access mouse wheel

/*
MOUSE WHEEL
 Jeff Thompson | 2015 | www.jeffreythompson.org
 
 Use the mouse wheel to move an object onscreen! 
 
 Mouse wheel code via Rick Companje:
 http://wiki.processing.org/index.php/Wheel_mouse
 */

float ballY;    // position of ball vertically


void setup() {
  size(600,600);
  
  // start in center
  ballY = height/2;
  
  // we have to "listen" for the mouse wheel using this code
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
    }
  });
}


void draw() {
  background(240);
  
  // draw the ball
  fill(255,150,0);
  noStroke();
  ellipse(width/2, ballY, 100,100);
}


// when mouse wheel is moved, update the ball position
void mouseWheel(int delta) {
  println("Mouse has moved by " + delta + " units");
  ballY += delta;
}


/**
 Wheel mouse taken from http://wiki.processing.org/index.php/Wheel_mouse
 @author Rick Companje
 */

import java.awt.event.*;

void setup() {
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
    }
  }
  );
}

void mouseWheel(int delta) {
  println("mouse has moved by " + delta + " units.");
}

void draw() {
}


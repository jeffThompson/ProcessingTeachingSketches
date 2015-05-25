
/*
MOUSEWHEEL/TRACKPAD SCROLLING
Jeff Thompson | 2015 | www.jeffreythompson.org

The mousewheel or trackpad scrolling can provide a natural
interface, especially for actions like moving through large
drawings/images or zooming in 3D models.

CHALLENGES:
+  Can you control the ball's size so it doesn't get too
   large or small?
+  Can you change the code so the ball moves up and down?
+  What other actions might be intuitive for a mousewheel?

*/

// set diameter of the circle
int diameter = 300;


void setup() {
  size(600,600);
}


void draw() {
  background(50);
  
  fill(255);
  noStroke();
  ellipse(width/2,height/2, diameter,diameter);
}


// this function gets the mousewheel (or trackpad,
// depending on your system) and returns the direction
// as a "count" – basically ticks of the wheel
void mouseWheel(MouseEvent event) {
  diameter += event.getCount();
}



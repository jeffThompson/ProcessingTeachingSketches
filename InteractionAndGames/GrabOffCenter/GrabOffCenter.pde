
/*
GRAB OFF-CENTER
 Jeff Thompson | 2012 | www.jeffreythompson.org
 
 A deceptively simple upgrade - grabbing an object onscreen and
 not having its center jump to the mouse coordinates! A little
 extra code makes the interaction more natural.
 
 A nice extra: change color when we grab the square!
 */

int rectSize =   100;                // size of the rectangle to grab
color off =      color(200);         // regular (ie: not-grabbed) color
color grab =     color(255,150,0);   // bonus: color when dragging
boolean drag =   false;              // keep track of if we're dragging or not

int rx, ry, offsetX, offsetY;        // position coordinates


void setup() { 
  size(500, 500);
  noStroke();
  
  // start rectangle in center
  rx = width/2;
  ry = height/2;
  rectMode(CENTER);
}


void draw() {
  background(255);
  
  // if dragging is turned on, update the position
  if (drag) {
    
    // the usual method - notice how the rectangle
    // jumps to center on the mouse position
    // rx = mouseX;
    // ry = mouseY;

    // a more natural way of dragging
    // (see mousePressed code where we set the offsets)
    rx = mouseX + offsetX;
    ry = mouseY + offsetY;
    
    // change the fill color
    fill(grab);
  }
  
  // non-grab color
  else {
    fill(off);
  }
  rect(rx, ry, rectSize, rectSize);
}


// if we're clicking inside the box, set the offset and set drag to true
// note this makes click-and-drag more intelligent than placing
// everything in the mouseDragged function (and is required for our
// off-center dragging)
void mousePressed() {
  if (mouseX > rx - rectSize/2 && mouseX < rx + rectSize/2 && mouseY > ry - rectSize/2 && mouseY < ry + rectSize/2) {
    offsetX = rx - mouseX;    // difference between current mouse position and the center of the box
    offsetY = ry - mouseY;    // ditto y position
    drag = true;              // set dragging to true (on)
  }
}


// when we release the mouse, stop dragging
void mouseReleased() {
  drag = false;
}


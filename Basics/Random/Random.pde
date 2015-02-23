
/*
RANDOM
Jeff Thompson | 2015 | www.jeffreythompson.org

Random values can mimic natural processes, draw entire game
landscapes, secure information through crypography, and even
make digital creatures appear to move!**

Here we use random values to draw circles at random locations
and in random sizes.

CHALLENGE:
+  Can you make the circles randomly colored as well?
+  Can you make the color change randomly but smoothly over time?
+  ** This is through a process called Brownian Motion. Can you make
   the cirles move in this way?

*/

void setup() {
  size(600,600);
  background(0, 150, 150);
  
  fill(255, 100);
  noStroke();
  
  // draw a bunch of randomized circles
  for (int i=0; i<30; i++) {
    float x = random(0, width);          // random returns a float from min-max
    float y = random(height);            // just 1 argument, min is assumed to be 0
    int diameter = int(random(30,100));  // if we want an int, we have to "cast" it using int()
    
    // print the coordinates and diameter
    println("(" + x + ", " + y + ") " + diameter + "px");
    
    // draw!
    ellipse(x, y, diameter, diameter);
  }
}

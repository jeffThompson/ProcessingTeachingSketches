
/*
RECURSION
Jeff Thompson | 2015 | www.jeffreythompson.org

Recursion is a way of controlling the flow of a program with
a function that continually calls itself. Unlike iteration,
where we walk through a repeated series of commands step-by-
step, recursion can create complex behavior such as fractals.

A recursive function always:
1. Has a test to see if it's time to stop (otherwise it will
   continue forever and freeze your program!)
2. Calls itself, usually with modified data.

CHALLENGES:
+  Instead of printing 0, can you make the countdown example
   print "BLASTOFF!"?
+  Can you add another piece to the spiral() function that angles
   off the other direction?
+  What shapes do you find in nature that mimic this kind of
   recursive function? Can you re-create them in code?

*/


// spiral variables - try changing and see what happens!
float initialLen = 100;            // initial length of spiral segment
float minLen =     10;             // minimum size
float angle =      radians(-30);   // angle of spiral


void setup() {
  size(600,600);
  background(255);
  
  // a simple example: count down from 10 to 0
  countdown(10);
  
  // as an iterative function, it would look like this
  // for (int i=10; i>=0; i-=1) {
  //   println(i);
  // }
  
  // a more complex example: draw a spiral
  // this would be very difficult to do using a for loop
  translate(width/2, height*0.75);    // move into initial position
  rotate(angle);                      // initial angle
  stroke(0, 100);
  strokeWeight(10);
  line(0,0, initialLen,0);            // draw first line
  spiral(initialLen);                 // then draw the rest of the spiral
}


// countdown function that prints numbers
// from N to 0
void countdown(int n) {
  if (n >= 0) {              // check we're still at or above 0
    println(n);              // print the number
    countdown(n-1);          // call the function again
  }
}


// a function to draw a spiral
// note: this requires the initial translate() and first
// segment, since we move the origin before drawing
void spiral(float len) {
  float prevLen = len;        // store previous length, used to translate
  len *= 0.9;                 // then shorten - try changing this value too
  
  if (len > minLen) {         // check if still above the minimum length
    pushMatrix();             // local origin*
    translate(prevLen, 0);    // move to end of previous line
    rotate(angle);
    stroke(0, 100);
    fill(255,150,0);
    line(0,0, len,0);         // draw a line
    spiral(len);              // and call function again!
    popMatrix();              // pop out of local mode when done
  }
  
  // *NOTE: see what happens when you make minLen 1 – you get
  // an error saying "you can't use push this much"! This means 
  // you're calling the spiral() function (and therefore calling
  // nested push/popMatrix) too many times for your computer.
}
    


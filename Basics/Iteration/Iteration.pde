
/*
ITERATION
Jeff Thompson | 2015 | www.jeffreythompson.org

Iteration is a very important programming idea - it uses repetition
to execute lines of code. This can be purely functional (like going 
through every item in an array) or to draw repeated shapes across
the screen (like a grid).

The two main ways we can iterate are "while" loops and "for" loops. Each
are described below, though for loops are much more common.

CHALLENGES:
+  Can you modify our grid loop to make the spacing get progressively
   smaller? Can you make every 10th line a different color? (Hint: modulus)
+  Can you use a for loop to draw concentric circles?
+  You can nest for loops together! Can you write a for loop inside a
   for loop to draw a dot across the screen every 5px?
*/


void setup() {
  size(600,600);
  background(255);
 
  // a "while loop" runs until a condition is met
  // this loop counts down from 10 to 0
  int count = 10;          // an initial variable to work with
  while (count >= 0) {     // runs until the condition is met (less than 0)
    println(count);        // print the count
    count -= 1;            // update the variable*
  }
  
  // *NOTE: what happens if you don't update the count variable?
  // your program gets stuck and runs forever!
  
  // a "for loop" is a little harder to understand, but puts the
  // initial value, condition, and increment into one statement
  
  // this for loop starts at 0, runs until i equals 9, and adds
  // 1 to i each time
  for (int i=0; i<10; i++) {
    println(i);    
  }
  
  // we can use for loops to do tedious tasks like draw a grid of
  // lines across the screen (this saves us at least 80 lines of code!)
  stroke(0, 100);
  for (int x=0; x<width; x+=10) {    // note lines will be 10px apart
    line(x,0, x,height);             // draw vertical lines
  }
  for (int y=0; y<height; y+=20) {   // this draws lines 20px apart
    line(0,y, width,y);
  }

}



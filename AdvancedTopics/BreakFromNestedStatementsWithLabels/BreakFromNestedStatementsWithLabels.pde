/*
BREAK FROM NESTED STATEMENTS USING LABELS
Jeff Thompson
March 2012

If we have nested iterating statements, like the for loop within
a while loop below, a single 'break' cannot get us out of the
outer loop.  Since the while loop here will always evaluate true,
we would be stuck infinitely running it.

Instead, add a label before the outer loop in the following format:
<labelName>:

This is then called inside the nested loop with the standard 'break'
followed by the label:
break <label>;

Below we have a while loop that iterates continuously; inside it a for
loop adds 1 to a value n, 10 at a time.  When it reaches the target
value of 100, it breaks both loops and prints the result.  Not a particularly
useful example, but this principle is very helpful for running
iterative processes.

More information:
http://docs.oracle.com/javase/tutorial/java/nutsandbolts/branch.html

www.jeffreythompson.org
*/

int n = 0;          // number to increment
int target;         // target value to look for (here we set to the width)

void setup() {
  
  size(400,400);
  fill(0, 100);
  noStroke();
  target = width;

outerLoop:                        // label name (turns gray in the Processing IDE)
  while (true) {                  // this statement will run forever
    for (int i=0; i<10; i++) {    // run ten times before testing
      n += i;                     // add one to n
      if (n >= target) {          // if we've reached/exceeded the target value
        break outerLoop;          // break from the entire procedure
      }
      else {
        rect(n,0, 2,height);      // otherwise, draw rectangles across the screen
      }
    }
  }
  
  // when done, print the result to see that we have broken from the loops
  println(n);
}



/*
RANDOM RANGE NOT ZERO!
Jeff Thompson | 2013 | www.jeffreythompson.org

Generates a random number within a +/- range but NOT zero - 
great for velocities where you don't want an object to sit
still or move just horiz/vert.

Note this will not work for ints because rounding will bring
some values to 0.

Based on a suggestion from:
http://stackoverflow.com/a/6326560/1167783
  
*/

int range = 100;    // range +/- (ie within -100/100)

// generate a bunch of examples!
for (int i=0; i<30; i++) {
  float rand = random(range) * 2 - range;
  println(rand);
}
exit();
